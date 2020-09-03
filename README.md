# Ranger admin server playground

## MySQL DB on Gitpod
This project uses `gitpod/workspace-mysql` Docker image. On workspace creation a MySQL DB is started,
the init script builds Ranger admin and starts the webapp.

## MySQL DB on localhost
Should work, but the steps need to be specified. TBD

## MSSQL on localhost

```
# start DB:
docker run --name  ranger-mssql -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=1234Password' -p 1433:1433 -d mcr.microsoft.com/mssql/server:2017-CU8-ubuntu

# build and configure Ranger for MSSQL
DB_FLAVOR=MSSQL ./init-ranger-admin.sh

# start Ranger Admin:
cd ranger/embeddedwebserver && ../../start-ranger-admin.sh

```