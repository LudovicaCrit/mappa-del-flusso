# Mappa del flusso

Una skill per Claude Code che, alla fine di ogni compito, fa spiegare all'agente il flusso dei file che ha letto e del codice che il programma esegue, con una domanda calibrata sul livello di chi impara.

## Perché esiste

Chi lavora con un agente di programmazione rischia di vedere il codice crescere senza capire come il sistema sta in piedi. Questa skill trasforma ogni compito in una lezione ancorata al codice vero: cosa l'agente ha letto, in che ordine il programma esegue davvero le cose, quale concetto è emerso.

Distingue esplicitamente l'ordine di esplorazione dell'agente dall'ordine di esecuzione del programma. L'agente può aprire prima una rotta, poi il modello, poi il file di avvio; il programma, quando gira, parte dall'avvio, registra le dipendenze e solo dopo arriva alla rotta. Confondere i due ordini porta a costruirsi una logica sbagliata del sistema.

## Come funziona

Alla fine di ogni compito in cui ha letto o modificato codice, l'agente aggiunge al resoconto una sezione "Mappa del flusso" in quattro punti:

1. **Ordine di esplorazione**: i file letti, nell'ordine reale, con il motivo.
2. **Ordine di esecuzione a runtime**: il percorso che il programma segue davvero, dall'avvio al dato letto o salvato, con i nomi veri di file e funzioni. Ogni passaggio non verificato nel codice è marcato `[non verificato]`.
3. **Concetto emerso**: uno solo, il più importante del compito, spiegato in poche righe a partire dal codice appena visto.
4. **Domanda**: una sola, sul codice toccato, al livello indicato dal profilo per l'area più pertinente.

Per rispondere, si scrive nel prompt successivo una riga che inizia con `Risposta:`. All'inizio di quel compito l'agente valuta la risposta sul codice reale (corretta, parziale o sbagliata), aggiorna il profilo e riporta l'esito prima della nuova mappa. Una domanda a cui non si risponde viene registrata come saltata, senza conseguenze.

Ogni voce finisce anche nel diario del progetto, `docs/mappa-flusso.md`, con un indice dei concetti incontrati, così le spiegazioni non si ripetono e si possono rileggere.

Con una riga del prompt che inizia con `Mappa:` si può regolare la skill: per esempio togliere la domanda o la mappa da un singolo compito, oppure metterla in pausa e riprenderla. La domanda aperta, in questi casi, resta aperta. L'elenco dei comandi è nella sezione "Comandi nel prompt" di [SKILL.md](skill/SKILL.md).

## Calibrazione

I livelli sono cinque, e ognuno chiede una capacità diversa, non solo una difficoltà maggiore:

1. **Localizzare**: trovare dove sta una cosa.
2. **Tracciare**: ricostruire l'ordine in cui le cose accadono.
3. **Prevedere**: dire cosa succede se si cambia qualcosa.
4. **Modificare**: pianificare un cambiamento.
5. **Scegliere**: decidere tra strutture o strumenti, motivando e indicando le alternative.

Il livello si tiene separato per sette aree: avvio e configurazione, accesso ai dati, API e rotte, autenticazione e sicurezza, frontend, deploy e infrastruttura, test.

Regole di avanzamento:

- con 3 risposte corrette consecutive in un'area il livello sale di 1, fino a 5;
- con 2 risposte sbagliate consecutive scende di 1, fino a 1;
- le risposte parziali e le domande saltate non cambiano i contatori;
- nelle prime due settimane, il periodo di taratura, bastano 2 corrette consecutive per salire, così il profilo raggiunge in fretta il livello reale.

Il profilo è globale, in `~/.claude/mappa-del-flusso/profilo.md`, perché la competenza è della persona e non del repo: ciò che si è imparato su un progetto vale anche sul successivo. Il diario invece è per progetto, perché descrive quel sistema e i suoi flussi.

## Installazione

```sh
git clone https://github.com/LudovicaCrit/mappa-del-flusso.git ~/progetti/mappa-del-flusso
mkdir -p ~/.claude/skills
ln -s ~/progetti/mappa-del-flusso/skill ~/.claude/skills/mappa-del-flusso
```

Il link simbolico della skill fa sì che ogni modifica al repo valga subito per la skill installata.

Poi si aggiungono in fondo a `~/.claude/CLAUDE.md` queste righe:

```markdown
## Mappa del flusso
- All'inizio di ogni compito, se il prompt contiene una riga che inizia con "Risposta:", applica la skill mappa-del-flusso per valutarla.
- Alla fine di ogni compito in cui hai letto o modificato codice, applica la skill mappa-del-flusso e aggiungi la sua sezione al resoconto.
```

Le righe nel CLAUDE.md globale servono perché l'attivazione automatica delle skill non è garantita a ogni compito, mentre il CLAUDE.md globale viene letto sempre.

Il profilo si crea copiando `skill/template/profilo.md` in `~/.claude/mappa-del-flusso/profilo.md` e sostituendo le date: la data di creazione e la fine della taratura, quattordici giorni dopo. Se manca, la skill lo crea da sola.

Chi usa la skill sia su Windows sia su WSL e vuole un solo profilo può tenerlo su Windows e definire su WSL, in `~/.bashrc`, la variabile che ne indica il percorso:

```sh
export MAPPA_FLUSSO_PROFILO=/mnt/c/Users/<utente>/.claude/mappa-del-flusso/profilo.md
```

Non si usa un link simbolico perché alcuni strumenti salvano i file sostituendoli, e il link andrebbe perso.

## Struttura del repo

```
mappa-del-flusso/
├── LICENSE
├── README.md
├── ROADMAP.md                  sviluppi previsti, per tappe
└── skill/
    ├── SKILL.md                istruzioni della skill per Claude Code
    └── template/
        ├── mappa-flusso.md     modello del diario di progetto
        └── profilo.md          modello del profilo di apprendimento
```

## Progetti collegati

È pensata come complementare a una skill sulla scrittura di codice leggibile e mantenibile: questa aiuta a capire il codice che c'è, quella a scriverlo in modo che si lasci capire.

## Sviluppi previsti

Le tappe successive, dal grafo del codice come indice al ripasso dilazionato fino al sussidiario per progetto, sono descritte in [ROADMAP.md](ROADMAP.md), insieme al principio che le guida: il codice è l'unica fonte di prova.

## Licenza e autrice

MIT. Ludovica Ignatia Di Cianni.
