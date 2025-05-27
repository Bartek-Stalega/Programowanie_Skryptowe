def xor_decrypt(ciphertext, key):
    decrypted = bytearray(len(ciphertext))
    for i in range(len(ciphertext)):
        decrypted[i] = ciphertext[i] ^ key[i % len(key)]
    return decrypted

def main():
    ciphertext = bytearray(b'ey}BQB_^[\\ZEnw\x01uWoY~aF\x0fiRdbum\x04BUn\x06[\x02CHonZ\x03~or\x03UT\x00_\x03]mD\x00W\x02gpScL')

    with open('wordlist.txt', 'r') as key_file:
        keys = [line.strip() for line in key_file]

    for key in keys:
        key_bytes = bytearray(key.encode())
        decrypted = xor_decrypt(ciphertext, key_bytes)

        if all(32 <= byte <= 126 for byte in decrypted):
            print(f"Key: '{key}', Decrypted Text: '{decrypted.decode()}'")

if __name__ == "__main__":
    main()
