<#
        .SYNOPSIS
        Badanie bezpieczenstwa pliku

        .DESCRIPTION
        Skrypt wysyla zapytanie do API wirus total z hashem podanego pliku aby sprawdzic czy jest bezpieczny a nastepnie interpretuje wynik.

        .PARAMETER FileName
        Określa nazwe pliku z rozszerzeniem np. plik.txt .


        .EXAMPLE
        PS> .\Scan-VirusTotal -FileName

#>
param(
        [Parameter(Mandatory = $true)]
        [string]$FileName

)

# wygenerowanie hasha z podanego pliku 
$hash = Get-FileHash $FileName

# Wczytanie danych do headera zapytania i wysłanie zapytania do api VirusTotal
$headers=@{}
$headers.Add("accept", "application/json")
$headers.Add("x-apikey", "dd5ab84517eaf8159b9c6c3b2f8b9a2a9e06c2d223c2acf3dc4d04cf629dbf17")
$response = Invoke-WebRequest -Uri "https://www.virustotal.com/api/v3/files/$($hash.Hash)" -Method GET -Headers $headers
# Przekonwertowanie danych z odpowiedzi na format Json
$responseJson = $response.Content | ConvertFrom-Json

#Sprawdzenie liczby oznaczeń pliku jako złośliwy
$response_malicious = $responseJson.data.attributes.last_analysis_stats.malicious

# Jeśli któryś z silników VirusTotal oznaczył plik jako złośliwy to wtedy uznajemy go za niebezpieczny, w przeciwnym wypadku jest bezpieczny
if ($response_malicious -gt 0){
    Write-Host "Plik moze byc niebezpieczny!!!"
}
else{
    Write-Host "Plik jest bezpieczny!!!"
}