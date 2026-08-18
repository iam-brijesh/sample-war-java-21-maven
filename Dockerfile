FROM tomcat:10-jdk21

COPY target/hello-world.war /usr/local/tomcat/webapps/hello-world.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
