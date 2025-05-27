<#
        .SYNOPSIS
        Sprawdza stan wskazanego procesu.

        .DESCRIPTION
        Skrypt będzie sprawdzać czy proces o wskazanej nazwie jest:
        -Uruchomiony i aktywny
        -Nieuruchomiony.

        .PARAMETER ProcessName
        Określa nazwe procesu bez rozszerzenia.

        .EXAMPLE
        PS> .\Monitor-Process -ProcessName notepad

    #>

param(
[Parameter(Mandatory = $true)]
[string]$ProcessName
)


$process = Get-Process -Name $ProcessName -ErrorAction SilentlyContinue

if ($process -eq $null){

    Write-Host "Process jest nieaktywny"

}
else{

    Write-Host "Process jest aktywny"

}