from flask import Flask
from dotenv import load_dotenv

load_dotenv()

app = Flask(__name__)

@app.route('/ping')
def ping():
    f = open("/tmp/ping", "a")
    f.write("pong\n")
    f.close()
    return "OK"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000)
    open("/tmp/ping", "w")
