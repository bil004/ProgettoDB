-- PERSONA
insert into Persona values
('RSSMRA80A01H501Z', 'Rossi', 'Mario', '1980-01-01', 'Visitatore', NULL),
('BNCLRA95C10H501X', 'Bianchi', 'Laura', '1995-03-10', 'Guida', NULL),
('VRDGPP00D15H501A', 'Verdi', 'Giuseppe', '2000-04-15', 'Utente', 'Classe3A');

-- ENTE
insert into Ente values
('WWF', true),
('Legambiente', false);

-- PARCO
insert into Parco values
('Gran Paradiso', 'Parco nazionale alpino', 70300, 'Piemonte', true, 'Montano'),
('Cinque Terre', 'Area costiera ligure', 3800, 'Liguria', true, 'Marino');

-- GRUPPO
insert into Gruppo values
('Classe3A', 'Scolastico', 25, '3A'),
('TrekkingClub', 'Amatoriale', 12, null);

-- UTENTE
insert into Utente values
('marior', 'password1', 'mario.rossi@email.it', '333123456', 'RSSMRA80A01H501Z'),
('peppev', 'passverde', 'g.verdi@email.it', '339111222', 'VRDGPP00D15H501A');

-- GUIDA
insert into Guida values
(101, 5, 'LIC123', 'Naturalistica'),
(102, 4, 'LIC456', 'Storica');

-- TRAGITTI
insert into Tragitti values
('SentieroLago', '02:30:00', 'Base rifugio', 4, 'Percorso intorno al lago alpino', 'Trekking'),
('BorgoAntico', '01:00:00', 'Centro visite', 2, 'Passeggiata nel borgo medievale', 'Culturale');

-- FEEDBACK
insert into Feedback values
('SentieroLago', '2025-10-01', '09:30:00', 5, 'Bellissimo percorso!', 'Positivo', 'marior', false),
('BorgoAntico', '2025-10-02', '11:00:00', 3, 'Troppo breve ma interessante', 'Neutro', null, true),
('SentieroLago', '2025-11-15', '10:00:00', 5, 'Tutto perfetto!', 'Positivo', 'peppev', false),
('BorgoAntico', '2025-11-16', '11:00:00', 4, 'Molto carino, consigliato.', 'Positivo', NULL, true);

-- Riservare una struttura esistente (CORRETTO)
insert into Riservare values
('ViaMontagna', 12, 10100, 'BNCLRA95C10H501X', '2025-12-05', 1, 'Confermata');

-- CALENDARIO
insert into Calendario values
('2025-10-20', '09:00:00', '12:00:00', 'Tour mattutino'),
('2025-10-21', '14:00:00', '17:00:00', 'Visita pomeridiana');

-- TOUR
insert into Tour values
('TourLago', '2025-10-20', '09:00:00', 'Confermato', 15),
('TourBorgo', '2025-10-21', '14:00:00', 'Aperto', 20);

-- ASSEGNATA_A
insert into Assegnata_a values
('TourLago', 101),
('TourBorgo', 102);

-- INCLUDE
insert into Include values
('SentieroLago', 'TourLago'),
('BorgoAntico', 'TourBorgo');

-- SVOLGE
insert into Svolge values
('SentieroLago', 101),
('BorgoAntico', 102);

-- RELATIVO_A
insert into Relativo_a values
(101, 'SentieroLago', '2025-10-01', '09:30:00'),
(102, 'BorgoAntico', '2025-10-02', '11:00:00');

-- STRUTTURA_RICETTIVA
insert into Struttura_ricettiva values
('ViaMontagna', 12, 10100, 'HotelAlpino', '0123456789', 'WiFi', true, 'Mezza pensione', true, true),
('ViaLitorale', 5, 19010, 'B&B MareBlu', '019654321', 'Colazione', false, 'Solo pernottamento', false, false);

-- RISERVARE
insert into Riservare values
('ViaMontagna', 12, 10100, 'RSSMRA80A01H501Z', '2025-10-10', 1, 'Confermata'),
('ViaLitorale', 5, 19010, 'VRDGPP00D15H501A', '2025-10-11', 2, 'In attesa');

-- CENTRO_VISITA
insert into Centro_visita values
('CentroGranParadiso', 'PiazzaAlpi', '08:00:00', 'Info, Mostre', 'Aperto tutto l’anno', '18:00:00', '0123456789', 'info@gp.it'),
('CentroCinqueTerre', 'ViaMarina', '09:00:00', 'Info, Guida', 'Chiuso martedì', '19:00:00', '019112233', 'info@5terre.it');

-- SI_RIFERISCE_A
insert into Si_riferisce_a values
('Gran Paradiso', 'CentroGranParadiso'),
('Cinque Terre', 'CentroCinqueTerre');

-- SI_RIVOLGE_A
insert into Si_rivolge_a values
('RSSMRA80A01H501Z', 'CentroGranParadiso'),
('VRDGPP00D15H501A', 'CentroCinqueTerre');

-- GESTIONE
insert into Gestione values
('Gran Paradiso', 'WWF'),
('Cinque Terre', 'Legambiente');

-- PRENOTA
insert into Prenota values
('TourLago', 'marior', '2025-10-01', '09:00:00', 1, true, 'Confermato'),
('TourBorgo', 'peppev', '2025-10-05', '14:00:00', 1, true, 'In attesa');