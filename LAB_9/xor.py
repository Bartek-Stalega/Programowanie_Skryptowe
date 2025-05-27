from pwn import xor

encrypted = b' \x00\x00\x00\x00%\x1c\r\x03\x18\x06\x1e'
key = b'ayham'
decrypted = xor(encrypted, key)
print(decrypted.decode())