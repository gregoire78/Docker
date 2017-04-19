clear
"=======redeploy======="
docker-machine env leader1 | Invoke-Expression
docker stack rm vossibility
Start-Sleep -s 3
docker stack deploy --compose-file docker-compose-stack.yml vossibility