rmmod f81601
modprobe f81601

ip link set down can0
ip link set down can1
ip link set can0 type can bitrate 500000
ip link set can1 type can bitrate 500000
ifconfig can0 txqueuelen 1000
ifconfig can1 txqueuelen 1000
ip link set up can0
ip link set up can1

# configure 4 channel M2 port (this configuration is taken from the driver)
ifconfig can2 down
ifconfig can3 down
ifconfig can4 down
ifconfig can5 down
ip link set can2 type can restart-ms 100
ip link set can3 type can restart-ms 100
ip link set can4 type can restart-ms 100
ip link set can5 type can restart-ms 100
ip link set can2 type can bitrate 500000 sample-point 0.875
ip link set can3 type can bitrate 500000 sample-point 0.875
ip link set can4 type can bitrate 500000 sample-point 0.875
ip link set can5 type can bitrate 500000 sample-point 0.875
ip link set can2 type can berr-reporting on
ip link set can3 type can berr-reporting on
ip link set can4 type can berr-reporting on
ip link set can5 type can berr-reporting on
ifconfig can2 txqueuelen 8000
ifconfig can3 txqueuelen 8000
ifconfig can4 txqueuelen 8000
ifconfig can5 txqueuelen 8000
tc qdisc add dev can2 root handle 1: pfifo_fast
tc qdisc add dev can3 root handle 1: pfifo_fast
tc qdisc add dev can4 root handle 1: pfifo_fast
tc qdisc add dev can5 root handle 1: pfifo_fast
ifconfig can2 up
ifconfig can3 up
ifconfig can4 up
ifconfig can5 up

