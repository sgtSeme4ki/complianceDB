drop table if exists dienstleister;
drop table if exists risiko;
drop table if exists steuerungsmaßnahme;
drop table if exists gefährdung;
drop table if exists steuerung;

drop table if exists dienstleisterart;
drop table if exists dienstleisterart_risiko;

use complianceDB;

create table if not exists dienstleister(
	dienstleister_id int auto_increment primary key, 
	dienstleister_name varchar(255) not null unique,
	kategorie varchar(255) not null
	);
	
create table if not exists risiko(
	risiko_id int auto_increment primary key, 
	risiko_name varchar(255) not null unique,
	wahrscheinlichkeit int not null,
	bedeutung int not null
	);
	
create table if not exists steuerungsmaßnahme(
	steuerungsmaßnahme_id int auto_increment primary key, 
	steuerungsmaßnahme_name varchar(255) not null unique, 
	effizienz decimal(2, 1) not null,
	bedeutung decimal(2, 1) not null
	);
	
create table if not exists dienstleisterart(
	dienstleisterart_id int auto_increment primary key,
	dienstleister_name varchar(255) not null unique
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
		
create table if not exists gefährdung(
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
	steuerungsmaßnahme_id int not null,
	primary key (risiko_id, steuerungsmaßnahme_id),
	foreign key (risiko_id)
		references risiko(risiko_id),
	foreign key (steuerungsmaßnahme_id)
		references steuerungsmaßnahme(steuerungsmaßnahme_id)
		);


alter table steuerungsmaßnahme add constraint intervall check((effizienz <= 1 and effizienz >= 0.1) and (bedeutung <= 1 and bedeutung >= 0.1)
);
