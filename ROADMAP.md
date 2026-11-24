# Roadmap

Stato attuale, versione 0.1 di novembre 2026: a fine compito la mappa del flusso, con ordine di esplorazione, ordine di esecuzione, un concetto e una domanda calibrata per area e livello; comandi nel prompt per sospendere domanda o mappa; domande a richiesta, consultazione e ripetizione delle domande passate; profilo globale; diario per progetto. La taratura dura fino al 7 dicembre 2026.

## Principio: il codice è la fonte

Vale per tutte le tappe, presenti e future.

- **Il codice è l'unica fonte di prova.** Ogni affermazione della mappa, delle domande, delle valutazioni e del sussidiario si basa sul codice letto in quel momento, con file e riga.
- **Gli strumenti di analisi servono solo a orientarsi.** Un grafo del codice, come quello prodotto da Graphify, può suggerire dove guardare e quali parti sono centrali, ma non dimostra niente. Ciò che emerge da lì va verificato sul codice prima di essere scritto.
- **Se grafo e codice non coincidono, vince il codice.** La skill lo segnala in una riga, così si sa che il grafo va rigenerato.

## Tappa 1: raccolta, fino al 7 dicembre 2026

Nessuna modifica alla calibrazione: livelli, aree e regole di avanzamento restano come sono. Il diario si riempie e si osserva come si comporta la skill:

- se la sezione compare a ogni compito che tocca codice;
- se il profilo viene trovato sempre nel percorso giusto;
- se le domande sono troppo facili o troppo difficili per il livello;
- se la sezione resta entro la lunghezza prevista.

Le osservazioni si annotano in fondo a questo file, nella sezione Osservazioni dalla taratura.

## Tappa 2: il grafo come indice

Se nel repo esiste l'output di un grafo del codice, per esempio la cartella graphify-out, la skill lo usa per:

- scegliere le domande anche in base alla struttura, privilegiando le parti da cui dipende molto altro codice;
- sapere dove guardare per verificare i passaggi marcati come non verificati nell'ordine di esecuzione.

Sempre nel rispetto del principio: il grafo indica, il codice prova.

## Tappa 3: ripasso dilazionato e domande a gruppi

Oggi la domanda segue solo l'ultimo compito: un concetto sbagliato, se il lavoro si sposta altrove, non torna più. Il ripasso lo fa tornare.

- Nel profilo, una sezione Da ripassare con i concetti delle risposte sbagliate o parziali, con data e progetto.
- Ripasso automatico a intervalli, con domande non legate all'ultimo compito ma sempre ancorate al codice di un progetto reale.
- Proposta iniziale di intervalli: dopo 1, 3, 7 e 14 giorni da un errore; un concetto esce dal ripasso dopo due risposte corrette di fila.
- Un comando per chiedere un gruppo di domande in una volta, per esempio "Mappa: gruppo 5", pescate dal diario e dal ripasso, con risposte numerate in un unico prompt e valutazione domanda per domanda.
- Da decidere in questa tappa: se il ripasso arriva solo a richiesta o anche da solo, per esempio una domanda di ripasso ogni tanti compiti.

## Tappa 4: il sussidiario del codice

Una modalità a richiesta che genera docs/sussidiario/ nel repo di un progetto, con un capitolo per area: avvio e configurazione, accesso ai dati, API e rotte, autenticazione e sicurezza, frontend, deploy e infrastruttura, test.

- Fonti: il codice come prova, il grafo come orientamento, il diario come esperienza già fatta.
- Ogni capitolo indica il commit su cui è stato generato, ancora ogni affermazione a file e riga e marca come non verificato ciò che non è stato controllato.
- Ogni capitolo chiude con esercizi al livello che il profilo indica per quell'area.
- Quando il codice cambia, un capitolo si rigenera per intero, non si corregge a pezzi.

## Condizionale: attivazione garantita

Se durante la taratura la sezione non compare in modo affidabile, si valuta un hook di Claude Code alla fine di ogni risposta: a differenza delle istruzioni, un hook lo esegue il programma, non lo interpreta il modello.

## Da valutare

- Uno script che aggiorni contatori e livelli del profilo in modo deterministico, invece di affidarlo al modello.
- Un README in inglese, per chi non legge l'italiano.

## Osservazioni dalla taratura

- 2026-11-23: una risposta data alla domanda precedente è stata contata come sbagliata: introdotto l'esito fuori bersaglio, e la domanda viene riportata nella valutazione.
- 2026-11-23: rischio noto: una sessione di lavoro e un comando di studio che scrivono il profilo nello stesso momento possono perdere una modifica; mitigato rileggendo il profilo prima di ogni scrittura e modificando solo le righe interessate.
- 2026-11-24: una domanda è stata sostituita a fine compito prima che chi impara la leggesse: da ora, finché c'è una domanda aperta, a fine compito non se ne genera una nuova.
- 2026-11-24: una sessione di lavoro avviata prima di un aggiornamento della skill ha scritto lo storico nel formato vecchio: dopo ogni aggiornamento le sessioni vanno riaperte da zero.
- 2026-11-24: il comando domanda, senza permesso di scrittura, ha mostrato una domanda con identificativo D-008 senza salvarla, mentre un'altra sessione registrava una diversa D-008: da ora l'identificativo si assegna rileggendo il profilo al momento della scrittura, la scrittura viene verificata e una domanda non salvata non riceve identificativo.
- 2026-11-24: in modalità non interattiva il modello non poteva leggere la variabile del profilo e lo cercava per tentativi: ora il percorso è passato nel prompt.
