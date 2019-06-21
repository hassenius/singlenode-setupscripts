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

mv ${cluster_dir}/config.yaml ${cluster_dir}/config.yaml-original

cat <<EOF > ${cluster_dir}/config.yaml
network_type: calico
network_ip_version: ipv4
network_cidr: 172.28.0.0/16
service_cluster_ip_range: 172.29.0.0/16
cluster_name: ${cluster_name}
cluster_CA_domain: ${cluster_ca_domain}
cluster_domain: cluster.local
etcd_extra_args: ["--grpc-keepalive-timeout=0", "--grpc-keepalive-interval=0", "--snapshot-count=10000"]
etcd_data_dir: "/var/lib/etcd"
etcd_wal_dir: "/var/lib/etcd-wal"
firewall_enabled: true
fips_enabled: false
default_admin_user: admin
default_admin_password: ${password}
ansible_user: icpuser
ansible_become: true
ansible_ssh_pass: ${ssh_pass}
ansible_become_password: "{{ ansible_ssh_pass }}"
journal_path: /run/log/journal
calico_ip_autodetection_method: interface=eth0
isolated_namespaces: []
isolated_proxies: []
vip_manager: etcd
management_services:
  istio: disabled
  vulnerability-advisor: enabled
  storage-glusterfs: disabled
  storage-minio: disabled
  platform-security-netpols: disabled
  node-problem-detector-draino: disabled
  multicluster-endpoint: disabled
docker_config:
  log-opts:
    max-size: "100m"
    max-file: "10"
offline_pkg_copy_path: /u01/tic/tmp

EOF
