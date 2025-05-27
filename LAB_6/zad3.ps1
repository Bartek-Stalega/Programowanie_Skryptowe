# Wczytywanie nazwy użytkownika
$username = Read-Host -Prompt "Podaj nazwe uzytkownika"
# Wczytywanie hasła z maskowaniem jako secure string
$password_secure = Read-Host -Prompt "Podaj haslo" -AsSecureString

# Zamiana hasła z secure string na plain text w celu porównania
$password = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($password_secure))

# Sprawdzenie poprawności
if ($username -eq "Admin" -and $password -eq "1234") {
    Write-Host "Dane poprawne. Dostep przyznany."
} else {
    Write-Host "Niepoprawna nazwa uzytkownika lub haslo."
}