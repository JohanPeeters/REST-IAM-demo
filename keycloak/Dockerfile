FROM jboss/keycloak:3.1.0.Final

RUN mkdir /opt/jboss/keycloak/standalone/configuration/realms
ADD keystore.jks /opt/jboss/keycloak/standalone/configuration
ADD standalone.xml /opt/jboss/keycloak/standalone/configuration
ADD themes /opt/jboss/keycloak/themes

USER root

RUN chown -R jboss /opt/jboss/keycloak/standalone/configuration

RUN curl -L -O https://github.com/jwilder/dockerize/releases/download/v0.3.0/dockerize-linux-amd64-v0.3.0.tar.gz
RUN tar -C /usr/local/bin -xvzf dockerize-linux-amd64-v0.3.0.tar.gz

USER jboss

RUN mkdir -p /opt/jboss/keycloak/modules/system/layers/base/org/postgresql/jdbc/main; \
  cd /opt/jboss/keycloak/modules/system/layers/base/org/postgresql/jdbc/main; \
  curl -O https://repo1.maven.org/maven2/org/postgresql/postgresql/9.4.1212/postgresql-9.4.1212.jar
ADD module.xml /opt/jboss/keycloak/modules/system/layers/base/org/postgresql/jdbc/main/
RUN cd /opt/jboss

ADD start.sh .

EXPOSE 8443

# Set the default command to run on boot
ENTRYPOINT ["./start.sh"]
