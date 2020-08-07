export MAVEN_REPO=`mvn help:evaluate -Dexpression=settings.localRepository -q -DforceStdout`

mvn dependency:get -Dartifact='mysql:mysql-connector-java:8.0.20'
mvn dependency:get -Dartifact='com.microsoft.sqlserver:mssql-jdbc:8.2.2.jre8'

if [ "$DB_FLAVOR" == "MYSQL" ]
    then
    ./set-install-properties-mysql.sh
fi

if [ "$DB_FLAVOR" == "MSSQL" ]
    then
    ./set-install-properties-mssql.sh
fi


cd ranger && \
echo "<configuration></configuration>" > security-admin/src/main/resources/conf.dist/core-site.xml && \
\
mvn -am -pl security-admin,embeddedwebserver,jisql -DskipTests package && \
mvn -am -pl embeddedwebserver -Dmdep.outputFile=classpath.out dependency:build-classpath && \
\
cd security-admin && \
\
mkdir -p jisql/lib && \
ln -s `pwd`/../jisql/target/jisql-2.1.0-SNAPSHOT.jar jisql/lib/jisql-2.1.0-SNAPSHOT.jar && \
ln -s ${MAVEN_REPO}/net/sf/jopt-simple/jopt-simple/3.2/jopt-simple-3.2.jar jisql/lib/jopt-simple-3.2.jar && \
\
mkdir ews && \
ln -s `pwd`/target/security-admin-web-2.1.0-SNAPSHOT ews/webapp && \
ln -s `pwd`/target/security-admin-web-2.1.0-SNAPSHOT/WEB-INF/classes/conf.dist/ target/security-admin-web-2.1.0-SNAPSHOT/WEB-INF/classes/conf && \
\
RANGER_ADMIN_CONF=`pwd`/scripts python2 scripts/dba_script.py -q && \
RANGER_ADMIN_CONF=`pwd`/scripts python2 scripts/db_setup.py && \
\
../../set-ranger-admin-site-props.sh && \
rm -rf ./target/security-admin-web-2.1.0-SNAPSHOT/WEB-INF/lib/ranger-plugins-audit-*.jar && \
\
echo "init-ranger-admin DONE"
