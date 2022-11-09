# ordner pfad zu den backupfiles
$Root = "/workspaces/77514119/test"


# liest alle dateien im ordner $Root aus, wenn die dateine formatiert sind wie "2022-10-10"  vergleicht mit datum heute und löscht alle die älter als 30 tage sind
Get-ChildItem -Path $Root -Recurse | Where-Object { $_.Name -match "^[0-9]{4}-[0-9]{2}-[0-9]{2}$" } | Where-Object { (Get-Date) -gt (Get-Date $_.Name).AddDays(30) } | Remove-Item -Force
                                                                                                                                                            # wie viele tage soll das backup behalten werden



