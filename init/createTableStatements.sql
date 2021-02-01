-- entities
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
	dienstleister_name varchar(255) not null unique,
	);
	
create table if not exists risiko(
	risiko_id int auto_increment primary key, 
	risiko_name varchar(255) not null unique,
	wahrscheinlichkeit int not null,
	bedeutung int not null
	);
	
create table if not exists steuerungsmassnahme(
	steuerungsmassnahme_id int auto_increment primary key, 
	steuerungsmassnahme_name varchar(255) not null unique, 
	effizienz decimal(2, 1) not null,
	bedeutung decimal(2, 1) not null
	);
	
create table if not exists dienstleisterart(
	dienstleisterart_id int auto_increment primary key,
	dienstleister_name varchar(255) not null unique
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