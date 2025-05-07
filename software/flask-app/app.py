#!/usr/bin/env python3
import argparse
from flask import Flask, render_template, redirect, request
from flask_socketio import SocketIO
import logging
import sys
from dotenv import load_dotenv
import os

logging.getLogger("werkzeug").setLevel(logging.ERROR)

__version__ = "0.5.0.2"
load_dotenv()
app = Flask(__name__)
app.config["SECRET_KEY"] = os.getenv("SECRET_KEY")
socketio = SocketIO(app)

@app.route("/")
@app.route("/index")
def index():
    return render_template("index.html")

@app.route("/grafana")
def grafana():
    # forward the user to the grafana page
    return redirect(f"http://{request.host.split(':')[0]}:3000", code=302)

def main():
    parser = argparse.ArgumentParser(
        description=(
            "Web interface for the VPTP project."
            "https://github.com/Spenc3rB/VPTP"
        ),
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )
    parser.add_argument(
        "-p", "--port", default=5000, help="port to run server on", type=int
    )
    parser.add_argument(
        "--host",
        default="127.0.0.1",
        help="host to run server on (use 0.0.0.0 to allow access from other hosts)",
    )
    parser.add_argument("--debug", action="store_true", help="debug the server")
    parser.add_argument("--version", action="store_true", help="print version and exit")
    args = parser.parse_args()
    if args.version:
        print(__version__)
        exit(0)

    green = "\033[92m"
    end = "\033[0m"
    log_format = (
        green
        + "vptp-server > "
        + end
        + "%(levelname)s (%(funcName)s:%(lineno)s) %(message)s"
    )
    logging.basicConfig(
        format=log_format,
        stream=sys.stdout,
        level=logging.DEBUG if args.debug else logging.INFO,
    )
    logging.info(f"serving on http://{args.host}:{args.port}")
    socketio.run(app, debug=args.debug, port=args.port, host=args.host)

if __name__ == "__main__":
    main()
