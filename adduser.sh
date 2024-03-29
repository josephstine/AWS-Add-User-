#!/bin/bash
if [ $(id -u) -eq 0 ]; then #if user id is equal to 0/root read the username,fullname, and password
	read -p "Enter username: " username 
	read -p "Enter full name: " fullname
	read -s -p "Enter password: " password
	egrep "^$username" /etc/passwd >/dev/null #print the username
	if [ $? -eq 0 ]; then #if the user exists do nothing
		echo "$user already exists!"
		exit 1
	else
		pass=$(perl -e 'print crypt($ARGV[0], "password")' $password) #hash the password using crypt and perl
		low=1001
		high=10000
		uidandgid=$((low + RANDOM%(1+high-low)))
		echo $uidandgid
		etcPasswordLine="$username:x:$uidandgid:$uidandgid:$fullname:/home/$username:/bin/bash"
		echo $etcPasswordLine >> /etc/passwd
		etcGroupLine="$username:x:$uidandgid"
		echo $etcGroupLine >> /etc/group
		echo "$username:$pass" | chpasswd
		#useradd -m -p $pass $username
		#usermod -c "$fullname" $username
		[ $? -eq 0 ] && echo "User added succesfully" || echo "User couldn't be added!"
	fi
else
	echo "root access required"
	exit 2
fi
#copy files from skel to the home of the username, make the directory,mod then, chown
cp -r /etc/skel/. /home/"$username"
mkdir -p /home/"$username"
chmod -R 770 /home/"$username" 
chown "$username":"$username" /home/"$username"

