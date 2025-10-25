-- PERSONA
insert into Persona values
('RSSMRA80A01H501Z', 'Rossi', 'Mario', '1980-01-01', 'Visitatore'),
('BNCLRA95C10H501X', 'Bianchi', 'Laura', '1995-03-10', 'Guida'),
('VRDGPP00D15H501A', 'Verdi', 'Giuseppe', '2000-04-15', 'Utente');

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
('2025-10-01', '09:30:00', 'SentieroLago', 'Positivo', 5, 'Bellissimo percorso!', false, 'marior'),
('2025-10-02', '11:00:00', 'BorgoAntico', 'Neutro', 3, 'Troppo breve ma interessante', true, null);

-- CALENDARIO
insert into Calendario values
(101, '09:00:00', '12:00:00', '2025-10-20', 'Tour mattutino'),
(102, '14:00:00', '17:00:00', '2025-10-21', 'Visita pomeridiana');

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
('TourLago', 101, '2025-10-20', '09:00:00', 'SentieroLago'),
('TourBorgo', 102, '2025-10-21', '14:00:00', 'BorgoAntico');
-- STRUTTURA_RICETTIVA
insert into Struttura_ricettiva values
('ViaMontagna', 10100, 12, 'HotelAlpino', '0123456789', true, true, 'Mezza pensione', 'WiFi', true),
('ViaLitorale', 19010, 5, 'B&B MareBlu', '019654321', false, false, 'Solo pernottamento', 'Colazione', false);

-- RISERVARE
insert into Riservare values
('RSSMRA80A01H501Z', 'ViaMontagna', 10100, 12, '2025-10-10', 1, 'Confermata'),
('VRDGPP00D15H501A', 'ViaLitorale', 19010, 5, '2025-10-11', 2, 'In attesa');
-- CENTRO_VISITA
insert into Centro_visita values
('CentroGranParadiso', 'PiazzaAlpi', 'Info, Mostre', '08:00:00', '18:00:00', '0123456789', 'info@gp.it', 'Aperto tutto l’anno'),
('CentroCinqueTerre', 'ViaMarina', 'Info, Guida', '09:00:00', '19:00:00', '019112233', 'info@5terre.it', 'Chiuso martedì');

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

-- APPARTIENE_A
insert into Appartiene_a values
('RSSMRA80A01H501Z', 'TrekkingClub'),
('VRDGPP00D15H501A', 'Classe3A');

-- ESPRIME
insert into Esprime values
('marior', '2025-10-01', '09:30:00', 'SentieroLago', false),
('marior', '2025-10-02', '11:00:00', 'BorgoAntico', true);

-- PRENOTA
insert into Prenota values
('marior', 'TourLago', 'Confermato', true, '2025-10-20', '09:00:00', '2025-10-01'),
('peppev', 'TourBorgo', 'In attesa', true, '2025-10-21', '14:00:00', '2025-10-05');