#!/usr/bin/env bash

echo "Creating directory structure in /u01"
mkdir -p  /u01/tic/var/lib/docker /u01/tic/var/lib/etcd /u01/tic/var/lib/icp /u01/tic/var/lib/kubelet /u01/tic/var/log/cloudsight /u01/tic/opt/ibm-cloud-private-3.1.2  /u01/tic/var/lib/etcd-wal

echo "Creating /var directory structure"
mkdir -p /var/lib/docker /var/lib/etcd /var/lib/icp /var/lib/kubelet /var/log/cloudsight /var/lib/etcd-wal

# Create mountpoint for cluster config
echo "Create mountpoint for cluster config"
mkdir -p /opt/ibm-cloud-private-3.2.0
chown -R admicp02:admicp02 /opt/ibm-cloud-private-3.2.0

# Create storage point for cluster config
echo "Create storage point for cluster config"
mkdir -p /u01/tic/ibm-cloud-private-3.2.0
chown -R admicp02:admicp02   /u01/tic/ibm-cloud-private-3.2.0

# Setup mount
echo "Update fstab"
cat <<EOF >>scrpfile
/dev/sdc1 on /u01 type ext4 (rw,relatime,seclabel,data=ordered)
/dev/sdc1 on /var/lib/docker type ext4 (rw,relatime,seclabel,data=ordered)
/dev/sdc1 on /var/lib/etcd type ext4 (rw,relatime,seclabel,data=ordered)
/dev/sdc1 on /var/lib/icp type ext4 (rw,relatime,seclabel,data=ordered)
/dev/sdc1 on /var/lib/kubelet type ext4 (rw,relatime,seclabel,data=ordered)
/dev/sdc1 on /var/log/cloudsight type ext4 (rw,relatime,seclabel,data=ordered)
/dev/sdc1 on /opt/ibm-cloud-private-3.2.0 type ext4 (rw,relatime,seclabel,data=ordered)
/dev/sdc1 on /var/lib/etcd-wal type ext4 (rw,relatime,seclabel,data=ordered)
EOF

echo "Mounting..."
mount -a
