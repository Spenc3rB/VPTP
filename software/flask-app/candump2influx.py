import influxdb_client, os, time
from influxdb_client import Point, WritePrecision
from influxdb_client.client.write_api import SYNCHRONOUS
import argparse

def init_influxdb(token, org, url):
    write_client = influxdb_client.InfluxDBClient(url=url, token=token, org=org)
    write_api = write_client.write_api(write_options=SYNCHRONOUS)
    return write_api

def parse_can(file_path, write_api, bucket, org):
    with open(file_path, "r") as file:
        for line in file:
            try:
                parts = line.strip().split()
                
                timestamp = float(parts[0].strip("()"))  
                can_id = parts[1]          
                data = parts[2:]            
                
                point = (
                    Point("can_data")
                    .tag("can_id", can_id)  
                    .field("data", ",".join(data))
                    .time(int(timestamp * 1e9), WritePrecision.NS)  
                )
                
                # Write point to InfluxDB
                write_api.write(bucket=bucket, org=org, record=point)
            
            except Exception as e:
                print(f"Error processing line: {line}. Error: {e}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Parse and write CAN log to an InfluxDB database")
    parser.add_argument("file", help="Path to the CAN log file")
    parser.add_argument("token", help="InfluxDB token")
    parser.add_argument("org", help="InfluxDB organization")
    parser.add_argument("bucket", help="InfluxDB bucket")
    parser.add_argument("url", help="InfluxDB URL")
    args = parser.parse_args()

    write_api = init_influxdb(args.token, args.org, args.url)
    parse_can(args.file, write_api, args.bucket, args.org)
