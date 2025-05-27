# Wczytanie nazwy komputera
$hostname = hostname

# Funkcja która wypisuje date przy pomocy Get-Date, przyjmuje nazwe komputera jako $hostname i wypisuje informacje
function get-current_date{
    param($hostname)
    $date = Get-Date
    Write-Host "Data na urzadzeniu $hostname to $date"
}

# Funkcja która wypisuje adres IP przy pomocy Get-NetIPAdress z interfejsu "Ethernet 3", przyjmuje nazwe komputera jako $hostname i wypisuje informacje
function get-ip{
    param($hostname)
    $ip = GET-NetIPAddress -AddressFamily IPv4 -InterfaceAlias "Ethernet 3" | Select-Object -ExpandProperty IPAddress
    Write-Host "Adres IP na urzadzeniu $hostname to $ip"
}

# Funkcja która wypisuje nazwe użytkownika ze zmiennej środowiskowej $Env:USERNAME
function get-username{
    param($hostname)
    $username = $Env:USERNAME
    Write-Host "Aktualny uzytkownik na $hostname to $username"
}

# Funkcja która wypisuje Wersje systemu z funkcji Get-ComputerInfo
function Get-SystemVersion{
    param ($hostname)
    Write-Host "Wersja systemu na $hostname to: "
    Get-ComputerInfo | select-object OsName,OSDisplayVersion
}

# Użycie funkcji
get-current_date -hostname $hostname
get-ip -hostname $hostname
get-username -hostname $hostname
Get-SystemVersion -hostname $hostname

