from . import app
from flask import Flask, render_template, redirect, url_for, request
from flask_login import current_user, LoginManager, logout_user, login_user
from flask_wtf import FlaskForm

@app.route('/')
def index():
    return render_template("index.html")

@app.route('/submitTest', methods=['POST'])
def submitTest():
    if current_user.is_authenticated:
        #Code for submitting tests to the database
        return 0
    else:
        return render_template('login.html')

@app.route('/submitScan', methods=['POST'])
def submitScan():
    if current_user.is_authenticated:
        #Code for submitting scans to the database
        return 0
    else:
        return render_template('login.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if current_user.is_authenticated:
        return render_template('homepage.html')
    if request.methods == 'GET':
        return render_template('login.html', title='Sign In')
    if request.methods == 'POST':
        #Check the database to sign in user
        return render_template('homepage')

@app.route('signup', methods=['GET','POST'])
def signup():
    if request.methods == 'GET':
        return render_template('signup.html')
    if request.methods == 'POST':
        #code to signup
        return render_template('login.html')

@app.route('/logout')
def logout():
    logout_user()
    return redirect(url_for('index'))