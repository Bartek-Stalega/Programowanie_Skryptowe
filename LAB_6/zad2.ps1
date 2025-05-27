
#Wczytanie liczby jako double
[double[]]$liczba = Read-Host -p "Podaj liczbe"

# Sprawdzanie liczby
if ($liczba -gt 10){
    Write-Host "Liczba $liczba jest wieksza od 10"
}
elseif($liczba -eq 10){
    Write-Host "Liczba $liczba jest rowna 10"
}
else{
    Write-Host "Liczba $liczba jest mniejsza od 10"
}
