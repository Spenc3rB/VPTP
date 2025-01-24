import argparse
import can
import cantools
import json
import paho.mqtt.client as mqtt
import sys
import time

from pathlib import Path
from typing import Iterable


def can2mqtt(bus: Iterable[can.Message], source_name: str, db, mqtt_host: str, mqtt_port: int, use_system_time=False):
    
    print(f"Connecting to MQTT broker: {mqtt_host}:{mqtt_port}")
    client = mqtt.Client(mqtt.CallbackAPIVersion.VERSION2)
    client.connect(host=mqtt_host, port=mqtt_port)
    client.loop_start()

    topics = []
    print("\nPress \"ctrl + c\" to quit\n\nMQTT topics:")
    try:
        # Receive CAN-bus
        for msg in bus:
            if db:
                # Get message name from DB
                try:
                    db_msg = db.get_message_by_frame_id(msg.arbitration_id)
                    # Decode CAN-bus frame
                    signals = db.decode_message(db_msg.name, msg.data, decode_choices=False)
                    message_name = db_msg.name
                except KeyError:
                    continue
            else:
                # If no DBC, use raw data
                signals = {"data": list(msg.data)}
                message_name = f"RAW_{msg.arbitration_id:03X}"

            # Add timestamp as integer in ms
            if use_system_time:
                signals["timestamp"] = int(time.time() * 1000)
            else:
                signals["timestamp"] = int(msg.timestamp * 1000)

            # Construct topic
            topic = f"{source_name}/{message_name}"
            if topic not in topics:
                topics.append(topic)
                print(f"- {topic}")

            # MQTT publish
            client.publish(topic, json.dumps(signals))
    except KeyboardInterrupt:
        pass

    client.disconnect()


def main():
    parser = argparse.ArgumentParser(formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument("--itf", type=str, default="can0", help="CAN-bus interface, e.g. can0")
    parser.add_argument("--file", type=str, default=None, help="CAN-bus log file")
    parser.add_argument("--dbc", type=Path, default=None, help="CAN-bus database file path (optional)")
    parser.add_argument("--host", type=str, default="localhost", help="MQTT broker host")
    parser.add_argument("--port", type=int, default=1883, help="MQTT broker port")
    args = parser.parse_args()

    # Load CAN-bus database if provided
    db = None
    if args.dbc:
        if not args.dbc.is_file():
            print(f"DBC file \"{args.dbc}\" not found. Continuing without a DBC file.")
        else:
            print(f"Loading CAN-bus database: \"{args.dbc}\"")
            db = cantools.database.load_file(args.dbc)

    if not args.itf and not args.file:
        print("Provide interface or file")
        sys.exit(1)

    elif args.file:
        # CAN-bus from file
        log_file = Path(args.file)

        if not log_file.is_file():
            print(f"Cannot open log file \"{log_file}\"")
            sys.exit(1)

        reader = can.LogReader(log_file)
        reader = can.MessageSync(reader)
        can2mqtt(bus=reader, source_name="file", db=db, mqtt_host=args.host, mqtt_port=args.port, use_system_time=True)

    elif args.itf:
        # Validate CAN interface by attempting to open it
        print(f"Validating CAN interface: {args.itf}")
        try:
            with can.Bus(interface="socketcan", channel=args.itf) as bus:
                print(f"Successfully opened CAN interface: {args.itf}")
                can2mqtt(bus=bus, source_name=args.itf, db=db, mqtt_host=args.host, mqtt_port=args.port)
        except Exception as e:
            print(f"Failed to open CAN interface '{args.itf}': {e}")
            sys.exit(-1)


if __name__ == '__main__':
    main()
