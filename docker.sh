#!/bin/bash

cid=$(docker ps -a| grep application | awk '{print $1}')
if [ "$cid" != "" ]; then
        echo $(date "+%Y-%m-%d %H:%M:%S") "start stop container $cid"
        docker stop $cid
        sleep 2
        docker rm $cid
fi

rid=`docker images -q --filter reference=application:latest | awk '{print $1}'`
if [ "$rid" != "" ]; then
        echo $(date "+%Y-%m-%d %H:%M:%S") "start delete image $rid"
        docker rmi $rid
fi

docker build -t application:latest .

docker run -itd -p 8000:8000 --name application application:latest
