#!/bin/bash

export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
export CYCLONEDDS_URI=file:///etc/cyclone/cyclonedds.xml
export CYCLONE_INCLUDE=/opt/ros/foxy/include
export CYCLONE_LIB=/opt/ros/foxy/lib/x86_64-linux-gnu
export ROS_DOMAIN_ID=1
export LD_LIBRARY_PATH=/usr/local/lib/
source /home/user/adehome/AutowareAuto/install/setup.bash
ros2 launch iac_launch master.launch.py enable_cameras:=False enable_radars:=False enable_lidars:=True

