#!/bin/bash
LOGFILE=/tmp/copyclusterskel.log
exec 3>&1
exec > >(tee -a ${LOGFILE} >/dev/null) 2> >(tee -a ${LOGFILE} >&3)

echo "Script started with inputs $@"

source ./functions.sh
source ./get-args.sh

# If loaded from tarball, icp version may not be specified in terraform
if [[ -z "${icp_version}" ]]; then
  icp_version=$(get_inception_image)
fi

# Figure out the version
# This will populate $org $repo and $tag
parse_icpversion ${icp_version}
echo "registry=${registry:-not specified} org=$org repo=$repo tag=$tag"

# Copy the default data to the cluster directory
sudo docker run -e LICENSE=accept -v /tmp/icp:/data ${registry}${registry:+/}${org}/${repo}:${tag} cp -r cluster /data
sudo chown $(whoami):$(whoami) -R /tmp/icp
ensure_directory_reachable ${cluster_dir}
sudo mv /tmp/icp/cluster/* ${cluster_dir}

# Take a backup of original config file, to keep a record of original settings and comments
cp ${cluster_dir}/config.yaml ${cluster_dir}/config.yaml-original
