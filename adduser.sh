#!/bin/bash
if [ $(id -u) -eq 0 ]; then
	read -p "Enter username: " username
	read -p "Enter full name: " fullname
	read -s -p "Enter password: " password
	egrep "^$username" /etc/passwd >/dev/null
	if [ $? -eq 0 ]; then
		echo "$user already exists!"
		exit 1
	else
		pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
		useradd -m -p $pass $username
		usermod -c "$fullname" $username
		[ $? -eq 0 ] && echo "User added succesfully" || echo "User couldn't be added!"
	fi
else
	echo "root access required"
	exit 2
fi

cp -r /etc/skel/. /home/"$username"
mkdir -p /home/"$username"
#usermod -d /home/"$username" "$username"
chown "$username":"$username" /home/"$username"
