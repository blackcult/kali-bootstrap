#!/bin/bash
sudo su
hostnamectl set-hostname $1
curl -fsSL https://pkgs.tailscale.com/stable/raspbian/bullseye.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg > /dev/null
curl -fsSL https://pkgs.tailscale.com/stable/raspbian/bullseye.tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list
apt update
apt upgrade
apt install -y kali-grant-root git xrdp tailscale apt-transport-https dnsmasq
apt autoremove
dpkg-reconfigure kali-grant-root
sed -i 's/^port=3389/port=tcp:\/\/:3389/g' /etc/xrdp/xrdp.ini
systemctl enable xrdp
systemctl restart xrdp
git clone git@github.com:morrownr/8814au.git
./8814au/install-driver.sh
systemctl enable --now tailscaled
tailscale up --ssh --authkey $1
sed -i '1s/^/dtoverlay=dwc2\n/' /boot/config.txt
echo "modules-load=dwc2" >> /boot/cmdline.txt
echo "libcomposite" >> /etc/modules
cp usb /etc/dnsmasq.d/usb
cp usb0 /etc/network/interfaces.d/usb0
cp usb.sh /root/usb.sh
chmod +x /root/usb.sh
cp rc-local.service /etc/systemd/system/rc-local.service
cp rc.local /etc/rc.local
sudo chmod +x /etc/rc.local
systemctl enable --now rc-local