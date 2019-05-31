#!/usr/bin/env bash
user="admicp01"
while getopts ":u:p:" arg; do
    case "${arg}" in
      u)
        user=${OPTARG}
        ;;
      p)
        password=${OPTARG}
        ;;
      \?)
        echo "Invalid option : -$OPTARG in commmand $0 $*" >&2
        exit 1
        ;;
      :)
        echo "Missing option argument for -$OPTARG in command $0 $*" >&2
        exit 1
        ;;
    esac
done


echo "Adding ${user}"
useradd ${user}
usermod -a -G wheel ${user}
echo "${password}" | passwd --stdin ${user}

echo "Generating private key for ${user}"
su - ${user} -c "ssh-keygen -b 4096 -f ~/.ssh/id_rsa -N ''"
su - ${user} -c "cp ~/.ssh/id_rsa.pub ~/.ssh/authorized_keys"
