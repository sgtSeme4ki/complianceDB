# complianceDB

## Start Container first time

1. command: "sudo docker build -t compliance . " in ./compliance

2. sudo docker-compose up

3. starten mit: 
docker exec -it compliancedb_db_1 bash 

4. mysql -p
	password: dasAuto

5. use complianceDB;


## Reset Container

1. docker stop compliancedb_db_1
2. docker rm -f compliancedb_db_1
3. execute steps from Start container

## How to add SqlScripts:

1. put them in ./init folder
2. build container again

### Randnotizen

-ER-Notation um gleich 2. Normalisierung zu erreichen<br>
-Ein kann mehrere Vorfälle haben<br>
-Jeder Vorfall gehört zu einer Kategorie, ID steht gleichzeitig für Schwere, besitzt auch eine Gewichtung<br>
-Ein Vorfall kann mehreren Kategorien zugehörig sein, z. B. Datenverlust, Lahmlegung des Systems, etc<br>
-Ein Vorfall muss mindestens zu einer Kategorie gehören<br>
-Teilung in Teilvorfälle -> einfacher für Berechnung<br>
-Kategorie sollt nicht geupdatet werden<br>
-Docker weil CI/CD<br>
-automatische Eintragung per Programm?<br>
-MySQL Excel Add-in?<br>
-Adminer Support?
