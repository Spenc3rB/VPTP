# [SavvyCAN](https://www.savvycan.com/)

## How to use with the VPTP

### 1. Exfiltrate CAN data from the vehicle
> Note: no write access with this method

#### 1.1 Start the server 
> Note: this works in the LAN. If you want to access it from the internet, you need to set up a VPN. **(or use the tunnel available in the VPTP)** --> TODO

Check if it's already running (it should be):
```bash
sudo systemctl status vptp-canlogserver
```

If not:
```bash
sudo systemctl start vptp-canlogserver
```

#### 1.2 Open the SavvyCAN GUI on your computer

And connect to the VPTP (canlogserver) with '\<ip>:28700' (e.g. 127.0.0.1:28700)

### 2. Utilize the MQTT broker on board the VPTP

> Note: TODO