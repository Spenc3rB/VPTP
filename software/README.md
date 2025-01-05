# Software

> Note: this project is a Work In Progress (WIP) and is not yet complete. Find the current software details below. Until the project is complete, there will be no SBOM. Please continue to check back for updates. The following also assumes the VPTP repo is cloned into the home directory. If you have cloned the repo elsewhere, please adjust the path accordingly to follow along.

## Installation

### Step 1: Update the Raspberry Pi

```bash
sudo apt update
sudo apt install full-upgrade -y
sudo reboot now
```

### Step 2: Install the VPTP software

> Note: To organize the desktop, I've opted to use .desktop files with their respective icons. I've included them in the [desktop](./desktop) directory. If you'd like to use them, you can copy them to the desktop with the following commands:

```bash
cp ~/VPTP/software/desktop/*.desktop ~/Desktop
sed -i "s|\$HOME|$HOME|g" ~/Desktop/*.desktop
```

#### 2.1 Install core dependencies

```bash
sudo apt remove -y xtrx-dkms
sudo apt install -y \ 
      can-utils \
      gnuradio \
      gqrx-sdr \
      jupyter \
      openocd \
      sigrok \
      sigrok-firmware-fx2lafw \
      ruby \
      ruby-dev \
      python3-scapy
```

#### 2.2 Install Misc. Git Repositories

Let's create a backup repository if we need to access the source code at any point:
```bash
mkdir $HOME/git-backups
cd $HOME/git-backups
```
##### 2.2.1 Install and setup the CanCat repository
```bash
git clone https://github.com/atlas0fd00m/
cd CanCat
sudo python setup.py install
```
##### 2.2.2 Install and setup the OpenDBC repository
<h5 style="color:red;">Note: dbc files not tested and reliability is unknown</h5>

```bash
git clone https://github.com/commaai/opendbc
cp -r ./opendbc/opendbc/dbc ~/Desktop
```
##### 2.2.3 Install and setup the CaringCaribou repository
```bash
git clone https://github.com/CaringCaribou/caringcaribou
cd caringcaribou
sudo python setup.py install
```
##### 2.2.4 Install and setup the TruckDevil repository
```bash
git clone https://github.com/LittleBlondeDevil/TruckDevil
echo "# Define a function to run truckdevil and return to the original directory
truckdevil() {
    local current_dir=$(pwd)
    cd ~/Desktop/TruckDevil/truckdevil
    ./truckdevil.py
    cd "$current_dir"
}" >> ~/.bashrc
```
> TODO: ICsim, UDSim, rpi_hardware_pwm, canexplorer (dearpygui not supported on pi 5 yet)

#### 2.3 Install Python Dependencies

```bash
python3 -m venv ~/Desktop/vptp_venv
source ~/Desktop/vptp_venv/bin/activate
pip install --upgrade pip
pip install \
      python-can \
      python-uds \
      can-isotp \
      can-j1939 
```

#### 2.4 Install Ruby Dependencies
<h5 style="color:red;">Note: c0f not tested and reliability is unknown</h5>

```bash
sudo gem install c0f
```

#### 2.5 Install Custom Software

> TODO: systemd services, slcan testing, custom OS options (e.g. custom splash video, desktop theme, capacative touch screen drivers, etc.)
