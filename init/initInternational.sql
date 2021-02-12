drop table if exists dienstleister;
drop table if exists risiko;
drop table if exists steuerungsmassnahme;

drop table if exists dienstleisterart;
drop table if exists bewertung_steuerungsmassnahmenahme;
drop table if exists bewertung_risiko;

drop table if exists ergebnis_risiko;
drop table if exists ergebnis_steuerung;

-- relationship tables

drop table if exists dienstleisterart_risiko;
drop table if exists gefaehrdung;
drop table if exists steuerung;

use complianceDB;

create table if not exists dienstleister(
	dienstleister_id int auto_increment primary key, 
	dienstleister_name varchar(255) not null unique
	);
	
create table if not exists risiko(
	risiko_id int auto_increment primary key, 
	risiko_name varchar(255) not null unique
	);
	
create table if not exists steuerungsmassnahme(
	steuerungsmassnahme_id int auto_increment primary key, 
	steuerungsmassnahme_name varchar(255) not null unique
	);
	
create table if not exists dienstleisterart(
	dienstleisterart_id int auto_increment primary key,
	dienstleisterart_name varchar(255) not null unique
	);
	
create table if not exists bewertung_steuerungsmassnahme(
	steuerungsmassnahme_id int,
	dienstleister_id int,
	risiko_id int,
	primary key (steuerungsmassnahme_id, dienstleister_id, risiko_id),
	foreign key (dienstleister_id)
		references dienstleister(dienstleister_id),
	foreign key (steuerungsmassnahme_id)
		references steuerungsmassnahme(steuerungsmassnahme_id),
	foreign key (risiko_id)
		references risiko(risiko_id),
	effizienz int,
	bedeutung int
	);
	
create table if not exists bewertung_risiko(
	risiko_id int,
	dienstleister_id int,
	primary key (risiko_id, dienstleister_id),
	foreign key (dienstleister_id)
		references dienstleister(dienstleister_id),
	foreign key (risiko_id)
		references risiko(risiko_id),
	wahrscheinlichkeit int,
	bedeutung int
	);
	
create table if not exists ergebnis_risiko(
	datum datetime,
	risikoprioritaetszahl int,
	dienstleister_id int,
	risiko_id int,
	primary key (datum, dienstleister_id, risiko_id),
	foreign key (dienstleister_id)
		references dienstleister(dienstleister_id),
	foreign key (risiko_id)
		references risiko(risiko_id)
	);
	
create table if not exists ergebnis_steuerung(
	datum datetime,
	risiko_id int,
	steuerungsprioritaetszahl int,
	dienstleister_id int,
	steuerungsmassnahme_id int,
	primary key (datum, dienstleister_id, risiko_id, steuerungsmassnahme_id),
	foreign key (dienstleister_id)
		references ergebnis_risiko(dienstleister_id),
	foreign key (risiko_id)
		references ergebnis_risiko(risiko_id),
	foreign key (steuerungsmassnahme_id)
		references steuerungsmassnahme(steuerungsmassnahme_id)
	);

-- Relationships
create table if not exists typisierung(
	dienstleister_id int not null,
	dienstleisterart_id int not null,
	primary key (dienstleister_id, dienstleisterart_id),
	foreign key (dienstleister_id)
		references dienstleister(dienstleister_id),
	foreign key (dienstleisterart_id)
		references dienstleisterart(dienstleisterart_id)
		);
		
create table if not exists gefaehrdung(
	dienstleisterart_id int not null, 
	risiko_id int not null, 
	primary key (dienstleisterart_id, risiko_id),
	foreign key (dienstleisterart_id)
		references dienstleisterart(dienstleisterart_id),
	foreign key (risiko_id)
		references risiko(risiko_id)
		);

create table if not exists steuerung(
	risiko_id int not null,
	steuerungsmassnahme_id int not null,
	primary key (risiko_id, steuerungsmassnahme_id),
	foreign key (risiko_id)
		references risiko(risiko_id),
	foreign key (steuerungsmassnahme_id)
		references steuerungsmassnahme(steuerungsmassnahme_id)
		);
		
insert into dienstleisterart(dienstleisterart_name)
values('Cloud-Computing');

insert into dienstleisterart(dienstleisterart_name)
values('Hosting / Rechenzentrum');

insert into dienstleisterart(dienstleisterart_name)
values('Betreuung und Implementierung von Hardware');

