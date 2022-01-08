# FuseSoapAmqMicrocksDemo
Demo with Fuse, AMQ and Microcks using Docker Compose

# Generate Fuse Skeleton Project

Generate a Fuse 7.10 Spring Boot skeleton project, using maven Arche type:

    mvn org.apache.maven.plugins:maven-archetype-plugin:2.4:generate \
      -DarchetypeCatalog=https://maven.repository.redhat.com/ga/io/fabric8/archetypes/archetypes-catalog/2.2.0.fuse-sb2-7_10_0-00015-redhat-00001/archetypes-catalog-2.2.0.fuse-sb2-7_10_0-00015-redhat-00001-archetype-catalog.xml \
      -DarchetypeGroupId=org.jboss.fuse.fis.archetypes \
      -DarchetypeArtifactId=spring-boot-camel-xml-archetype \
      -DarchetypeVersion=2.2.0.fuse-sb2-7_10_0-00015-redhat-00001 \
      -DgroupId=nl.vs.fuse.demo \
      -DartifactId=fuse-adapter-animalorder-soap \
      -Dversion=1.0.0-SNAPSHOT \
      -Dpackage=nl.vs.fuse.demo

# Adapter Projects
## Fuse adapter AnimalOrder SOAP
The project [fuse-adapter-animalorder-soap](fuse-adapter-animalorder-soap/README.md) provides a SOAP service that publishes the request to an AMQ broker.

