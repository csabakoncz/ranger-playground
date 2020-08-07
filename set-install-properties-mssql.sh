sed -ie "s/^db_root_password=.*$/db_root_password=rootpassword/" ranger/security-admin/scripts/install.properties
sed -ie "s/^db_password=.*$/db_password=Rangerpassword@123/" ranger/security-admin/scripts/install.properties
sed -ie "s/^DB_FLAVOR=.*$/DB_FLAVOR=MSSQL/" ranger/security-admin/scripts/install.properties
sed -ie "s/^db_root_user=.*$/db_root_user=SA/" ranger/security-admin/scripts/install.properties

sed -ie "s/^SQL_CONNECTOR_JAR=.*$/SSQL_CONNECTOR_JAR=unset/" ranger/security-admin/scripts/install.properties
echo "$MAVEN_REPO/com/microsoft/sqlserver/mssql-jdbc/8.2.2.jre8/mssql-jdbc-8.2.2.jre8.jar" >> ranger/security-admin/scripts/install.properties
