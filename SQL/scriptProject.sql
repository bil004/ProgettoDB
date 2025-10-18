create database Progetto_2024_2025;

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
    COD_fiscale char(16),
    constraint COD_fiscale_FK foreign key(COD_fiscale) references Persona(COD_fiscale),
    constraint Utente_PK primary key(username)
);

create table Tragitti (
    nomeTragitto varchar(20),
    durata time,
    punto_partenza varchar(20),
    difficolta int check (difficolta between 1 and 10),
    descrizione text,
	tipo varchar(10),
    constraint Tragitti_PK primary key(nomeTragitto)
);

create table Feedback (
    data date,
    ora time,
    nomeTragitto varchar(20),
    tipo varchar(20),
    valutazione int check (valutazione between 1 and 5),
    commento text,
    anonimo boolean default false,
    username varchar(20) default NULL,
    constraint Feedback_nomeTragitto_FK foreign key(nomeTragitto) references Tragitti(nomeTragitto),
    constraint checkAnonimo check (
        (anonimo = true  and username is null)
        or
        (anonimo = false and username is not null)
    ),
    constraint Feedback_PK primary key(data, ora, nomeTragitto)
);

create table Guida (
    numTesserino int,
    voto int check (voto between 1 and 5),
    licenza varchar(20),
    campo varchar(20),
    constraint Guida_PK primary key(numTesserino)
);

create table Calendario (
    numTesserino int,
	oraInizio time,
    oraFine time,
    data date,
	note text,
	constraint numTesserino_FK foreign key(numTesserino) references Guida(numTesserino),
    constraint Calendario_PK primary key(numTesserino, oraInizio, oraFine, data)
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
    nomeCentro varchar(20),
    indirizzo varchar(20),
    servizi varchar(20),
    orarioApertura time,
    orarioChiusura time,
    telefono varchar(20),
    email varchar(20),
    note text,
    constraint Centro_visita_PK primary key(nomeCentro)
);

/*---------------------------------------------------------------------------------------------------------------*/

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

create table Relativo_a (
	data date,
	ora time,
	nomeTragitto varchar(20) foreign key(nomeTragitto) references Tragitti(nomeTragitto),
	numTesserino int,
	constraint Relativo_a primary key(nomeTour, numTesserino),
	constraint Tour_FK foreign key(nomeTour) references Tour(nomeTour),
	constraint Guida_FK foreign key(numTesserino) references Guida(numTesserino)
);

create table Svolge (
	nomeTragitto varchar(20) foreign key(nomeTragitto) references Tragitti(nomeTragitto),
	numTesserino int foreign key(numTesserino) references Guida(numTesserino),
	constraint Svolge_PK primary key(nomeTragitto, numTesserino),
);

create table Include (
    nomeTragitto varchar(20) foreign key(nomeTragitto) references Tragitti(nomeTragitto),
	nomeTour varchar(20) foreign key(nomeTour) references Tour(nomeTour),
	constraint Svolge_PK primary key(nomeTragitto, nomeTour),
); 

create table Prenota (
    username varchar(20) foreign key(username) references Utente(username),
    nomeTour varchar(20) foreign key(nomeTour) references Tour(nomeTour),
    stato text,
    disponibile boolean,
    giornoDisponibile date,
    orario time,
    data date,
    constraint Prenota_PK primary key(username, nomeTour)
);

create table Si_rivolge_a (
    COD_fiscale char(16) foreign key(COD_fiscale) references Persona(COD_fiscale),
    nomeCentro char(20) foreign key(nomeCentro) references Centro_visita(nomeCentro),
    constraint Si_rivolge_a_PK primary key(COD_fiscale, nomeCentro)
);

create table Si_riferisce_a (
    nomeParco varchar(20) foreign key(nomeParco) references Parco(nomeParco),
    nomeCentro char(20) foreign key(nomeCentro) references Centro_visita(nomeCentro),
    constraint Si_riferisce_a_PK primary key(nomeParco, nomeCentro)
);

create table Gestione(
    nomeParco varchar(20) foreign key(nomeParco) references Parco(nomeParco),
    nomeEnte varchar(20) foreign key(nomeEnte) references Ente(nomeEnte),
    constraint Gestione_PK primary key(nomeParco, nomeEnte)
);

create table Riservare (
    COD_fiscale char(16) foreign key(COD_fiscale) references Persona(COD_fiscale),
    via varchar(10),
    cap int not null,
    numCivico int not null,
    dataPrenotazione date not null,
    numStanze int,
    stato text,
    constraint Riservare_PK primary key(COD_fiscale, via, cap, numCivico, dataPrenotazione),
    constraint Riservare_fk_persona foreign key(COD_fiscale) references Persona(COD_fiscale),
    constraint Riservare_fk_struttura foreign key(via, cap, numCivico) references Struttura_ricettiva(via, cap, numCivico)
);

create table Appartiene_a (
    COD_fiscale char(16) foreign key(COD_fiscale) references Persona(COD_fiscale),
    nomeGruppo varchar(20) foreign key(nomeGruppo) references Gruppo(nomeGruppo),
    constraint Appartiene_a_PK primary key(COD_fiscale, nomeGruppo)
);