#!/bin/bash

server_pid=$(ps aux | grep java | grep application | awk '{print $2}')
if [ -n "$server_pid" ]; then
    kill -9 $server_pid
fi

sleep 1

nohup java -Xms256m -Xmx768m -jar -Duser.timezone=GMT+08 -Dfile.encoding=utf8 application.jar > /dev/null 2>&1 &

# do not forget the parameters [-Duser.timezone=GMT+08 -Dfile.encoding=utf8] to fix date and chinese messy code
# if you want define your runtime parameters:
# 1 - bind your parameters by java -jar -DXXX=XXX like : nohup java -Xms256m -Xmx768m -jar -Duser.timezone=GMT+08 -Dfile.encoding=utf8 -Dserver.port=8100 application.jar > /dev/null 2>&1 &
# 2 - change spring boot config file with path : conf/application-xx.yml
