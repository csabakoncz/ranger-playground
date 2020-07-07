LINES=$(wc -l src/main/resources/conf.dist/ranger-admin-site.xml | cut -d ' ' -f 1)
# echo $LINES
LINES1=$((LINES - 1))
# echo $LINES1
head -n $LINES1 src/main/resources/conf.dist/ranger-admin-site.xml > /tmp/site.xml.tmp
echo "<property><name>xa.webapp.dir</name><value>../security-admin/target/security-admin-web-2.1.0-SNAPSHOT</value><description></description></property>" >> /tmp/site.xml.tmp
echo "<property><name>servername</name><value>rangeradmin</value><description></description></property>" >> /tmp/site.xml.tmp
echo "</configuration>" >> /tmp/site.xml.tmp

mv /tmp/site.xml.tmp src/main/resources/conf.dist/ranger-admin-site.xml