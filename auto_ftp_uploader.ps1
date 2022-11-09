# dieses Script lädt dateinen die älter als 48 stunden sind auf einen ftp server (ausgenommen wochenende)
# docs https://renenyffenegger.ch/notes/Microsoft/dot-net/namespaces-classes/System/Net/WebClient/UploadFile; https://stackoverflow.com/questions/17829785/delete-files-older-than-15-days-using-powershell
# test ftp server : https://dlptest.com/ftp-test/


$ftpHost    = 'ftp.dlptest.com'             # ftp server
$username   = 'dlpuser'                     # ftp user
$password   = 'rNrKYTX9g7z3RgJRmxWuGHbeu'   # ftp password

# alle dateien die älter als 48 stunden sind werden ausgelsen
$files = Get-ChildItem -Path . -Filter *.zip -Recurse | Where-Object { $_.LastWriteTime -lt(Get-Date).AddHours(-48) -and $_.LastWriteTime.DayOfWeek -ne 'Saturday' -and $_.LastWriteTime.DayOfWeek -ne 'Sunday' }


#lädt die dateien auf den ftp server
$files | ForEach-Object { $file = $_.Name;
    $localFile = get-item $file;
    $remoteFile = "ftp://${ftpHost}/${file}";
    $uri = new-object System.Uri($remoteFile);
    $webclient = new-object System.Net.WebClient;
    $webClient.Credentials = new-object System.Net.NetworkCredential($username, $password);
    $webclient.UploadFile($uri, $localFile.fullName)
     }












