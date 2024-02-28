#!/bin/bash

# HOSTNAME = network name
# TIMEZONE = time zone as: America/New_York UTC -5 (time zone must be taken from the system and be correct for the current location)
# USER = current user who ran the script
# OS = type and version of operating system
# DATE = current time as: 12 May 2020 12:24:36
# UPTIME = system uptime
# UPTIME_SEC = system uptime in seconds
# IP = _ip address of the machine on any of the network interfaces
# MASK = network mask of any of the network interfaces as: xxx.xxx.xxx.xxx.
# GATEWAY = default gateway ip
# RAM_TOTAL = main memory size in GB with an accuracy of three decimal places as: 3.125 GB
# RAM_USED = used memory size in GB with an accuracy of three decimal places
# RAM_FREE = free memory size in GB, with an accuracy of three decimal places
# SPACE_ROOT = root partition size in MB, with an accuracy of two decimal places, as 254.25 MB
# SPACE_ROOT_USED = size of used space of the root partition in MB, with an accuracy of two decimal places
# SPACE_ROOT_FREE = size of free space of the root partition in MB, with an accuracy of two decimal places

HOSTNAME=$(ip -o link show | awk -F': ' '{print $2}' | grep '^e' | awk '{printf "%s ", $0}')
# TIMEZONE=$
echo "HOSTNAME = $HOSTNAME"
