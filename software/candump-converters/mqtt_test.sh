#!/bin/bash
cangen vcan0 -g 10 -I 0x123 -D i -L 8
python3 can2mqtt.py --itf vcan0