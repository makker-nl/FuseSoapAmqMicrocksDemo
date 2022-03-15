package nl.vs.fuse.animalorder;

import java.nio.file.Files;
import java.nio.file.Path;
import java.util.concurrent.TimeUnit;

import org.apache.camel.CamelContext;
import org.apache.camel.ProducerTemplate;
import org.apache.camel.builder.NotifyBuilder;
import org.apache.camel.builder.RouteBuilder;
import org.apache.camel.test.spring.CamelSpringBootRunner;
import org.apache.camel.test.spring.UseAdviceWith;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.ActiveProfiles;

import nl.vs.fuse.demo.animalorder.Application;
import nl.vs.fuse.demo.test.TestSupport;
import nl.vs.fuse.demo.test.stub.EmbeddedBrokerService;

@RunWith(CamelSpringBootRunner.class)
@SpringBootTest(classes = Application.class)
@ActiveProfiles("utest")
@DirtiesContext(classMode = DirtiesContext.ClassMode.AFTER_EACH_TEST_METHOD)
@UseAdviceWith
public class ReceiveAnimalOrderAMQPRouteTest {
	private static final Logger log = LoggerFactory.getLogger(ReceiveAnimalOrderAMQPRouteTest.class);
	private static final String URI_ACTV1_SVC = "cxf:bean:mockAnimalOrderSvcSOAPEndpoint";
	private static final String AMQP = "amqp:";
	private static final String TEST_FLDR_ANORD = "src/test/resources/animalorder";
	private static final String TEST_REQ_ORD_ANORD = TEST_FLDR_ANORD + "/animalorder-req-1234.xml";
	private static final String TEST_RESP_ORD_ANORD = TEST_FLDR_ANORD + "/animalorder-resp-1234.xml";
	private static final String TRGT_FLDR = "target/";
	private static final String TEST_TRGT_FLDR_ANORD = TRGT_FLDR + "test/animalorder/";
	private static final String TEST_TRGT_ORD_ANORD = "orderAnimalOrder-1234.xml";

	@Autowired
	private CamelContext context;

	@Autowired
	private ProducerTemplate amqpServiceEndpoint;

	@Value("${amqp.service.address}")
	private String amqpServiceAddress;

	// NotificationBuilder to wait for the processing by the MockService.
	private NotifyBuilder notification = null;

	@BeforeClass
	public static void setUpClass() throws Exception {
		final String methodName = "setUpClass";
		log.debug(methodName + " - start");
		// Setup Embedded Broker Service
		EmbeddedBrokerService.createBrokerSvc();
		log.debug(methodName + " - end");
	}

	@Before
	public void setUp() throws Exception {
		final String methodName = "setUp";
		log.debug(methodName + " - start");
		String animalOrderResponseMsg = TestSupport.readFile(TEST_RESP_ORD_ANORD);

		Path targetFldr = Path.of(TEST_TRGT_FLDR_ANORD);
		Files.createDirectories(targetFldr);

		// Add route to mock SoapService.
		context.addRoutes(new RouteBuilder() {
			@Override
			public void configure() throws Exception {
				from(URI_ACTV1_SVC).id("fromMockActivitySvcSOAPEndpoint")
						.log("AnimalOrder Mock Service - request ontvangen.").id("logFromActSvcReq")
						.to("file:" + TEST_TRGT_FLDR_ANORD + "?fileName=" + TEST_TRGT_ORD_ANORD)
						.setBody(constant(animalOrderResponseMsg))
						.log("AnimalOrder Mock Service - response geladen:\n ${body}.").id("logFromActSvcResp");
			}
		});
		notification = new NotifyBuilder(context).from(URI_ACTV1_SVC).whenDone(1).create();
		context.start();
		log.debug(methodName + " - end");
	}

	@AfterClass
	public static void tearDownClass() throws Exception {
		final String methodName = "tearDownClass";
		log.debug(methodName + " - start");
		EmbeddedBrokerService.stopBrokerSvc();
		log.debug(methodName + " - end");
	};

	@Test
	public void tc01_happyFlow() throws Exception {
		final String methodName = "tc01_happyFlow";
		log.debug(methodName + " - start");
		String animalOrderRequest = TestSupport.readFile(TEST_REQ_ORD_ANORD);
		// Test Activity Service
		amqpServiceEndpoint.setDefaultEndpointUri(AMQP + amqpServiceAddress);
		amqpServiceEndpoint.sendBodyAndHeader(animalOrderRequest, "TestCase", "HappyFlow");
		boolean done = notification.matches(10, TimeUnit.SECONDS);
		// Check message geconsumeerd door Mock SOAP Service
		String animalOrderRequestSOAP = TestSupport.readFile(TEST_REQ_ORD_ANORD);
		String consumedResult = TestSupport.readFile(TEST_TRGT_FLDR_ANORD + TEST_TRGT_ORD_ANORD);
		TestSupport.assertEqualsXML(consumedResult, animalOrderRequestSOAP);
		log.debug(methodName + " - end");
	}

}