FROM tomcat:7.0

RUN apt-get update && apt-get install -y wget  default-jdk 

ENV MAVEN_FILE apache-maven-3.3.9

WORKDIR /usr/local
RUN wget http://apache.mindstudios.com/maven/maven-3/3.3.9/binaries/${MAVEN_FILE}-bin.tar.gz && \
    tar -xvf ${MAVEN_FILE}-bin.tar.gz && \
    rm -rf ${MAVEN_FILE}-bin.tar.gz && \
    cd ${MAVEN_FILE} && \ 
    cp -r bin conf lib boot /usr/local/

COPY server.xml /usr/local/tomcat/conf/server.xml

EXPOSE 80

WORKDIR /usr/local/tomcat
CMD [ "bin/catalina.sh", "run"]
