package nl.vs.fuse.demo.animalorder.webservices;

import javax.xml.soap.SOAPMessage;
import javax.xml.ws.Provider;

import org.springframework.stereotype.Component;

@Component
public class AnimalOrderServiceProvider implements Provider<SOAPMessage> {

	@Override
	public SOAPMessage invoke(SOAPMessage soapMessage) {
		return null;
	}

	public SOAPMessage order(SOAPMessage soapMessage) {
		return null;
	}
}
