from flask_restful import Resource, Api
from flask import Flask
from src import REST
from src.controller import *

api = Api(REST)


api.add_resource(RecieveImageController, "/image")
