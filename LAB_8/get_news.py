import requests
import argparse

# Konfiguracja argumentów i help page
parser = argparse.ArgumentParser(
                    prog='get_news.py',
                    description='Program pobiera artykuły z newsAPI z podanym słowem klucz i wyświetla pierwsze 10 wyników',
                    )

parser.add_argument('-k', "--keyword", help="Słowo klucz które ma zawierać wyszykiwany artykuł", required=True)           # positional argument

args = parser.parse_args()
# Wczytywanie parametrów
api_key = 'api-key'
url = f'https://newsapi.org/v2/everything?'
params = {
    "q": args.keyword,
    "pageSize": 10

}

# Wysłanie zapytania do newsapi i wczytanie go
response = requests.get(url,params=params,headers={"X-Api-Key": api_key})
data = response.json()
# Obsługa błędów i wyświetlanie artykułow
if data["status"] == "ok":
    print("Pierwsze 10 artykułów: ")
    articles = data['articles']
    if not articles:
        print("Nie znaleziono artykułów z podanym słowem klucz")
    for x, article in enumerate(articles,1):
        print()
        print("--------------------------------------------------------------------------------------")
        print()
        print(f"{x}. {article["title"]}")
        print(f"Źródło: {article["source"]["name"]}")
        print(f"Autor: {article["author"]}")
        print(f"Data wydania: {article["publishedAt"]}")
        print(f"URL: {article["url"]}")
    print()
    print("--------------------------------------------------------------------------------------")
    print()
else:
    print("Error")