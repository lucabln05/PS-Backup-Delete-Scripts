# ein log abschnitt ist 17.436 spalten lang
# script löscht alle zeilen auser die letzten $LogLength zeilen

$Logdeletedays = 1                      # lösche alle logdateien älter als $Logdeletedays 1 = ein tag
$LogLength = -17437 * $Logdeletedays    # rechnet die länge des nicht zu löschenden logabschnitts aus

$lines = Get-Content -Path log.txt      # liest die logdatei ein
$lines = $lines[$LogLength..-1]         # löscht alle zeilen auser die letzten $LogLength zeilen
$lines | Out-File -FilePath log.txt -Encoding UTF8  # schreibt die logdatei neu
