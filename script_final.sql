#source D:/BD/Proiect BD/scriptXX.sql;  
/*          Folositi pentru cale simbolul "/", NU "\"         */ 


/*#############################################################*/
/*        PARTEA 1 - STERGEREA SI RECREAREA BAZEI DE DATE      */

DROP DATABASE fotbalDB;  /*stergeti baza de date (pentru a evita situatiile in care imi veti trimite de mai multe ori scriptul modificat si va trebui sa-l rulez)*/
CREATE DATABASE fotbalDB;
USE fotbalDB;

/*#############################################################*/




/*#############################################################*/
/*                  PARTEA 2 - CREAREA TABELELOR              */

CREATE TABLE tblLigi(
	idLiga INT PRIMARY KEY AUTO_INCREMENT,
	numeLiga VARCHAR(40) UNIQUE,
	premiu INT,
	organizator VARCHAR(60)
);

CREATE TABLE tblEchipe(
	idEchipa INT PRIMARY KEY AUTO_INCREMENT,
	numeEchipa VARCHAR(40),
	taraEchipa VARCHAR(40),
	antrenor VARCHAR(40),
	stadion VARCHAR(40),
	liga INT,
	CONSTRAINT fk_ligi FOREIGN KEY(liga)
		REFERENCES tblLigi(idLiga) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE tblJucatori(
	idJucator INT PRIMARY KEY AUTO_INCREMENT,
	numeJucator VARCHAR(50),
	nationalitate VARCHAR(30),
	pozitie ENUM('GK','CB','RB','CDM','CM','CAM','ST','RW','LW','LB'),
	cota SMALLINT
);


CREATE TABLE tblMeciuri(
	idMeci INT PRIMARY KEY AUTO_INCREMENT,
	arbitru VARCHAR(40),
	data_meci DATE,
	minuteJucate SMALLINT
);

CREATE TABLE tblEchipeJucatori
(
	Jucator INT, 
	Echipe INT,
	dataSosire DATE,
	dataPlecare DATE DEFAULT NULL,
	CONSTRAINT fk_jucator FOREIGN KEY(Jucator)
		REFERENCES tblJucatori(idJucator) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_echipe FOREIGN KEY(Echipe)
		REFERENCES tblEchipe(idEchipa) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_unicEchipeJucatori UNIQUE (Jucator,Echipe,dataPlecare)
	
);


CREATE TABLE tblStatisticiJucatori
(

	jucator INT,
	meci INT,
	minuteJucate TINYINT DEFAULT 90,
	goluri TINYINT DEFAULT 0,
	asisturi TINYINT DEFAULT 0,
	nota TINYINT DEFAULT 5,
	cartonase ENUM("ROSU","GALBEN","FARA") DEFAULT 'FARA',
	CONSTRAINT fk_mecijucator FOREIGN KEY(jucator)
		REFERENCES tblJucatori(idJucator) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_meci FOREIGN KEY(meci)
		REFERENCES tblMeciuri(idMeci) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_unicStats UNIQUE (Jucator,meci)
);


CREATE TABLE tblEchipeMeciuri
(
	meci INT,
	echipa INT,
	goluriMarcate TINYINT,
	Gazda ENUM("DA","NU"),
	CONSTRAINT fk_mecie FOREIGN KEY(meci)
		REFERENCES tblMeciuri(idMeci) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_echipem FOREIGN KEY(echipa)
		REFERENCES tblEchipe(idEchipa) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_EchipeMeciuriUnice UNIQUE (meci,echipa)
);



/*#############################################################*/




/*#############################################################*/
/*         PARTEA 3 - INSERAREA INREGISTRARILOR IN TABELE      */



INSERT INTO tblLigi (numeLiga,premiu,organizator) VALUES ('LaLiga', 5000000, 'The Royal Spanish Football Federation');
INSERT INTO tblLigi (numeLiga,premiu,organizator) VALUES ('Premier League', 20000000, 'English Fotball Association');
INSERT INTO tblLigi (numeLiga,premiu,organizator) VALUES ('Serie A', 8000000, 'Federatione Italiana Giocco Calcio');
INSERT INTO tblLigi (numeLiga,premiu,organizator) VALUES ('Superliga', 500000, 'Federatia Romana de Fotbal');	
INSERT INTO tblLigi (numeLiga,premiu,organizator) VALUES ('Liga 2', 100000, 'Federatia Romana de Fotbal');
INSERT INTO tblLigi (numeLiga,premiu,organizator) VALUES ('Bundesliga', 5000000, 'Deutsche Fotball Federation');
INSERT INTO tblLigi (numeLiga,premiu,organizator) VALUES ('League 1', 2000000, 'Francais Fotball Federation');
INSERT INTO tblLigi (numeLiga,premiu,organizator) VALUES ('EFL 2', 3000000, 'English Fotball Association');
INSERT INTO tblLigi (numeLiga,premiu,organizator) VALUES ('Liga Nos', 2000000, ' Federação Portuguesa de Futebol');
INSERT INTO tblLigi (numeLiga,premiu,organizator) VALUES ('Eredivisie', 2000000, 'Royal Dutch Football Association');




/*Facem LaLiga, PremierLeague,Serie A, Superliga si Bundesliga; min 3 echipe de fiecare*/

/*LaLiga*/
INSERT INTO tblEchipe (numeEchipa,taraEchipa,antrenor,stadion,liga) VALUES ('Real Madrid', 'Spania','Carlo Anceloti','Santiago Bernabeu',1);
INSERT INTO tblEchipe (numeEchipa,taraEchipa,antrenor,stadion,liga) VALUES ('Barcelona', 'Spania','Hansi Flick','Camp Nou',1);
INSERT INTO tblEchipe (numeEchipa,taraEchipa,antrenor,stadion,liga) VALUES ('Atletico Madrid', 'Spania','Diego Simeone','Wanda Metropolitano',1);

/*PremierLeague*/
INSERT INTO tblEchipe (numeEchipa,taraEchipa,antrenor,stadion,liga) VALUES ('Liverpool', 'Anglia','Arne Sloth','Anfield Road',2);
INSERT INTO tblEchipe (numeEchipa,taraEchipa,antrenor,stadion,liga) VALUES ('Manchester City', 'Anglia','Pep Guardiola','Etihad Stadium',2);
INSERT INTO tblEchipe (numeEchipa,taraEchipa,antrenor,stadion,liga) VALUES ('Arsenal', 'Anglia','Mikel Arteta','Emirates',2);

/*Serie A*/
INSERT INTO tblEchipe (numeEchipa,taraEchipa,antrenor,stadion,liga) VALUES ('Ac Milan', 'Italia','Paolo Fonseca','San Siro',3);
INSERT INTO tblEchipe (numeEchipa,taraEchipa,antrenor,stadion,liga) VALUES ('Inter Milan', 'Italia','Simone Inzaghi','Giuseppe Meaza',3);
INSERT INTO tblEchipe (numeEchipa,taraEchipa,antrenor,stadion,liga) VALUES ('Juventus', 'Italia','Thiago Motta','Juventus Stadium',3);

/*SuperLiga*/
INSERT INTO tblEchipe (numeEchipa,taraEchipa,antrenor,stadion,liga) VALUES ('FCSB', 'Romania','Eduard Charalambous','Ghencea',4);
INSERT INTO tblEchipe (numeEchipa,taraEchipa,antrenor,stadion,liga) VALUES ('Petrolul Ploiesti', 'Romania','Sanjin Algic','Ilie Oana',4);
INSERT INTO tblEchipe (numeEchipa,taraEchipa,antrenor,stadion,liga) VALUES ('Dinamo Bucuresti', 'Romania','Kopic','Stefan Cel Mare',4);

/*Bundesliga*/
INSERT INTO tblEchipe (numeEchipa,taraEchipa,antrenor,stadion,liga) VALUES ('Bayern Munchen', 'Germania','Vancent Kompany','Alianz Arena',6);
INSERT INTO tblEchipe (numeEchipa,taraEchipa,antrenor,stadion,liga) VALUES ('Bayer Leverkusen', 'Germania','Xabi Alonso','Bay Arena',6);
INSERT INTO tblEchipe (numeEchipa,taraEchipa,antrenor,stadion,liga) VALUES ('Borusia Dortmund', 'Germania','Michael Zorc','Signal Iduna Park',6);

/* Echipe optionale (carora nu le-am adaugat meciuri) */
INSERT INTO tblEchipe (numeEchipa,taraEchipa,antrenor,stadion,liga) VALUES ('Psg', 'Franta','Luis Enrique','Parc Des Princes',7);
INSERT INTO tblEchipe (numeEchipa,taraEchipa,antrenor,stadion,liga) VALUES ('CSA Steaua', 'Romania','Daniel Oprita','Ghencea',5);
INSERT INTO tblEchipe (numeEchipa,taraEchipa,antrenor,stadion,liga) VALUES ('Benfica', 'Portugal','Roger Schmidt','Estádio do Benfica',9);
INSERT INTO tblEchipe (numeEchipa,taraEchipa,antrenor,stadion,liga) VALUES ('Ajax', 'Netherlands','Francesco Farioli','Amsterdam Arena',10);


/*Players*/
/* Real Madrid */
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Vinicius Junior', 'Brazil', 'LW', 200);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Luka Modric', 'Croatia', 'CM', 10);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Rodrygo Goes', 'Brazil', 'RW', 140);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Eder Militao', 'Brazil', 'CB', 50);


