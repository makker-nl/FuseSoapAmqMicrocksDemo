package nl.vs.fuse.demo.test.stub;

import javax.jms.Session;

import org.apache.activemq.broker.BrokerService;
import org.apache.activemq.command.ActiveMQDestination;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/*
 * // Set up embedded broker
 */
public class EmbeddedBrokerService {
	private static final Logger log = LoggerFactory.getLogger(EmbeddedBrokerService.class);
	public static final String BROKER_NAME = "EmbeddedBrokerService";
	public static final String BROKER_ENDPOINT = "amqp://localhost:61616/";
	public static final int ACK_MODE = Session.AUTO_ACKNOWLEDGE;
	public static final boolean TRANSACTED = false;
	public static final int RECEIVE_TIMEOUT_MS = 10000;

	private static BrokerService brokerSvc = null;

	/*
	 * Set up embedded broker
	 */
	public static void createBrokerSvc() throws Exception {
		final String methodName = "createBrokerSvc";
		log.debug(methodName + " - start");
		brokerSvc = new BrokerService();
		brokerSvc.setBrokerName(BROKER_NAME);
		brokerSvc.addConnector(BROKER_ENDPOINT);
		brokerSvc.setPersistent(false);
		brokerSvc.setUseShutdownHook(false);

		// start broker
		brokerSvc.start();
		brokerSvc.waitUntilStarted();
		log.debug(methodName + " - end");
	};

	/*
	 * Stop embedded broker
	 */
	public static void stopBrokerSvc() throws Exception {
		final String methodName = "createBrokerSvc";
		log.debug(methodName + " - start");
		brokerSvc.stop();
		brokerSvc.waitUntilStopped();
		brokerSvc = null;
		log.debug(methodName + " - end");
	}

	public static int getNoMsgsOnQueue(String amqpServiceAddress) throws Exception {
		ActiveMQDestination amqpServiceAddressQ = ActiveMQDestination.createDestination(amqpServiceAddress,
				ActiveMQDestination.QUEUE_TYPE);
		int numMessagesOnQueue = brokerSvc.getDestination(amqpServiceAddressQ).getMessageStore().getMessageCount();
		return numMessagesOnQueue;
	}

}