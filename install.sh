#!/usr/bin/env bash
# This script installs the VPTP environment by copying necessary files to the user's home directory

set -e  # Exit immediately if a command exits with a non-zero status.
set -u  # Treat unset variables as an error when substituting.
set -o pipefail  # Prevent errors in a pipeline from being masked.

sudo apt update
sudo apt install full-upgrade -y

# clone the repository if it doesn't exist
if [ ! -d "$HOME/VPTP" ]; then
    git clone https://github.com/Spenc3rB/VPTP "$HOME/VPTP"
    echo "VPTP repository cloned to $HOME/VPTP"
else
    echo "VPTP repository already exists at $HOME/VPTP"
fi

# append the VPTP bashrc modifications to the user's .bashrc if not already present
if ! grep -q "####### VPTP Mods #######" "$HOME/.bashrc"; then
    echo "

####### VPTP Mods #######

truckdevil() {
    pushd $HOME/VPTP/software/external/TruckDevil/truckdevil/ > /dev/null || return 1 
    python3 ./truckdevil.py "$@"
    popd > /dev/null || return 1
}

pretty_j1939() {
    # note: the J1939db.json file is expected to be in $HOME/. Check the pretty j1939 documentation for details.
    $HOME/VPTP/software/external/pretty_j1939/pretty_j1939.py --da-json $HOME/VPTP/software/external/pretty_j1939/J1939db.json "$@"
}

####### End VPTP Mods #######" >> "$HOME/.bashrc"
    echo "VPTP modifications added to $HOME/.bashrc"
else
    echo "VPTP modifications already present in $HOME/.bashrc"
fi

### Semi-Auto Installs ###

# install TruckDevil if it doesn't exist
if [ ! -d "$HOME/VPTP/software/external/TruckDevil" ]; then
    git clone https://github.com/Spenc3rB/TruckDevil "$HOME/VPTP/software/external/TruckDevil"
    pushd "$HOME/VPTP/software/external/TruckDevil" > /dev/null || exit 1
    python3 -m pip install -r requirements.txt
    popd > /dev/null || exit 1
    echo "TruckDevil repository cloned to $HOME/VPTP/software/external/TruckDevil"
else
    echo "TruckDevil repository already exists at $HOME/VPTP/software/external/TruckDevil"
fi


# install pretty_j1939 if it doesn't exist
if [ ! -d "$HOME/VPTP/software/external/pretty_j1939" ]; then
    git clone https://github.com/nmfta-repo/pretty_j1939 "$HOME/VPTP/software/external/pretty_j1939"
    pushd "$HOME/VPTP/software/external/pretty_j1939" > /dev/null || exit 1
    sudo python3 setup.py install
    popd > /dev/null || exit 1
    echo "pretty_j1939 repository cloned to $HOME/VPTP/software/external/pretty_j1939"
else
    echo "pretty_j1939 repository already exists at $HOME/VPTP/software/external/pretty_j1939"
fi
echo "NOTE: you will need to install the J1939db.json file manually. It is not included in this repository. See the pretty_j1939 documentation for details."

# install caring caribou if it doesn't exist
if [ ! -d "$HOME/VPTP/software/external/caringcaribou" ]; then
    git clone https://github.com/CaringCaribou/caringcaribou "$HOME/VPTP/software/external/caringcaribou"
    pushd "$HOME/VPTP/software/external/caringcaribou" > /dev/null || exit 1
    sudo python3 setup.py install
    popd > /dev/null || exit 1
    echo "caringcaribou repository cloned to $HOME/VPTP/software/external/caringcaribou"
else
    echo "caringcaribou repository already exists at $HOME/VPTP/software/external/caringcaribou"
fi

# install icsim if it doesn't exist
if [ ! -d "$HOME/VPTP/software/external/icsim" ]; then
    sudo apt install meson -y
    git clone https://github.com/zombieCraig/ICSim "$HOME/VPTP/software/external/icsim"
    pushd "$HOME/VPTP/software/external/icsim" > /dev/null || exit 1
    if [ ! -d "builddir" ]; then
        meson setup builddir
    fi
    meson compile -C builddir
    popd > /dev/null || exit 1
    echo "icsim repository cloned to $HOME/VPTP/software/external/icsim"
else
    echo "icsim repository already exists at $HOME/VPTP/software/external/icsim"
fi

# install udsim if it doesn't exist
if [ ! -d "$HOME/VPTP/software/external/udsim" ]; then
    git clone https://github.com/zombieCraig/UDSim "$HOME/VPTP/software/external/udsim"
    make -C "$HOME/VPTP/software/external/udsim" || exit 1
    echo "udsim repository cloned to $HOME/VPTP/software/external/udsim"
else
    echo "udsim repository already exists at $HOME/VPTP/software/external/udsim"
fi

# install drivers for RTL8812au WiFi dongles

