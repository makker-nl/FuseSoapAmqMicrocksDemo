package nl.vs.fuse.demo.animalorder.webservice;

import org.apache.camel.component.cxf.CxfEndpoint;
import org.apache.camel.component.cxf.DataFormat;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import nl.vs.fuse.demo.animalorder.webservices.AnimalOrderServiceProvider;

@Configuration
public class AnimalOrderServiceConfig {

	String animalOrderSvcServiceNameSpaceWsdlUrl = "wsdl/AnimalOrderService.wsdl";
	

	@Value("${aoSvc.mock.remote.soap.endpoint}")
	String animalOrderSvcEndpoint;

	String animalOrderSvcServiceNameSpace = "http://xmlns.vs.nl/fuse/demo/wsdl/AnimalOrders";
	String animalOrderSvcPortName = "order_pttPort";
	String animalOrderSvcServiceName = "order_ptt";

	@Bean
	public CxfEndpoint mockAnimalOrderSvcSOAPEndpoint() {
		CxfEndpoint cxfEndpoint = new CxfEndpoint();
		cxfEndpoint.setAddress(animalOrderSvcEndpoint);
		cxfEndpoint.setWsdlURL(animalOrderSvcServiceNameSpaceWsdlUrl);
		cxfEndpoint.setEndpointNameString("{" + animalOrderSvcServiceNameSpace + "}" + animalOrderSvcPortName);
		cxfEndpoint.setServiceNameString("{" + animalOrderSvcServiceNameSpace + "}" + animalOrderSvcServiceName);
		// Important: POJO is default
		cxfEndpoint.setDataFormat(DataFormat.PAYLOAD);
		cxfEndpoint.setServiceClass(AnimalOrderServiceProvider.class);
		return cxfEndpoint;
	}

}
