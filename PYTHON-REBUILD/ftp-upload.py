# Importet Module
import ftplib
import os 
import time
import datetime

# Variablen
today = datetime.date.today()
path = 'test'
delete_days = 2

# FTP Verbindung
HOSTNAME = "ftp.dlptest.com"    # FTP Server
USERNAME = "dlpuser"        # FTP Username
PASSWORD = "rNrKYTX9g7z3RgJRmxWuGHbeu"      # FTP Password
#   FTP Verbindung aufbauen
ftp_server = ftplib.FTP(HOSTNAME, USERNAME, PASSWORD)
#  Zwangs Endcoding
ftp_server.encoding = "utf-8"

# listet alle Dateien im Verzeichnis und liesst das datei Datum aus und vergleicht es mit dem aktuellen Datum
# wenn datei alter als delete_days ist wird sie auf ftp server hochgeladen

for f in os.listdir(path):      # listet alle Dateien im Verzeichnis
    try:
        filedata, filetype = f.split('.')       # trennt Dateiendung von Dateinamen
        number, filedate, filetime, clientname = filedata.split('-')        # trennt Dateinamen in Teile
        file_year = int(filedate[:4])       # liest Jahr aus Dateinamen
        file_month = int(filedate[4:6])     # liest Monat aus Dateinamen
        file_day = int(filedate[6:8])       # liest Tag aus Dateinamen

    except Exception as err:
        print(err)
    today_year = int(time.strftime("%Y"))       # liest aktuelles Jahr
    today_month = int(time.strftime("%m"))      # liest aktuelles Monat
    today_day = int(time.strftime("%d"))        # liest aktuelles Tag

    diff_year = today_year - file_year          # berechnet Differenz zwischen aktuellem Jahr und Jahr aus Dateinamen
    diff_month = today_month - file_month       # berechnet Differenz zwischen aktuellem Monat und Monat aus Dateinamen
    diff_day = today_day - file_day             # berechnet Differenz zwischen aktuellem Tag und Tag aus Dateinamen

    diff_days = diff_year * 360 + diff_month * 30 + today_day - file_day        # berechnet Differenz zwischen aktuellem Datum und Datum aus Dateinamen

    if today.weekday() == 4 or today.weekday() == 5 or today.weekday() == 6 :       # prüft ob heute Freitag, Samstag oder Sonntag ist
        print('Kein Upload am Wochenende')

    elif diff_days > delete_days:       # prüft ob Datei älter als delete_days ist
        filedata = open(path + '/' + f, 'r+')       # öffnet Datei zum lesen und schreiben
        print('Upload: ' + f)       # gibt Dateinamen aus
        ftp_server.storbinary(f"STOR {f}", filedata)        # lädt Datei auf ftp server hoch
        ftp_server.quit()           # trennt ftp Verbindung

