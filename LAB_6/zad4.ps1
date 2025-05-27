# Stworzenie pętli for która wypisuje 10 liczb i
for ($i = 0; $i -lt 10; $i++) {
    # Wypisanie adresu ze zmianą ostatniego oktetu na i
    Write-Host "192.168.0.$i"
}