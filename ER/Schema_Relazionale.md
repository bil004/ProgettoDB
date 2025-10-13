Parco(**nomeParco(pk)**, descrizione, superficie, regione, accessibile, tipo)

Centro_visita(**nomeCentro(pk)**, servizi, note, orarioApertura, orarioChiusura, telefono, email, numCivico, via, CAP)

Ente(**nomeEnte(pk)**, CETS)

News(**data(pk)**, titolo(pk), foto, testo, autore)

Persona(**COD_fiscale(pk)**, nome, cognome, dataNascita, tipo)

Gruppo(**numGruppo(pk)**, tipo, totPartecipanti, classe)

Struttura_ricettiva(**nome(pk)**, contatti, servizi, trattamenti, CETS, parcheggio, impiego_ecologico, numCivico, via, CAP)

Utente(**username(pk)**, password, email, telefono)

Tour(**nomeTour(pk)**, maxPartecipanti, data, ora, stato)

Feedback(**idFeedback(pk)**, tipo, valutazione, commento, data, ora, autore, )

Calendario(**idCalendario(pk)**, data, oraInizio, oraFine, note)

Guida(**numTesserino(pk)**, nome, campo, licenza)

Tragitto(**idTragitto(pk)**, durata, nomeTragitto, punto_partenza, difficolta, descrizione)

---

-- Relazioni di associazione (logico)

VISITA(**nomeParco(pk)**, **COD_fiscale(pk)**, data, oraInizio, oraFine, entrate)

ESPRIME(**username(pk)**, **idFeedback(pk)**, anonimo)

PRENOTA(**username(pk)**, **nomeTour(pk)**, stato, dataPrenotazione, giorniDisponibili, orario)

RISERVARE(**COD_fiscale(pk)**, **nome(pk)**, **dataPrenotazione(pk)**, numPersone, stato)