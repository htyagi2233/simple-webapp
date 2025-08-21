FROM tomcat:9.0-jdk11
# पुराना default ROOT हटाएं
RUN rm -rf /usr/local/tomcat/webapps/*
# हमारी WAR deploy करें
COPY target/AddressBook-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
