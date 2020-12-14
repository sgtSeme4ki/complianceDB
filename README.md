# complianceDB

## Start Container first time

1. command: "sudo docker build -t compliance . " in ./compliance

2. sudo docker-compose up

3. starten mit: 
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

### Randnotizen

-ER-Notation um gleich 2. Normalisierung zu erreichen
-Ein kann mehrere Vorfälle haben
-Jeder Vorfall gehört zu einer Kategorie, ID steht gleichzeitig für Schwere, besitzt auch eine Gewichtung
-Ein Vorfall kann mehreren Kategorien zugehörig sein, z. B. Datenverlust, Lahmlegung des Systems, etc
-Ein Vorfall muss mindestens zu einer Kategorie gehören
-Teilung in Teilvorfälle -> einfacher für Berechnung
-Kategorie sollt nicht geupdatet werden
-Docker weil CI/CD
-automatische Eintragung per Programm?
-MySQL Excel Add-in?
