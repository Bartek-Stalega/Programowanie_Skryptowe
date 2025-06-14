from Crypto.Signature import pkcs1_15
from Crypto.Hash import SHA256
from Crypto.PublicKey import RSA

# Funkcja która podpisuje wiadomość przy pomocy RSA
def RSA_sign(message):
    key = RSA.import_key(open('private_key.der', 'rb').read())
    h = SHA256.new(message)
    signature = pkcs1_15.new(key).sign(h)
    return signature

# Funkcja któa weryfikuje wiadomość przy pomocy klucza publicznego
def RSA_verify(message, signature):
    key = RSA.import_key(open('public_key.der', 'rb').read())
    h = SHA256.new(message)
    try:
        pkcs1_15.new(key).verify(h, signature)
        print(message)
        print("The signature is valid.")
    except (ValueError, TypeError):
        print(message)
        print("The signature is not valid.")

# Podpisywanie wiadomości
signature = RSA_sign(message = b'ale_fajna_wiadomosc')
# Sprawdzenie czy podpis się zgadza
RSA_verify(message = b'ale_fajna_wiadomosc', signature = signature)
RSA_verify(message = b'a_ta_juz_nie_taka_fajna', signature = signature)
