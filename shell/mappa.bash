# Comandi di studio della mappa del flusso: domanda chiede la domanda aperta, rispondi invia una risposta, con il repo in sola lettura.
# Vanno caricati da ~/.bashrc con: source ~/progetti/mappa-del-flusso/shell/mappa.bash
_mappa_claude() {
    local dir_profilo radice
    if [ -z "$MAPPA_FLUSSO_PROFILO" ]; then
        echo "Errore: la variabile MAPPA_FLUSSO_PROFILO è vuota. Impostala con il percorso del profilo di apprendimento, per esempio in ~/.bashrc." >&2
        return 1
    fi
    dir_profilo="$(dirname "$MAPPA_FLUSSO_PROFILO")"
    radice="$(git rev-parse --show-toplevel 2>/dev/null)" || radice="$PWD"
    claude -p "$1
Il profilo di apprendimento è il file $MAPPA_FLUSSO_PROFILO: usa solo quello." \
        --add-dir "$dir_profilo" \
        --allowedTools "Read" "Grep" "Glob" "Skill(mappa-del-flusso)" \
            "Bash(git log:*)" "Bash(git diff:*)" "Bash(git show:*)" "Bash(git status:*)" \
            "Edit(/$MAPPA_FLUSSO_PROFILO)" \
        --disallowedTools "Write" "NotebookEdit" "Edit(/$radice/**)"
}
domanda() { _mappa_claude "Mappa: domanda"; }
rispondi() { _mappa_claude "Risposta: $*"; }
