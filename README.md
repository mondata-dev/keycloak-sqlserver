# Keycloak Docker image with Microsoft SQL Server support

This image inherits from the official keycloak docker image and adds support for Microsoft SQL Server / Azure SQL.

## Configuration

For normal configuration see the documentation of the official image: https://hub.docker.com/r/jboss/keycloak.

Additionally the following environment variables can be set:

* `MSSQL_HOST`
* `MSSQL_PORT`
* `MSSQL_DATABASE`
* `MSSQL_USER`
* `MSSQL_PASSWORD`

## Acknowledgments

This image is based on https://github.com/stocksoftware/docker-keycloak-sqlserver.