insert into dienstleisterart(dienstleisterart_name)
values('IT-Sicherheit');

insert into dienstleisterart(dienstleisterart_name)
values('Implementierung und Betreuung von Drittanwendungen');

insert into dienstleisterart(dienstleisterart_name)
values('Schulungen');

insert into dienstleisterart(dienstleisterart_name)
values('Consulting');

insert into dienstleisterart(dienstleisterart_name)
values('Softwareentwicklung');

insert into risiko(risiko_name)
values('Verlust vertraulicher Informationen durch unvollstaendige Erfassung der physischen Assets (insb. Notebooks, Tablets, Smartphones)');

insert into risiko(risiko_name)
values('Manipulation/Kopie/Modifizierung oder Verlust von Daten durch unzureichende Klassifizierung der Assets');

insert into risiko(risiko_name)
values('Sicherheitsrisiko durch fehlerhaften Freigabeprozess fuer den Einsatz von inzubetrieb-nehmender Hardware');

insert into risiko(risiko_name)
values('Verlust von Daten durch mangelhafte Ausserbetrieb-nahme von Hardware');

insert into risiko(risiko_name)
values('Verlust der physischen Sicherheit durch ein mangelndes Sicherheitskonzept');

insert into risiko(risiko_name)
values('Verlust der gespeicherten Daten durch einen Komplettausfall eines Standortes');

insert into risiko(risiko_name)
values('Sicherheitsrisiko durch unzureichend geschuetzte bauliche Huelle (z.B. unberechtigter Zutritt, Feuer, Rauch, Wasser)');

insert into risiko(risiko_name)
values('Manipulation/Kopie/Modifizierung oder Verlust von Daten durch den Zutritt Unbefugter');

insert into risiko(risiko_name)
values('Verlust der gespeicherten Daten durch falsch eingestellte Betriebsparameter in der technischen Versorgung');

insert into risiko(risiko_name)
values('Personalausfall fuehrt zum Kapazitaetsengpass');

insert into risiko(risiko_name)
values('IT-Ausfall fuehrt zum Kapazitaetsengpass');

insert into risiko(risiko_name)
values('Softwareschwachstellen durch fehlende Schutz-mechanismen');

insert into risiko(risiko_name)
values('Datenverlust durch fehlende Datensicherung');

insert into risiko(risiko_name)
values('Gesicherte Daten im Fall einer notwendigen Wiederherstellung koennten nicht nutzbar sein');

insert into risiko(risiko_name)
values('Ausfall von Datenquellen fuer Protokollierungs-daten');

insert into risiko(risiko_name)
values('Ausspaehen von Informationen (Spionage)');

insert into risiko(risiko_name)
values('Diebstahl von Geraeten, Datentraegern und Dokumenten');

insert into risiko(risiko_name)
values('Unbefugtes Eindringen in IT-Systemen');

insert into risiko(risiko_name)
values('Ausfall von Geraeten oder Systemen');

insert into risiko(risiko_name)
values('Fehlerhafte Nutzung oder Administration von Geraeten und Systemen');

insert into risiko(risiko_name)
values('Identitaetsdiebstahl');

insert into risiko(risiko_name)
values('Kompromittierung sensibler Daten bei Uebertragung / Speicherung');

insert into risiko(risiko_name)
values('Schluessel-Kompromittierung gegenueber Dritten');

insert into risiko(risiko_name)
values('Fehlerhafte Schluesselgenerierung');

insert into risiko(risiko_name)
values('Beitreten von unbekannten (physischen oder virtuellen) Geraeten zum physischen oder virtuellen Netz des Dienstleisters');

insert into risiko(risiko_name)
values('Moegliche Verbindung zu nicht-vertrauenswuerdigen Netzwerken');

insert into risiko(risiko_name)
values('Verlust von Datenintegritaet durch gemeinsam genutzte Netzumgebungen mit anderen Cloud-Kunden');

insert into risiko(risiko_name)
values('Informationsverlust durch unvollstaendige oder nicht gueltige Verzeichnisse (Name, Adresse,.. des Dienstleister/Lieferanten)');

insert into risiko(risiko_name)
values('Unzureichende Ueberwachung der Einhaltung der Anforderungen der Dienstleister');

