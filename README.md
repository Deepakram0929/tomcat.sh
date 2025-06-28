### Step 1: Connect to EC2 Instance
```
ssh -i <your-key.pem> ec2-user@<your-ec2-public-ip>
```
### Step 2: Install Java (Tomcat prerequisite)
Check if Java is installed:
```
java -version
```
If not installed, install Java:
```
sudo yum update -y
sudo yum install java-1.8.0 -y
```
or for Amazon Linux 2023:
```
sudo dnf install java-11-amazon-corretto -y
```
### Step 3: Download Tomcat
```
https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.106/bin/apache-tomcat-9.0.106.tar.gz
```
### Step 4: Extract Tomcat
```
sudo tar -xvf apache-tomcat-9.0.106.tar.gz
```
### Step 5: Enter inside extracted file
```
cd apache-tomcat-9.0.106
```
### Step 6: Enter inside bin directory and start tomcat server and stop 
```
cd bin
ls
bash startup.sh
bash shutdown.sh
```
### Step 7: Configure Security Group in AWS
Go to your EC2 console.
Select the instance → Security → Security Groups → Edit inbound rules.
Add rule:
```
Type	  Protocol	Port	Source
Custom	TCP	      8080	0.0.0.0/0
```
### Step 8: Access Tomcat Web UI
Open your browser:
```
http://<Your-EC2-Public-IP>:8080
```
### Step 9: Configure Tomcat Users
```
sudo nano /apache-tomcat-9.0.106/conf/tomcat-users.xml
```
Add this inside <tomcat-users>:
```
 <role rolename="manager-gui"/>
 <role rolename="manager-script"/>
 <role rolename="admin-gui"/>
 <user username="tomcat" password="tomcat" roles="manager-gui"/>
 <user username="admin" password="admin" roles="manager-gui,admin-gui,manager-script"/>
```
Save (Ctrl + O, Enter, Ctrl + X) and restart Tomcat:
```
sudo /apache-tomcat-9.0.106/bin/shutdown.sh
sudo /apache-tomcat-9.0.106/bin/startup.sh
```
## Tomcat is installed and running on Amazon Linux


