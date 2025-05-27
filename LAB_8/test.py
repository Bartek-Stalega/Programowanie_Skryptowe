import argparse

parser = argparse.ArgumentParser(
                    prog='get_news.py',
                    description='Program pobiera dane z newsAPI z podanym słowem klucz i wyświetla pierwsze 10 wyników',
                    )

parser.add_argument('keyword', help="Słowo klucz które ma zawierać wyszykiwany artykuł")           # positional argument

args = parser.parse_args()
print(args.keyword)