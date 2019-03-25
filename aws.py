#!/usr/bin/env python 
import boto3
import os


ec2 = boto3.resource('ec2')

#if there is a duplicate keyname already created the program will return an error as the key is already created
keyname = raw_input("Enter keyname (do not end with .pem) must be a new key: ")
filename = keyname + ".pem"

# create a file to store the key in current directory
outfile = open(filename,'w')

# call the boto ec2 function to create a key pair
key_pair = ec2.create_key_pair(KeyName=keyname)

# capture the key and store it in a file
KeyPairOut = str(key_pair.key_material)
print("Setting up the instance. Please wait")
outfile.write(KeyPairOut)
os.chmod(filename,0400) #chmod it with the permissions 400

# create a new EC2 instance
instances = ec2.create_instances(
     ImageId='ami-0de7daa7385332688',
     MinCount=1,
     MaxCount=1,
     InstanceType='t2.micro',
     KeyName=keyname,
)

instance = instances[0]
instance.wait_until_running()
instance.load()

#prints the ip of the instance once it is running
print(instance.public_dns_name)
#prints the path to the .pem private key that is stored locally
print(os.path.dirname(os.path.abspath(filename)))
