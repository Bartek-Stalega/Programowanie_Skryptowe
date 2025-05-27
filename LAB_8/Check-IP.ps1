<#
        .SYNOPSIS
        Sprawdzanie danych dla podanego adresu IP

        .DESCRIPTION
        Skrypt sprawdza podany adres IP przy pomocy Shodan API

        .PARAMETER IP_add
        Okresla adres IP ktory chcemy sprawdzic

        .EXAMPLE
        PS> .\Check-IP -IP_add 8.8.8.8

#>
# Ustalenie parametrów
param(
        [Parameter(Mandatory = $true)]
        [ipaddress]$IP_add
)


$ApiKey = "apikey"

# Wysłanie zapytania do shodan api i wczytanei tego z pliku json
$Response = Invoke-WebRequest -Uri ("https://api.shodan.io/shodan/host/" + $IP_add + "?key=" + $ApiKey)
$ResponseJson = $Response.Content | ConvertFrom-Json

# Klucze danych które chcemy wypisać
$keys = @("city", "region_code", "isp", "country_code", "ip_str", "org", "last_update")

# Wypisanie danych
Write-Host ">>>Podstawowe informacje na temat adresu IP: "
foreach($key in $keys){
    $value = $ResponseJson.$key
    Write-Host "$key : $value"
}

# Wypisanie otwartych portów
Write-Host ">>>Otwarte porty dla adresu IP:"
$ResponseJson.ports