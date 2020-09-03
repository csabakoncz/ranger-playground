export MAVEN_REPO=`mvn help:evaluate -Dexpression=settings.localRepository -q -DforceStdout`
export RANGER_VERSION=`mvn help:evaluate -Dexpression=project.version -q -DforceStdout`

CP=`cat classpath.out`
CP=$CP:target/embeddedwebserver-${RANGER_VERSION}.jar
CP=$CP:$MAVEN_REPO/mysql/mysql-connector-java/8.0.20/mysql-connector-java-8.0.20.jar
CP=$CP:$MAVEN_REPO/com/microsoft/sqlserver/mssql-jdbc/8.2.2.jre8/mssql-jdbc-8.2.2.jre8.jar
CP=$CP:../security-admin/src/main/resources/conf.dist

#DEBUG_OPTS= -Xdebug -Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=y
java \
    $DEBUG_OPTS \
    -Dlogdir=target/logs \
    -Dlog4j.configuration=file:../security-admin/src/main/webapp/WEB-INF/log4j.properties\
    -cp $CP org.apache.ranger.server.tomcat.EmbeddedServer
