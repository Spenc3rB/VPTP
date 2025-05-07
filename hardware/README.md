# Hardware

> Note: this project is a Work In Progress (WIP) and is not yet complete. Find the current hardware details below. Until the project is complete, there will be no Bill of Materials (BOM) or further hardware details. Please continue to check back for updates. Full price to manufactor will be posted as well.

## Hardware Used

### Core Components

- Raspberry Pi 5 Model B. Why? Because it includes a Real-Time Clock (RTC) built into the board, a quad core processor ([with cryptographic extensions](https://www.engr.colostate.edu/~jdaily/presentations/2017%20Seed%20Key%20Exchange.pdf)), 8GB of RAM, a power button, bluetooth 5.0 / BLE, Dual Band WiFi, PCIe 2.0 interface for faster storage, and more.

- 64GB MicroSD Card

- 5.1v 5.0A Power Supply, with optional [RPi UPS](https://www.amazon.com/Geekworm-X1202-Raspberry-Shutdown-Detection/dp/B0CRZ4ZXQW?ref_=ast_sto_dp) for safe-shutdown, and portability

- [7" Capacative Touch Screen](https://www.amazon.com/gp/product/B0BKGCB18T/ref=ewc_pr_img_1?smid=A1PKC2PUMNR8VD&th=1) found to be perfect for handheld typing and optimal human factors 

- [18650 Batteries](https://www.18650batterystore.com/products/samsung-35e) and [Protective Housing](https://www.amazon.com/gp/product/B07KZQZBN2/ref=ppx_yo_dt_b_asin_title_o01_s00?ie=UTF8&psc=1) for battery saftey while charging

- [RPi Global Shutter for Object Identification](https://www.canakit.com/raspberry-pi-global-shutter-camera.html?cid=usd&src=raspberrypi) paired with the [RPi 5 AI Kit](https://www.amazon.com/gp/product/B0D6GMXH73/ref=ppx_yo_dt_b_asin_title_o02_s00?ie=UTF8&psc=1)

- [Junction Box ](https://www.amazon.com/ANIMACYN-Electrical-Junction-Ventilated-Waterproof/dp/B0D2HQZXRC/ref=pd_ci_mcx_mh_mcx_views_0_image?pd_rd_w=NH64i&content-id=amzn1.sym.bb21fc54-1dd8-448e-92bb-2ddce187f4ac%3Aamzn1.symc.40e6a10e-cbc4-4fa5-81e3-4435ff64d03b&pf_rd_p=bb21fc54-1dd8-448e-92bb-2ddce187f4ac&pf_rd_r=VRK4YD00C778F75H90YW&pd_rd_wg=4L7Uv&pd_rd_r=ede68a42-89ea-49ed-8f0c-6dc052e312f7&pd_rd_i=B0D2HQZXRC&th=1) for weather proofing

### Optional Components

- [SDR (Software Defined Radio) for RF Testing, WiFi, and Bluetooth Capturing](https://www.analog.com/en/resources/evaluation-hardware-and-software/evaluation-boards-kits/ADALM-PLUTO.html#eb-overview), even with the built in Bluetooth and WiFi capabilities ~ $250

- [Tigard Protocol Tool](https://1bitsquared.com/collections/embedded-hardware/products/tigard) for firmware extraction and analysis of vehicle systems.

- [Bitmagic Basic Logic Analyzer](https://1bitsquared.com/collections/embedded-hardware/products/bitmagic-basic) for bit-level analysis of vehicle systems.

- [PCAN-USB](https://www.peak-system.com/PCAN-USB.199.0.html?L=1) CAN Adapter or [CAN2USB](https://www.amazon.com/Innomaker-Converter-Module-Raspberry-Zero/dp/B07P9JGXXB?th=1) Adapter

> Note: DB9 is used frequently in CAN to USB adapters. Therefore, the following cables are optional, but may be useful for connecting to different vehicles.

- [OBD-II to DB9 Cable (optional)](https://www.amazon.com/Female-Adapter-Diagnostic-Extension-Connector/dp/B08TWMWZZR/ref=sr_1_3?crid=ATSHSIBTJZO6&dib=eyJ2IjoiMSJ9.JwhPyrQ7GLuJ2qGkePQP3gUpOtTiChjjxvJ3YXkw6gCLL8uScH_XlPg4SRR1EnB2mXb-0HzfLtlfKvm-zlU2KfdlF7pOFETMTiPh205iJNb1T_H6IwcOXrfS2T1EceK7ZDBhLvdfxtatoe7jLb_cHqWLc8mfhFpXXmt9G5H4TakHqhNqG6oLovh_qUYgyn6NDUcxNbgZOu1VfndZcluSw84Zl71Ng1NbbraGkKYgvee-yAK0st7cgbjr9bVs7gmJyC7TuHFyMITonZbDZhjPHkFm22ConOjE0Zgv3mDfggqgzqfgulonugiWMVAAJgyxRtWoH1hiD1E4cxWCl3BtMWXHHKXta9EoIfTKZLEQHCQ.YJ5ZbS2EA8IRxFUzknnOcFOiIk50rNBIidx3n8jLDGc&dib_tag=se&keywords=obd%2B2%2Bto%2Bdb9&qid=1734898336&s=industrial&sprefix=obd%2B2%2Bto%2Bdb9%2Cindustrial%2C131&sr=1-3&th=1) --> Typically found on most commercial vehicles

- [Deutsch 9-pin to DB9 Cable (optional)](https://www.amazon.com/GXMRHWY-Cable-Deutsch-Connector-Female/dp/B0C5XBNGGL) --> MHD Vehicles (e.g. John Deere, Caterpillar, Cummins, etc.)

- [Fans, a lot of em'](https://www.digikey.com/en/products/detail/adafruit-industries-llc/4468/11587354?gclsrc=aw.ds&utm_adgroup=&utm_source=google&utm_medium=cpc&utm_campaign=PMax%20Shopping_Product_Medium%20ROAS%20Categories&utm_term=&utm_content=&utm_id=go_cmp-20223376311_adg-_ad-__dev-c_ext-_prd-11587354_sig-CjwKCAiAjp-7BhBZEiwAmh9rBf2Wtx2g0co_zDT26a9iJaVTtEEFEIpt9ig0RBnOY_veiiCc6xDS4BoCEJMQAvD_BwE&gad_source=1&gclsrc=ds) assuming the thermal output of the pi is going to be high with all of the peripherals.

# Installation

Install the config.txt file to the following location:
```bash
sudo install -m 644 config.txt /boot/firmware/config.txt
sudo install -m 644 autostart /etc/xdg/lxsession/LXDE-pi/autostart
```