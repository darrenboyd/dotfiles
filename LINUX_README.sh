
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


# Binding mouse buttons to other things
# https://ask.fedoraproject.org/en/question/10201/bind-gnome-3-overview-mode-to-a-mouse-button/


sudo apt install enpass

# OTHER SUDO APT INSTALL...
# gnome-sushi diodon


# Ruby
# This is for ruby-build to work...
sudo apt install -y libssl-dev libreadline-dev zlib1g-dev
# ruby-build
# chruby


# Postgresql...

# This gets latest, which may be too new.
# sudo apt install postgresql postgresql-common libpq-dev postgresql-client-common

# This gets specific version from postgresql.org
sudo cp etc/pgdg.list /etc/apt/sources.list.d/
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt install postgresql-9.4 postgresql-client-9.4 libpq-dev

# For rails to easily login as current user, change this line in pg_hba.conf
# host    all             all             127.0.0.1/32            md5
# To this:
# host    all             all             127.0.0.1/32            trust

sudo -u postgres createuser --superuser darren
createdb darren

sudo add-apt-repository ppa:stebbins/handbrake-releases

