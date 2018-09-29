#!/bin/bash

# Shadowsocks
# update
apt-get update

# vim
apt-get install vim

# add source
echo "deb http://ppa.launchpad.net/max-c-lv/shadowsocks-libev/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ss.list

# update
apt-get update

# install shadowsocks-libev
apt-get install shadowsocks-libev

# config
ss_pwd=$(cat /proc/sys/kernel/random/uuid)
cur_ip=$(curl -4 ip.sb)

echo -e "{" > /etc/shadowsocks-libev/config.json
echo -e "\t\"server\":\"$cur_ip\"," >> /etc/shadowsocks-libev/config.json
echo -e "\t\"server_port\":443," >> /etc/shadowsocks-libev/config.json
echo -e "\t\"local_port\":1080," >> /etc/shadowsocks-libev/config.json
echo -e "\t\"password\":\"$ss_pwd\"," >> /etc/shadowsocks-libev/config.json
echo -e "\t\"timeout\":600," >> /etc/shadowsocks-libev/config.json
echo -e "\t\"method\":\"aes-256-cfb\"" >> /etc/shadowsocks-libev/config.json
echo -e "}" >> /etc/shadowsocks-libev/config.json

# BBR
# download
cd ~
mkdir download
cd download
wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.9.10/linux-image-4.9.10-040910-generic_4.9.10-040910.201702141931_amd64.deb

# install
dpkg -i linux-image-4.9.10-040910-generic_4.9.10-040910.201702141931_amd64.deb

# delete kernel
apt-get purge .*3.13.*

# update-grub
update-grub

reboot
