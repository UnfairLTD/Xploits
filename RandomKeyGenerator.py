from flask import Flask
import time
import random
import string

app = Flask(__name__)

# Generate a new random key
def generate_key(length=12):
    return ''.join(random.choices(string.ascii_letters + string.digits, k=length))

# Key data
key_data = {
    "key": generate_key(),
    "last_generated": time.time()
}

# Route to show the current key
@app.route("/")
def get_key():
    current_time = time.time()
    if current_time - key_data["last_generated"] >= 172800:  # 172800 = 48 hours
        key_data["key"] = generate_key()
        key_data["last_generated"] = current_time
    return key_data["key"]

# Start the web server
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
