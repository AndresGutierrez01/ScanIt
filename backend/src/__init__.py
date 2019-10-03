from flask import Flask
from src.routes import TempRoute
from flask_login import LoginManager

app = Flask(__name__)
login = LoginManager(app)


