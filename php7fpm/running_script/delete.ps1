docker rmi $(docker images -q) -f

docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q) -f

docker-machine rm worker2 --force
docker-machine rm worker1 --force
docker-machine rm leader3 --force
docker-machine rm leader2 --force
docker-machine rm leader1 --force