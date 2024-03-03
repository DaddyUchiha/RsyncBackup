#!/bin/bash

echo -e "\033[1;33mTool is used to create Backup using rysnc\033[0m"

start="Backup Using Rsync"

for ((i=0; i<${#start};i++)); do
	echo -ne "\033[0;31m${start:i:1}\033[0m"
	sleep 0.1
done

echo 

read -e -p "Enter the file do you want to Backup : " file

echo

read -p "Enter the Name of output result file : " output
echo

read -p "Where do you want to backup [remote] or [local] : " destination

echo 
function local {

read -p "Do you want to save your Output File in Present working Directory? [yes] [no] : " present

if [ ${present} = "yes" ]; then
	if [ -e ${file} ]; then
		echo $(sudo rsync -avz --compress-level=9 --compress-choice=lz4 ${file} ${output})
	fi
elif [ ${present} = "no" ]; then	
	read -e -p "Provide absolute path location : " path
	if [ -e ${file} ]; then
		echo $(sudo rsync -avz --compress-level=9 --compress-choice=lz4 ${file} ${path}${output})
	fi
else
	echo "error"
	exit 1
fi
}

function remote {
echo -e "\033[1;31mYou selected remote Backup option\033[0m"

echo 

read -p "Enter HOSTNAME of remote machine : " hostname

read -p "Enter IPADDRESS of remote machine : " ip

echo $(rsync -avz --compress-level=9 --compress-choice=lz4 -e ssh ${file} ${hostname}@${ip}:/home/${hostname}/${output})

}
if [ ${destination} = "local" ];then
	local
elif [ ${destination} = "remote" ]; then
	remote
else
	echo "Something unexpected error"
	exit 1
fi
