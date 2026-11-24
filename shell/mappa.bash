# Comandi di studio della mappa del flusso: domanda chiede la domanda aperta, rispondi invia una risposta, con il repo in sola lettura.
# Vanno caricati da ~/.bashrc con: source ~/progetti/mappa-del-flusso/shell/mappa.bash
_mappa_claude() {
    local dir_profilo
    dir_profilo="$(dirname "$MAPPA_FLUSSO_PROFILO")"
    claude -p "$1" \
        --add-dir "$dir_profilo" \
        --allowedTools "Read" "Grep" "Glob" "Skill(mappa-del-flusso)" \
            "Bash(echo \$MAPPA_FLUSSO_PROFILO)" \
            "Bash(git log:*)" "Bash(git diff:*)" "Bash(git show:*)" "Bash(git status:*)" \
            "Edit(/$MAPPA_FLUSSO_PROFILO)" \
        --disallowedTools "Write" "NotebookEdit" "Edit(./**)"
}
domanda() { _mappa_claude "Mappa: domanda"; }
rispondi() { _mappa_claude "Risposta: $*"; }
