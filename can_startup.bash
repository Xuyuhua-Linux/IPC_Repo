ip link set can0 type can bitrate 500000
ip link set can0 berr-reporting on
ip link set can0 restart-ms 100
ip link set can0 txqueuelen 1000
tc qdisc add dev can0 root handle 1: pfifo_fast
ip link set up can0

ip link set can1 type can bitrate 500000
ip link set can1 berr-reporting on
ip link set can1 restart-ms 100
ip link set can1 txqueuelen 1000
tc qdisc add dev can1 root handle 1: pfifo_fast
ip link set up can1

ip link set can2 type can bitrate 500000
ip link set can2 berr-reporting on
ip link set can2 restart-ms 100
ip link set can2 txqueuelen 1000
tc qdisc add dev can2 root handle 1: pfifo_fast
ip link set up can2

ip link set can3 type can bitrate 500000
ip link set can3 berr-reporting on
ip link set can3 restart-ms 100
ip link set can3 txqueuelen 1000
tc qdisc add dev can3 root handle 1: pfifo_fast
ip link set up can3

ip link set can4 type can bitrate 500000
ip link set can4 berr-reporting on
ip link set can4 restart-ms 100
ip link set can4 txqueuelen 1000
tc qdisc add dev can4 root handle 1: pfifo_fast
ip link set up can4

ip link set can5 type can bitrate 500000
ip link set can5 berr-reporting on
ip link set can5 restart-ms 100
ip link set can5 txqueuelen 1000
tc qdisc add dev can5 root handle 1: pfifo_fast
ip link set up can5