/* Barcelona */
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Lamine Yamal', 'Spain', 'RW', 180);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Pedri', 'Spain', 'CM', 100);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Raphinha', 'Brazil', 'LW', 80);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Frankie De Jong', 'Netherlands', 'CM', 60);

/* Atletico Madrid */
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Jan Oblak', 'Slovenia', 'GK', 30);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Jose Maria Gimenez', 'Uruguay', 'CB', 50);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Julian Alvarez', 'Argentina', 'ST', 120);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Koke', 'Spain', 'CB', 50);

/*LIVERPOOL F.C.*/
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Virgil van Dijk','Netherlands','CB',30);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Alexis Mac Allister','Argentina','CM',75);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Alisson Becker','Brazil','GK',28);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Tyler Morton','England','CDM',8);

/* Manchester City */
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Kevin De Bruyne', 'Belgium', 'CM', 40);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Erling Haaland', 'Norway', 'ST', 220);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Ruben Dias', 'Portugal', 'CB', 10);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Rodri', 'Spain', 'CDM', 70);



/*ARSENAL F.C.*/
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('William Saliba','France','CB',80);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Declan Rice','England','CDM',120);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Ben White','England','CB',55);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('David Raya','Spain','GK',35);


#AC MILAN
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Tijjani Reijnders','Netherlands','CM',30);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Christian Pulisic','United States','RW',50);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Mike Maignan','France','GK',38);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Davide Calabria','Italy','RB',10);