-- ----------------------------------------------------------------------------------------------------------------------------------------

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Log-Files: Automatische Erfassung der Assets und dadurch direkte Dokumentation von Veraenderungen an der Datenbank');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Digitales Ticket-System: Digitale Dokumentation, um kontinuierliche Pruefung zu ermoeglichen; im jeweiligen Ticket muessen autorisiertes Personal sowie die Verifikation der Konfiguration hinterlegt sein');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Der IT Dienstleister hat eine Sicherheitsrichtlinie ausgearbeitet, nach der vorschriftsmaessig gearbeitet wird.');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Es findet eine regelmaessige Redundanzpruefung statt, welche protokolliert wird.');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Der Dienstleister hat ein funktionierendes Zutrittskontrollsystem, welches es ermoeglicht die Zutritts-Logs auszuwerten.');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Die Raeumlichkeiten werden mittels einer Videoueberwachung geschuetzt.');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Es wird Sicherheitspersonal (mind. 2 Personen) zum Schutz der baulichen Huelle beschaeftigt.');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Eine Einbruchmeldeanlage ist installiert, so dass Unregelmaessigkeiten schnell gemeldet werden.');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Es gibt regelmaessige Kontrollen der Betriebsparameter. Diese werden in Logs dokumentiert um so Veraenderungen festzustellen.');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Prognose von zukuenftigen Kapazitaetsanforderungen');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Self-Service-Portal zur Ueberwachung der Kapazitaet und der Verfuegbarkeit');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Brand- und Rauchschutzmassnahmen sowie Brandfrueherkennung und Loeschsystem als Schutz vor Feuer und dessen Auswirkungen; Zugangskontrollen und Videoueberwachungen als Schutz vor materiellen Schaeden');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Energieversorgung aus mehreren Umspannwerken und redundanter unterbrechungsfreier Stromversorgung als Schutz vor Stromausfall; zusaetzliche Notversorgung mittels Dieselgenerator');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Effiziente und moderne Klimatisierung als Schutz vor Ueberhitzung');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Redundante Internetanbindung; doppelte Server');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Raeumlich getrennte Rechenzentrums-Standorte um die Risiken eines IT-Ausfalls durch lokale Schadens-ereignisse zu minimieren');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Regelmaessige Pruefung und Zertifizierung von IT-Prozessen und -Systemen');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Nutzung systemspezifischer Schutzmechanismen (Betrieb von Schutzprogrammen auf Systemkomponenten und fuer Endgeraete der Mitarbeiter)');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Protokolle oder zusammengefassten Ergebnisse in einem Self-Service Portal zur Ueberwachung der Datensicherung');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Regelmaessige Tests der Wiederherstellungsverfahren (Vorgaben zur maximal tolerierbaren Ausfallzeit und zum maximal zulaessigen Datenverlust werden so geprueft)');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Entwicklung eines Authentisierungskonzeptes fuer IT-Systeme und Anwendungen');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Einsatz eines zentralen Authentisierungsdienstes');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Schutz von Benutzerkennungen mit weitreichenden Berechtigungen');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Geeignete Auswahl von Authentisierungsmechanismen');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Vergabe von Zugriffsrechten');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Regelung des Passwortgebrauchs/der Passwortqualitaet');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Mehr-Faktor-Authentisierung');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Notfallvorsorge fuer das Identitaets- und Berechtigungsmanagement-Systemen');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Einweisung aller Mitarbeiter in den Umgang mit Authentisierungsverfahren und – mechanismen');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Regelmaessige Kontrolle der kryptografischen Sicherheitsstandards der Erzeugung, Veraenderung und Uebermittlung der Schluessel');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('kontinuierliche Pruefung ob die Verschluesselung aktiv ist und die genehmigten Ausnahmen eingehalten werden');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Regelmaessige Kontrollen des Systemzustandes auf Kompromittierung und Dokumentation von Unregelmaessigkeiten');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Dokumentation, Kommunikation und Bereitstellung von Richtlinien und Anweisungen mit technischen und organisatorischen Massnahmen zum Schutz der Datenuebertragung');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Geregelter Umgang mit kompromittierten/veralteten Schluesseln');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Dokumentation und Kommunikation von Ausnahmen zur Verschluesselung von Daten gemaess eines geregelten Verfahrens sowie Abstimmung des Verfahrens mit Kunden');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Dokumentation und Implementierung technischer Massnahmen zur Sicherstellung des Nicht-Beitretens von unbekannten Geraeten in das physische/virtuelle Netz');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Geeignete Kontrollen zur zeitnahen Identifikation und Reaktion von/auf netzbasierte Angriffe und Dokumentation & Kommunikation dieser');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Verwendung eines uebergreifenden SIEM-Systems zur Initialisierung erforderlicher (Gegen-)Massnahmen');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Separierung Netze nach Vertrauen in verschiedene Netzbereiche');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Konzeption und Konfiguration physischer und virtualisierter Netzumgebungen zur Beschraenkung und Ueberwachung von Verbindungen');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Regelmaessige risikoorientierte Ueberpruefung der Konzepte zur Ueberwachung der Verbindung zu (nicht) vertrauenswuerdigen Netzen');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Vorhandensein Konzept zur Segregation des Datenverkehrs auf Netzebene & Dokumentation dieses Konzepts');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Zertifizierte Pruefung der Sicherheit ueber sachverstaendige Dritte');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Anforderungen an Qualifikation und Kompetenz der Dienstleister');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Genaue Beschreibung, dessen was bereitzustellen ist');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Vereinbarungen zur Leistungsueberwachung der Dienstleister');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Regelmaessige Ueberpruefung der Einhaltung der Anforderungen');

