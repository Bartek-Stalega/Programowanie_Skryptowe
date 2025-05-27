<#
        .SYNOPSIS
        Monitorowanie folderu i przenoszenie plikow txt

        .DESCRIPTION
        Skrypt Tworzy proces w tle który monitoruje folder zrodlowy i przenosi wszystkie pliki txt z niego do folderu docelowego.

        .PARAMETER source_dir
        Określa nazwe folderu zrodlowego.
        .PARAMETER destination_dir
        Określa nazwe folderu docelowego.

        .EXAMPLE
        PS> .\Create-DirWatcher -source_dir zrodlowy -destination_dir docelowy

#>

param(
    [Parameter(Mandatory = $true)]
    [string]$source_dir,
    [Parameter(Mandatory = $true)]
    [string]$destination_dir
    )

# Jesli folder docelowy nie istnieje to go tworzymy
if (!(Test-Path $destination_dir)){
    New-Item -ItemType Directory -Path $destination_dir
    Write-Host "Utworzono folder docelowy $destination_dir"
} 

# Włączamy kod w tle
Start-Job -ArgumentList $source_dir, $destination_dir -ScriptBlock {
    param($source_dir, $destination_dir)
    # Tworzymy nieskończoną pętlę
    # Ustawiamy katalog roboczy
    Set-Location -Path "C:\Users\Barte\Desktop\Programowanie_Skryptowe\LAB_7"
    while ($true){
        # Wczytujemy wszystkie pliki z folderu źródłowego
        $files = Get-ChildItem -Path $source_dir -Filter "*.txt"

        # Przechodzimy po kolei po każdym z plików
        foreach ($file in $files){
            # Tworzymy ścieżkę docelową dla pliku który przenosimy
            $destination_path = Join-Path -Path $destination_dir -ChildPath $file.Name
            
            # Przenosimy plik do folderu docelowego i wypisujemy wiadmość o powodzeniu
            Move-Item $file.FullName $destination_path -Force
            Write-Host "Przeniesiono: $($file.Name)"
        }
        # Usypiamy program na jakiś czas czekając aż pojawią sie nowe pliki
        Start-Sleep 5
}
}