#INTER MILANO
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Henrikh Mkhitaryan','Armenia','CM',37);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Nicolò Barella','Italy','CM',80);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Marcus Thuram','Italy','ST',65);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Alessandro Bastoni','Italy','CB',70);

#JUVENTUS F.C.
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Gleison Bremer','Brazil','CB',60);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Michele Di Gregorio','Italy','GK',18);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Weston McKennie','United States','CM',24);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Dusan Vlahovic','Serbia','ST',65);




#FCSB
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Stefan Tarnovanu','Romania','GK',3);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Vlad Chiriches','Romania','CB',1);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Darius Olaru','Romania','CAM',7);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Daniel Birligea','Romania','ST',2);

#FC DINAMO 1948
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Adnan Golubovic','Slovenia','GK',1);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Razvan Patriche','Romania','CB',1);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Catalin Cirjan','Romania','CM',1);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Alberto Soro','Spain','RW',1);

#PETROLUL PLOIESTI
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Lukas Zima','Czechia','GK',1);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Valentin Ticu','Romania','LB',1);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Sergiu Hanca','Romania','RW',1);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Gheorghe Grozav','Romania','LW',1);

#BAYERN MUNCHEN
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Manuel Neuer','Germany','GK',4);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Alphonso Davies','Canada','LB',50);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Jamal Musiala','Germany','CAM',130);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Harry Kane','England','ST',100);

#BAYER 04 LEVERKUSEN
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Lukas Hradecky','Finland','GK',3);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Edmond Tapsoba','Burkina Faso','CB',45);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Granit Xhaka','Switzerland','CDM',20);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Florian Wirtz','Germany','CAM',130);

#BORUSSIA DORTMUND
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Gregor Kobel','Switzerland','GK',40);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Nico Schlotterbeck','Germany','CB',40);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Marcel Sabitzer','Austria','CM',20);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Karim Adeyemi','Germany','LW',35);


/* PSG */
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Achraf Hakimi', 'Morocco', 'RB', 60);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Nuno Mendes', 'Portugal', 'LB', 60);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Vitinha', 'Portugal', 'LB', 54);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Goncalo Ramos', 'Portugal', 'LB', 60);

# Benfica
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('João Mário', 'Portugal', 'CAM', 18000);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('António Silva', 'Portugal', 'CB', 20000);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Rafa Silva', 'Portugal', 'RW', 22000);


# Ajax
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Dusan Tadic', 'Serbia', 'LW', 18000);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Jurrien Timber', 'Netherlands', 'CB', 25000);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Steven Bergwijn', 'Netherlands', 'RW', 22000);
INSERT INTO tblJucatori (numeJucator, nationalitate, pozitie, cota) VALUES ('Kenneth Taylor', 'Netherlands', 'CM', 16000);





-- Real Madrid
INSERT INTO tblEchipeJucatori (Jucator, Echipe, dataSosire) 
VALUES (1, 1, '2023-07-01'),  -- Vinicius Junior at Real Madrid
       (2, 1, '2014-08-01'),  -- Luka Modric at Real Madrid
       (3, 1, '2022-07-01'),  -- Rodrygo Goes at Real Madrid
       (4, 1, '2019-08-01');  -- Eder Militao at Real Madrid

-- Barcelona
INSERT INTO tblEchipeJucatori (Jucator, Echipe, dataSosire) 
VALUES (5, 2, '2023-06-01'),  -- Lamine Yamal at Barcelona
       (6, 2, '2020-08-01'),  -- Pedri at Barcelona
       (7, 2, '2021-07-01'),  -- Raphinha at Barcelona
       (8, 2, '2019-07-01');  -- Frankie De Jong at Barcelona

-- Atletico Madrid
INSERT INTO tblEchipeJucatori (Jucator, Echipe, dataSosire) 
VALUES (9, 3, '2014-08-01'),  -- Jan Oblak at Atletico Madrid
       (10, 3, '2013-07-01'), -- Jose Maria Gimenez at Atletico Madrid
       (11, 3, '2025-01-01'), -- Julian Alvarez at Atletico Madrid
       (12, 3, '2013-08-01'); -- Koke at Atletico Madrid


