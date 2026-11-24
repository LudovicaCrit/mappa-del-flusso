---
name: mappa-del-flusso
description: Da usare alla fine di ogni compito in cui si è letto o modificato codice, e all'inizio di un compito se il prompt contiene una riga "Risposta:". Aggiunge al resoconto la mappa del flusso (ordine di lettura dei file, ordine di esecuzione a runtime, un concetto) e una domanda calibrata sul livello di chi impara, e aggiorna il profilo di apprendimento.
---

# Mappa del flusso

Chi usa questa skill sta imparando l'architettura dei sistemi seguendo il lavoro che fai sul suo codice. Il tuo resoconto è il suo materiale di studio. Spiega sempre in concreto, ancorato ai file veri del progetto, mai in astratto: la spiegazione generica non le serve, quella dettagliata sì.

## File coinvolti

- Profilo globale: se è definita la variabile d'ambiente `MAPPA_FLUSSO_PROFILO`, usa il percorso che contiene; verificalo con echo all'inizio. Se il prompt indica esplicitamente il percorso del profilo, usa quello. Altrimenti usa `mappa-del-flusso/profilo.md` dentro la cartella `.claude` della home dell'utente: `~/.claude` su Linux e WSL, `%USERPROFILE%\.claude` su Windows. Contiene i livelli per area, le domande aperte, al massimo una per progetto, e lo storico. Se manca, crealo da template/profilo.md di questa skill e scrivi all'inizio del resoconto, in grassetto, che hai creato un profilo nuovo e in quale percorso: se chi impara ne ha già uno altrove, deve accorgersene subito.
- Progetto corrente: il nome della cartella radice del repo git corrente (`git rev-parse --show-toplevel`), o della cartella corrente se non è un repo. Se il prompt indica il progetto corrente, usa quello. Ogni progetto ha al massimo una domanda aperta, nella sua sottosezione "### nome-progetto" sotto "## Domande aperte" del profilo. Livelli, contatori, identificativi e storico sono globali, comuni a tutti i progetti. Le domande aperte degli altri progetti non si toccano mai.
- Diario del progetto: docs/mappa-flusso.md nella radice del repo su cui stai lavorando. Se manca, crealo da template/mappa-flusso.md di questa skill.
- Scrittura del profilo: rileggilo sempre subito prima di modificarlo e cambia solo le righe interessate, senza riscriverlo per intero, perché un'altra sessione può averlo modificato nel frattempo. Prima di registrare una domanda nuova, controlla in quella rilettura che non sia comparsa una domanda aperta per il progetto corrente: se c'è, non registrare la tua e riproponi quella. Assegna l'identificativo solo in quel momento, partendo dall'ultimo presente nel profilo, contando lo storico e le domande aperte di tutti i progetti. Dopo ogni scrittura rileggi il profilo e verifica che contenga ciò che hai scritto. Se la scrittura fallisce o la verifica non torna, scrivilo in apertura della risposta e non presentare la domanda come registrata: niente identificativo.

## All'inizio del compito: valutare la risposta

Se il prompt contiene una riga che inizia con "Risposta:":

