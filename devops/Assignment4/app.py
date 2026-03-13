import os
from flask import Flask

app = Flask(__name__)


@app.route('/')
def home():
    return os.environ.get('APP_MESSAGE', 'Default message')


@app.route('/health')
def health():
    return os.environ.get('APP_HEALTH', 'Default health')


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)