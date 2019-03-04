# Assignment #4 - adduser and Cloud Computing
#### Due: 11:59pm, Mar 11

### Overview
In this assignment, you will be writing a shell script wrapper for user management using usermod, userdel, and useradd as building blocks. Include a verbose option to output what is happening step by step. Alongside this, you will be writing a python script that utilizes the AWS SDK to provision a t2.micro EC2 instance. For both of your scripts, create appropriate documentation in your git repo’s README.md file. 

### Submission
No webcampus submission. Follow the link provided below to create a GitHub classroom repo to push your code to. I will be checking the two scripts and the readme for documentation. 

### To-Do
**For Git repo**
* Follow link instructions: https://classroom.github.com/a/GlVuYrot 

**Adduser script:** 
* Prompt for username, full name, and password
* Create /etc/passwd, /etc/shadow, and /etc/group entries
  * Make sure syntax is correct before you make changes to actual files
  * For /etc/shadow, see sample code for generating password hash 
* Create home directory, chmod and chown it

**AWS Script**
https://aws.amazon.com/sdk-for-python/ 
* Create SSH keypair to connect to instance with via aws SDK
  * create_key_pair() method: [Documentation](https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2.html#EC2.Client.create_key_pair)
  * Save the private key in it’s return JSON object
    * Save to a .pem file in current directory, with permissions 400
* Create an t2.micro EC2 instance
  * create_instances() method: [Documentation](https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2.html#EC2.ServiceResource.create_instances)
  * Use keypair that you created
  * Save the public IP address of the instance in it’s return JSON object
* Print out the IP address of the instance, and the path to the saved .pem private key

