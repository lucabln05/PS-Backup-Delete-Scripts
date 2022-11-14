# dieses Script lädt dateinen die älter als 48 stunden sind auf einen ftp server (ausgenommen wochenende(F;S;S))
# docs https://renenyffenegger.ch/notes/Microsoft/dot-net/namespaces-classes/System/Net/WebClient/UploadFile;
# test ftp server : https://dlptest.com/ftp-test/

$ftpHost    = 'ftp.dlptest.com'             # ftp server
$username   = 'dlpuser'                     # ftp user
$password   = 'rNrKYTX9g7z3RgJRmxWuGHbeu'   # ftp password

# alle dateien die älter als 48 stunden sind werden ausgelesen (im pfad wo das script liegt)
$files = Get-ChildItem -Path . -Filter *.zip -Recurse | Where-Object { $_.LastWriteTime -lt(Get-Date).AddHours(-48)}


# wenn heute freitag, samstag oder sonntag ist, dann wird das script beendet
if ((Get-Date).DayOfWeek -eq 'Friday' -or (Get-Date).DayOfWeek -eq 'Saturday' -or (Get-Date).DayOfWeek -eq 'Sunday' ){
    exit
} else {
    #lädt die dateien auf den ftp server
    $files | ForEach-Object { $file = $_.Name;
        $localFile = get-item $file;
        $remoteFile = "ftp://${ftpHost}/${file}";
        $uri = new-object System.Uri($remoteFile);
        $webclient = new-object System.Net.WebClient;
        $webClient.Credentials = new-object System.Net.NetworkCredential($username, $password);
        $webclient.UploadFile($uri, $localFile.fullName)
         }
}
