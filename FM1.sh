#!/bin/bash
sleep 10
cd /home/user/zenoh-plugin-dds/target/release/
ROS_DOMAIN_ID=1 RUST_LOG=debug ./zenoh-bridge-dds -d 1 -m peer -l tcp/10.42.0.200:7447 -s /DO12 -r /DO12/** -w /DO12/** \
--allow "ros_discovery_info|diagnostics|/joystick/.*|rt/lateral_error|lookahead_error|ct_report|misc_report_do|pt_report|/vehicle/.*|rc_to_ct|/raptor_dbw_interface/pt_report"
