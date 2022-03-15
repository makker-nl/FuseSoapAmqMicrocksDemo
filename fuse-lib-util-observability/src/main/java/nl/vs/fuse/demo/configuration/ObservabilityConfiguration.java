package nl.vs.fuse.demo.configuration;

import org.springframework.context.annotation.ImportResource;
import org.springframework.context.annotation.Configuration;

/** 
 * This empty class only loads the imported bean configuration file into the application context	
*/
@Configuration
@ImportResource("classpath:spring/util-observability.xml")
public class ObservabilityConfiguration{

};
