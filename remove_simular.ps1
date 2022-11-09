# dieses script löscht alle zeilen die mehr als 1 mal vorkommen und schreibt die logdatei neu
# erst nach dem delete_in_logfile script ausführen

#liest alle files
$file = Get-Content -Path "log.txt"

#entfernt alle duplicate
$file = $file | Select-Object -Unique

#speichert die änderungen
$file | Out-File -FilePath "log.txt" -Encoding UTF8 -Force