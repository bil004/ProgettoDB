-- ===============================
-- TEST DATABASE QUERY SUITE
-- ===============================

-- 1️⃣ Query base
SELECT * FROM Persona;

SELECT u.username, u.email, p.nome, p.cognome, p.tipo
FROM Utente u
JOIN Persona p ON u.COD_fiscale = p.COD_fiscale;

SELECT numTesserino, licenza, campo, voto FROM Guida;


-- 2️⃣ Parchi e gestione
SELECT pa.nomeParco, e.nomeEnte, e.CETS
FROM Parco pa
JOIN Gestione g ON pa.nomeParco = g.nomeParco
JOIN Ente e ON g.nomeEnte = e.nomeEnte;

SELECT c.nomeCentro, p.nomeParco, p.regione
FROM Centro_visita c
JOIN Si_riferisce_a s ON c.nomeCentro = s.nomeCentro
JOIN Parco p ON s.nomeParco = p.nomeParco;


-- 3️⃣ Tragitti, tour e guide
SELECT t.nomeTour, tr.nomeTragitto, tr.durata, tr.difficolta
FROM Tour t
JOIN Include i ON t.nomeTour = i.nomeTour
JOIN Tragitti tr ON i.nomeTragitto = tr.nomeTragitto;

SELECT g.numTesserino, g.campo, tr.nomeTragitto, tr.tipo
FROM Guida g
JOIN Svolge s ON g.numTesserino = s.numTesserino
JOIN Tragitti tr ON s.nomeTragitto = tr.nomeTragitto;

SELECT t.nomeTour, t.data, g.numTesserino, g.licenza, g.voto
FROM Tour t
JOIN Assegnata_a a ON t.nomeTour = a.nomeTour
JOIN Guida g ON a.numTesserino = g.numTesserino;


-- 4️⃣ Feedback e utenti
SELECT f.data, f.ora, f.nomeTragitto, f.valutazione, f.commento, f.username
FROM Feedback f
WHERE f.anonimo = false;

SELECT nomeTragitto, AVG(valutazione) AS media_valutazioni
FROM Feedback
GROUP BY nomeTragitto;

SELECT DISTINCT u.username, p.nome, p.cognome
FROM Esprime e
JOIN Utente u ON e.username = u.username
JOIN Persona p ON u.COD_fiscale = p.COD_fiscale;


-- 5️⃣ Strutture e prenotazioni
SELECT r.COD_fiscale, p.nome, p.cognome, s.nome AS struttura, r.dataPrenotazione, r.stato
FROM Riservare r
JOIN Persona p ON r.COD_fiscale = p.COD_fiscale
JOIN Struttura_ricettiva s ON (r.via, r.cap, r.numCivico) = (s.via, s.cap, s.numCivico);

SELECT s.nome, COUNT(*) AS numero_prenotazioni
FROM Struttura_ricettiva s
JOIN Riservare r ON (s.via, s.cap, s.numCivico) = (r.via, r.cap, r.numCivico)
GROUP BY s.nome;


-- 6️⃣ Gruppi e appartenenze
SELECT g.nomeGruppo, p.nome, p.cognome
FROM Appartiene_a a
JOIN Gruppo g ON a.nomeGruppo = g.nomeGruppo
JOIN Persona p ON a.COD_fiscale = p.COD_fiscale
ORDER BY g.nomeGruppo;


-- 7️⃣ Query complesse
SELECT u.username, t.nomeTour, t.data, g.numTesserino, g.campo
FROM Prenota p
JOIN Utente u ON p.username = u.username
JOIN Tour t ON p.nomeTour = t.nomeTour
JOIN Assegnata_a a ON t.nomeTour = a.nomeTour
JOIN Guida g ON a.numTesserino = g.numTesserino
ORDER BY u.username;

SELECT nomeTragitto, AVG(valutazione) AS media
FROM Feedback
GROUP BY nomeTragitto
HAVING AVG(valutazione) > 4;

SELECT p.nomeParco, e.nomeEnte
FROM Gestione g
JOIN Parco p ON g.nomeParco = p.nomeParco
JOIN Ente e ON g.nomeEnte = e.nomeEnte
WHERE e.CETS = true;


-- 8️⃣ Vincoli e integrità
SELECT * FROM Feedback
WHERE (anonimo = true AND username IS NOT NULL)
   OR (anonimo = false AND username IS NULL);

SELECT *
FROM Riservare r
WHERE (r.via, r.cap, r.numCivico) NOT IN (
  SELECT via, cap, numCivico FROM Struttura_ricettiva
);