import socket


def scan_port(ip, port, timeout=0.5):
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
        sock.settimeout(timeout)
        # 0 oznacza że port jest otwarty więc jeśli port jest otwarty zwracane jest True
        result = sock.connect_ex((ip, port))
        return result == 0

def scan_range(ip, start_port, end_port):
    print(f"\nSkanowanie {ip} od portu {start_port} do {end_port}...\n")
    open_ports = []

    # Skanujemy każdy port z zakresu
    for port in range(start_port, end_port + 1):
        # Jeśli port jest otwarty to zwracamy jego numer i dodajemy do listy
        if scan_port(ip, port):
            print(f"[+] Port {port} otwarty")
            open_ports.append(port)

    # Jeśli nie ma otwartych portów zwracamy wiadmość
    if not open_ports:
        print("[-] Nie znaleziono otwartych portów.")
    # Jeśli są to zwracamy ich numery z listy
    else:
        print(f"\n[✓] Otwarte porty: {open_ports}")

if __name__ == "__main__":
    # Przykład: localhost i zakres portów 3000–3010
    target_ip = "127.0.0.1"
    port_start = 1
    port_end = 3010

    scan_range(target_ip, port_start, port_end)
