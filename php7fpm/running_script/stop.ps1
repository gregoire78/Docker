"===========stack service remove============"
docker-machine env leader1 | Invoke-Expression
docker stack rm vossibility

"==========swarm leave======================"
docker-machine env worker2 | Invoke-Expression
docker swarm leave
docker-machine env worker1 | Invoke-Expression
docker swarm leave
docker-machine env leader3 | Invoke-Expression
docker swarm leave --force
docker-machine env leader2 | Invoke-Expression
docker swarm leave --force
docker-machine env leader1 | Invoke-Expression
docker swarm leave --force

"========stop vm machines============="
docker-machine stop worker2
docker-machine stop worker1
docker-machine stop leader3
docker-machine stop leader2
docker-machine stop leader1