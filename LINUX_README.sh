
# RAID Setup...
# https://raid.wiki.kernel.org/index.php/RAID_setup#RAID_setup

# mdadm --create --verbose /dev/md0 --level=5 --raid-devices=3 /dev/sdb /dev/sdc /dev/sdd
# mkfs.ext4 -v -m .1 -b 4096 -E stride=128,stripe-width=256 /dev/md0


