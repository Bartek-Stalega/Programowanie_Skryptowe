import requests
import datetime
import argparse

# Konfiguracja argumentów i help page
parser = argparse.ArgumentParser(
                        prog='get_rates.py',
                        description='Program pobiera dane z frankfurter API na temat kursu podanej waluty z ostatnich 5 dni (UWAGA API nie ma danych na temat kursów w weekendy i święta)',
                        )

parser.add_argument('-b', "--base", help="Kod waluty bazowej (np. USD, EUR)", required=True)
parser.add_argument('-c',"--currency" , help="Kod waluty docelowej której kurs chcemy sprawdzić (np. USD, EUR)", required=True)
args = parser.parse_args()

# Wczytanie parametrów
now = datetime.datetime.now()
to = now - datetime.timedelta(days=5)
to = to.strftime("%Y-%m-%d")
now = now.strftime("%Y-%m-%d")
params = {
    "base": args.base,
    "symbols": args.currency,
}

try:
    # Wysłanei zapytania do frankfurter api i wczytanie danych
    response = requests.get(f"https://api.frankfurter.dev/v1/{to}..{now}?base={args.base}&symbols={args.currency}")
    data = response.json()
    rates_data = data["rates"]
    dates = sorted(rates_data.keys())
    previous_rate = None
    # wyświetlanie danych
    for date in dates:
        current_rate = rates_data[date][args.currency]
        print(f"{date}: 1 {args.base} = {current_rate} {args.currency}", end="")
        if previous_rate is not None:
            diff = current_rate - previous_rate
            print(f" różnica: {diff:+.5f} {args.currency}")
        else:
            print()
        previous_rate = current_rate

# Obsługa błędów
except requests.exceptions.RequestException:
    print(f"Błąd połączenia")
except KeyError:
    print("Błąd: Nieprawidłowy kod waluty lub brak danych")
except ValueError:
    print("Błąd: Nieprawidłowy format danych z API")