#!/bin/bash

# Update system (optional but recommended)
sudo yum update -y

# Install wget and tar if not present
sudo yum install wget tar -y

# Download Tomcat 9
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.106/bin/apache-tomcat-9.0.106.tar.gz

# Extract Tomcat
tar -xvf apache-tomcat-9.0.106.tar.gz

# Move to Tomcat directory
cd apache-tomcat-9.0.106
