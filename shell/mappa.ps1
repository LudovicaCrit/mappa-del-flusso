# Comandi di studio della mappa del flusso per PowerShell: domanda chiede la domanda aperta, indizio dice dove guardare, rispondi invia una risposta, con il repo in sola lettura.
# Vanno caricati dal profilo di PowerShell ($PROFILE) con: . "$env:USERPROFILE\progetti\mappa-del-flusso\shell\mappa.ps1"

# Le regole di permesso di Claude Code vogliono i percorsi Windows in forma POSIX:
# C:\Users\nome diventa //c/Users/nome (documentazione dei permessi, "How path patterns match").
function ConvertTo-MappaRegola([string]$Percorso) {
    $p = $Percorso -replace '\\', '/'
    if ($p -match '^([A-Za-z]):(/.*)?$') { $p = '/' + $Matches[1].ToLower() + $Matches[2] }
    return '/' + $p.TrimEnd('/')
}

function _MappaClaude([string]$Comando) {
    if ($env:MAPPA_FLUSSO_PROFILO) {
        $profilo = $env:MAPPA_FLUSSO_PROFILO
    } else {
        $profilo = Join-Path $env:USERPROFILE '.claude\mappa-del-flusso\profilo.md'
    }
    if (-not (Test-Path -LiteralPath $profilo -PathType Leaf)) {
        Write-Host "Errore: il profilo di apprendimento $profilo non esiste. Crealo oppure imposta MAPPA_FLUSSO_PROFILO con il percorso giusto." -ForegroundColor Red
        return
    }
    $profilo = (Resolve-Path -LiteralPath $profilo).ProviderPath
    $dirProfilo = Split-Path -Parent $profilo
    $radice = git rev-parse --show-toplevel 2>$null
    if ($LASTEXITCODE -ne 0 -or -not $radice) { $radice = (Get-Location).ProviderPath }
    $radice = (Resolve-Path -LiteralPath $radice).ProviderPath
    $progetto = Split-Path -Leaf $radice

    $prompt = "$Comando`nIl profilo di apprendimento è il file ${profilo}: usa solo quello.`nIl progetto corrente è $progetto."
    # Il prompt passa da standard input, in UTF-8: come argomento, PowerShell 5.1 rovinerebbe le virgolette contenute nella risposta.
    $OutputEncoding = New-Object System.Text.UTF8Encoding $false
    $prompt | claude -p `
        --add-dir $dirProfilo `
        --allowedTools 'Read' 'Grep' 'Glob' 'Skill(mappa-del-flusso)' `
            'Bash(git log:*)' 'Bash(git diff:*)' 'Bash(git show:*)' 'Bash(git status:*)' `
            "Edit($(ConvertTo-MappaRegola $profilo))" `
        --disallowedTools 'Write' 'NotebookEdit' "Edit($(ConvertTo-MappaRegola $radice)/**)"
}

function domanda { _MappaClaude 'Mappa: domanda' }
function indizio { _MappaClaude 'Mappa: indizio' }
function rispondi { _MappaClaude ('Risposta: ' + ($args -join ' ')) }
