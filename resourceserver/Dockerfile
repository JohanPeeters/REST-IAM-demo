FROM openjdk:8u111-jre-alpine

ARG RELEASE=3.0.3

RUN apk upgrade --update && apk add --update libstdc++ curl ca-certificates bash

WORKDIR /opt/

RUN curl -sL https://github.com/SoftInstigate/restheart/releases/download/${RELEASE}/restheart-${RELEASE}.tar.gz --output restheart.tar.gz \
&& tar -zxvf restheart.tar.gz \
&& mv restheart-${RELEASE} restheart \
&& rm -f restheart.tar.gz

WORKDIR /opt/restheart
COPY etc/* /opt/restheart/etc/
COPY entrypoint.sh /opt/restheart/
COPY mongodbcert.cer /opt/restheart

RUN keytool -importcert -file /opt/restheart/mongodbcert.cer -keystore $JAVA_HOME/lib/security/cacerts -storepass changeit -noprompt -alias "mongodbselfsignedcert"

RUN chmod +x /opt/restheart/entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
CMD ["etc/restheart.yml"]
EXPOSE 8080 4443