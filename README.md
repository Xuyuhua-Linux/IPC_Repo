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
- Copy `can.conf` to `/etc/modules.d/` with `sudo cp can.conf /etc/modules.d/`
- Install the driver for the PCIe CAN channels
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
- Reboot the computer

# Network Configuration
Copy `01-network-manager-all.yaml` to `/etc/netplan` and run `sudo netplan apply`.

Be sure that the fibre cable on the ADLINK side is plugged into the **right** port (looking at the Adlink from the front of the car).

# Sensor Prerequisites
- Install Vimba SDK 4.2 from https://www.alliedvision.com/en/products/software.html
- After de-compressing with `tar xvf`, move the `Vimba_4_2` folder to `/opt` with `sudo mv Vimba_4_2/ /opt`
- `cd /opt/Vimba_4_2/VimbaGigETL/`
- `sudo ./Install.sh`

# Autoware Install
Install Autoware.Auto (cloned from https://gitlab.com/cuicardeeporange/AutowareAuto) to /home/user/adehome/AutowareAuto using instructions from https://autowarefoundation.gitlab.io/autoware.auto/AutowareAuto/installation-no-ade.html
