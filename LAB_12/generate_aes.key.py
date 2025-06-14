import Crypto.Random

with open('.env', 'w') as f:
    f.write(f"AES_KEY={Crypto.Random.get_random_bytes(16).hex()}")