Parco(**nomeParco(pk)**, descrizione, superficie, regione, accessibile, tipo)

Centro_visita(**nomeCentro(pk)**, servizi, note, orarioApertura, orarioChiusura, telefono, email, numCivico, via, CAP)

Ente(**nomeEnte(pk)**, CETS)

News(**data(pk)**, titolo(pk), foto, testo, autore)

Persona(**COD_fiscale(pk)**, nome, cognome, dataNascita, tipo)

Gruppo(**numGruppo(pk)**, tipo, totPartecipanti, classe)

Struttura_ricettiva(**nome(pk)**, contatti, servizi, trattamenti, CETS, parcheggio, impiego_ecologico, numCivico, via, CAP)

Utente(**username(pk)**, password, email, telefono, Utente_CODfiscale_FK)

Tour(**nomeTour(pk)**, maxPartecipanti, data, ora, stato)

Feedback(**idFeedback(pk)**, tipo, valutazione, commento, data, ora, autore, Feedback_Tragitto_FK)

Calendario(**idCalendario(pk)**, data, oraInizio, oraFine, note, Calendario_Guida_FK)

Guida(**numTesserino(pk)**, nome, campo, licenza)

Tragitto(**idTragitto(pk)**, durata, nomeTragitto, punto_partenza, difficolta, descrizione)

---

-- Relazioni di associazione (logico)

Visita(**nomeParco(pk)**, **COD_fiscale(pk)**, data, oraInizio, oraFine)

Esprime(**username(pk)**, **idFeedback(pk)**, anonimo)

Prenota(**username(pk)**, **nomeTour(pk)**, stato, dataPrenotazione, giorniDisponibili, orario)

Riservare(**COD_fiscale(pk)**, **nome(pk)**, **dataPrenotazione(pk)**, numPersone, stato)