1. Recupera la domanda aperta del progetto corrente dalla sezione "Domande aperte" del profilo. Se il progetto corrente non ha una domanda aperta, dillo e non valutare: la risposta va data dal progetto a cui si riferisce la domanda.
2. Valuta la risposta come corretta, parziale o sbagliata, basandoti sul codice reale. Se la risposta corrisponde chiaramente a un'altra domanda, per esempio a una domanda precedente già chiusa, l'esito è fuori bersaglio: non cambia i contatori e la domanda resta aperta. Rileggi i file se serve: non valutare a memoria.
3. Aggiorna contatori e livelli secondo le regole di avanzamento, sposta la domanda nello storico come scheda, con identificativo, data, progetto, area, livello, testo completo, risposta data, esito, correzione in 2-4 righe, come trovarlo da sola e indizio usato (il testo dell'indizio dato, oppure no se non è stato chiesto), e togli la domanda dalle domande aperte, insieme alla sottosezione del progetto. La stessa scheda si usa anche quando una domanda viene registrata come saltata, con risposta data: nessuna, correzione: nessuna e come trovarlo da sola: nessuno. La data della scheda è quella in cui la domanda è stata posta, non quella della chiusura.
4. Nel resoconto finale, prima della mappa, aggiungi una sezione "Valutazione": riporta per intero la domanda a cui si riferisce, poi l'esito e, in 2-4 righe, cosa era giusto e cosa mancava, con file e riga. La correzione chiude sempre con una riga Come trovarlo da sola: il percorso di ricerca in 2-3 passi concreti, con il file da cui partire e le parole da cercare.

Se il prompt non contiene una risposta, la domanda aperta del progetto corrente resta aperta. Viene registrata come saltata solo quando chi impara scrive Mappa: salta, Mappa: domanda nuova o Mappa: ripeti.

Se il prompt contiene solo la riga Risposta:, senza un compito, limitati alla valutazione: niente sezione Mappa del flusso e nessuna modifica al diario.

## Alla fine del compito: la sezione "Mappa del flusso"

Se nel compito hai letto o modificato codice, aggiungi in fondo al resoconto una sezione "Mappa del flusso" con questi quattro punti.

### 1. Ordine di esplorazione
I file che hai letto, nell'ordine reale, con mezza riga sul perché. Al massimo 8 righe: se ne hai letti di più, raggruppali per cartella.

### 2. Ordine di esecuzione a runtime
Per la parte toccata, il percorso che il programma segue davvero quando gira: dall'avvio, alla richiesta, fino al dato letto o salvato. Per uno script, un job o un componente frontend, usa il percorso equivalente. Indica i nomi veri dei file e, dove aiuta, delle funzioni.
Ogni passaggio che non hai verificato leggendo il codice va marcato [non verificato], con l'indicazione di dove guardare. Non inventare mai un passaggio per completare il quadro.
Se l'ordine in cui hai esplorato differisce da quello di esecuzione in un punto significativo, dillo in una riga: è una distinzione che chi impara deve vedere.

### 3. Concetto emerso
Uno solo: il concetto architetturale più importante incontrato nel compito, per esempio dependency injection, middleware, migrazione, sessione, CORS. Da 3 a 5 righe, ancorate al codice appena visto. Se il concetto è già nel diario, rimanda alla voce esistente e mostrane un aspetto nuovo, oppure scegline un altro.

### 4. Domanda
Se il progetto corrente ha già una domanda aperta, non generarne una nuova: al posto della domanda scrivi una riga che ricorda identificativo e testo di quella domanda. Le domande aperte di altri progetti non impediscono una domanda nuova. Una sola domanda, sul codice appena toccato, al livello che il profilo indica per l'area più pertinente al compito. Indica identificativo, area e livello tra parentesi quadre, per esempio [D-004, accesso ai dati, livello 1]. Non dare la risposta e non suggerirla. Scrivila nella sottosezione del progetto corrente sotto Domande aperte, creandola se manca, con un identificativo progressivo D-NNN, data, progetto, area, livello e testo completo.

Ai livelli 1 e 2 la domanda chiede una sola cosa: un file, oppure una funzione, oppure una riga, non più elementi insieme. Non deve richiedere di conoscere in anticipo costrutti del linguaggio: deve misurare se chi impara sa trovare, non se sa già.

Infine aggiungi al diario del progetto una voce con data, una riga sul compito, il punto 2 e il punto 3. Aggiorna l'indice dei concetti del diario se il concetto è nuovo.

## Comandi nel prompt

Chi impara può regolare la skill con una riga del prompt che inizia con "Mappa:". I comandi valgono solo per il compito in corso, salvo pausa e ripresa.

- **Mappa: senza domanda** — produci la mappa del flusso ma non fare la domanda.
- **Mappa: niente** — non produrre la sezione Mappa del flusso in questo compito, né aggiornare il diario. Serve per le urgenze.
- **Mappa: pausa** — come "niente", ma per tutti i compiti successivi, anche in sessioni nuove: nel profilo imposta "Stato: in pausa". Finché il profilo è in pausa, scrivi solo una riga a fine resoconto per ricordare che la mappa è in pausa.
- **Mappa: riprendi** — nel profilo imposta "Stato: attiva" e torna al funzionamento normale da questo compito.
- **Mappa: salta** — registra la domanda aperta del progetto corrente come saltata e toglila dalle domande aperte, senza conseguenze sui contatori.
- **Mappa: domanda** — se il progetto corrente ha una domanda aperta, riproponila copiando il testo dal profilo parola per parola, senza riformularlo, con il suo identificativo. Se non c'è, generane una sul codice toccato di recente nel repo corrente, basandoti sugli ultimi commit e sul diario, al livello del profilo per l'area che scegli, e registrala come domanda aperta del progetto corrente.
- **Mappa: domanda nuova** — genera una domanda nuova come sopra anche se il progetto corrente ne ha una aperta; quella aperta va nello storico come saltata.
- **Mappa: rivedi** — elenca le domande dello storico di tutti i progetti: identificativo, data, progetto, area, esito. Accetta un filtro per area o per progetto, per esempio "Mappa: rivedi accesso ai dati" o "Mappa: rivedi IMC-GANTT-agent". Con un identificativo, per esempio "Mappa: rivedi D-003", mostra la scheda completa.
- **Mappa: ripeti D-NNN** — riapri la domanda indicata come domanda aperta del progetto corrente; quella aperta del progetto, se c'è, va nello storico come saltata. Se la domanda indicata appartiene a un altro progetto, rifiuta e di' da quale progetto lanciare il comando. Prima rileggi il codice a cui si riferisce: se è cambiato, riformula la domanda sul codice attuale e dillo in una riga.
- **Mappa: indizio** — per la domanda aperta del progetto corrente, indica dove guardare: un file da cui partire o una parola da cercare, senza la risposta. Registralo nella domanda aperta come indizio usato. Una risposta corretta dopo un indizio conta come corretta; la scheda dello storico riporta in Indizio usato il testo dell'indizio dato.

I comandi domanda, domanda nuova, rivedi, ripeti e indizio sono comandi di studio: puoi leggere il codice e il diario, ma non modificare nessun file del repo, diario compreso; scrivi solo nel profilo. Con questi comandi non produrre la sezione Mappa del flusso.

Con tutti i comandi tranne salta, domanda nuova e ripeti, la domanda aperta del progetto corrente resta aperta: non registrarla come saltata. Se il prompt contiene una riga "Risposta:", valutala comunque, perché è stata data apposta.

## Aree

- avvio e configurazione
- accesso ai dati
- API e rotte
- autenticazione e sicurezza
- frontend
- deploy e infrastruttura
- test

## Livelli

Ogni livello chiede una capacità diversa, non solo una difficoltà maggiore.

1. Localizzare: trovare dove sta una cosa. Esempio: in quale file sta la stringa di connessione?
2. Tracciare: ricostruire l'ordine in cui le cose accadono. Esempio: in che ordine vengono eseguiti questi tre passaggi all'avvio?
3. Prevedere: dire cosa succede se si cambia qualcosa. Esempio: se togli la registrazione del DbContext, dove si rompe e con che errore?
4. Modificare: pianificare un cambiamento. Esempio: per aggiungere un campo all'utente, quali file tocchi e in che ordine?
5. Scegliere: decidere tra strutture o strumenti, motivando e indicando le alternative. Esempio: questa logica va nel controller o in un servizio, e perché? Che alternative ci sono e cosa comporta ciascuna?

## Regole di avanzamento

- Corretta: aumenta di 1 le corrette consecutive dell'area e azzera le sbagliate consecutive.
- Sbagliata: aumenta di 1 le sbagliate consecutive dell'area e azzera le corrette consecutive.
- Parziale, saltata o fuori bersaglio: nessun cambiamento ai contatori.
- Indizio: una risposta corretta dopo un indizio conta come corretta.
- Salita: con 3 corrette consecutive, oppure 2 durante la taratura, il livello dell'area sale di 1, fino a un massimo di 5, e i contatori si azzerano.
- Discesa: con 2 sbagliate consecutive il livello dell'area scende di 1, fino a un minimo di 1, e i contatori si azzerano.
- La taratura è attiva fino alla data indicata nel profilo.
- Quando un livello cambia, segnalalo nel resoconto in una riga.

## Stile

- Sempre in italiano, in ogni output della skill, compresi i comandi di studio e la modalità non interattiva, anche nelle frasi di servizio. Usa sempre il termine tecnico corretto, spiegandolo la prima volta che compare nel diario del progetto.
- Prima il concreto, poi l'astratto.
- L'intera sezione, valutazione compresa, non supera circa 40 righe.
- Non ripetere spiegazioni già presenti nel diario: rimanda alla voce.
