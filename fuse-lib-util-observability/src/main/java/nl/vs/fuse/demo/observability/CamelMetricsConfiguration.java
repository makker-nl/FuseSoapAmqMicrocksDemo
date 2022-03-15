package nl.vs.fuse.demo.observability;

import org.apache.camel.CamelContext;
import org.apache.camel.component.micrometer.messagehistory.MicrometerMessageHistoryFactory;
import org.apache.camel.component.micrometer.routepolicy.MicrometerRoutePolicyFactory;
import org.apache.camel.spring.boot.CamelContextConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Automatically loads Camel metrics configuration to all routes for performance measures
 */
@Configuration
public class CamelMetricsConfiguration {

	/**
	 * Loads Camel metrics configuration to all routes for performance measures
	 */
	@Bean
	public CamelContextConfiguration camelContextConfiguration() {
		return new CamelContextConfiguration() {
			public void beforeApplicationStart(CamelContext camelContext) {
				camelContext.addRoutePolicyFactory(new MicrometerRoutePolicyFactory());
				camelContext.setMessageHistoryFactory(new MicrometerMessageHistoryFactory());
			}

			public void afterApplicationStart(CamelContext camelContext) {
			}
		};
	}
}