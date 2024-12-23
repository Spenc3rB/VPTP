# Hardware

> Note: this project is a Work In Progress (WIP) and is not yet complete. Find the current hardware details below. Until the project is complete, there will be no Bill of Materials (BOM) or further hardware details. Please continue to check back for updates.

## Hardware Used

- Raspberry Pi 5 Model B. Why? Because it includes a Real-Time Clock (RTC) built into the board, a quad core processor ([with cryptographic extensions](https://www.engr.colostate.edu/~jdaily/presentations/2017%20Seed%20Key%20Exchange.pdf)), 8GB of RAM, a power button, bluetooth 5.0 / BLE, Dual Band WiFi, PCIe 2.0 interface for faster storage, and more. 

- 64GB MicroSD Card

- 5.1v 5.0A Power Supply, with optional [RPi UPS](https://www.amazon.com/Geekworm-X1202-Raspberry-Shutdown-Detection/dp/B0CRZ4ZXQW?ref_=ast_sto_dp)

- Elecrow 5" HDMI Touchscreen Display

- [Google Coral Mini PCIe Accelerator](https://coral.ai/products/pcie-accelerator/) with the [RPi M.2 Hat+](https://www.raspberrypi.com/documentation/accessories/m2-hat-plus.html) for identifying diagnostic ports, parts of a vehicle, and more.

- [RPi Global Shutter for Object Identification](https://www.canakit.com/raspberry-pi-global-shutter-camera.html?cid=usd&src=raspberrypi)

- [SDR (Software Defined Radio) for RF Testing, WiFi, and Bluetooth Capturing](https://www.analog.com/en/resources/evaluation-hardware-and-software/evaluation-boards-kits/ADALM-PLUTO.html#eb-overview), even with the built in Bluetooth and WiFi capabilities.

- [Tigard Protocol Tool](https://1bitsquared.com/collections/embedded-hardware/products/tigard) for firmware extraction and analysis of vehicle systems.

- [Bitmagic Basic Logic Analyzer](https://1bitsquared.com/collections/embedded-hardware/products/bitmagic-basic) for bit-level analysis of vehicle systems.

- [Mini Keyboard](https://www.adafruit.com/product/3601) because typing on a touchscreen is a pain.

- [PCAN-USB](https://www.peak-system.com/PCAN-USB.199.0.html?L=1) CAN Adapter or [CAN2USB](https://www.amazon.com/Innomaker-Converter-Module-Raspberry-Zero/dp/B07P9JGXXB?th=1) Adapter

> Note: DB9 is used frequently in CAN to USB adapters. Therefore, the following cables are optional, but may be useful for connecting to different vehicles.

- [OBD-II to DB9 Cable (optional)](https://www.amazon.com/Female-Adapter-Diagnostic-Extension-Connector/dp/B08TWMWZZR/ref=sr_1_3?crid=ATSHSIBTJZO6&dib=eyJ2IjoiMSJ9.JwhPyrQ7GLuJ2qGkePQP3gUpOtTiChjjxvJ3YXkw6gCLL8uScH_XlPg4SRR1EnB2mXb-0HzfLtlfKvm-zlU2KfdlF7pOFETMTiPh205iJNb1T_H6IwcOXrfS2T1EceK7ZDBhLvdfxtatoe7jLb_cHqWLc8mfhFpXXmt9G5H4TakHqhNqG6oLovh_qUYgyn6NDUcxNbgZOu1VfndZcluSw84Zl71Ng1NbbraGkKYgvee-yAK0st7cgbjr9bVs7gmJyC7TuHFyMITonZbDZhjPHkFm22ConOjE0Zgv3mDfggqgzqfgulonugiWMVAAJgyxRtWoH1hiD1E4cxWCl3BtMWXHHKXta9EoIfTKZLEQHCQ.YJ5ZbS2EA8IRxFUzknnOcFOiIk50rNBIidx3n8jLDGc&dib_tag=se&keywords=obd%2B2%2Bto%2Bdb9&qid=1734898336&s=industrial&sprefix=obd%2B2%2Bto%2Bdb9%2Cindustrial%2C131&sr=1-3&th=1) --> Typically found on most commercial vehicles

- [Deutsch 9-pin to DB9 Cable (optional)](https://www.amazon.com/GXMRHWY-Cable-Deutsch-Connector-Female/dp/B0C5XBNGGL) --> MHD Vehicles (e.g. John Deere, Caterpillar, Cummins, etc.)

- [Fans, a lot of em'](https://www.digikey.com/en/products/detail/adafruit-industries-llc/4468/11587354?gclsrc=aw.ds&utm_adgroup=&utm_source=google&utm_medium=cpc&utm_campaign=PMax%20Shopping_Product_Medium%20ROAS%20Categories&utm_term=&utm_content=&utm_id=go_cmp-20223376311_adg-_ad-__dev-c_ext-_prd-11587354_sig-CjwKCAiAjp-7BhBZEiwAmh9rBf2Wtx2g0co_zDT26a9iJaVTtEEFEIpt9ig0RBnOY_veiiCc6xDS4BoCEJMQAvD_BwE&gad_source=1&gclsrc=ds) assuming the thermal output of the pi is going to be high with all of the peripherals.

# Custom 3D Printed Case

Spin off of this one: https://www.printables.com/model/85017-elecrow-5inch-hdmi-display-b-case

Coming soon...