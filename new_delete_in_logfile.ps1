
# Dieses Script splitet log.txt wenn "ROBOCOPY"
#und löscht alle abschnitte auser dem letzten


$logfile = "log.txt"    # Pfad zum Logfile

$logfile_content = Get-Content $logfile   # Inhalt des Logfiles in Variable speichern

# Splitet das Logfile in Abschnitte wenn "ROBOCOPY" gefunden wird
$logfile_content | Select-String -Pattern "ROBOCOPY" | Select-Object -last 1 | ForEach-Object {
    $logfile_content | Select-Object -Skip ($_.LineNumber - 1) | Set-Content $logfile
}

