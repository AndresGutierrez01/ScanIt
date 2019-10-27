import os
from flask_restful import Resource, reqparse
from flask_api import status
import werkzeug
from src.scanner_service import ScannerService

parser = reqparse.RequestParser()


class ScannerController(Resource):

    def post(self):
        parser.add_argument(
            'submission', type=werkzeug.FileStorage, location='files')
        parser.add_argument('key', type=list)
        parser.add_argument('id-len', type=int)
        imageParam = parser.parse_args()

        image = imageParam['submission']
        key = imageParam['key']
        id_len = imageParam['id-len']

        if image is None:
            return "ERROR: The required parameters are not provided. [image]", status.HTTP_400_BAD_REQUEST
        if key is None:
            return "ERROR: The required parameters are not provided. [key]", status.HTTP_400_BAD_REQUEST
        if id_len is None:
            return "ERROR: The required parameters are not provided. [id-len]", status.HTTP_400_BAD_REQUEST

        scanner = ScannerService(image)
        result, submitted = scanner.grade_test(key)
        student_id = scanner.get_student_id(id_len)

        return {'result': result, 'submitted': submitted, 'student-id': student_id}, 200
