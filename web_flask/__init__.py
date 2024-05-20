from flask import Flask

def create_app():
    app = Flask(__name__)

    @app.route('/', strict_slashes=False)
    def hello_world():
        """ Returns some text. """
        return 'Hello HBNB!'

    return app
