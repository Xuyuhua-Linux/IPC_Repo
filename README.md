# Assumptions
- Ubuntu 20.04 installed and updated
- ROS2 Foxy installed from Debian binaries (https://docs.ros.org/en/foxy/Installation/Ubuntu-Install-Debians.html)
- AutowareAuto (cloned from https://gitlab.com/cuicardeeporange/AutowareAuto) installed in /home/user/adehome/AutowareAuto using instructions from https://autowarefoundation.gitlab.io/autoware.auto/AutowareAuto/installation-no-ade.html

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
alias source_aa='source ~/adehome/AutowareAuto/install/setup.bash'
alias spoof_gnss='ros2 topic pub --rate 10 /inspva novatel_gps_msgs/msg/Inspva "{status: INS_SOLUTION_GOOD}"'
```
