#!/usr/bin/env bash

echo "Creating directory structure in /u01"
mkdir -p  /u01/tic/var/lib/docker /u01/tic/var/lib/etcd /u01/tic/var/lib/icp /u01/tic/var/lib/kubelet /u01/tic/var/log/cloudsight /u01/tic/opt/ibm-cloud-private-3.1.2  /u01/tic/var/lib/etcd-wal

echo "Creating /var directory structure"
mkdir -p /var/lib/docker /var/lib/etcd /var/lib/icp /var/lib/kubelet /var/log/cloudsight /var/lib/etcd-wal

# Create mountpoint for cluster config
echo "Create mountpoint for cluster config"
mkdir -p /opt/ibm-cloud-private-3.1.2
chown -R admicp02:admicp02 /opt/ibm-cloud-private-3.1.2

# Create storage point for cluster config
echo "Create storage point for cluster config"
mkdir -p /u01/tic/ibm-cloud-private-3.1.2
chown -R admicp02:admicp02   /u01/tic/ibm-cloud-private-3.1.2

# Setup mount
echo "Update fstab"
cat <<EOF >>scrpfile
/u01/tic/var/lib/docker /var/lib/docker  ext4 bind    0       0
/u01/tic/var/lib/etcd /var/lib/etcd  ext4 bind    0       0
/u01/tic/var/lib/icp /var/lib/icp  ext4 bind    0       0
/u01/tic/var/lib/kubelet /var/lib/kubelet  ext4 bind    0       0
/u01/tic/var/log/cloudsight /var/log/cloudsight  ext4 bind    0       0
/u01/tic/ibm-cloud-private-3.1.2  /opt/ibm-cloud-private-3.1.2 ext4 bind    0       0
EOF

echo "Mounting..."
mount -a
