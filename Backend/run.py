from src.controller import *
from flask import Flask
from flask_restful import Resource, Api

def create_app():
    app = Flask(__name__)
    api = Api(app)

    api.add_resource(RecieveImageController, "/image")
    api.add_resource(ScannerController, '/<string:class_id>/<string:test_id>')

    return app


if __name__ == '__main__':
    app.create_app()
    app.run()
