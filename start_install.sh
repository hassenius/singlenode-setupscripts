#!/bin/bash
source ./get-args.sh
source ./functions.sh

# If loaded from tarball, icp version may not be specified in terraform
if [[ -z "${icp_inception}" ]]; then
  icp_inception=$(get_inception_image)
fi

# Figure out the version
# This will populate $org $repo and $tag
parse_icpversion ${icp_inception}
echo "registry=${registry:-not specified} org=$org repo=$repo tag=$tag"

sudo docker run -e LICENSE=accept -e ANSIBLE_CALLBACK_WHITELIST=profile_tasks,timer --net=host -t -v ${cluster_dir}:/installer/cluster ${registry}${registry:+/}${org}/${repo}:${tag} ${install_command} ${log_verbosity} |& tee /tmp/icp-${install_command}-log.txt

exit ${PIPESTATUS[0]}
