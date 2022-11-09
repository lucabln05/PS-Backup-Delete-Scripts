# script checkt die größe der ersten beiden log files und gibt user output

# ordner pfad in dem die log ordner liegen
$path = "/workspaces/77514119/check_file_size"

# ersten zwei log ordner auslesen
$folder = Get-ChildItem -Path "$path" -Directory | Select-Object -First 1
$folder2 = Get-ChildItem -Path "$path" -Directory | Select-Object -First 2 | Select-Object -Last 1

$files = Get-ChildItem $folder
$files2 = Get-ChildItem $folder2

# vergleiche die größe der beiden log ordner
foreach ($file in $files) {
    $file2 = $files2 | Where-Object {$_.Name -eq $file.Name}
    if ($file.Length -ne $file2.Length) {
        Write-Host "CHECK OKAY: Logfiles unterschiedlich groß"
    }
    else {
        Write-Host "WARNUNG: Logfiles sind gleich groß"
    }
}
