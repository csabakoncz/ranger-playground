export MAVEN_REPO=`mvn help:evaluate -Dexpression=settings.localRepository -q -DforceStdout`

CP=`cat classpath.out`
CP=$CP:target/embeddedwebserver-2.1.0-SNAPSHOT.jar
CP=$CP:$MAVEN_REPO/mysql/mysql-connector-java/8.0.20/mysql-connector-java-8.0.20.jar
CP=$CP:$MAVEN_REPO/com/microsoft/sqlserver/mssql-jdbc/8.2.2.jre8/mssql-jdbc-8.2.2.jre8.jar
CP=$CP:../security-admin/src/main/resources/conf.dist

java \
    -Dlogdir=target/logs \
    -Dlog4j.configuration=file:../security-admin/src/main/webapp/WEB-INF/log4j.properties\
    -cp $CP org.apache.ranger.server.tomcat.EmbeddedServer