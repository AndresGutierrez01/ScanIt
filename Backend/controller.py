from flask_restful import Resource, Api
from flask import Flask
from src import REST
from src.controller.helloWorldController import HelloWorldController

api = Api(REST)


api.add_resource(HelloWorldController, "/api/hello")
