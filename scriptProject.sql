create table Persona (
    COD_fiscale char(16),
    cognome varchar(20),
    nome varchar(20),
    dataNascita date,
    tipo varchar(20),
    constraint Persona_PK primary key(COD_fiscale)
);

create table Parco (
    nomeParco varchar(40),
    descrizione text,
    superficie int,
    regione varchar(20),
    accessibile boolean default true,
    tipo varchar(40),
    constraint Parco_PK primary key(nomeParco)
);

create table Ente (
    nomeEnte varchar(20),
    CETS boolean,
    constraint Ente_PK primary key(nomeEnte)
);

create table News (
    data date,
    titolo varchar(20),
    testo text,
    autore varchar(100),
    foto bytea,
    constraint News_PK primary key(data, titolo)
);

create table Struttura_ricettiva (
    via varchar(20),
    cap int,
    numCivico int,
    nome varchar(40),
    contatti varchar(30),
    parcheggio boolean,
    CETS boolean default false,
    trattamenti varchar(30),
    servizi varchar(30),
    impegno_ecologico boolean default false,
    constraint Sr_PK primary key(via, cap, numCivico)
);

create table Gruppo (
    nomeGruppo varchar(20),
    tipo varchar(20),
    totPartecipanti int,
    classe char(2) default null,
    constraint Gruppo_PK primary key(nomeGruppo)
);

create table Utente (
    username varchar(20),
    password varchar(20),
    email varchar(40),
    telefono varchar(9),
    constraint Utente_PK primary key(username)
);

create table Tragitti (
    nomeTragitto varchar(20),
    durata time,
    punto_partenza varchar(20),
    difficolta int check (difficolta between 1 and 10),
    descrizione text,
    constraint Tragitti_PK primary key(nomeTragitto)
);

create table Feedback (
    data date,
    ora time,
	nomeTragitto varchar(20),
    tipo varchar(20),
    valutazione int check (valutazione between 1 and 5),
    commento text,
	constraint nomeTragitto_FK foreign key(nomeTragitto) references Tragitti(nomeTragitto),
    constraint Feedback_PK primary key(data, ora, nomeTragitto)
);

create table Guida (
    numTesserino int,
    voto int check (voto between 1 and 5),
    cognome varchar(20),
    nome varchar(20),
    dataNascita date,
    licenza varchar(20),
    campo varchar(20),
    constraint Guida_PK primary key(numTesserino)
);

create table Calendario (
    idCalendario int,
    oraInizio time,
    oraFine time,
    data date,
    constraint Calendario_PK primary key(idCalendario)
);

create table Tour (
    nomeTour varchar(20),
    data date,
    ora time,
    stato varchar(50),
    maxPartecipanti int,
    constraint Tour_PK primary key(nomeTour)
);

create table Centro_visita (
    Nome varchar(20),
    numCivico int,
    via varchar(20),
    CAP int,
    servizi varchar(20),
    orarioApertura time,
    orarioChiusura time,
    telefono varchar(20),
    email varchar(20),
    note text,
    constraint CV_PK primary key(Nome)
);

create table Riservare (
    COD_fiscale char(16) not null,
    via varchar(10) not null,
    cap int not null,
    numCivico int not null,
    dataPrenotazione date not null,
    numStanze int,
    stato text,
    constraint Riservare_PK primary key(COD_fiscale, via, cap, numCivico, dataPrenotazione),
    constraint Riservare_fk_persona foreign key(COD_fiscale) references Persona(COD_fiscale),
    constraint Riservare_fk_struttura foreign key(via, cap, numCivico) references Struttura_ricettiva(via, cap, numCivico)
);

create table Prenota (
    username varchar(20),
    nomeTour varchar(20),
    stato text,
    disponibile boolean,
    giornoDisponibile date,
    orario time,
    data date,
    constraint Dude_PK primary key(username, nomeTour),
    constraint Utente_FK foreign key(username) references Utente(username),
    constraint Tour_FK foreign key(nomeTour) references Tour(nomeTour)
);

create table Esprime (
    username varchar(20),
    data date,
    ora time,
    anonimo boolean default false,
    constraint Esprime_PK primary key(username, data, ora),
    constraint Utente_FK foreign key(username) references Utente(username),
    constraint Feedback_FK foreign key(data, ora) references Feedback(data, ora)
);

create table Visita(
    nomeParco varchar(20),
    COD_fiscale char(16),
    data date,
    oraInizio time,
    oraFine time,
    constraint Visita_PK primary key(nomeParco, COD_fiscale),
    constraint Persona_FK foreign key(COD_fiscale) references Persona(COD_fiscale),
    constraint Parco_FK foreign key(nomeParco) references Parco(nomeParco)
);

create table Assegnata_a (
	nomeTour varchar(20),
	numTesserino int,
	constraint Assegnata_a_PK primary key(nomeTour, numTesserino),
	constraint Tour_FK foreign key(nomeTour) references Tour(nomeTour),
	constraint Guida_FK foreign key(numTesserino) references Guida(numTesserino)
);

/*create table Relativo_a (
	data date,
	ora time,
	nomeTragitto varchar(20) foreign key(nomeTragitto) references Tragitto(nomeTragitto),
	numTesserino int,
	constraint Relativo_a primary key(nomeTour, numTesserino),
	constraint Tour_FK foreign key(nomeTour) references Tour(nomeTour),
	constraint Guida_FK foreign key(numTesserino) references Guida(numTesserino)
);

create table Assegnata_a (
	nomeTour varchar(20),
	numTesserino int,
	constraint Assegnata_a_PK primary key(nomeTour, numTesserino),
	constraint Tour_FK foreign key(nomeTour) references Tour(nomeTour),
	constraint Guida_FK foreign key(numTesserino) references Guida(numTesserino)
);*/