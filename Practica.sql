-------------------------------inciso 1---------------------------------------
create database db_Juegos_Olimpicos;


--------------------------------Tabla Profesión--------------------------------1
create table PROFESION(
	cod_prof serial primary key,
	nombre varchar(50) not null unique
);
-------------------------------------------------------------------------------
-----------------------------------Tabla País----------------------------------2
create table PAIS(
	cod_pais serial primary key,
	nombre varchar(50) not null unique
);
-------------------------------------------------------------------------------
-----------------------------------Tabla Puesto--------------------------------3
create table PUESTO(
	cod_puesto serial primary key,
	nombre varchar(50) not null unique
);
-------------------------------------------------------------------------------
------------------------------Tabla Departamento-------------------------------4
create table DEPARTAMENTO(
	cod_depto serial primary key,
	nombre varchar(50) not null unique
);
-------------------------------------------------------------------------------
----------------------------------Tabla Miembro--------------------------------5
create table MIEMBRO(
	cod_miembro serial primary key,
	nombre varchar(100) not null,
	apellido varchar(100) not null,
	edad integer not null,
	telefono integer,
	residencia varchar(100) null,
	PAIS_cod_pais integer not null,
	PROFESION_cod_prof integer not null,
	FOREIGN KEY (PAIS_cod_pais) REFERENCES PAIS (cod_pais),
	FOREIGN KEY (PROFESION_cod_prof) REFERENCES PROFESION (cod_prof)
	
);
------------------------------------------------------------------------------
-----------------------------Tabla Puesto_Miembro-----------------------------6
create table PUESTO_MIEMBRO(
	MIEMBRO_cod_miembro integer not null,
	PUESTO_cod_puesto integer not null,
	DEPARTAMENTO_cod_depto integer not null,
	fecha_inicio date not null,
	fecha_fin date,
	FOREIGN KEY (MIEMBRO_cod_miembro) REFERENCES MIEMBRO(cod_miembro),
	FOREIGN KEY (PUESTO_cod_puesto) REFERENCES PUESTO(cod_puesto),
	FOREIGN KEY (DEPARTAMENTO_cod_depto) REFERENCES DEPARTAMENTO(cod_depto)
);
------------------------------------------------------------------------------
------------------------------Tabla Tipo_Medalla------------------------------7
create table TIPO_MEDALLA(
	cod_tipo serial primary key,
	medalla varchar(20) not null unique
);
------------------------------------------------------------------------------
--------------------------------Tabla Medallero-------------------------------8
create table MEDALLERO(
	PAIS_cod_pais integer not null,
	TIPO_MEDALLA_cod_tipo integer not null,
	cantidad_medallas integer not null,
	PRIMARY KEY (PAIS_cod_pais,TIPO_MEDALLA_cod_tipo),
	FOREIGN KEY (PAIS_cod_pais) REFERENCES PAIS (cod_pais),
	FOREIGN KEY (TIPO_MEDALLA_cod_tipo) REFERENCES TIPO_MEDALLA(cod_tipo)
);
------------------------------------------------------------------------------
-------------------------------Tabla Disciplina-------------------------------9
create table DISCIPLINA(
	cod_disciplina serial primary key,
	nombre varchar(50) not null,
	descripcion varchar(150) null
);
------------------------------------------------------------------------------
---------------------------------Tabla Atleta---------------------------------10
create table ATLETA(
	cod_atleta serial primary key,
	nombre varchar(50) not null,
	apellido varchar(50) not null,
	edad integer not null,
	participaciones varchar(100) not null,
	DISCIPLINA_cod_disciplina integer not null,
	PAIS_cod_pais integer not null,
	FOREIGN KEY (DISCIPLINA_cod_disciplina) REFERENCES DISCIPLINA (cod_disciplina),
	FOREIGN KEY (PAIS_cod_pais) REFERENCES PAIS (cod_pais)
);
------------------------------------------------------------------------------
-------------------------------Tabla Categoría--------------------------------11
create table CATEGORIA(
	cod_categoria serial primary key,
	categoria varchar(50) not null
);
------------------------------------------------------------------------------
--------------------------Tabla Tipo_Participacion----------------------------12
create table TIPO_PARTICIPACION(
	cod_participacion serial primary key,
	tipo_participacion varchar(100) not null
);
------------------------------------------------------------------------------
---------------------------------Tabla Evento---------------------------------13
create table EVENTO(
	cod_evento serial primary key,
	fecha date not null,
	ubicacion varchar(50) not null,
	hora date not null,
	DISCIPLINA_cod_disciplina integer not null,
	TIPO_PARTICIPACION_cod_participacion integer not null,
	CATEGORIA_cod_categoria integer not null,
	FOREIGN KEY (DISCIPLINA_cod_disciplina) REFERENCES DISCIPLINA (cod_disciplina),
	FOREIGN KEY (CATEGORIA_cod_categoria) REFERENCES CATEGORIA (cod_categoria)
);
------------------------------------------------------------------------------
-----------------------------Tabla Evento_Atleta------------------------------14
create table EVENTO_ATLETA(
	ATLETA_cod_atleta integer not null,
	EVENTO_cod_evento integer not null,
	PRIMARY KEY (ATLETA_cod_atleta,EVENTO_cod_evento),
	FOREIGN KEY (ATLETA_cod_atleta) REFERENCES ATLETA(cod_atleta),
	FOREIGN KEY (EVENTO_cod_evento) REFERENCES EVENTO(cod_evento)
);
------------------------------------------------------------------------------
-------------------------------Tabla Televisora-------------------------------15
create table TELEVISORA(
	cod_televisora serial primary key,
	nombre varchar(50) not null
);
------------------------------------------------------------------------------
------------------------------Tabla Costo_Evento------------------------------16
create table COSTO_EVENTO(
	EVENTO_cod_evento integer not null,
	TELEVISORA_cod_televisora integer not null,
	tarifa integer not null,
	PRIMARY KEY (EVENTO_cod_evento,TELEVISORA_cod_televisora),
	FOREIGN KEY (EVENTO_cod_evento) REFERENCES EVENTO(cod_evento),
	FOREIGN KEY (TELEVISORA_cod_televisora) REFERENCES TELEVISORA(cod_televisora)
);
------------------------------------------------------------------------------


