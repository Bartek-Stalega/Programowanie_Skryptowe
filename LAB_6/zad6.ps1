# Wyszukujemy ścieżkę do pliku input_file.csv
$filepath = $(Get-ChildItem -Recurse -Filter "input_file.csv" | Select-Object -ExpandProperty FullName)
# Wyciągamy zawartość pliku
$input = $(Get-Content $filepath)
$i = 1
# Tworzymy zmienną z datą w formacie do nazwy pliku z raportem
$date = Get-Date -Format yyyyMMdd-HHmmss
# Tworzymy plik z raportem
New-Item -ItemType File $("ComputerReport_$date.txt") | Out-Null
# Pętlą przechodzimy przez każdą linijkę pliku pomijając pierwszą
while ($i -lt $input.Length) {
    # Przy pomocy split dzielimy raport na polecenie i True albo False 
    $raport = $input[$i].Split(";")[0]
    $bool = $input[$i].Split(";")[1]
    # Jeśli $bool jest równe False to możemy pominąć całą pętle bo nic nie robimy 
    if ($bool -eq 'False'){
        $i++
        continue
    }
    # W przedziwnym wypadku sprawdzamy jaki raport mamy wygenerować przy pomocy polecenia Switch. Jeśli zmatchujemy nazwe raportu to wypisujemy dane na konsoli i do pliku który wcześniej stworzyliśmy 
    Switch -regex ($raport){
        "Computername" {
            Write-Host "Computername: $(hostname)"
            "Computername: $(hostname)" | Out-File -FilePath .\ComputerReport_$date.txt -Append
        }
        "Manufacturer"{
            $Manufacturer = (Get-ComputerInfo).CsManufacturer
            Write-Host "Manufacturer: $Manufacturer"
            "Manufacturer: $Manufacturer" | Out-File -FilePath .\ComputerReport_$date.txt -Append
        }
        "Model"{
            $Model = (Get-ComputerInfo).CsModel
            Write-Host "Model: $Model"  
            "Model: $Model"  | Out-File -FilePath .\ComputerReport_$date.txt -Append
        }
        "SerialNumber"{
            $SerialNumber = (Get-ComputerInfo).BiosSeralNumber 
            Write-Host "SerialNumber: $SerialNumber"
            "SerialNumber: $SerialNumber" | Out-File -FilePath .\ComputerReport_$date.txt -Append
        }
        "CPUName"{
            $CPUName = (Get-ComputerInfo).CsProcessors.Name 
            Write-Host "CPUName: $CPUName"
           "CPUName: $CPUName" | Out-File -FilePath .\ComputerReport_$date.txt -Append
        }
        "RAM"{
            $RAM = (Get-ComputerInfo).OsTotalVisibleMemorySize
            $RAM = [math]::round($RAM/1Mb)
            Write-Host "RAM: $RAM GB"
            "RAM: $RAM GB" | Out-File -FilePath .\ComputerReport_$date.txt -Append
        }
    }
    $i++
    
}