-- Liverpool
INSERT INTO tblEchipeJucatori (Jucator, Echipe, dataSosire) 
VALUES (13, 4, '2018-07-01'), -- Virgil van Dijk at Liverpool
       (14, 4, '2021-08-01'), -- Alexis Mac Allister at Liverpool
       (15, 4, '2018-07-01'), -- Alisson Becker at Liverpool
       (16, 4, '2020-01-01'); -- Tyler Morton at Liverpool

-- Manchester City
INSERT INTO tblEchipeJucatori (Jucator, Echipe, dataSosire) 
VALUES (17, 5, '2015-07-01'), -- Kevin De Bruyne at Manchester City
       (18, 5, '2022-06-01'), -- Erling Haaland at Manchester City
       (19, 5, '2020-08-01'), -- Ruben Dias at Manchester City
       (20, 5, '2017-07-01'); -- Rodri at Manchester City

-- Arsenal
INSERT INTO tblEchipeJucatori (Jucator, Echipe, dataSosire) 
VALUES (21, 6, '2023-07-01'), -- William Saliba at Arsenal
       (22, 6, '2023-08-01'), -- Declan Rice at Arsenal
       (23, 6, '2022-08-01'), -- Ben White at Arsenal
       (24, 6, '2023-07-01'); -- David Raya at Arsenal


-- AC Milan
INSERT INTO tblEchipeJucatori (Jucator, Echipe, dataSosire) 
VALUES (25, 7, '2023-07-01'), -- Tijjani Reijnders at AC Milan
       (26, 7, '2023-08-01'), -- Christian Pulisic at AC Milan
       (27, 7, '2022-06-01'), -- Mike Maignan at AC Milan
       (28, 7, '2020-08-01'); -- Davide Calabria at AC Milan

-- Inter Milan
INSERT INTO tblEchipeJucatori (Jucator, Echipe, dataSosire) 
VALUES (29, 8, '2020-01-01'), -- Henrikh Mkhitaryan at Inter Milan
       (30, 8, '2021-07-01'), -- Nicolò Barella at Inter Milan
       (31, 8, '2023-06-01'), -- Marcus Thuram at Inter Milan
       (32, 8, '2017-08-01'); -- Alessandro Bastoni at Inter Milan

-- Juventus
INSERT INTO tblEchipeJucatori (Jucator, Echipe, dataSosire) 
VALUES (33, 9, '2018-07-01'), -- Gleison Bremer at Juventus
       (34, 9, '2022-07-01'), -- Michele Di Gregorio at Juventus
       (35, 9, '2020-08-01'), -- Weston McKennie at Juventus
       (36, 9, '2020-08-01'); -- Dusan Vlahovic at Juventus


-- FCSB
INSERT INTO tblEchipeJucatori (Jucator, Echipe, dataSosire) 
VALUES (37, 10, '2020-01-01'), -- Stefan Tarnovanu at FCSB
       (38, 10, '2019-06-01'), -- Vlad Chiriches at FCSB
       (39, 10, '2021-07-01'), -- Darius Olaru at FCSB
       (40, 10, '2022-07-01'); -- Daniel Birligea at FCSB

-- Petrolul Ploiesti
INSERT INTO tblEchipeJucatori (Jucator, Echipe, dataSosire) 
VALUES (41, 11, '2021-01-01'), -- Lukas Zima at Petrolul Ploiesti
       (42, 11, '2020-06-01'), -- Valentin Ticu at Petrolul Ploiesti
       (43, 11, '2022-02-01'), -- Sergiu Hanca at Petrolul Ploiesti
       (44, 11, '2023-01-01'); -- Gheorghe Grozav at Petrolul Ploiesti

-- Dinamo Bucuresti
INSERT INTO tblEchipeJucatori (Jucator, Echipe, dataSosire) 
VALUES (45, 12, '2022-07-01'), -- Adnan Golubovic at Dinamo Bucuresti
       (46, 12, '2020-07-01'), -- Razvan Patriche at Dinamo Bucuresti
       (47, 12, '2021-08-01'), -- Catalin Cirjan at Dinamo Bucuresti
       (48, 12, '2023-02-01'); -- Alberto Soro at Dinamo Bucuresti


-- Bayern Munich
INSERT INTO tblEchipeJucatori (Jucator, Echipe, dataSosire) 
VALUES (49, 13, '2011-07-01'), -- Manuel Neuer at Bayern Munich
       (50, 13, '2019-07-01'), -- Alphonso Davies at Bayern Munich
       (51, 13, '2020-07-01'), -- Jamal Musiala at Bayern Munich
       (52, 13, '2023-08-01'); -- Harry Kane at Bayern Munich

-- Bayer Leverkusen
INSERT INTO tblEchipeJucatori (Jucator, Echipe, dataSosire) 
VALUES (53, 14, '2018-07-01'), -- Lukas Hradecky at Bayer Leverkusen
       (54, 14, '2020-01-01'), -- Edmond Tapsoba at Bayer Leverkusen
       (55, 14, '2023-06-01'), -- Granit Xhaka at Bayer Leverkusen
       (56, 14, '2021-07-01'); -- Jeremie Frimpong at Bayer Leverkusen

