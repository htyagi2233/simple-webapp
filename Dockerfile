FROM tomcat:9-jdk11

RUN rm -rf /usr/local/tomcat/webapps/*

COPY target/simple-webapp.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
