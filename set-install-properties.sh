sed -ie "s/^db_root_password=.*$/db_root_password=rootpassword/" ranger/security-admin/scripts/install.properties

sed -ie "s/^db_password=.*$/db_password=rangeradmin/" ranger/security-admin/scripts/install.properties

# sed -ie "s/^SQL_CONNECTOR_JAR=.*$/SQL_CONNECTOR_JAR=\/workspace\/m2-repository\/mysql\/mysql-connector-java\/5.1.31\/mysql-connector-java-5.1.31.jar/" ranger/security-admin/scripts/install.properties
sed -ie "s/^SQL_CONNECTOR_JAR=.*$/SQL_CONNECTOR_JAR=\/workspace\/m2-repository\/mysql\/mysql-connector-java\/8.0.20\/mysql-connector-java-8.0.20.jar/" ranger/security-admin/scripts/install.properties
