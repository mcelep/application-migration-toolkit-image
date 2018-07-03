#!/bin/bash

set -ex

oc new-app . --docker-image=registry.access.redhat.com/jboss-eap-7/eap71-openshift --name rhamt --strategy source --build-env ARTIFACT_DIR=target/dependency --build-env MAVEN_ARGS="-e -Popenshift -DskipTests -Dcom.redhat.xpaas.repo.redhatga dependency:copy-dependencies" -e MQ_QUEUES=executorQueue,statusUpdateQueue,packageDiscoveryQueue -e MQ_TOPICS=executorCancellation -e DB_SERVICE_PREFIX_MAPPING=rhamt-mysql=DB -e DB_JNDI=java:jboss/datasources/WindupServicesDS -e DB_USERNAME=rhamt -e DB_PASSWORD=rhamt2018 -e DB_DATABASE=rhamt -e RHAMT_MYSQL_SERVICE_HOST=mysql.rhamt.svc  -e RHAMT_MYSQL_SERVICE_PORT=3306
oc start-build rhamt --from-dir .
