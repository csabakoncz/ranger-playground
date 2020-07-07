mysqladmin --user=root password rootpassword && \
echo "SET GLOBAL log_bin_trust_function_creators = 1;" | mysql -uroot -prootpassword && \
\
mvn dependency:get -Dartifact='mysql:mysql-connector-java:8.0.20' && \
./set-install-properties.sh && \
\
cd ranger && \
echo "<configuration></configuration>" > security-admin/src/main/resources/conf.dist/core-site.xml && \
\
mvn -am -pl security-admin,embeddedwebserver,jisql -DskipTests package && \
mvn -am -pl embeddedwebserver -Dmdep.outputFile=classpath.out dependency:build-classpath && \
\
cd security-admin && \
\
mkdir -p jisql/lib && \
ln -s /workspace/ranger-playground/ranger/jisql/target/jisql-2.1.0-SNAPSHOT.jar jisql/lib/jisql-2.1.0-SNAPSHOT.jar && \
ln -s /workspace/m2-repository/net/sf/jopt-simple/jopt-simple/3.2/jopt-simple-3.2.jar jisql/lib/jopt-simple-3.2.jar && \
\
mkdir ews && \
ln -s /workspace/ranger-playground/ranger/security-admin/target/security-admin-web-2.1.0-SNAPSHOT ews/webapp && \
ln -s /workspace/ranger-playground/ranger/security-admin/target/security-admin-web-2.1.0-SNAPSHOT/WEB-INF/classes/conf.dist/ target/security-admin-web-2.1.0-SNAPSHOT/WEB-INF/classes/conf && \
\
RANGER_ADMIN_CONF=`pwd`/scripts python2 scripts/dba_script.py -q && \
RANGER_ADMIN_CONF=`pwd`/scripts python2 scripts/db_setup.py && \
\
../../set-ranger-admin-site-props.sh && \
rm -rf /workspace/m2-repository/org/apache/ranger/ranger-plugins-audit && \
\
echo "init-ranger-admin DONE"
