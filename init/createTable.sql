use complianceDB;

drop table if exists dienstleister;
drop table if exists vorfall;
drop table if exists kategorie;
drop table if exists vorfall_kategorie;
drop table if exists dienstleister_vorfall;


create table if not exists dienstleister(
	dienstleister_id int auto_increment primary key, 
	dienstleister_name varchar(255) not null, 
	standort varchar(255) not null);
	
create table if not exists vorfall(
	vorfall_id int auto_increment primary key, 
	vorfall_name varchar(255) not null, 
	beschreibung text not null);
	
create table if not exists kategorie(
	kategorie_id int auto_increment primary key, 
	kategorie_name varchar(255) not null, 
	gewicht decimal(5, 4) not null, 
	beschreibung text not null);

-- Relationships
create table if not exists vorfall_kategorie(
	vorfall_id int not null, 
	kategorie_id int not null, 
	primary key (vorfall_id, kategorie_id),
	foreign key (vorfall_id)
		references vorfall(vorfall_id),
	foreign key (kategorie_id)
		references kategorie(kategorie_id)
		);

create table if not exists dienstleister_vorfall(
	dienstleister_id int not null,
	vorfall_id int not null,
	datum timestamp not null default current_timestamp ,
	primary key (dienstleister_id, vorfall_id),
	foreign key (vorfall_id)
		references vorfall(vorfall_id),
	foreign key (dienstleister_id)
		references dienstleister(dienstleister_id)
		);
		

