from Crypto.PublicKey import RSA

# 1. Generowanie pary kluczy RSA
key = RSA.generate(2048)

# 2. Exportowanie prywatnego klucza do pliku der
private_der = key.export_key(format='DER')

with open('private_key.der', 'wb') as f:
    f.write(private_der)

# 3. Exportowanie publicznego klucza do pliku der
public_der = key.publickey().export_key(format='DER')

with open('public_key.der', 'wb') as f:
    f.write(public_der)