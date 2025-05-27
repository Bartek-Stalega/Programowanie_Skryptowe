New-Item -ItemType File plik.txt
Rename-Item plik.txt inny_plik.txt
Get-FileHash inny_plik.txt
Start-Process notepad
Get-ChildItem | Sort-Object {$_.Name.Length}
$lokalizacja = Get-Location
$lokalizacja | Out-File -FilePath lokalizacja.txt
Get-Process | Select-Object -First 5 ProcessName, Id
Get-Process | Sort-Object -Property WS -Descending | Select-Object -First 5 ProcessName, WS
Get-Process | Sort-Object -Property WS | Select-Object -First 5 @{Name="MemoryUsage"; Expression={$_.WS}}, ProcessName