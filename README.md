

# Setup disks
As root:
```
./disksetup.sh
```

# User setup
As root:
```
./usersetup.sh -u <username> -p <password>
```

# Install docker
As user with sudo access
```
./install-docker.sh -o <docker_package_location>
```

# Load image
As user with sudo access
```
./load-image.sh -f <image_file>
```

# Create the cluster directory
As user with sudo access
```
./copy_cluster_skel.sh -d <cluster_dir>
```

# Generate the configs
As user with sudo access
```
./generateconfigs.sh -d <cluster_dir> -p <icp_admin_password> -n <cluster_name> -a <cluster_ca_domain> -s <ssh_pass>
```

# Start installation
As user with sudo access
```
./start_install.sh -c install -d <cluster_dir> 
```


# Update certificates after install
As user with kubectl permissions
```
./update_certificate.sh -d <directory> (optional, default /u02/tic/stage/certs) -c <certificate> (optional, default atapcdhictic01.crt) -k <key> (optional, default atapcdhictic01.key)
```
