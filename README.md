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

### Add support for national characters in group names:

```

# connect to SQL server:
docker exec -it ranger-mssql /opt/mssql-tools/bin/sqlcmd -d ranger -U rangeradmin -P 'Rangerpassword@123'

ALTER TABLE [dbo].[x_group] DROP CONSTRAINT x_group$x_group_UK_group_name;
GO

alter table x_group alter column group_name nvarchar(1700);
GO

alter table x_group add CONSTRAINT [x_group$x_group_UK_group_name] UNIQUE NONCLUSTERED ( [group_name] ASC ) WITH (PAD_INDEX = OFF,STATISTICS_NORECOMPUTE = OFF,IGNORE_DUP_KEY = OFF,ALLOW_ROW_LOCKS = ON,ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];
GO
```

Test it:
```
# Create a user:
curl -v -H "accept:application/json" -H "content-type:application/json" -X POST -d '{"loginId":"csaba4user","firstName":"csaba4user", "lastName": "csaba4user"}' -u "admin:admin" http://localhost:6080/service/users/default

# create a group
curl -v -H "accept:application/json" -H "content-type:application/json" -X POST -d '{"xuserInfo":{"name":"csaba4user","description":"csaba4user - add from Unix box","groupNameList":[],"userRoleList":[]},"xgroupInfo":[{"name":"csabathai测试组","description":"add from Unix box","groupType":"1","groupSource":"1"}]}' -u "admin:admin" http://localhost:6080/service/xusers/users/userinfo

```