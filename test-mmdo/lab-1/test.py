from flask import Flask

app = Flask(__name__)


@app.route('/')
def home():
    return 'Привіт, це мій перший веб-сайт на Flask!'


if __name__ == '__main__':
    app.run(debug=True)
