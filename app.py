from flask import Flask, jsonify
import pyjokes

app = Flask(__name__)


@app.route("/jokes", methods=["GET"])
def get_joke():
    joke = pyjokes.get_joke()
    return jsonify({"joke": joke})


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
