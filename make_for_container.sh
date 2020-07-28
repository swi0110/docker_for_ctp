# !/bin/bash

dir=`pwd`
VERSION=0.5
IMAGE_NAME=ctp_container
CONTAINER_NAME=docker_for_ctp

# Remove the previous container & image
IMAGE_ID=`docker images | grep "${IMAGE_NAME}" | awk '{print $3}'`
docker rm -f ${CONTAINER_NAME}_01
docker rm -f ${CONTAINER_NAME}_02
sleep 5;
docker rmi ${IMAGE_ID}
sleep 5;

# docker build -t ctp_container:0.1  .
docker build -t ${IMAGE_NAME}:${VERSION} .

sleep 10;

docker network create --driver bridge br1 --ip-range=172.200.1.0/24 --subnet=172.200.1.0/24

#centos 7
# docker run --privileged -dit --net br1 --ip 172.200.1.2 -v /root/docker_for_ctp/ctp_config:/home/ctp/ctp_config --name docker_for_ctp --hostname docker_for_ctp_01 ctp_container:0.1 /sbin/init
#docker run --privileged -dit --net br1 --ip 172.200.1.2 -v ${dir}/ctp_config:/home/ctp/ctp_config --name ${CONTAINER_NAME}_01 --hostname ${CONTAINER_NAME}_01 ${IMAGE_NAME}:${VERSION} /sbin/init

#docker run --privileged -dit --net br1 --ip 172.200.1.3 -v ${dir}/ctp_config:/home/ctp/ctp_config --name ${CONTAINER_NAME}_02 --hostname ${CONTAINER_NAME}_02 ${IMAGE_NAME}:${VERSION} /sbin/init

#centos 6
docker run --privileged -dit --net br1 --ip 172.200.1.2 -v ${dir}/ctp_config:/home/ctp/ctp_config --name ${CONTAINER_NAME}_01 --hostname ${CONTAINER_NAME}_01 ${IMAGE_NAME}:${VERSION} /bin/bash

docker run --privileged -dit --net br1 --ip 172.200.1.3 -v ${dir}/ctp_config:/home/ctp/ctp_config --name ${CONTAINER_NAME}_02 --hostname ${CONTAINER_NAME}_02 ${IMAGE_NAME}:${VERSION} /bin/bash

sleep 3;

docker exec ${CONTAINER_NAME}_01 service sshd restart
docker exec ${CONTAINER_NAME}_02 service sshd restart