-------------------------------inciso 2---------------------------------------
alter table EVENTO drop fecha, drop hora , add column fecha_hora timestamp;

-------------------------------inciso 3---------------------------------------
alter table EVENTO add constraint verificacion_fecha_en_evento check (fecha_hora between '2020/07/24 9:00:00'and'2020/08/09 20:00:00');

-------------------------------inciso 4---------------------------------------
create table SEDE(
	codigo serial primary key,
	sede varchar(50) not null
);

alter table EVENTO
alter column ubicacion set data type int using ubicacion::integer, 
add constraint fk_ubicacion foreign key(ubicacion) REFERENCES SEDE(codigo);

-------------------------------inciso 5---------------------------------------
alter table MIEMBRO alter column telefono set default 0;

-------------------------------inciso 6---------------------------------------
insert into PAIS (nombre) values ('Guatemala'),('Francia'),('Argentina'),('Alemania'),('Italia'),('Brasil'),('Estados Unidos');

select * from PAIS;

insert into PROFESION (nombre) values ('Médico'),('Arquitecto'),('Ingeniero'),('Secretaria'),('Auditor');
select * from PROFESION

insert into MIEMBRO (nombre,apellido,edad,residencia,PAIS_cod_pais,PROFESION_cod_prof) values ('Scott','Mitchell',32,'1092 Highland Drive Manitowoc, WI 54220',7,3);
insert into MIEMBRO (nombre,apellido,edad,telefono,residencia,PAIS_cod_pais,PROFESION_cod_prof) values ('Fanette','Poulin',25,25075853,'49, boulevard Aristide Briand 76120 LEGRAND-QUEVILLY',2,4);
insert into MIEMBRO (nombre,apellido,edad,residencia,PAIS_cod_pais,PROFESION_cod_prof) values ('Laura','Cunha Silva',55,'Rua Onze, 86 Uberaba-MG',6,5);
insert into MIEMBRO (nombre,apellido,edad,telefono,residencia,PAIS_cod_pais,PROFESION_cod_prof) values ('Juan José','López',38,36985247,'26 calle 4-10 zona 11',1,2);
insert into MIEMBRO (nombre,apellido,edad,telefono,residencia,PAIS_cod_pais,PROFESION_cod_prof) values ('Arcangela','Panicucci',39,391664921,'Via Santa Teresa, 11490010-Geraci Siculo PA',5,1);
insert into MIEMBRO (nombre,apellido,edad,residencia,PAIS_cod_pais,PROFESION_cod_prof) values ('Jeuel','Villalpando',31,'Acuña de Figeroa 610680101 Playa Pascual',3,5);

select * from MIEMBRO;

insert into DISCIPLINA (nombre,descripcion) values ('Atletismo','Saltos de longitud y triples, de altura y con pértiga o garrocha; las pruebas de lanzamiento de martillo, jabalina y disco.');
insert into DISCIPLINA (nombre) values ('Bádminton'),('Ciclismo');
insert into DISCIPLINA (nombre,descripcion) values ('Judo','Es un arte marcial que se originó en Japón alrededor de 1880.');
insert into DISCIPLINA (nombre) values ('Lucha'),('Tenis de mesa'),('Boxeo');
insert into DISCIPLINA (nombre,descripcion) values ('Natación','Está presente como deporte en los Juegos desde la primera edición de la era moderna, en Atenas, Grecia, en 1896, donde se disputo en aguas abiertas.');
insert into DISCIPLINA (nombre) values ('Esgrima'),('Vela');

