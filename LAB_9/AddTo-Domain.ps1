
# Pobieranie danych logowania do domeny od administratora
$creds = Get-Credential

# Parametry domeny
$domain = "Kaufland.local"
$OU = "OU=Komputery,DC=Kaufland,DC=local"
$logFile = "C:\Logs\DodawanieKomputerow.log"
New-Item -ItemType Directory -Force -Path (Split-Path $logFile) | Out-Null

# Lista komputerów (Na potrzeby zadania zakładamy że komputery mają nazwy PC1-20)
$computers = 1..20 | ForEach-Object { "PC$_" }

# Dodawanie komputerów do domeny
foreach ($computer in $computers) {
    try {
        Write-Host "Przetwarzanie: $computer"
        Invoke-Command -ComputerName $computer -ScriptBlock {
            param(
                [string]$domain,
                [string]$OU,
                [PSCredential]$creds
                )
            Add-Computer -DomainName $domain -Credential $creds -OUPath $OU -Restart -Force
        } -ArgumentList $domain, $OU, $creds -ErrorAction Stop

        "$computer - Dodano do domeny pomyslnie." | Out-File -Append -FilePath $logFile
    }
    # Obasługa błędów
    catch {
        "$computer - Blad: $($_.Exception.Message)" | Out-File -Append -FilePath $logFile
        Write-Warning "Blad podczas dodawania $computer : $($_.Exception.Message)"
    }
}

