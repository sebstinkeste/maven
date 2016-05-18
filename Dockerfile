FROM java:7-jdk
FROM tomcat:7.0

RUN apt-get update && apt-get install -y wget  default-jdk 

ENV MAVEN_VERSION apache-maven-3.3.9

WORKDIR /usr/local
RUN wget http://apache.mindstudios.com/maven/maven-3/3.3.9/binaries/${MAVEN_VERSION}-bin.tar.gz && \
    tar -xvf ${MAVEN_VERSION}-bin.tar.gz && \
    rm -rf ${MAVEN_VERSION}-bin.tar.gz && \
    cd ${MAVEN_VERSION} && \ 
    cp -r bin conf lib boot /usr/local/

COPY server.xml /usr/local/tomcat/conf/server.xml


ADD entrypoint.sh /entrypoint.sh
RUN chmod 750 /entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]

CMD [ "/usr/local/tomcat/bin/catalina.sh", "run"]
