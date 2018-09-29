# 
echo -e "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo -e "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf

# 
sysctl -p

# show result
lsmod | grep bbr

# restart
service shadowsocks-libev restart


