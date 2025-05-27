
#Wyznaczenie parametrow
param(
    [double]$podstawa,
    [double]$wysokosc
)
#Obliczenie pola
$pole = 0.5 * $podstawa * $wysokosc

#Wypisanie wyniku
Write-Host "Pole trojkata o podstawie $podstawa i wysokosci $wysokosc wynosi: $pole"