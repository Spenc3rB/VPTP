# Software

> Note: this project is a Work In Progress (WIP) and is not yet complete. Find the current software details below. Until the project is complete, there will be no SBOM. Please continue to check back for updates.

## Installation

### Step 1: Update the Raspberry Pi

```bash
sudo apt-get update
```

### Step 2: Install the drivers for the Elecrow 5" HDMI Touchscreen Display

```bash
echo "hdmi_force_hotplug=1
max_usb_current=1
hdmi_drive=1
hdmi_group=2
hdmi_mode=1
hdmi_mode=87
hdmi_cvt 800 480 60 6 0 0 0
dtoverlay=ads7846,cs=1,penirq=25,penirq_pull=2,speed=50000,keep_vref_on=0,swapxy=0, pmax=255,xohms=150,xmin=200,xmax=3900,ymin=200,ymax=3900 display_rotate=0" | sudo tee -a /boot/config.txt
```
```bash
sudo reboot now
```
```bash
sudo apt install xinput-calibrator
```
