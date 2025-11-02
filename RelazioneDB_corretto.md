# Relazione Progetto Database — Parchi, Tour e Visite

Autori: bil004 (team)
Data: 2025-11-02

## Obiettivo

Progettare e realizzare un database per la gestione di parchi naturali, centri visita, tour guidati, tragitti escursionistici, feedback degli utenti, strutture ricettive e prenotazioni. Il sistema supporta:
- gestione anagrafica di persone, utenti e guide;
- pianificazione di tour e assegnazione guide;
- modellazione di tragitti e inclusione nei tour;
- raccolta e consultazione di feedback (anonimi o associati ad utente);
- interazioni con centri visita e enti gestori dei parchi;
- prenotazioni di strutture ricettive e tour.

## Modello concettuale (sintesi)

Entità principali e attributi salienti:
- Parco(nomeParco, descrizione, superficie, regione, accessibile, tipo)
- Centro_visita(nomeCentro, indirizzo, servizi, orarioApertura, orarioChiusura, telefono, email, note)
- Ente(nomeEnte, CETS)
- News(data, titolo, foto, testo, autore)
- Persona(COD_fiscale, nome, cognome, dataNascita, tipo)
- Gruppo(nomeGruppo, tipo, totPartecipanti, classe)
- Struttura_ricettiva(via, cap, numCivico, nome, contatti, parcheggio, CETS, trattamenti, servizi, impegno_ecologico)
- Utente(username, password, email, telefono, COD_fiscale → Persona)
- Guida(numTesserino, voto, licenza, campo)
- Tragitti(nomeTragitto, durata, punto_partenza, difficolta, descrizione, tipo)
- Tour(nomeTour, data, ora, stato, maxPartecipanti)
- Feedback(data, ora, nomeTragitto → Tragitti, tipo, valutazione, commento, anonimo, username → Utente opzionale)
- Calendario(numTesserino → Guida, data, oraInizio, oraFine, note)

Relazioni principali:
- Gestione(Parco, Ente)
- Si_riferisce_a(Parco, Centro_visita), Si_rivolge_a(Persona, Centro_visita)
- Visita(Persona, Parco, data, oraInizio, oraFine)
- Appartiene_a(Persona, Gruppo)
- Include(Tour, Tragitti), Svolge(Guida, Tragitti)
- Assegnata_a(Tour, Guida), Relativo_a(Tour, Guida, Tragitti, data, ora)
- Prenota(Utente, Tour, stato, disponibile, giornoDisponibile, orario, data)
- Riservare(Persona, Struttura_ricettiva, dataPrenotazione, numStanze, stato)
- Esprime(Utente, Feedback)

Le cardinalità sono coerenti con le chiavi e i vincoli esterni riportati nel modello logico.

## Modello logico (schema relazionale)

Di seguito lo schema consolidato, coerente con gli script SQL del progetto.

Tabelle di base:
- Persona(COD_fiscale PK, cognome, nome, dataNascita, tipo)
- Parco(nomeParco PK, descrizione, superficie, regione, accessibile default true, tipo)
- Ente(nomeEnte PK, CETS)
- News((data, titolo) PK, testo, autore, foto)
- Struttura_ricettiva((via, cap, numCivico) PK, nome, contatti, parcheggio, CETS default false, trattamenti, servizi, impegno_ecologico default false)
- Gruppo(nomeGruppo PK, tipo, totPartecipanti, classe nullable)
- Utente(username PK, password, email, telefono, COD_fiscale FK→Persona)
- Tragitti(nomeTragitto PK, durata time, punto_partenza, difficolta int check 1..10, descrizione, tipo)
- Guida(numTesserino PK, voto int check 1..5, licenza, campo)
- Calendario((numTesserino, oraInizio, oraFine, data) PK, note; numTesserino FK→Guida)
- Tour(nomeTour PK, data, ora, stato, maxPartecipanti)

Tabelle associative e di processo:
- Feedback((data, ora, nomeTragitto) PK, tipo, valutazione int check 1..5, commento, anonimo boolean default false, username nullable, nomeTragitto FK→Tragitti,
  vincolo: (anonimo = true ⇒ username IS NULL) ∨ (anonimo = false ⇒ username IS NOT NULL)
)
- Esprime((username, data, ora, nomeTragitto) PK; username FK→Utente, (data,ora,nomeTragitto) FK→Feedback)
- Visita((nomeParco, COD_fiscale) PK, data, oraInizio, oraFine; nomeParco FK→Parco, COD_fiscale FK→Persona)
- Assegnata_a((nomeTour, numTesserino) PK; FKs→Tour, Guida)
- Relativo_a((nomeTour, numTesserino) PK, data, ora, nomeTragitto FK→Tragitti; FKs→Tour, Guida)
- Svolge((nomeTragitto, numTesserino) PK; FKs→Tragitti, Guida)
- Include((nomeTragitto, nomeTour) PK; FKs→Tragitti, Tour)
- Prenota((username, nomeTour) PK, stato, disponibile boolean, giornoDisponibile date, orario time, data date; FKs→Utente, Tour)
- Si_rivolge_a((COD_fiscale, nomeCentro) PK; FKs→Persona, Centro_visita)
- Si_riferisce_a((nomeParco, nomeCentro) PK; FKs→Parco, Centro_visita)
- Gestione((nomeParco, nomeEnte) PK; FKs→Parco, Ente)
- Riservare((COD_fiscale, via, cap, numCivico, dataPrenotazione) PK, numStanze, stato; FK COD_fiscale→Persona, FK (via,cap,numCivico)→Struttura_ricettiva)
- Appartiene_a((COD_fiscale, nomeGruppo) PK; FKs→Persona, Gruppo)

