#!/usr/bin/env bash

source ./get-args.sh

myip=$(ip route get 8.8.8.8 | awk 'NR==1 {print $NF}')

cat <<EOF > ${cluster_dir}/hosts
[master]
${myip}

[worker]
${myip}

[proxy]
${myip}

[management]
${myip}

[va]
${myip}

[etcd]
${myip}
EOF
