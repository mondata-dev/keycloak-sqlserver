# based on the docker file of https://github.com/stocksoftware/docker-keycloak-sqlserver

FROM jboss/keycloak:6.0.1

ADD changeDatabase.xsl /opt/jboss/keycloak/

RUN mkdir -p /opt/jboss/keycloak/modules/system/layers/base/com/microsoft/sqlserver/main
ADD module.xml /opt/jboss/keycloak/modules/system/layers/base/com/microsoft/sqlserver/main/
ADD sqljdbc_7.2/enu/mssql-jdbc-7.2.2.jre8.jar /opt/jboss/keycloak/modules/system/layers/base/com/microsoft/sqlserver/main/

RUN java -jar /usr/share/java/saxon.jar -s:/opt/jboss/keycloak/standalone/configuration/standalone.xml -xsl:/opt/jboss/keycloak/changeDatabase.xsl -o:/opt/jboss/keycloak/standalone/configuration/standalone.xml; java -jar /usr/share/java/saxon.jar -s:/opt/jboss/keycloak/standalone/configuration/standalone-ha.xml -xsl:/opt/jboss/keycloak/changeDatabase.xsl -o:/opt/jboss/keycloak/standalone/configuration/standalone-ha.xml; rm /opt/jboss/keycloak/changeDatabase.xsl