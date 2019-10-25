from flask_restful import Resource, reqparse
import werkzeug
from src.scanner_service import format_image, grade_submitted_answers

parser = reqparse.RequestParser()


class ScannerController(Resource):

    def get(self, class_id, test_id):
        parser.add_argument(
            'submission', type=werkzeug.FileStorage, location='files')
        parser.add_argument('key', type=list)
        imageParam = parser.parse_args()

        image = imageParam['submission']
        key = imageParam['key']

        if image is None:
            return "ERROR: The required parameters are not provided. [image]", status.HTTP_400_BAD_REQUEST
        if key is None:
            return "ERROR: The required parameters are not provided. [key]", status.HTTP_400_BAD_REQUEST

        formatted_image = format_image(image)
        result = grade_submitted_answers(formatted_image, key)

        return result, 200
