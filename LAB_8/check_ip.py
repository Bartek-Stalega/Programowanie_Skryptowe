import shodan

api = shodan.Shodan("arwcnVtMJnRCMMlIfQ01H7fcQvA1em79")
ip = "8.8.8.8"
info = api.host(ip)
data = info["data"][1]
print(f"Dane dla adresu ip {ip}:")

for key in data:
    if key != "port":
        print(f"{key}: {data[key]}")


print(f"Otwarte porty dla adresu ip {ip}:")
print(data["port"])