-- CC

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(1, 1);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(1, 2);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(1, 3);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(1, 4);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(1, 5);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(1, 6);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(1, 7);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(1, 8);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(1, 9);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(1, 10);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(1, 11);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(1, 12);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(1, 13);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(1, 14);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(1, 15);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(1, 16);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(1, 17);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(1, 18);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(1, 19);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(1, 20);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(1, 21);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(1, 22);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(1, 23);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(1, 24);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(1, 25);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(1, 26);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(1, 27);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(1, 28);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(1, 29);

-- RZ

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(2, 1);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(2, 2);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(2, 3);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(2, 4);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(2, 5);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(2, 6);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(2, 7);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(2, 8);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(2, 9);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(2, 10);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(2, 11);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(2, 12);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(2, 13);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(2, 14);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(2, 15);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(2, 16);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(2, 17);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(2, 18);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(2, 19);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(2, 20);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(2, 21);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(2, 22);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(2, 23);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(2, 24);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(2, 25);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(2, 26);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(2, 28);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(2, 29);

-- HW

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(3, 1);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(3, 2);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(3, 3);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(3, 4);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(3, 5);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(3, 7);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(3, 8);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(3, 10);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(3, 11);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(3, 12);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(3, 17);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(3, 25);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(3, 26);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(3, 28);

-- IS

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(4, 3);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(4, 4);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(4, 5);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(4, 7);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(4, 8);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(4, 11);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(4, 12);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(4, 13);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(4, 14);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(4, 15);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(4, 22);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(4, 23);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(4, 24);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(4, 25);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(4, 26);

-- DW

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(5, 5);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(5, 7);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(5, 8);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(5, 10);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(5, 11);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(5, 12);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(5, 22);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(5, 23);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(5, 24);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(5, 25);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(5, 26);

-- SU

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(6, 10);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(6, 11);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(6, 25);

-- CS

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(7, 10);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(7, 11);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(7, 25);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(7, 26);

-- SE

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(8, 11);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(8, 12);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(8, 13);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(8, 14);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(8, 15);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(8, 16);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(8, 17);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(8, 18);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(8, 19);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(8, 20);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(8, 21);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(8, 25);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(8, 26);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(8, 28);

insert into gefaehrdung(dienstleisterart_id, risiko_id)
values(8, 29);

-- ----------------------------------------------------------------------------------------------------------------------------------------
-- steuerungsmassnahme - risiko

insert into steuerung(steuerungsmassnahme_id, risiko_id)
values(1, 1);

insert into steuerung(steuerungsmassnahme_id, risiko_id)
values(1, 2);

insert into steuerung(steuerungsmassnahme_id, risiko_id)
values(2, 3);

insert into steuerung(steuerungsmassnahme_id, risiko_id)
values(2, 4);

insert into steuerung(steuerungsmassnahme_id, risiko_id)
values(3, 5);

insert into steuerung(steuerungsmassnahme_id, risiko_id)
values(4, 6);

insert into steuerung(steuerungsmassnahme_id, risiko_id)
values(5, 7);

insert into steuerung(steuerungsmassnahme_id, risiko_id)
values(5, 8);

insert into steuerung(steuerungsmassnahme_id, risiko_id)
values(6, 7);

insert into steuerung(steuerungsmassnahme_id, risiko_id)
values(7, 7);

insert into steuerung(steuerungsmassnahme_id, risiko_id)
values(8, 7);

