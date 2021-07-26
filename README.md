# Assumptions
- Ubuntu 20.04 installed and updated with the user `user`
- ROS2 Foxy installed from Debian binaries (https://docs.ros.org/en/foxy/Installation/Ubuntu-Install-Debians.html)

# Cyclone DDS
```bash
sudo mkdir /etc/cyclone
sudo cp cyclonedds.xml /etc/cyclone
```

# ~/.bashrc Configuration
Add the following lines at the bottom:

```bash
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
export CYCLONEDDS_URI=file:///etc/cyclone/cyclonedds.xml
export CYCLONE_INCLUDE=/opt/ros/foxy/include
export CYCLONE_LIB=/opt/ros/foxy/lib/x86_64-linux-gnu
source /home/user/adehome/AutowareAuto/install/setup.bash

alias echo_ct='ros2 topic echo /raptor_dbw_interface/ct_report'
alias echo_sys='ros2 topic echo /raptor_dbw_interface/misc_report_do'
alias fm1='/home/user/VehicleConfig/FM1.sh'
alias restart_autoware='sudo systemctl restart autoware.service'
alias spoof_gnss='ros2 topic pub --rate 10 /inspva novatel_gps_msgs/msg/Inspva "{status: INS_SOLUTION_GOOD}"'
alias start_autoware='sudo systemctl start autoware.service'
alias stop_autoware='sudo systemctl stop autoware.service'
```

# CAN Channel Configuration
- Be sure that from `lsusb` output in the terminal you can find these lines
```
0a:00.0 CANBUS: Advantech Co. Ltd MIOe-3680 2-Port CAN-Bus MIOe Module with Isolation Protection
10:00.0 CANBUS: Device 1c29:1703 (rev 01)
11:00.0 CANBUS: Device 1c29:1703 (rev 01)
```
If you cant find the last 2 lines go to ADLINK BIOS setting:
```
In the Chipset -> PCH-IO Configuration -> M.2 Device Configuration screen, make sure the M.2 Port Device Link Selection is "X1".
```
- Copy `can.conf` to `/etc/modules.d/` with `sudo cp can.conf /etc/modules.d/`
- Install the driver for the PCIe CAN channels (2 ports)
  - Download the "Linux Socket CAN driver for CAN cards" from https://www.advantech.com/support/details/driver?id=GF-GRSC
  - Expand the downloaded file with `tar xvf advSocketCAN*`
  - `cd advSocketCAN*/driver`
  - `sudo apt update && sudo apt install -y flex bison`
  - Edit the file Makefile
    - In the line `$(MAKE) -w -C $(KDIR) SUBDIRS=$(PWD) modules`, replace `SUBDIRS=$(PWD)` with `M=$(shell pwd)`
  - Run `sudo make && sudo make install`
- Create a `cron` job that runs on reboot that sets up the CAN channels
  - `sudo crontab -e`
  - Add the line `@reboot /home/user/VehicleConfig/can_startup.bash`
- Install the driver for the M2 CAN channel (4 ports)
  - Download EGPC-B4S1 Driver https://www.innodisk.com/en/products/embedded-peripheral/communication/egpc-b4s1
  - Unpack folder and mode to `EGPC-B4S1/Linux/SocketCAN_v1.11`
  - compile with `make` and then `sudo make install`
  - sobstitute current f81601 module with the new one: 
```
sudo mv /usr/lib/modules/5.8.0-59-generic/kernel/drivers/net/can/sja1000/f81601.ko /usr/lib/modules/5.8.0-59-generic/kernel/drivers/net/can/sja1000/f81601_old.ko
depmod -a
```
- Reboot the computer

# Network Configuration
Copy `01-network-manager-all.yaml` to `/etc/netplan` and run `sudo netplan apply`.

Be sure that the fibre cable on the ADLINK side is plugged into the **right** port (looking at the Adlink from the front of the car).

# Install zenoh
- Go to home directory via `cd ~`
- Clone zenoh `git clone --branch IAC https://github.com/eclipse-zenoh/zenoh-plugin-dds`
- Build zenoh via `cargo build --release`

# Sensor Prerequisites
- Install Vimba SDK 4.2 from https://www.alliedvision.com/en/products/software.html
- After de-compressing with `tar xvf`, move the `Vimba_4_2` folder to `/opt` with `sudo mv Vimba_4_2/ /opt`
- `cd /opt/Vimba_4_2/VimbaGigETL/`
- `sudo ./Install.sh`

# Autoware Install
Install Autoware.Auto (cloned from https://gitlab.com/cuicardeeporange/AutowareAuto) to /home/user/adehome/AutowareAuto using instructions from https://autowarefoundation.gitlab.io/autoware.auto/AutowareAuto/installation-no-ade.html

# Real time configuration
We decided to use the lowlatency Kernel rather than building the full real-time kernel from source for now. This allows to assign RT priorities to threads and should still show significantly increased RT performance in comparison to the generic kernel. To do this: 
- `sudo apt-get install linux-lowlatency-hwe-20.04` (Installation)
- Change the GRUB settings to boot into this kernel. This can be done from `etc/default/grub/` by setting `GRUB_DEFAULT=1`. This makes grub choose the first menu entry as listed in `/boot/grub/grub.cfg`. Double check if this is the lowlatency kernel. 
- Reboot via `sudo shutdown -r now`
- Check if the kernel was correctly installed via `uname -r`. It should output this `5.8.0-59-lowlatency`. The running number 59 might change due to different builds. 
