from flask_restful import Resource, reqparse
from flask import request
from io import IOBase
import werkzeug
from flask_api import status

parser = reqparse.RequestParser()


class RecieveImageController(Resource):
    def post(self):
        parser.add_argument(
            'image', type=werkzeug.FileStorage, location='files')
        imageParam = parser.parse_args()

        if imageParam['image'] is None:
            return "ERROR: The required parameters are not provided. [image]", status.HTTP_400_BAD_REQUEST

        return {'image': str(imageParam['image'])}, 200
