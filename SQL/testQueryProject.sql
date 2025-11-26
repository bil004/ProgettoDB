-- ===============================
--   TEST DATABASE QUERY SUITE
-- ===============================

-- 1️⃣ Query base
SELECT * FROM Persona;

SELECT u.username, u.email, p.nome, p.cognome, p.tipo
FROM Utente u
JOIN Persona p ON p.COD_fiscale = u.PERSONA_COD_fiscale;

SELECT numTesserino, licenza, campo, voto FROM Guida;


-- 2️⃣ Parchi e gestione
SELECT pa.nomeParco, e.nomeEnte, e.CETS
FROM Parco pa
JOIN Gestione g ON pa.nomeParco = g.PARCO_nomeParco
JOIN Ente e ON g.ENTE_nomeEnte = e.nomeEnte;

SELECT c.nomeCentro, p.nomeParco, p.regione
FROM Centro_visita c
JOIN Si_riferisce_a s ON c.nomeCentro = s.CENTRO_VISITA_nomeCentro
JOIN Parco p ON s.PARCO_nomeParco = p.nomeParco;


-- 3️⃣ Tragitti, tour e guide
SELECT t.nomeTour, tr.nomeTragitto, tr.durata, tr.difficolta
FROM Tour t
JOIN Include i ON t.nomeTour = i.TOUR_nomeTour
JOIN Tragitti tr ON i.TRAGITTI_nomeTragitto = tr.nomeTragitto;

SELECT g.numTesserino, g.campo, tr.nomeTragitto, tr.tipo
FROM Guida g
JOIN Svolge s ON g.numTesserino = s.GUIDA_numTesserino
JOIN Tragitti tr ON s.TRAGITTI_nomeTragitto = tr.nomeTragitto;

SELECT t.nomeTour, t.data, g.numTesserino, g.licenza, g.voto
FROM Tour t
JOIN Assegnata_a a ON t.nomeTour = a.TOUR_nomeTour
JOIN Guida g ON a.GUIDA_numTesserino = g.numTesserino;


-- 4️⃣ Feedback e utenti
SELECT f.data, f.ora, f.TRAGITTI_nomeTragitto, f.valutazione, f.commento, f.UTENTE_username
FROM Feedback f
WHERE f.anonimo = false;

SELECT TRAGITTI_nomeTragitto, AVG(valutazione) AS media_valutazioni
FROM Feedback
GROUP BY TRAGITTI_nomeTragitto;

SELECT DISTINCT u.username, p.nome, p.cognome
FROM Feedback f
JOIN Utente u ON f.UTENTE_username = u.username
JOIN Persona p ON u.PERSONA_COD_fiscale = p.COD_fiscale;


-- 5️⃣ Strutture e prenotazioni
SELECT r.PERSONA_COD_fiscale, p.nome, p.cognome, s.nome AS struttura, r.dataPrenotazione, r.stato
FROM RISERVARE r
JOIN Persona p ON r.PERSONA_COD_fiscale = p.COD_fiscale
JOIN Struttura_ricettiva s ON (r.STRUTTURA_RICETTIVA_Via, r.STRUTTURA_RICETTIVA_CAP, r.STRUTTURA_RICETTIVA_numCivico) = (s.Via, s.CAP, s.numCivico);

SELECT s.nome, COUNT(*) AS numero_prenotazioni
FROM Struttura_ricettiva s
JOIN Riservare r ON (s.Via, s.CAP, s.numCivico) = (r.STRUTTURA_RICETTIVA_Via, r.STRUTTURA_RICETTIVA_CAP, r.STRUTTURA_RICETTIVA_numCivico)
GROUP BY s.nome;


-- 6️⃣ Gruppi e appartenenze
SELECT g.nomeGruppo, p.nome, p.cognome
FROM Persona p
JOIN Gruppo g ON p.GRUPPO_nomeGruppo = g.nomeGruppo
ORDER BY g.nomeGruppo;


-- 7️⃣ Query complesse
SELECT u.username, t.nomeTour, t.data, g.numTesserino, g.campo
FROM PRENOTA pr
JOIN Utente u ON pr.UTENTE_username = u.username
JOIN Tour t ON pr.TOUR_nomeTour = t.nomeTour
JOIN Assegnata_a a ON t.nomeTour = a.TOUR_nomeTour
JOIN Guida g ON a.GUIDA_numTesserino = g.numTesserino
ORDER BY u.username;

SELECT TRAGITTI_nomeTragitto, AVG(valutazione) AS media
FROM Feedback
GROUP BY TRAGITTI_nomeTragitto
HAVING AVG(valutazione) > 4;

SELECT p.nomeParco, e.nomeEnte
FROM Gestione g
JOIN Parco p ON g.PARCO_nomeParco = p.nomeParco
JOIN Ente e ON g.ENTE_nomeEnte = e.nomeEnte
WHERE e.CETS = true;


-- 8️⃣ Vincoli e integrità
-- VERIFICA DI COERENZA
SELECT * FROM Feedback
WHERE (anonimo = true AND UTENTE_username IS NOT NULL)
   OR (anonimo = false AND UTENTE_username IS NULL);

SELECT *
FROM Riservare r
WHERE (r.STRUTTURA_RICETTIVA_Via, r.STRUTTURA_RICETTIVA_CAP, r.STRUTTURA_RICETTIVA_numCivico) NOT IN (
  SELECT Via, CAP, numCivico FROM Struttura_ricettiva;


-- VERIFICA DI VIOLAZIONE ATTIVA
DELETE FROM PARCO WHERE nomeParco = 'Gran Paradiso';

INSERT INTO Feedback (TRAGITTI_nomeTragitto, data, ora, valutazione, commento, tipo, UTENTE_username, anonimo)
VALUES ('SentieroLago', '2025-12-01', '10:00:00', 1, 'Fake', 'Negativo', 'utente_inesistente_99', false);
