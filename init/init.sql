drop table if exists dienstleister;
drop table if exists risiko;
drop table if exists steuerungsmassnahme;

drop table if exists dienstleisterart;
drop table if exists bewertung_steuerungsmassnahmenahme;
drop table if exists bewertung_risiko;

drop table if exists ergebnis;

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
	primary key (steuerungsmassnahme_id, dienstleister_id),
	foreign key (dienstleister_id)
		references dienstleister(dienstleister_id),
	foreign key (steuerungsmassnahme_id)
		references steuerungsmassnahme(steuerungsmassnahme_id),
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
	
create table if not exists ergebnis(
	datum datetime,
	risikoprioritaetszahl int,
	steuerungsprioritaetszahl int,
	dienstleister_id int,
	primary key (datum, dienstleister_id),
	foreign key (dienstleister_id)
		references dienstleister(dienstleister_id)
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
values('Software');

insert into dienstleisterart(dienstleisterart_name)
values('Implementierung und Betreuung von Drittanwendungen');

insert into dienstleisterart(dienstleisterart_name)
values('Schulungen');

insert into dienstleisterart(dienstleisterart_name)
values('Consulting');

insert into dienstleisterart(dienstleisterart_name)
values('Softwareentwicklung');

insert into risiko(risiko_name)
values('Verlust vertraulicher Informationen durch unvollständige Erfassung der physischen Assets (insb. Notebooks, Tablets, Smartphones)');

insert into risiko(risiko_name)
values('Manipulation/Kopie/Modifizierung oder Verlust von Daten durch unzureichende Klassifizierung der Assets');

insert into risiko(risiko_name)
values('Sicherheitsrisiko durch fehlerhaften Freigabeprozess für den Einsatz von inzubetrieb-nehmender Hardware');

insert into risiko(risiko_name)
values('Verlust von Daten durch mangelhafte Außerbetrieb-nahme von Hardware');

insert into risiko(risiko_name)
values('Verlust der physischen Sicherheit durch ein mangelndes Sicherheitskonzept');

insert into risiko(risiko_name)
values('Verlust der gespeicherten Daten durch einen Komplettausfall eines Standortes');

insert into risiko(risiko_name)
values('Sicherheitsrisiko durch unzureichend geschützte bauliche Hülle (z.B. unberechtigter Zutritt, Feuer, Rauch, Wasser)');

insert into risiko(risiko_name)
values('Manipulation/Kopie/Modifizierung oder Verlust von Daten durch den Zutritt Unbefugter');

insert into risiko(risiko_name)
values('Verlust der gespeicherten Daten durch falsch eingestellte Betriebsparameter in der technischen Versorgung');

insert into risiko(risiko_name)
values('Personalausfall führt zum Kapazitätsengpass');

insert into risiko(risiko_name)
values('IT-Ausfall führt zum Kapazitätsengpass');

insert into risiko(risiko_name)
values('Softwareschwachstellen durch fehlende Schutz-mechanismen');

insert into risiko(risiko_name)
values('Datenverlust durch fehlende Datensicherung');

insert into risiko(risiko_name)
values('Gesicherte Daten im Fall einer notwendigen Wiederherstellung könnten nicht nutzbar sein');

insert into risiko(risiko_name)
values('Ausfall von Datenquellen für Protokollierungs-daten');

insert into risiko(risiko_name)
values('Ausspähen von Informationen (Spionage)');

insert into risiko(risiko_name)
values('Diebstahl von Geräten, Datenträgern und Dokumenten');

insert into risiko(risiko_name)
values('Unbefugtes Eindringen in IT-Systemen');

insert into risiko(risiko_name)
values('Ausfall von Geräten oder Systemen');

insert into risiko(risiko_name)
values('Fehlerhafte Nutzung oder Administration von Geräten und Systemen');

insert into risiko(risiko_name)
values('Identitätsdiebstahl');

insert into risiko(risiko_name)
values('Kompromittierung sensibler Daten bei Übertragung / Speicherung');

insert into risiko(risiko_name)
values('Schlüssel-Kompromittierung gegenüber Dritten');

insert into risiko(risiko_name)
values('Fehlerhafte Schlüsselgenerierung');

insert into risiko(risiko_name)
values('Beitreten von unbekannten (physischen oder virtuellen) Geräten zum physischen oder virtuellen Netz des Dienstleisters');

insert into risiko(risiko_name)
values('Mögliche Verbindung zu nicht-vertrauenswürdigen Netzwerken');

insert into risiko(risiko_name)
values('Verlust von Datenintegrität durch gemeinsam genutzte Netzumgebungen mit anderen Cloud-Kunden');

insert into risiko(risiko_name)
values('Informationsverlust durch unvollständige oder nicht gültige Verzeichnisse (Name, Adresse,.. des Dienstleister/Lieferanten)');

insert into risiko(risiko_name)
values('Unzureichende Überwachung der Einhaltung der Anforderungen der Dienstleister');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Log-Files: Automatische Erfassung der Assets und dadurch direkte Dokumentation von Veränderungen an der Datenbank');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Digitales Ticket-System: Digitale Dokumentation, um kontinuierliche Prüfung zu ermöglichen; im jeweiligen Ticket müssen autorisiertes Personal sowie die Verifikation der Konfiguration hinterlegt sein');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Der IT Dienstleister hat eine Sicherheitsrichtlinie ausgearbeitet, nach der vorschriftsmäßig gearbeitet wird.');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Es findet eine regelmäßige Redundanzprüfung statt, welche protokolliert wird.');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Der Dienstleister hat ein funktionierendes Zutrittskontrollsystem, welches es ermöglicht die Zutritts-Logs auszuwerten.');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Die Räumlichkeiten werden mittels einer Videoüberwachung geschützt.');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Es wird Sicherheitspersonal (mind. 2 Personen) zum Schutz der baulichen Hülle beschäftigt.');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Eine Einbruchmeldeanlage ist installiert, so dass Unregelmäßigkeiten schnell gemeldet werden.');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Es gibt regelmäßigen Kontrollen der Betriebsparameter. Diese werden in Logs dokumentiert um so Veränderungen festzustellen.');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Prognose von zukünftigen Kapazitätsanforderungen');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Self-Service-Portal zur Überwachung der Kapazität und der Verfügbarkeit');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Brand- und Rauchschutzmaßnahmen sowie Brandfrüherkennung und Löschsystem als Schutz vor Feuer und dessen Auswirkungen; Zugangskontrollen und Videoüberwachungen als Schutz vor materiellen Schäden');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Energieversorgung aus mehreren Umspannwerken und redundanter unterbrechungsfreier Stromversorgung als Schutz vor Stromausfall; zusätzliche Notversorgung mittels Dieselgenerator');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Effiziente und moderne Klimatisierung als Schutz vor Überhitzung');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Redundante Internetanbindung; doppelte Server');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Räumlich getrennte Rechenzentrums-Standorte um die Risiken eines IT-Ausfalls durch lokale Schadens-ereignisse zu minimieren');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Regelmäßige Prüfung und Zertifizierung von IT-Prozessen und -Systemen');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Nutzung systemspezifischer Schutzmechanismen (Betrieb von Schutzprogrammen auf Systemkomponenten und für Endgeräte der Mitarbeiter)');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Protokolle oder zusammengefassten Ergebnisse in einem Self-Service Portal zur Überwachung der Datensicherung');

insert into steuerungsmassnahme(steuerungsmassnahme_name)
values('Regelmäßige Tests der Wiederherstellungsverfahren (Vorgaben zur maximal tolerierbaren Ausfallzeit und zum maximal zulässigen Datenverlust werden so geprüft)');

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

-- 11 - 29 risks are missing from 

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