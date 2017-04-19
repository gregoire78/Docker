docker-machine start leader1
docker-machine start leader2
docker-machine start leader3
docker-machine start worker1
docker-machine start worker2

docker-machine regenerate-certs leader1 -f
docker-machine regenerate-certs leader2 -f
docker-machine regenerate-certs leader3 -f
docker-machine regenerate-certs worker1 -f
docker-machine regenerate-certs worker2 -f