-- Borussia Dortmund
INSERT INTO tblEchipeJucatori (Jucator, Echipe, dataSosire) 
VALUES (57, 15, '2018-07-01'), -- Gregor Kobel at Borussia Dortmund
       (58, 15, '2022-07-01'), -- Marcel Sabitzer at Borussia Dortmund
       (59, 15, '2023-08-01'), -- Felix Nmecha at Borussia Dortmund
       (60, 15, '2022-08-01'); -- Karim Adeyemi at Borussia Dortmund

-- PSG
INSERT INTO tblEchipeJucatori (Jucator, Echipe, dataSosire) 
VALUES (61, 16, '2023-07-01'), -- Achraf Hakimi at PSG
       (62, 16, '2022-08-01'), -- Nico Schlotterbeck
       (63, 16, '2023-08-01'), -- Vitinha at PSG
       (64, 16, '2023-06-01'); -- Goncalo Ramos at PSG
	   
-- Benfica
INSERT INTO tblEchipeJucatori (Jucator, Echipe, dataSosire) 
VALUES (65, 17, '2017-07-01'), -- João Mário at Benfica
       (66, 17, '2019-08-01'), -- António Silva at Benifica
       (67, 17, '2017-08-01'); -- Rafa Silva at Benfica
	   
-- Ajax
INSERT INTO tblEchipeJucatori (Jucator, Echipe, dataSosire) 
VALUES (68, 18, '2018-07-01'), -- Dusan Tadic at Ajax
       (69, 18, '2017-08-01'), -- Jurrien Timber at Ajax
       (70, 18, '2022-08-01'), -- Steven Bergwijn at Ajax
       (71, 18, '2023-06-01'); -- Kenneth Taylor at Ajax
      
	   
	   
	   
	   
-- Jucatori care si-au schimbat echipele
INSERT INTO tblEchipeJucatori (Jucator, Echipe, dataSosire, dataPlecare) VALUES (61,1,'2018-07-01','2020-08-01'); -- Hakimi la Real 
INSERT INTO tblEchipeJucatori (Jucator, Echipe, dataSosire, dataPlecare) VALUES (64,17,'2020-07-01','2023-06-01');  -- Goncalo Ramos la Benfica
INSERT INTO tblEchipeJucatori (Jucator, Echipe, dataSosire, dataPlecare) VALUES (55,6,'2016-07-01','2023-06-01'); -- Xhacka la Arsenal	
INSERT INTO tblEchipeJucatori (Jucator, Echipe, dataSosire, dataPlecare) VALUES (20,3,'2015-07-01','2017-07-01'); -- Rodri la Atletico	  	   
INSERT INTO tblEchipeJucatori (Jucator, Echipe, dataSosire, dataPlecare) VALUES (18,15,'2020-1-01','2022-06-01'); -- Haaland la Dortmund
INSERT INTO tblEchipeJucatori (Jucator, Echipe, dataSosire, dataPlecare) VALUES (11,5,'2023-01-01','2025-01-01'); -- Haaland la Dortmund




-- Meciuri --
INSERT INTO tblMeciuri(arbitru,data_meci,minuteJucate) VALUES ('Istfan Kovacs','2024-11-04',97); -- FCSB vs Petrolul
INSERT INTO tblMeciuri(arbitru,data_meci,minuteJucate) VALUES ('Antony Taylor','2024-11-15',102); -- Liverpool vs City
INSERT INTO tblMeciuri(arbitru,data_meci,minuteJucate) VALUES ('Jesus Gil Manzano','2024-11-16',94); -- Real Madrid vs Barcelona
INSERT INTO tblMeciuri(arbitru,data_meci,minuteJucate) VALUES ('Artur Soares Dias','2024-11-07',93); -- Atletico vs Real Madrid
INSERT INTO tblMeciuri(arbitru,data_meci,minuteJucate) VALUES ('Marco Guida','2023-08-10',110); -- Inter vs Milan 
INSERT INTO tblMeciuri(arbitru,data_meci,minuteJucate) VALUES ('Szymon Marciniak','2024-11-04',101); -- Leverkusen vs Bayen 
INSERT INTO tblMeciuri(arbitru,data_meci,minuteJucate) VALUES ('Horatiu Fesnic','2024-11-04',96); -- FCSB vs Dinamo  
INSERT INTO tblMeciuri(arbitru,data_meci,minuteJucate) VALUES ('Felix Zweier','2024-11-04',98); -- Dortmund vs Bayen 
INSERT INTO tblMeciuri(arbitru,data_meci,minuteJucate) VALUES ('Michael Oliver','2024-11-04',99); -- Arsenal vs Man City
INSERT INTO tblMeciuri(arbitru,data_meci,minuteJucate) VALUES ('Daniele Orsato','2024-11-04',94);-- Juve vs Milan

-- Meciuri-Echipe --

