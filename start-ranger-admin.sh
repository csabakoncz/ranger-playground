CP=`cat classpath.out`
CP=$CP:target/embeddedwebserver-2.1.0-SNAPSHOT.jar
CP=$CP:/workspace/m2-repository/mysql/mysql-connector-java/8.0.20/mysql-connector-java-8.0.20.jar

java \
    -Dlogdir=target/logs \
    -Dlog4j.configuration=file:../security-admin/src/main/webapp/WEB-INF/log4j.properties\
    -cp $CP org.apache.ranger.server.tomcat.EmbeddedServer