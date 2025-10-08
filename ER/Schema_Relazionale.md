Parco(**Nome(pk)**, descrizione, superficie, regione, accessibile, tipo)
Centro_visita (**Nome(pk)**, servizi, note, orarioApertura, telefono, email, numCivico, via, CAP)

Ente(**Nome(pk)**, CETS)

News (**data(pk)**, titolo(pk), foto, testo, autore)

Persona(**COD_fiscale(pk)**, nome, cognome, dataNascita, tipo)

Gruppo(**ID(pk)**, tipo, totPartecipanti)

Struttura_ricettiva(**nome(pk)**, contatti, servizi, trattamenti, CETS*, parcheggio, impiego_ecologico*, numCivico, via, CAP)

Utente(**username(pk)**, password)

Tour(**nome(pk)**, maxPartecipanti, data, ora, stato)

Feedback(**idFeedback(pk)**, testo, voto, data, autore)


---

-- Relazioni di associazione (logico)


GESTIONE(**nomeEnte(pk)**, **codParco(pk)**)
- FK: nomeEnte → ENTE(nome), codParco → PARCO(codParco)

POSSEDE(**nomeEnte(pk)**, **idStruttura(pk)**)
- FK: nomeEnte → ENTE(nome), idStruttura → STRUTTURA_RICETTIVA(idStruttura)

VISITA(**codParco(pk)**, **codFiscale(pk)**, data, oraInizio, oraFine, entrate)
- PK (composita): (codParco, codFiscale, data)
- FK: codParco → PARCO(codParco), codFiscale → PERSONA(codFiscale)

SI_SUPERFICIE_A(**idCentro(pk)**, **codParco(pk)**)
- FK: idCentro → CENTRO_VISITA(idCentro), codParco → PARCO(codParco)

SI_RIVOLGE_A(**idCentro(pk)**, **idUtente(pk)**)
- FK: idCentro → CENTRO_VISITA(idCentro), idUtente → UTENTE(idUtente)

SI_REGISTRA(**idUtente(pk)**, **codFiscale(pk)**)
- FK: idUtente → UTENTE(idUtente), codFiscale → PERSONA(codFiscale)

DISPONIBILE(**idCalendario(pk)**, **codGuida(pk)**)
- FK: idCalendario → CALENDARIO(idCalendario), codGuida → GUIDA(codGuida)

SVOLGE(**codGuida(pk)**, **idTragitto(pk)**)
- FK: codGuida → GUIDA(codGuida), idTragitto → TRAGITTO(idTragitto)

INCLUDE(**idTour(pk)**, **idTragitto(pk)**)
- FK: idTour → TOUR(idTour), idTragitto → TRAGITTO(idTragitto)

ASSEGNA_A(**codGuida(pk)**, **idTour(pk)**)
- FK: codGuida → GUIDA(codGuida), idTour → TOUR(idTour)

RELATIVO_A(**idTour(pk)**, **idFeedback(pk)**)
- FK: idTour → TOUR(idTour), idFeedback → FEEDBACK(idFeedback)

RIGUARDA(**idTragitto(pk)**, **idFeedback(pk)**)
- FK: idTragitto → TRAGITTO(idTragitto), idFeedback → FEEDBACK(idFeedback)

ESPRIME(**idUtente(pk)**, **idFeedback(pk)**)
- FK: idUtente → UTENTE(idUtente), idFeedback → FEEDBACK(idFeedback)

PRENOTA(**idUtente(pk)**, **idTour(pk)**, stato, dataPrenotazione)
- PK (composita): (idUtente, idTour)
- FK: idUtente → UTENTE(idUtente), idTour → TOUR(idTour)

RISERVARE(**codFiscale(pk)**, **idStruttura(pk)**, **dataPrenotazione(pk)**, numPersone, stato)
- FK: codFiscale → PERSONA(codFiscale), idStruttura → STRUTTURA_RICETTIVA(idStruttura)

APPARTIENE_A(**codFiscale(pk)**, **idGruppo(pk)**)
- FK: codFiscale → PERSONA(codFiscale), idGruppo → GRUPPO(idGruppo)