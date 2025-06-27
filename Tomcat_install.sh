#!/bin/bash

# Update the system
sudo yum update -y

# Install necessary packages
sudo yum install -y wget tar java-1.8.0-openjdk

# Download Tomcat 9
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.106/bin/apache-tomcat-9.0.106.tar.gz

# Extract Tomcat
tar -xvf apache-tomcat-9.0.106.tar.gz

# Move Tomcat to /opt directory
sudo mv apache-tomcat-9.0.106 /opt/tomcat9

# Grant permission
sudo chmod -R 755 /opt/tomcat9

# Configure context.xml to allow remote access
sudo tee /opt/tomcat9/webapps/manager/META-INF/context.xml > /dev/null <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<Context antiResourceLocking="false" privileged="true">
    <CookieProcessor className="org.apache.tomcat.util.http.Rfc6265CookieProcessor"
                     sameSiteCookies="strict" />
    <Valve className="org.apache.catalina.valves.RemoteAddrValve"
           allow=".*" />
    <Manager sessionAttributeValueClassNameFilter="java\\.lang\\.(?:Boolean|Integer|Long|Number|String)|org\\.apache\\.catalina\\.filters\\.CsrfPreventionFilter\\\$LruCache(?:\\\$1)?|java\\.util\\.(?:Linked)?HashMap"/>
</Context>
EOF

# Configure tomcat-users.xml to allow GUI login
sudo tee /opt/tomcat9/conf/tomcat-users.xml > /dev/null <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<tomcat-users xmlns="http://tomcat.apache.org/xml"
               xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
               xsi:schemaLocation="http://tomcat.apache.org/xml tomcat-users.xsd"
               version="1.0">

    <role rolename="manager-gui"/>
    <role rolename="manager-script"/>
    <role rolename="admin-gui"/>
    <user username="tomcat" password="tomcat" roles="manager-gui"/>
    <user username="admin" password="admin" roles="manager-gui,admin-gui,manager-script"/>

</tomcat-users>
EOF

# Change port from 8080 to 9090 (optional)
sudo sed -i 's/port="8080"/port="9090"/g' /opt/tomcat9/conf/server.xml

# Start Tomcat
sudo /opt/tomcat9/bin/startup.sh

echo "Tomcat has been installed and started successfully on port 9090."
echo "Access it via http://<Your-Public-IP>:9090"
