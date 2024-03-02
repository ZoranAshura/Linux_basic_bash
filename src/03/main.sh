#!/bin/bash

# Foreground colors
BLACK=";30"
RED=";31"
GREEN=";32"
BLUE=";34"
PURPLE=";35"
WHITE=";37"

# Background colors
BG_BLACK=";40"
BG_RED=";41"
BG_GREEN=";42"
BG_BLUE=";44"
BG_PURPLE=";45"
BG_WHITE=";47"

# reset to default colors
CLEAR="\033[0m"

# Core of the color formatting
s="\033[0"
e="m"

function paramIsNumberInRange () {
for INDEX in "$@"; do
  if [[ "$INDEX" -ge 1 && "$INDEX" -le 6 ]]; then
    continue
  else
echo "Error: Parameter is out of range (1-6)"
    exit 1
fi
done
}

function coloursIsMatch () {
if [ "${1}" = "${2}" ] || [ "${3}" = "${4}" ]; then
    echo "Error: background color and font color is matched! Please try again"
    exit 1
fi
}

function takeColour() {
case $1 in
    1) FN=$WHITE ;;
    2) FN=$RED ;;
    3) FN=$GREEN ;;
    4) FN=$BLUE ;;
    5) FN=$PURPLE ;;
    6) FN=$BLACK ;;
esac

case $2 in
    1) BN=$BG_WHITE ;;
    2) BN=$BG_RED ;;
    3) BN=$BG_GREEN ;;
    4) BN=$BG_BLUE ;;
    5) BN=$BG_PURPLE ;;
    6) BN=$BG_BLACK ;;
esac

case $3 in
    1) FT=$WHITE ;;
    2) FT=$RED ;;
    3) FT=$GREEN ;;
    4) FT=$BLUE ;;
    5) FT=$PURPLE ;;
    6) FT=$BLACK ;;
esac

case $4 in
    1) BT=$BG_WHITE ;;
    2) BT=$BG_RED ;;
    3) BT=$BG_GREEN ;;
    4) BT=$BG_BLUE ;;
    5) BT=$BG_PURPLE ;;
    6) BT=$BG_BLACK ;;
esac
}

function systemInfo() {
    echo -e "HOSTNAME = $(ip -o link show | awk -F': ' '{print $2}' | awk '/^e/{printf "%s ", $0}')"
    echo -e "TIMEZONE = $(timedatectl | awk -F": " '/Time/{print $2}')"
    echo -e "USER = $(whoami)"
    echo -e "OS = $(hostnamectl |awk '/Op/{print $3, $4, $5}')"
    echo -e "DATE = $(date | awk '{print $2, $3, $4, $5}')"
    echo -e "UPTIME = $(uptime | awk '{print $3}') minutes"
    echo -e "UPTIME_SECv = $(uptime | awk '{print $3 * 60}') seconds"
    echo -e "IP = $(ifconfig | awk '/inet /{print $2}' | awk '{printf "%s ", $0}')"
    echo -e "MASK = $(ifconfig | awk '/netmask/{print $4}' | awk '{printf "%s ", $0}')"
    echo -e "GATEWAY = $(ip route | awk '/default/{print $3}')"
    echo -e "RAM_TOTAL = $(free --mega -t | awk '/Total:/{print $2 / 1000}') GB (also includes swap memory)"
    echo -e "RAM_USED = $(free --mega -t | awk '/Total:/{print $3 / 1000}') GB"
    echo -e "RAM_FREE = $(free --mega -t | awk '/Total:/{print $4 / 1000}') GB"
    echo -e "SPACE_ROOT = $(df / | sed -n '2p' | awk '{size = sprintf("%.2f", $2 / 1000); print size}') MB"
    echo -e "SPACE_ROOT_USED = $(df / | sed -n '2p' | awk '{size = sprintf("%.2f", $3 / 1000); print size}') MB"
    echo -e "SPACE_ROOT_FREE = $(df / | sed -n '2p' | awk '{size = sprintf("%.2f", $4 / 1000); print size}') MB"
}

if [ ! $# -eq 4 ]; then
    echo "Error: Expected 4 parameters."
    exit 1
fi

# cat text.txt | awk '{print "\033[0;31m",  $1 "\033[0m"}'
paramIsNumberInRange "$1" "$2" "$3" "$4"
coloursIsMatch "$1" "$2" "$3" "$4"
takeColour "$1" "$2" "$3" "$4"
systemInfo | awk -v fn=$FN -v bn=$BN -v ft=$FT -v bt=$BT -v S=$s -v E=$e -v clear=$CLEAR 'BEGIN { FS = "=" } {print S fn bn E $1 "=" clear S ft bt E $2 clear}'

