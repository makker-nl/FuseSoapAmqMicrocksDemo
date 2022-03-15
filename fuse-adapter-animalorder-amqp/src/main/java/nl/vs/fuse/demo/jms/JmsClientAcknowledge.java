package nl.vs.fuse.demo.jms;

import javax.jms.JMSException;
import javax.jms.Message;
import org.apache.camel.Exchange;
import org.apache.camel.component.jms.JmsMessage;
import org.apache.camel.support.SynchronizationAdapter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


/** configures the camel route to acknowledge a JMS transaction upon successful route completion, 
 * after which the input message is removed from the source queue. 
 * 
 * Unhandled errors will result in an unacknowledged JMS transaction, 
 * in which case the input message to remains on the source queue
*/
public class JmsClientAcknowledge {

	private static final Logger LOG = LoggerFactory.getLogger(JmsClientAcknowledge.class);
	
	 /**
	 * Prepare the exchange to append a JMS client acknowledgement on completion
	 * @param exchange the Camel exchange
	 */
	public void prepareForAcknowledge(Exchange exchange) throws JMSException {
		final Message jms = exchange.getIn(JmsMessage.class).getJmsMessage();

		exchange.addOnCompletion(new SynchronizationAdapter() {
			@Override
			public void onComplete(Exchange exchange) {
				LOG.debug("Using JMS client acknowledge to accept the JMS message that has been consumed: {}", jms);
				try {
					jms.acknowledge();
				} catch (JMSException e) {
					LOG.warn("JMS client acknowledge failed due: " + e.getMessage(), e);
				}
			}
		});
	}
}
