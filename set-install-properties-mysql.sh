mysqladmin --user=root password rootpassword
echo "SET GLOBAL log_bin_trust_function_creators = 1;" | mysql -uroot -prootpassword

sed -ie "s/^db_root_password=.*$/db_root_password=rootpassword/" ranger/security-admin/scripts/install.properties

sed -ie "s/^db_password=.*$/db_password=Rangerpassword@123/" ranger/security-admin/scripts/install.properties

sed -ie "s/^SQL_CONNECTOR_JAR=.*$/SSQL_CONNECTOR_JAR=unset/" ranger/security-admin/scripts/install.properties
echo "SQL_CONNECTOR_JAR=${MAVEN_REPO}/mysql/mysql-connector-java/8.0.20/mysql-connector-java-8.0.20.jar" >> ranger/security-admin/scripts/install.properties