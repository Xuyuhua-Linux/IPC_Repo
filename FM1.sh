#!/bin/bash
sleep 3
cd /home/user/zenoh-plugin-dds/target/release/
ROS_DOMAIN_ID=1 RUST_LOG=debug ./zenoh-bridge-dds -d 1 -m peer -l tcp/10.42.0.200:7447 -s /DO12 -r /DO12/** -w /DO12/** \
--allow "/telemetry/.*|ros_discovery_info|diagnostics|/joystick/.*|/vehicle/.*|rc_to_ct|/raptor_dbw_interface/pt_report|/counter"