INSERT INTO tblEchipeMeciuri(meci,echipa,goluriMarcate,Gazda) VALUES (1,10,2,'DA'); -- FCSB 2
INSERT INTO tblEchipeMeciuri(meci,echipa,goluriMarcate,Gazda) VALUES (1,11,3,'NU'); -- Petrolul 3
INSERT INTO tblEchipeMeciuri(meci,echipa,goluriMarcate,Gazda) VALUES (2,4,2,'DA'); -- Liverpool 2
INSERT INTO tblEchipeMeciuri(meci,echipa,goluriMarcate,Gazda) VALUES (2,5,2,'NU'); -- Man City 2
INSERT INTO tblEchipeMeciuri(meci,echipa,goluriMarcate,Gazda) VALUES (3,1,1,'DA'); -- Real Madrid 1
INSERT INTO tblEchipeMeciuri(meci,echipa,goluriMarcate,Gazda) VALUES (3,2,2,'NU'); -- Barcelona 2 
INSERT INTO tblEchipeMeciuri(meci,echipa,goluriMarcate,Gazda) VALUES (4,1,2,'DA'); -- Real Madrid 2
INSERT INTO tblEchipeMeciuri(meci,echipa,goluriMarcate,Gazda) VALUES (4,3,0,'NU'); -- Atletico 0
INSERT INTO tblEchipeMeciuri(meci,echipa,goluriMarcate,Gazda) VALUES (5,7,2,'DA'); -- Ac Milan 2
INSERT INTO tblEchipeMeciuri(meci,echipa,goluriMarcate,Gazda) VALUES (5,8,0,'NU'); -- Inter 0
INSERT INTO tblEchipeMeciuri(meci,echipa,goluriMarcate,Gazda) VALUES (6,13,2,'DA'); -- Bayern 2
INSERT INTO tblEchipeMeciuri(meci,echipa,goluriMarcate,Gazda) VALUES (6,14,2,'NU'); -- Leverkusen 2
INSERT INTO tblEchipeMeciuri(meci,echipa,goluriMarcate,Gazda) VALUES (7,10,5,'DA'); -- FCSB 5
INSERT INTO tblEchipeMeciuri(meci,echipa,goluriMarcate,Gazda) VALUES (7,13,0,'NU'); -- Dinamo Bucuresti 0
INSERT INTO tblEchipeMeciuri(meci,echipa,goluriMarcate,Gazda) VALUES (8,13,4,'DA'); -- Bayern 4
INSERT INTO tblEchipeMeciuri(meci,echipa,goluriMarcate,Gazda) VALUES (8,15,2,'NU'); -- Dortmund 2
INSERT INTO tblEchipeMeciuri(meci,echipa,goluriMarcate,Gazda) VALUES (9,6,1,'DA'); -- Arsenal 1
INSERT INTO tblEchipeMeciuri(meci,echipa,goluriMarcate,Gazda) VALUES (9,5,1,'NU'); -- Man City 1
INSERT INTO tblEchipeMeciuri(meci,echipa,goluriMarcate,Gazda) VALUES (10,7,2,'DA'); -- Juve 2
INSERT INTO tblEchipeMeciuri(meci,echipa,goluriMarcate,Gazda) VALUES (10,9,1,'NU'); -- Milan 1



-- Statistici Jucatori --

-- Match 1: FCSB vs Petrolul 2-3
INSERT INTO tblStatisticiJucatori (jucator, meci, minuteJucate, goluri, asisturi, nota, cartonase) VALUES 
(37, 1, 90, 0, 0, 5 ,'GALBEN'),  -- Stefan Tarnovanu
(38, 1, 90, 0, 0, 4, 'FARA'),  -- Vlad Chiriches 
(39, 1, 90, 1, 0, 8, 'FARA'),  -- Darius Olaru
(40, 1, 90, 1, 1, 9, 'GALBEN'); -- Daniel Birligea

INSERT INTO tblStatisticiJucatori (jucator, meci, minuteJucate, goluri, asisturi, nota, cartonase) VALUES 
(41, 1, 90, 0, 0, 7 ,'FARA'),  -- Lukas Zima
(42, 1, 90, 2, 0, 9 ,'FARA'),   -- Valentin Ticu
(43, 1, 90, 0, 1, 8 ,'FARA'), -- Sergiu Hanca
(44, 1, 90, 1, 0, 9 ,'GALBEN'); -- Gheorghe Grozav 

-- Match 2: Liverpool vs Manchester City 2-2

INSERT INTO tblStatisticiJucatori (jucator, meci, minuteJucate, goluri, asisturi, nota, cartonase) VALUES
(13, 2, 90, 1, 1, 7, 'FARA'),  -- Virgil van Dijk
(14, 2, 90, 1, 0, 8, 'FARA'),  -- Alexis Mac Allister
(15, 2, 90, 0, 0, 6, 'FARA'),  -- Alisson Becker
(16, 2, 90, 0, 1, 7, 'FARA');  -- Tyler Morton

INSERT INTO tblStatisticiJucatori (jucator, meci, minuteJucate, goluri, asisturi, nota, cartonase) VALUES
(17, 2, 90, 1, 0, 8, 'FARA'),  -- Kevin De Bruyne
(18, 2, 90, 1, 1, 9, 'FARA'),  -- Erling Haaland
(19, 2, 90, 0, 0, 6, 'FARA'),  -- Ruben Dias
(20, 2, 90, 0, 1, 7, 'FARA');  -- Rodri

