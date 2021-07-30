ip link set can0 type can bitrate 500000
ip link set can1 type can bitrate 500000
ip link set up can0
ip link set up can1

#ip link set down can2
#ip link set down can3
#ip link set down can4
#ip link set down can5
#ip link set can2 type can restart-ms 100
#ip link set can3 type can restart-ms 100
#ip link set can4 type can restart-ms 100
#ip link set can5 type can restart-ms 100
#ip link set can2 type can bitrate 500000 sample-point 0.875
#ip link set can3 type can bitrate 500000 sample-point 0.875
#ip link set can4 type can bitrate 500000 sample-point 0.875
#ip link set can5 type can bitrate 500000 sample-point 0.875
#ip link set can2 type can berr-reporting on
#ip link set can3 type can berr-reporting on
#ip link set can4 type can berr-reporting on
#ip link set can5 type can berr-reporting on
#ifconfig can2 txqueuelen 1000
#ifconfig can3 txqueuelen 1000
#ifconfig can4 txqueuelen 1000
#ifconfig can5 txqueuelen 1000
#ip link set up can2
#ip link set up can3
#ip link set up can4
#ip link set up can5
