from flask_restful import Resource

class HelloWorldController(Resource):
    def get(self):
        return {"response": "hello get"}
