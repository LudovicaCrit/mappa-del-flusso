---
name: mappa-del-flusso
description: Da usare alla fine di ogni compito in cui si è letto o modificato codice, e all'inizio di un compito se il prompt contiene una riga "Risposta:". Aggiunge al resoconto la mappa del flusso (ordine di lettura dei file, ordine di esecuzione a runtime, un concetto) e una domanda calibrata sul livello di chi impara, e aggiorna il profilo di apprendimento.
---

# Mappa del flusso

Chi usa questa skill sta imparando l'architettura dei sistemi seguendo il lavoro che fai sul suo codice. Il tuo resoconto è il suo materiale di studio. Spiega sempre in concreto, ancorato ai file veri del progetto, mai in astratto: la spiegazione generica non le serve, quella dettagliata sì.

## File coinvolti

- Profilo globale: ~/.claude/mappa-del-flusso/profilo.md. Contiene i livelli per area, la domanda aperta e lo storico. Se manca, crealo da template/profilo.md di questa skill.
- Diario del progetto: docs/mappa-flusso.md nella radice del repo su cui stai lavorando. Se manca, crealo da template/mappa-flusso.md di questa skill.

## All'inizio del compito: valutare la risposta

Se il prompt contiene una riga che inizia con "Risposta:":

1. Recupera la domanda dalla sezione "Domanda aperta" del profilo.
2. Valuta la risposta come corretta, parziale o sbagliata, basandoti sul codice reale. Rileggi i file se serve: non valutare a memoria.
3. Aggiorna contatori e livelli secondo le regole di avanzamento, registra l'esito nello storico e svuota la domanda aperta.
4. Nel resoconto finale, prima della mappa, aggiungi una sezione "Valutazione": l'esito e, in 2-4 righe, cosa era giusto e cosa mancava, con file e riga.

Se il prompt non contiene una risposta ma c'è una domanda aperta: registrala nello storico come saltata e svuota la domanda aperta. Una domanda saltata non ha conseguenze.

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
Una sola domanda, sul codice appena toccato, al livello che il profilo indica per l'area più pertinente al compito. Indica area e livello tra parentesi quadre, per esempio [accesso ai dati, livello 2]. Non dare la risposta e non suggerirla. Scrivila nella sezione "Domanda aperta" del profilo, con data e progetto.

Infine aggiungi al diario del progetto una voce con data, una riga sul compito, il punto 2 e il punto 3. Aggiorna l'indice dei concetti del diario se il concetto è nuovo.

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
- Parziale o saltata: nessun cambiamento ai contatori.
- Salita: con 3 corrette consecutive, oppure 2 durante la taratura, il livello dell'area sale di 1, fino a un massimo di 5, e i contatori si azzerano.
- Discesa: con 2 sbagliate consecutive il livello dell'area scende di 1, fino a un minimo di 1, e i contatori si azzerano.
- La taratura è attiva fino alla data indicata nel profilo.
- Quando un livello cambia, segnalalo nel resoconto in una riga.

## Stile

- Italiano. Usa sempre il termine tecnico corretto, spiegandolo la prima volta che compare nel diario del progetto.
- Prima il concreto, poi l'astratto.
- L'intera sezione, valutazione compresa, non supera circa 40 righe.
- Non ripetere spiegazioni già presenti nel diario: rimanda alla voce.
