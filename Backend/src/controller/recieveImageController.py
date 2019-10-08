from flask_restful import Resource, reqparse
from flask import request
from io import IOBase

parser = reqparse.RequestParser()


class RecieveImageController(Resource):
    def post(self):
        # parser.add_argument('image', type=str)
        # args = parser.parse_args()
        args = request.form.get('image')

        print(args)
        return {"response": "hello get"}
