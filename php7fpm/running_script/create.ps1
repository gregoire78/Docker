cd C:\www\docker\php7fpm
clear

"=============vm leader1============="
docker-machine create --engine-env 'DOCKER_OPTS="-H unix:///var/run/docker.sock"' --driver virtualbox --virtualbox-share-folder C:\www:var/www leader1
"=============vm leader2============="
docker-machine create --engine-env 'DOCKER_OPTS="-H unix:///var/run/docker.sock"' --driver virtualbox --virtualbox-share-folder C:\www:var/www leader2
"=============vm leader3============="
docker-machine create --engine-env 'DOCKER_OPTS="-H unix:///var/run/docker.sock"' --driver virtualbox --virtualbox-share-folder C:\www:var/www leader3
"=============vm worker1============="
docker-machine create --engine-env 'DOCKER_OPTS="-H unix:///var/run/docker.sock"' --driver virtualbox --virtualbox-share-folder C:\www:var/www worker1
"=============vm worker2============="
docker-machine create --engine-env 'DOCKER_OPTS="-H unix:///var/run/docker.sock"' --driver virtualbox --virtualbox-share-folder C:\www:var/www worker2

"=============init swarm============"
docker-machine env leader1 | Invoke-Expression
docker swarm init --listen-addr $(docker-machine ip leader1) --advertise-addr $(docker-machine ip leader1)
$token=$(docker swarm join-token -q worker)
$tokenManager=$(docker swarm join-token -q manager)
$leaderIp=$(docker-machine ip leader1)

"===========swarm worker1==========="
docker-machine env worker1| Invoke-Expression
docker swarm join --token $token ${leaderIp}:2377

"===========swarm worker2==========="
docker-machine env worker2| Invoke-Expression
docker swarm join --token $token ${leaderIp}:2377

"===========swarm leader2==========="
docker-machine env leader2| Invoke-Expression
docker swarm join --token $tokenManager ${leaderIp}:2377

"===========swarm leader3==========="
docker-machine env leader3| Invoke-Expression
docker swarm join --token $tokenManager ${leaderIp}:2377

#"==============Visualizer==========="
docker-machine env leader2 | Invoke-Expression
docker run -it -d -p 5000:8080 -v /var/run/docker.sock:/var/run/docker.sock dockersamples/visualizer
docker-machine env leader1 | Invoke-Expression
docker run -it -d -p 5000:8080 -v /var/run/docker.sock:/var/run/docker.sock dockersamples/visualizer
clear
"=============deploy==============="
docker stack deploy --compose-file docker-compose-stack.yml vossibility
#"scalabilty"
#docker service scale vossibility_php=5
Start-Process "chrome.exe" "http://$($leaderIp):5000"