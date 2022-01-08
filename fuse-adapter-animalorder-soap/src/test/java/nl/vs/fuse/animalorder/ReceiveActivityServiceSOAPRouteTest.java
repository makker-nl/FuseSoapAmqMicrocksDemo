package nl.vs.fuse.animalorder;

import java.nio.file.Files;
import java.nio.file.Path;

import org.apache.camel.CamelContext;
import org.apache.camel.ProducerTemplate;
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
public class ReceiveActivityServiceSOAPRouteTest {
	private static final Logger log = LoggerFactory.getLogger(ReceiveActivityServiceSOAPRouteTest.class);
	private static final String URI_SEND_ANORD = "direct:sendActivityV1Request";
	private static final String TEST_FLDR_ANORD = "src/test/resources/animalorder";
	private static final String TEST_REQ_CREUPD_ANORD = TEST_FLDR_ANORD + "/animalorder-req-1234.xml";
	private static final String TEST_RESP_CREUPD_ANORD = TEST_FLDR_ANORD + "/animalorder-resp-1234.xml";
	private static final String TRGT_FLDR = "target/";
	private static final String TEST_TRGT_FLDR_ANORD = TRGT_FLDR +"test/activityv1/";
	private static final String TEST_TRGT_CREUPD_ANORD =  "createUpdateActivityReq522672.xml";

	@Autowired
	private CamelContext context;

	@Autowired
	private ProducerTemplate template;

	@Value("${amqp.service.address}")
	String amqpServiceAddress;

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
		// Voeg route voor verzenden van SoapMessage.
		// Deze is vooral nodig, om te zorgen dat het response van CxfPayload naar String geconverteerd wordt.
		context.addRoutes(new RouteBuilder() {
			@Override
			public void configure() throws Exception {
				from(URI_SEND_ANORD).routeId("sendActivityRequest")
				  .log("Invoke AnimalOrder Service with request").id("logInvokeAnOrdSvcReq")
				  .to("cxf:bean:testAnimalOrderSvcSOAPEndpoint").id("invokeAnimalOrderSvcSOAPMessage")
				  .log("AnimalOrder Service responded.").id("logInvokeAnOrdSvcResp")
				  .convertBodyTo(String.class).id("ConvertAnOrdSvcRespToStr");
			}
		});
		// Voeg route toe voor consumeren van berichten op de BrokerService.
		// Maak alvast de folder aan waar de geconsumeerde berichten naar worden weggeschreven.
		Path targetFldr = Path.of(TEST_TRGT_FLDR_ANORD);
		Files.createDirectories(targetFldr);
		context.addRoutes(new RouteBuilder() {
			public void configure() {
				from("amqp:" + amqpServiceAddress)
				.to("file:"+TEST_TRGT_FLDR_ANORD+"?fileName=" + TEST_TRGT_CREUPD_ANORD);
			}
		});
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
		String animalOrderRequest = TestSupport.readFile(TEST_REQ_CREUPD_ANORD);
		// Test AnimalOrder  Service
		String result = (String) template.requestBody(URI_SEND_ANORD, animalOrderRequest);
		log.debug(methodName + " - AnimalOrder Response: " + result);
		// check response
		String expectedResult = TestSupport.readFile(TEST_RESP_CREUPD_ANORD);
		TestSupport.assertEqualsXML(result, expectedResult);

		// check published message
		String consumedResult = TestSupport.readFile(TEST_TRGT_FLDR_ANORD + TEST_TRGT_CREUPD_ANORD);
		TestSupport.assertEqualsXML(consumedResult, animalOrderRequest);
		log.debug(methodName + " - end");
	}

}
