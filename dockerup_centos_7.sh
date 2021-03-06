#!/bin/bash
# Spin up a dev environment to run HEAT bootstrapping scripts.

distro=centos
major=7

echo -e "Please make sure you are in the root directory of hopstrapper/\n"

echo -e "\n$distro $major: Building image..."
docker build --rm -t "$distro$major" -f "docker/$distro/$major/Dockerfile" .

echo -e "\n$distro $major: Starting Container..."
docker run --privileged -d --restart=always -p 8080:80 --name=centos7 -ti -v /sys/fs/cgroup:/sys/fs/cgroup "$distro$major"

echo -e "\n\n$distro $major: Container running.\nUse the following to check on progress:"
echo -e "\n\tdocker logs $distro$major --follow"
echo -e "\tdocker logs $distro$major"
echo -e "\nto jump into the container:\n\tdocker exec -it $distro$major /bin/bash"