-- Match 3: Real Madrid vs Barcelona 1-2
INSERT INTO tblStatisticiJucatori (jucator, meci, minuteJucate, goluri, asisturi, nota, cartonase) VALUES
(1, 3, 90, 1, 1, 6, 'FARA'),  -- Vinicius Junior
(2, 3, 90, 0, 0, 6, 'FARA'), -- Luka Modric
(3, 3, 90, 0, 0, 7, 'FARA'), -- Rodrygo Goes
(4, 3, 90, 0, 0, 5, 'FARA'); -- Eder Militao

INSERT INTO tblStatisticiJucatori (jucator, meci, minuteJucate, goluri, asisturi, nota, cartonase) VALUES
(5, 3, 90, 1, 0, 8, 'FARA'), -- Lamine Yamal
(6, 3, 90, 0, 0, 6, 'FARA'), -- Pedri
(7, 3, 90, 1, 0, 9, 'FARA'), -- Raphinha
(8, 3, 90, 0, 1, 7, 'FARA'); -- Frankie De Jong


-- Match 4: Real Madrid  vs Atletico Madrid 2-0
INSERT INTO tblStatisticiJucatori (jucator, meci, minuteJucate, goluri, asisturi, nota, cartonase) VALUES
(1, 4, 90, 0, 0, 5, 'FARA'),  -- Jan Oblak
(2, 4, 90, 0, 1, 6, 'FARA'),  -- Jose Maria Gimenez
(3, 4, 90, 0, 0, 4, 'GALBEN'), -- Julian Alvarez
(4, 4, 90, 0, 0, 5, 'FARA'); -- Koke

INSERT INTO tblStatisticiJucatori (jucator, meci, minuteJucate, goluri, asisturi, nota, cartonase) VALUES
(9, 4, 88, 0, 0, 6, 'ROSU'), -- Vinicius Junior
(10, 4, 90, 1, 0, 8, 'FARA'), -- Luka Modric
(11, 4, 90, 1, 0, 8, 'FARA'), -- Rodrygo Goes
(12, 4, 90, 0, 1, 7, 'FARA'); -- Eder Militao


-- Match 5: Inter Milan vs AC Milan 2-0

INSERT INTO tblStatisticiJucatori (jucator, meci, minuteJucate, goluri, asisturi, nota, cartonase) VALUES
(29, 5, 90, 0, 0, 6, 'FARA'),  -- Marcus Thuram
(30, 5, 90, 1, 0, 8, 'FARA'),  -- Henrikh Mkhitaryan
(31, 5, 90, 0, 1, 7, 'FARA'),  -- Nicolò Barella
(32, 5, 90, 1, 0, 9, 'FARA');

INSERT INTO tblStatisticiJucatori (jucator, meci, minuteJucate, goluri, asisturi, nota, cartonase) VALUES
(25, 5, 90, 0, 0, 5, 'FARA'),  -- Tijjani Reijnders 
(26, 5, 90, 0, 0, 6, 'FARA'),  -- Christian Pulisic
(27, 5, 90, 0, 0, 5, 'FARA'),  -- Mike Maignan 
(28, 5, 90, 0, 0, 7, 'FARA');  -- Davide Calabria 


-- Match 6: Bayer Leverkusen vs Bayern Munich 2-2
INSERT INTO tblStatisticiJucatori (jucator, meci, minuteJucate, goluri, asisturi, nota, cartonase) VALUES
(49, 6, 90, 0, 1, 7, 'FARA'),  -- Lukas Hradecky
(50, 6, 90, 1, 0, 5, 'FARA'),  -- Edmond Tapsoba
(51, 6, 1, 0, 0, 5, 'GALBEN'), -- Granit Xhaka 
(52, 6, 90, 1, 0, 8, 'FARA'); -- Jeremie Frimpong

INSERT INTO tblStatisticiJucatori (jucator, meci, minuteJucate, goluri, asisturi, nota, cartonase) VALUES
(53, 6, 90, 1, 0, 8, 'FARA'), -- Harry Kane
(54, 6, 90, 0, 1, 7, 'FARA'), -- Jamal Musiala 
(55, 6, 90, 1, 1, 6, 'FARA'), -- Alphonso Davies 
(56, 6, 90, 0, 0, 5, 'FARA'); -- Manuel Neuer 


-- Match 7: FCSB vs Dinamo Bucuresti 5-0
INSERT INTO tblStatisticiJucatori (jucator, meci, minuteJucate, goluri, asisturi, nota, cartonase) VALUES
(37, 7, 90, 0, 1, 6, 'FARA'), -- Stefan Tarnovanu
(38, 7, 90, 1, 0, 9, 'FARA'), -- Vlad Chiriches
(39, 7, 90, 0, 0, 4, 'GALBEN'), -- Darius Olaru
(40, 7, 90, 1, 0, 9, 'FARA'); -- Daniel Birligea

