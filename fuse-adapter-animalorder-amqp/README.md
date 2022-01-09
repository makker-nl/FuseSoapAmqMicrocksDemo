# AnimalOrder AMQP adapter

This example project listens to an AMQP address. This can be an AMQ Artemis Broker address directly or through an Red Hat Interconnect/Apache QPid Router network. 
 A received request is posted on to a SOAP endpont, that should be mocked. Goal is to show how to do so with [microcks.io](microcks.io).

The application utilizes the Spring https://docs.spring.io/spring/docs/current/javadoc-api/org/springframework/context/annotation/ImportResource.html[`@ImportResource`] annotation to load a Camel Context definition via a _src/main/resources/spring/camel-context.xml_ file on the classpath.

## Build
To build the service:

    $ cd PROJECT_DIR
    $ mvn clean package
    

## Run the service
To run the service stand alone

    $ mvn spring-boot:run -Dspring-boot.run.profiles=dev

The service expets an AMQ Broker connection that is not run by default. A Docker-compose file to accommodate this will be provided in a later iteration.

## Test the service
The SoapUI project 	[./src/test/soapui/AnimalOrderQuoteService-soapui-project.xml](./src/test/soapui/AnimalOrderQuoteService-soapui-project.xml) can be used to test the service. Also a happy-flow unit test is run with running maven. 