Note su allineamenti rispetto allo schema bozza:
- La tabella Tragitto/Tragitti è implementata come `Tragitti` con chiave `nomeTragitto`.
- `Gruppo` usa `nomeGruppo` come PK (non `numGruppo`).
- La relazione `Visita` usa PK (nomeParco, COD_fiscale); l’eventuale duplicazione su più date/ore richiederebbe l’inclusione di `data` nella chiave se si volesse tracciare visite multiple per coppia Parco-Persona.

## Scelte progettuali

- Chiavi primarie: scelte significative quando esistono codici naturali (es. COD_fiscale, numTesserino, nomeTour); composite dove necessario (es. (via,cap,numCivico) per Struttura_ricettiva).
- Tipi dati: scelta coerente con PostgreSQL (time, date, boolean, text, varchar(N), bytea per immagini in `News`).
- Vincoli: check su range (`difficolta`, `voto`, `valutazione`), check di coerenza per anonimato feedback, default sensati (es. `accessibile` del Parco, `CETS`/`impegno_ecologico` della struttura).
- Normalizzazione: schema in 3NF; assenza di dipendenze parziali o transitive nelle entità principali; tabelle associative per risolvere N:M; nessuna ridondanza significativa persiste negli script.

## Operazioni e interrogazioni principali

Gli script `SQL/testQueryProject.sql` includono un set di query di verifica. Esempi significativi:
- Parco ↔ Ente (CETS): elenco parchi con ente gestore e certificazione CETS.
- Tour ↔ Include ↔ Tragitti: componenti di ciascun tour con durata/difficoltà.
- Guide ↔ Svolge ↔ Tragitti: competenze delle guide per tragitto.
- Feedback: calcolo della media valutazioni per tragitto; esclusione/gestione feedback anonimi.
- Prenotazioni strutture: join multi-attributo con chiave composta (via,cap,numCivico).

Queste query convalidano chiavi, FKs e vincoli di dominio implementati.

## Popolamento dati

Il file `SQL/dataProject.sql` fornisce dati di esempio coerenti con i vincoli:
- Persone/Utenti/Guide con referenze incrociate (Utente → Persona).
- Parchi, Enti e Centro_visita collegati via `Gestione` e `Si_riferisce_a`.
- Tour, Tragitti, Assegnazioni e inclusioni.
- Feedback sia anonimi che nominali, rispettando il vincolo di coerenza.
- Prenotazioni a strutture ricettive e tour.

## Considerazioni su integrità e qualità dei dati

- Vincolo coerenza Feedback: impedisce stati incoerenti tra `anonimo` e `username`.
- Difficoltà tragitti 1..10, valutazioni 1..5, voto guida 1..5: riduce outlier e garantisce confronto omogeneo.
- Chiavi composte e FKs su strutture e prenotazioni evitano orfani su riferimenti indirizzo.
- Possibile estensione: aggiungere unique constraints su campi come `email` di Utente e `licenza` di Guida se richiesto dal dominio.

## Prestazioni e indici suggeriti

- Indici su FKs frequentemente joinate: `Utente(COD_fiscale)`, `Feedback(nomeTragitto)`, `Include(nomeTour)`, `Svolge(numTesserino)`, `Assegnata_a(nomeTour)`, `Riservare(via,cap,numCivico)`, `Prenota(nomeTour)`.
- Indici composti in base alle query predominanti (es. `(data, ora, nomeTragitto)` su Feedback è PK quindi già indicizzata).

## Limiti e possibili miglioramenti

- La PK di `Visita` non include la data: per tracciare visite multiple della stessa persona allo stesso parco, valutare PK estesa a `(nomeParco, COD_fiscale, data, oraInizio)`.
- `Tour` ha solo PK `nomeTour`: se più edizioni con lo stesso nome, considerare PK su `(nomeTour, data)` o introdurre un identificatore surrogate.
- Validazioni su formati (email, telefono, CAP) possono essere rafforzate con check/constraint specifici o domini.

## Conclusioni

Lo schema implementato è coerente, normalizzato e supportato da vincoli che preservano integrità referenziale e regole di business principali. Gli script forniti (creazione, popolamento e test) dimostrano il corretto funzionamento del modello dati e costituiscono una base solida per evoluzioni applicative.
