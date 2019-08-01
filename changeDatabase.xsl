<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ds="urn:jboss:domain:datasources:5.0">

    <xsl:output method="xml" indent="yes"/>

    <!-- start by copying everything -->
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="//ds:subsystem/ds:datasources/ds:datasource[@jndi-name='java:jboss/datasources/KeycloakDS']">
        <datasource jndi-name="java:jboss/datasources/KeycloakDS" enabled="true" use-java-context="true" pool-name="KeycloakDS" use-ccm="true">
            <connection-url>jdbc:sqlserver://${env.MSSQL_HOST}:${env.MSSQL_PORT:1433};database=${env.MSSQL_DATABASE:keycloak};encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;</connection-url>
            <driver>sqlserver</driver>
            <security>
              <user-name>${env.MSSQL_USER:keycloak}</user-name>
              <password>${env.MSSQL_PASSWORD:password}</password>
            </security>
            <validation>
                <check-valid-connection-sql>SELECT 1</check-valid-connection-sql>
                <background-validation>true</background-validation>
                <background-validation-millis>60000</background-validation-millis>
            </validation>
            <pool>
                <flush-strategy>IdleConnections</flush-strategy>
            </pool>
        </datasource>
    </xsl:template>

    <xsl:template match="//ds:subsystem/ds:datasources/ds:drivers">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
            <driver name="sqlserver" module="com.microsoft.sqlserver">
                <!-- via https://access.redhat.com/documentation/en-us/jboss_enterprise_application_platform/6.2/html/administration_and_configuration_guide/example_microsoft_sqlserver_xa_datasource -->
                <xa-datasource-class>com.microsoft.sqlserver.jdbc.SQLServerXADataSource</xa-datasource-class>
            </driver>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
