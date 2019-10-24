from src.controller import *
from flask import Flask
from flask_restful import Resource, Api
from src.scanner_service import test_grader


def create_app():
    app = Flask(__name__)
    api = Api(app)

    api.add_resource(RecieveImageController, "/image")    

    return app

if __name__ == '__main__':
    app.create_app()
    app.run()
