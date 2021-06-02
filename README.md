# Assumptions
AutowareAuto (cloned from https://gitlab.com/cuicardeeporange/AutowareAuto) is installed in /home/user/adehome/AutowareAuto.

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
