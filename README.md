# Keycloak Docker image with Microsoft SQL Server support

This image inherits from the official keycloak docker image and adds support for Microsoft SQL Server / Azure SQL.
It uses the official jdbc driver from https://docs.microsoft.com/de-de/sql/connect/jdbc/download-microsoft-jdbc-driver-for-sql-server?view=sql-server-2017.

## Configuration

For normal configuration see the documentation of the official image: https://hub.docker.com/r/jboss/keycloak.

Additionally the following environment variables can be set:

* `MSSQL_HOST`
* `MSSQL_PORT`
* `MSSQL_DATABASE`
* `MSSQL_USER`
* `MSSQL_PASSWORD`

## Development

Make sure docker is installed and running: `sudo service docker start`

### Building the docker image

```bash
docker build -t docker.io/mondata/keycloak-sqlserver:TAG .
```

### Publishing the docker image to docker hub

If you have not done this earlier, login with docker hub:

```bash
docker login
```

Then, push the image:

```bash
docker push mondata/keycloak-sqlserver:TAG
```

## Acknowledgments

This image is based on https://github.com/stocksoftware/docker-keycloak-sqlserver.