insert into steuerung(steuerungsmassnahme_id, risiko_id)
values(9, 9);

insert into steuerung(steuerungsmassnahme_id, risiko_id)
values(10, 10);	

insert into steuerung(steuerungsmassnahme_id, risiko_id)
values(11, 10);	

insert into steuerung(steuerungsmassnahme_id, risiko_id)
values(12, 11);	

insert into steuerung(steuerungsmassnahme_id, risiko_id)
values(13, 11);	

insert into steuerung(steuerungsmassnahme_id, risiko_id)
values(14, 11);	

insert into steuerung(steuerungsmassnahme_id, risiko_id)
values(15, 11);	

insert into steuerung(steuerungsmassnahme_id, risiko_id)
values(16, 11);	

insert into steuerung(steuerungsmassnahme_id, risiko_id)
values(17, 11);	

insert into steuerung(steuerungsmassnahme_id, risiko_id)
values(18, 12);	

insert into steuerung(steuerungsmassnahme_id, risiko_id)
values(19, 13);

insert into steuerung(steuerungsmassnahme_id, risiko_id)
values(19, 15);		

insert into steuerung(steuerungsmassnahme_id, risiko_id) values(20,14);
insert into steuerung(steuerungsmassnahme_id, risiko_id) values(21,16);
insert into steuerung(steuerungsmassnahme_id, risiko_id) values(21,21);
insert into steuerung(steuerungsmassnahme_id, risiko_id) values(22,16);
insert into steuerung(steuerungsmassnahme_id, risiko_id) values(23,16);
insert into steuerung(steuerungsmassnahme_id, risiko_id) values(23,21);
insert into steuerung(steuerungsmassnahme_id, risiko_id) values(24,16);
insert into steuerung(steuerungsmassnahme_id, risiko_id) values(24,20);
insert into steuerung(steuerungsmassnahme_id, risiko_id) values(24,21);
insert into steuerung(steuerungsmassnahme_id, risiko_id) values(25,17);
insert into steuerung(steuerungsmassnahme_id, risiko_id) values(25,18);
insert into steuerung(steuerungsmassnahme_id, risiko_id) values(26,18);
insert into steuerung(steuerungsmassnahme_id, risiko_id) values(26,21);
insert into steuerung(steuerungsmassnahme_id, risiko_id) values(27,18);
insert into steuerung(steuerungsmassnahme_id, risiko_id) values(28,19);
insert into steuerung(steuerungsmassnahme_id, risiko_id) values(29,20);
insert into steuerung(steuerungsmassnahme_id, risiko_id) values(30,22);
insert into steuerung(steuerungsmassnahme_id, risiko_id) values(30,23);
insert into steuerung(steuerungsmassnahme_id, risiko_id) values(30,24);
insert into steuerung(steuerungsmassnahme_id, risiko_id) values(31,22);
insert into steuerung(steuerungsmassnahme_id, risiko_id) values(32,22);
insert into steuerung(steuerungsmassnahme_id, risiko_id) values(32,23);
insert into steuerung(steuerungsmassnahme_id, risiko_id) values(32,24);
insert into steuerung(steuerungsmassnahme_id, risiko_id) values(33,22);
insert into steuerung(steuerungsmassnahme_id, risiko_id) values(34,23);
insert into steuerung(steuerungsmassnahme_id, risiko_id) values(35,24);
insert into steuerung(steuerungsmassnahme_id, risiko_id) values(36,25);
insert into steuerung(steuerungsmassnahme_id, risiko_id) values(37,25);
insert into steuerung(steuerungsmassnahme_id, risiko_id) values(38,25);
insert into steuerung(steuerungsmassnahme_id, risiko_id) values(39,26);
insert into steuerung(steuerungsmassnahme_id, risiko_id) values(40,26);
insert into steuerung(steuerungsmassnahme_id, risiko_id) values(41,26);
insert into steuerung(steuerungsmassnahme_id, risiko_id) values(42,27);
insert into steuerung(steuerungsmassnahme_id, risiko_id) values(43,27);
insert into steuerung(steuerungsmassnahme_id, risiko_id) values(44,28);
insert into steuerung(steuerungsmassnahme_id, risiko_id) values(45,28);
insert into steuerung(steuerungsmassnahme_id, risiko_id) values(46,29);
insert into steuerung(steuerungsmassnahme_id, risiko_id) values(47,29);