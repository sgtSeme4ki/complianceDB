# complianceDB

## Start Container first time

1.
command: "sudo docker build -t compliance . " in ./compliance

2.
sudo docker-compose up

3.
starten mit: 
docker exec -it compliance_db_1 bash 

4. mysql -p
	password: dasAuto

5. use compliance_db;


## Reset Container

1. docker stop compliance_db_1
2. docker rm -f compliance_db_1
3. execute steps from Start container

## How to add SqlScripts:

1. put them in ./init folder
2. build container again
