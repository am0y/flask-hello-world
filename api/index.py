from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
    return {"message": "Hello from Flask on Railway!"}

@app.route('/health')
def health():
    return {"status": "healthy"}, 200

if __name__ == '__main__':
    app.run(debug=True)
