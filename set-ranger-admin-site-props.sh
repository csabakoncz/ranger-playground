LINES=$(wc -l src/main/resources/conf.dist/ranger-admin-site.xml | sed -e 's/^ *//' | cut -d ' ' -f 1)
# echo $LINES
LINES1=$((LINES - 1))
# echo $LINES1
head -n $LINES1 src/main/resources/conf.dist/ranger-admin-site.xml > /tmp/site.xml.tmp
echo "<property><name>xa.webapp.dir</name><value>../security-admin/target/security-admin-web-${RANGER_VERSION}</value><description></description></property>" >> /tmp/site.xml.tmp
echo "<property><name>servername</name><value>rangeradmin</value><description></description></property>" >> /tmp/site.xml.tmp
if [ "$DB_FLAVOR" == "MSSQL" ]
    then
    echo "<property><name>xa.db.flavor</name><value>MSSQL</value><description></description></property>" >> /tmp/site.xml.tmp
fi
echo "</configuration>" >> /tmp/site.xml.tmp

mv /tmp/site.xml.tmp src/main/resources/conf.dist/ranger-admin-site.xml

python2.7 ./scripts/update_property.py ranger.jpa.jdbc.password 'Rangerpassword@123' src/main/resources/conf.dist/ranger-admin-site.xml

if [ "$DB_FLAVOR" == "MSSQL" ]
    then
    python2.7 ./scripts/update_property.py ranger.jpa.jdbc.url 'jdbc:log4jdbc:sqlserver://localhost;databaseName=ranger' src/main/resources/conf.dist/ranger-admin-site.xml
fi