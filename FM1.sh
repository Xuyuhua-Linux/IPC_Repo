#!/bin/bash
sleep 10
cd /home/user/zenoh-plugin-dds/target/release/
ROS_DOMAIN_ID=21 RUST_LOG=debug ./dzd -d 21 -m peer -l tcp/10.42.2.200:7447 -s /DO12 -r /DO12/** -w /DO12/**