INSERT INTO tblStatisticiJucatori (jucator, meci, minuteJucate, goluri, asisturi, nota, cartonase) VALUES
(45, 7, 90, 0, 0, 4, 'FARA'), -- Adnan Golubovic
(46, 7, 90, 0, 0, 4, 'FARA'), -- Razvan Patriche
(47, 7, 90, 0, 0, 4, 'FARA'), -- Catalin Cirjan
(48, 7, 90, 0, 0, 5, 'FARA'); -- Alberto Soro

-- Match 8: Bayern vs Dortmund 5-0
INSERT INTO tblStatisticiJucatori (jucator, meci, minuteJucate, goluri, asisturi, nota, cartonase) VALUES
(49, 8, 90, 1, 0, 8, 'FARA'),  -- Harry Kane 
(50, 8, 90, 0, 1, 7, 'FARA'),  -- Jamal Musiala 
(51, 8, 90, 0, 0, 7, 'FARA'),  -- Alphonso Davies 
(52, 8, 90, 1, 0, 9, 'FARA');  -- Manuel Neuer 

-- Borussia Dortmund
INSERT INTO tblStatisticiJucatori (jucator, meci, minuteJucate, goluri, asisturi, nota, cartonase) VALUES
(57, 8, 90, 0, 0, 6, 'FARA'),  -- Gregor Kobel 
(58, 8, 90, 0, 0, 6, 'FARA'),  -- Nico Schlotterbeck 
(59, 8, 90, 0, 1, 7, 'FARA'),  -- Karim Adeyemi 
(60, 8, 90, 1, 0, 7, 'FARA');  -- Marcel Sabitzer 

--  Match 9: Arsenal vs City 1-1
INSERT INTO tblStatisticiJucatori (jucator, meci, minuteJucate, goluri, asisturi, nota, cartonase) VALUES
(21, 9, 90, 1, 0, 8, 'FARA'),  -- William Saliba 
(22, 9, 90, 0, 0, 7, 'FARA'),  -- Declan Rice 
(23, 9, 90, 0, 1, 7, 'FARA'),  -- Ben White 
(24, 9, 90, 0, 0, 6, 'FARA');  -- David Raya 

-- Manchester City 
INSERT INTO tblStatisticiJucatori (jucator, meci, minuteJucate, goluri, asisturi, nota, cartonase) VALUES
(17, 9, 90, 1, 0, 6, 'FARA'),  -- Kevin De Bruyne 
(18, 9, 90, 0, 0, 7, 'FARA'),  -- Erling Haaland 
(19, 9, 90, 0, 0, 6, 'FARA'),  -- Ruben Dias 
(20, 9, 90, 0, 0, 6, 'FARA');  -- Rodri 


--  Match 10: Juventus vs Milan 1-1
INSERT INTO tblStatisticiJucatori (jucator, meci, minuteJucate, goluri, asisturi, nota, cartonase) VALUES
(25, 10, 90, 0, 0, 6, 'FARA'),  -- Gleison Bremer 
(26, 10, 90, 0, 1, 7, 'FARA'),  -- Weston McKennie 
(27, 10, 90, 1, 0, 9, 'FARA'),  -- Dusan Vlahovic 
(28, 10, 90, 0, 0, 7, 'FARA');  -- Michele Di Gregorio 

-- AC Milan 
INSERT INTO tblStatisticiJucatori (jucator, meci, minuteJucate, goluri, asisturi, nota, cartonase) VALUES
(33, 10, 90, 1, 0, 8, 'FARA'),  -- Tijjani Reijnders 
(34, 10, 90, 0, 0, 9, 'FARA'),  -- Christian Pulisic 
(35, 10, 90, 0, 1, 7, 'FARA'),  -- Mike Maignan 
(36, 10, 90, 0, 0, 6, 'FARA');  -- Davide Calabria 




/*#############################################################*/



/*#############################################################*/
/*  PARTEA 4 - VIZUALIZAREA STUCTURII BD SI A INREGISTRARILOR  */
DESCRIBE tblEchipe;
DESCRIBE tblJucatori;
DESCRIBE tblLigi;
DESCRIBE tblMeciuri;
DESCRIBE tblEchipeJucatori;
DESCRIBE tblStatisticiJucatori;

SELECT * FROM tblLigi;
SELECT * FROM tblEchipe;
SELECT * FROM tblJucatori;
SELECT * FROM tblEchipeJucatori;
SELECT * FROM tblMeciuri; 
SELECT * FROM tblEchipeMeciuri;
SELECT * FROM tblStatisticiJucatori;

/*#############################################################*/




/*
- NU MODIFICATI STRUCTURA ACESTUI DOCUMENT

- REDENUMITI FISIERUL  scriptXX.sql astfel incat XX sa coincida cu numarul echipei de BD. Ex: script07.sql

- SCRIPTUL AR TREBUI SA POATA FI RULAT FARA NICI O EROARE!

- ATENTIE LA CHEILE STRAINE! Nu uitati sa modificati motorul de stocare pentru tabele, la InnoDB, pentru a functiona constrangerile de cheie straina (vezi laborator 1, pagina 16 - Observatie)

*/