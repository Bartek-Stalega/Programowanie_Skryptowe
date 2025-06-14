from Crypto.Cipher import AES
from dotenv import load_dotenv
import os

# Wczytywanie klucza z pliku .env
load_dotenv()
key_hex = os.getenv("AES_KEY")
global key
key = bytes.fromhex(key_hex)

def AES_Encrypt(data):
    print("Encrypting data...")
    # Szyfrowanie przy pomocy AES
    cipher = AES.new(key, AES.MODE_EAX)
    ciphertext, tag = cipher.encrypt_and_digest(data)
    nonce = cipher.nonce

    # Wypisanie zaszyfrowanych danych
    print(f"Nonce: {nonce}")
    print(f"Ciphertext: {ciphertext}")
    print(f"Tag: {tag}")
    
    return nonce, ciphertext, tag

def AES_Decrypt(nonce, ciphertext, tag):
    print("Decrypting data...")
    # Dekrypcja szyfru AES
    cipher = AES.new(key, AES.MODE_EAX, nonce)
    data = cipher.decrypt_and_verify(ciphertext, tag)

    print(f"Decrypted data: {data}")

# Inicjalizacja funkcji do inkrypcji i dekrypcji
nonce, ciphertext, tag = AES_Encrypt(b'mega_cool_skrypt_szyfrujacy')
AES_Decrypt(nonce, ciphertext, tag)
