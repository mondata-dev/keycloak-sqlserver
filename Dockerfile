# based on the docker file of https://github.com/stocksoftware/docker-keycloak-sqlserver

FROM jboss/keycloak:8.0.2

ADD changeDatabase.xsl /opt/jboss/keycloak/

RUN mkdir -p /opt/jboss/keycloak/modules/system/layers/base/com/microsoft/sqlserver/main
ADD module.xml /opt/jboss/keycloak/modules/system/layers/base/com/microsoft/sqlserver/main/
ADD sqljdbc_7.2/enu/mssql-jdbc-7.2.2.jre8.jar /opt/jboss/keycloak/modules/system/layers/base/com/microsoft/sqlserver/main/

ADD saxon-he-10.3.jar /opt/saxon.jar

RUN java -jar /opt/saxon.jar \
        -s:/opt/jboss/keycloak/standalone/configuration/standalone.xml \
        -xsl:/opt/jboss/keycloak/changeDatabase.xsl \
        -o:/opt/jboss/keycloak/standalone/configuration/standalone.xml && \
    java -jar /opt/saxon.jar \
        -s:/opt/jboss/keycloak/standalone/configuration/standalone-ha.xml \
        -xsl:/opt/jboss/keycloak/changeDatabase.xsl \
        -o:/opt/jboss/keycloak/standalone/configuration/standalone-ha.xml && \
    rm /opt/jboss/keycloak/changeDatabase.xsl
