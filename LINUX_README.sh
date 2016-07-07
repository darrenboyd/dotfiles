
# RAID Setup...
# https://raid.wiki.kernel.org/index.php/RAID_setup#RAID_setup

# mdadm --create --verbose /dev/md0 --level=5 --raid-devices=3 /dev/sdb /dev/sdc /dev/sdd
# mkfs.ext4 -v -m .1 -b 4096 -E stride=128,stripe-width=256 /dev/md0

sudo apt install openssh-server

# From: https://www.insynchq.com/downloads

wget -qO - https://d2t3ff60b2tol4.cloudfront.net/services@insynchq.com.gpg.key \
  | sudo apt-key add -

sudo cp etc/insync.list /etc/apt/sources.list.d/

sudo apt update
sudo apt install insync


# GoldenDict stuff
# http://goldendict.org/download.php


