#!/bin/bash

# --- Shadowsocks ---

# get distribution info and install shadowsocks-libev
if grep -Eqi "Debian" /etc/issue || grep -Eq "Debian" /etc/*-release; then
    echo "Distribution: Debian"

    # Debian 安装方法
    apt update
    apt install shadowsocks-libev
        
    # vim
    apt-get install vim

    # BBR
    # update kernel
    wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.16/linux-image-4.16.0-041600-generic_4.16.0-041600.201804012230_amd64.deb
    dpkg -i linux-image-4.*.deb
    # delete 
    dpkg -l | grep linux-image
    apt-get purge
    # update grub
    update-grub

elif grep -Eqi "Ubuntu" /etc/issue || grep -Eq "Ubuntu" /etc/*-release; then
    echo "Distribution: Ubuntu"
    
    if grep -Eqi "14.0" /etc/issue || grep -Eq "14.0" /etc/*-release; then
        echo "Release: 14.04"

        # Ubuntu 14.04 安装方法
        apt-get install software-properties-common -y
        add-apt-repository ppa:max-c-lv/shadowsocks-libev -y
        apt-get update
        apt install shadowsocks-libev

    elif grep -Eqi "16.0" /etc/issue || grep -Eq "16.0" /etc/*-release; then
        echo "Release: 16.04"

        # Ubuntu 16.04 安装方法
        apt-get install software-properties-common -y
        add-apt-repository ppa:max-c-lv/shadowsocks-libev -y
        apt-get update
        apt install shadowsocks-libev

        # BBR
        # update kernel
        apt install --install-recommends linux-generic-hwe-16.04
        # delete 
        apt autoremove

    else
        echo "Release: 18.04 or higher"

        # Ubuntu 18.04或更高版本 安装方法
        apt update
        apt install shadowsocks-libev

    fi

    # vim
    apt-get install vim
    
else
    echo "The script only supports Debian and Ubuntu"
    exit
fi

# config
ss_pwd=$(cat /proc/sys/kernel/random/uuid)
cur_ip=$(curl -4 ip.sb)

echo -e "{" > /etc/shadowsocks-libev/config.json
echo -e "\t\"server\":\"$cur_ip\"," >> /etc/shadowsocks-libev/config.json
echo -e "\t\"server_port\":23333," >> /etc/shadowsocks-libev/config.json
echo -e "\t\"local_port\":1080," >> /etc/shadowsocks-libev/config.json
echo -e "\t\"password\":\"$ss_pwd\"," >> /etc/shadowsocks-libev/config.json
echo -e "\t\"timeout\":600," >> /etc/shadowsocks-libev/config.json
echo -e "\t\"method\":\"aes-256-cfb\"" >> /etc/shadowsocks-libev/config.json
echo -e "}" >> /etc/shadowsocks-libev/config.json

# reboot
reboot
