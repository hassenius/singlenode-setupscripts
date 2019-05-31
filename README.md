

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
./generateconfigs.sh -d <cluster_dir>
```

# Start installation
As user with sudo access
```
./start_install.sh
```