if [ ! -d "$HOME/VPTP/software/external/rtl8812au" ]; then
    git clone https://github.com/morrownr/8812au-20210820 "$HOME/VPTP/software/external/rtl8812au"
    pushd "$HOME/VPTP/software/external/rtl8812au" > /dev/null || exit 1
    sudo ./install-driver.sh
    popd > /dev/null || exit 1
    echo "RTL8812au drivers cloned to $HOME/VPTP/software/external/rtl8812au"
else
    echo "RTL8812au drivers already exist at $HOME/VPTP/software/external/rtl8812au"
fi

# install bluelog if it doesn't exist
if [ ! -d "$HOME/VPTP/software/external/bluelog" ]; then
    git clone https://github.com/MS3FGX/Bluelog "$HOME/VPTP/software/external/bluelog"
    make -C "$HOME/VPTP/software/external/bluelog" || exit 1
    echo "bluelog repository cloned to $HOME/VPTP/software/external/bluelog"
else
    echo "bluelog repository already exists at $HOME/VPTP/software/external/bluelog"
fi

# install opendbc if it doesn't exist
if [ ! -d "$HOME/VPTP/software/external/opendbc" ]; then
    git clone https://github.com/commaai/opendbc/ "$HOME/VPTP/software/external/opendbc"
    echo "opendbc repository cloned to $HOME/VPTP/software/external/opendbc"
else
    echo "opendbc repository already exists at $HOME/VPTP/software/external/opendbc"
fi

### Package Manager Installs ###

sudo apt install aircrack-ng arduino bluetooth bluez-utils blueman can-utils cryptsetup \
    curl gnuradio gqrx-sdr htop net-tools python3 tree wireshark unzip wget netcat-traditional \
    apktool vbindiff rtl-sdr hackrf tmux conky-all ghex mitmproxy bettercap binutils meson nmap \
    perl ruby ruby-dev sigrok sigrok-firmware-fx2lafw openocd 7zip ubertooth hashcat crunch sqlmap \
    metasploit-framework hping3 dig nginx grafana jupyter python3-scapy software-properties-common \
    mosquitto -y

python3 -m pip install obd py-uds python-can can-j1939 can-isotp pyserial canmatrix flask flask-socketio python-dotenv --break-system-packages

## configs ##

if [ ! -d "$HOME/.config/autostart" ]; then
    mkdir -p "$HOME/.config/autostart"
    cp "$HOME/VPTP/software/configs/vptp-http-server.desktop" "$HOME/.config/autostart/"
fi
if [ ! -d "$HOME/Desktop" ]; then
    mkdir -p "$HOME/Desktop"
    cp "$HOME/VPTP/software/configs/vptp-http-server.desktop" "$HOME/Desktop/"
fi
if [ ! -d "/etc/grafana " ]; then
    sudo mkdir -p "/etc/grafana"
    sudo cp "$HOME/VPTP/software/configs/grafana.ini" "/etc/grafana/"
fi
if [ ! -d "/etc/mosquitto" ]; then
    sudo mkdir -p "/etc/mosquitto"
    sudo cp "$HOME/VPTP/software/configs/mosquitto.conf" "/etc/mosquitto/"
fi

## rpi-specific configs ##

if grep -q "Raspberry Pi 5" /proc/device-tree/model 2>/dev/null; then
    python3 -m pip install rpi-hardware-pwm --break-system-packages
    # fix for Fix the Pi 5 Power Issue
    # Thanks to [this](https://www.jeffgeerling.com/blog/2023/reducing-raspberry-pi-5s-power-consumption-140x) beautiful blog post.
    while true; do
        read -p "These two values are important to add in the next text editor under [all]
BOOT_UART=1
POWER_OFF_ON_HALT=1. For example, the config should look like: 
[all]
BOOT_UART=1
POWER_OFF_ON_HALT=1
BOOT_ORDER=0xf461

Have you copied them? (y/n): " answer
        if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
            break
        else
            echo "Well come on.. ctrl+shift+c"
        fi
    done
    sudo rpi-eeprom-config -e

    sudo cp "$HOME/VPTP/software/configs/config.txt" "/boot/firmware/config.txt"
else
    echo "Not a Raspberry Pi 5. Skipping Pi 5 particulars."
fi

## systemd services ##
if [ ! -d "/etc/systemd/system" ]; then
    echo "Systemd directory not found. Might not be a systemd-based system... Copying files to /etc/systemd/system/ anyway."
    sudo mkdir -p "/etc/systemd/system"
    sudo cp "$HOME/VPTP/software/configs/vptp-http-server.service" "/etc/systemd/system/"
    sudo cp "$HOME/VPTP/software/configs/vptp-canlogserver.service" "/etc/systemd/system/"
    # TODO: incomplete installation script.. continue to add services as needed

fi