SELECT * from DISCIPLINA

insert into TIPO_MEDALLA (medalla) values('Oro'),('Plata'),('Bronce'),('Platino');
select * from TIPO_MEDALLA

insert into CATEGORIA (categoria) values ('Clasificatorio'),('Eliminatorio'),('Final');
select * from CATEGORIA


insert into TIPO_PARTICIPACION (tipo_participacion) values ('Individual'),('Equipo'),('Parejas');
select * from TIPO_PARTICIPACION

insert into MEDALLERO (PAIS_cod_pais,TIPO_MEDALLA_cod_tipo,cantidad_medallas) values (5,1,3);
insert into MEDALLERO (PAIS_cod_pais,TIPO_MEDALLA_cod_tipo,cantidad_medallas) values (2,1,5);
insert into MEDALLERO (PAIS_cod_pais,TIPO_MEDALLA_cod_tipo,cantidad_medallas) values (6,3,4);
insert into MEDALLERO (PAIS_cod_pais,TIPO_MEDALLA_cod_tipo,cantidad_medallas) values (4,4,3);
insert into MEDALLERO (PAIS_cod_pais,TIPO_MEDALLA_cod_tipo,cantidad_medallas) values (7,3,10);
insert into MEDALLERO (PAIS_cod_pais,TIPO_MEDALLA_cod_tipo,cantidad_medallas) values (3,2,8);
insert into MEDALLERO (PAIS_cod_pais,TIPO_MEDALLA_cod_tipo,cantidad_medallas) values (1,1,2);
insert into MEDALLERO (PAIS_cod_pais,TIPO_MEDALLA_cod_tipo,cantidad_medallas) values (1,4,5);
insert into MEDALLERO (PAIS_cod_pais,TIPO_MEDALLA_cod_tipo,cantidad_medallas) values (5,2,7);

select * from medallero

insert into SEDE (sede) values ('Gimnasio Metropolitano de Tokio'),('Jardín del Palacio Imperial de Tokio');
insert into SEDE (sede) values ('Gimnasio Nacional Yoyogi'),('Nippon Budokan'),('Estadio Olímpico');

select * from sede

insert into EVENTO (fecha_hora, ubicacion,DISCIPLINA_cod_disciplina,TIPO_PARTICIPACION_cod_participacion ,CATEGORIA_cod_categoria) values 
	('24/07/2020 11:00:00',3,2,2,1),
	('26/07/2020 10:30:00',1,6,1,3),
	('30/08/2020 18:45:00',5,7,1,2),
	('01/08/2020 12:15:00',2,1,1,1),
	('08/08/2020 19:35:00',4,10,3,1);

-------------------------------inciso 7---------------------------------------
alter table PAIS drop constraint PAIS_nombre_key;
alter table TIPO_MEDALLA drop constraint TIPO_MEDALLA_medalla_key;
alter table DEPARTAMENTO drop constraint DEPARTAMENTO_nombre_key;

-------------------------------inciso 8---------------------------------------
alter table ATLETA drop constraint DISCIPLINA_cod_disciplina;

create table DISCIPLINA_ATLETA
(
  cod_atleta int not null, 
  cod_disciplina int not null,
  
  PRIMARY KEY (cod_atleta,cod_disciplina),
  FOREIGN KEY (cod_atleta) REFERENCES ATLETA(cod_atleta),
  FOREIGN KEY (cod_disciplina) REFERENCES DISCIPLINA(cod_disciplina)
);

-------------------------------inciso 9---------------------------------------
alter table COSTO_EVENTO alter column tarifa set data type decimal(20,2); 

-------------------------------inciso 10--------------------------------------
select * from TIPO_MEDALLA;
delete from TIPO_MEDALLA where (cod_tipo==4);
select * from TIPO_MEDALLA;
-------------------------------inciso 11--------------------------------------
drop table TELEVISORA, COSTO_EVENTO;
-------------------------------inciso 12--------------------------------------
select * from  DISCIPLINA;
delete from DISCIPLINA;
select * from  DISCIPLINA;
-------------------------------inciso 13--------------------------------------
update table set telefono=55464601 where ( nombre = 'Laura' and apellido ='Cunha Silva');
update table set telefono=91514243 where ( nombre = 'Jeuel' and apellido ='Villalpando');
update table set telefono=920686670 where( nombre = 'Scott' and apellido ='Mitchell');
-------------------------------inciso 14--------------------------------------
alter table ATLETA add column fotografia bytea null;

-------------------------------inciso 15--------------------------------------
alter table ATLETA add constraint atleta_edad check (edad<25);