## Relazioni

Parco(**nomeParco(pk)**, descrizione, superficie, regione, accessibile, tipo)

Centro_visita(**nomeCentro(pk)**, servizi, note, orarioApertura, orarioChiusura, telefono, email, indirizzo)

Ente(**nomeEnte(pk)**, CETS)

News(**data(pk)**, titolo(pk), foto, testo, autore)

Persona(**COD_fiscale(pk)**, nome, cognome, dataNascita, tipo, _nomeGruppo_)

Gruppo(**numGruppo(pk)**, tipo, totPartecipanti, classe)

Struttura_ricettiva(**numCivico(pk)**, **via(pk)**, **CAP(pk)**, contatti, servizi, trattamenti, CETS*, parcheggio, impiego_ecologico)

Utente(**username(pk)**, password, email, telefono, _CODfiscale_)

Tour(**nomeTour(pk)**, maxPartecipanti, data, ora, stato)

Feedback(**idFeedback(pk)**, tipo, valutazione, commento, data, ora, autore, Feedback_Tragitto_FK)

Calendario(**idCalendario(pk)**, data, oraInizio, oraFine, note)

Guida(**numTesserino(pk)**, nome, campo, licenza)

Tragitto(**idTragitto(pk)**, durata, nomeTragitto, punto_partenza, difficolta, descrizione, tipo)

<br><br>

## Relazioni di associazione (logico)

Visita(**nomeParco(pk)**, **COD_fiscale(pk)**, data, oraInizio, oraFine)

Esprime(**username(pk)**, **idFeedback(pk)**, anonimo)

Prenota(**username(pk)**, **nomeTour(pk)**, stato, dataPrenotazione, giorniDisponibili, orario)

Riservare(**COD_fiscale(pk)**, **nome(pk)**, **dataPrenotazione(pk)**, numPersone, stato)