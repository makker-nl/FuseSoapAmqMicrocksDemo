# From: https://catalog.redhat.com/software/containers/fuse7/fuse-java-openshift-jdk11-rhel8/60891f51b6f68e29bbcc6cdb
FROM registry.redhat.io/fuse7/fuse-java-openshift-jdk11-rhel8
USER jboss
WORKDIR /deployments
COPY --chown=jboss:jboss target/fuse-adapter-animalorder-amqp*.jar /deployments
EXPOSE 8080
