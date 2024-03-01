#!/bin/bash

# Color variables
BLACK=";30"
RED=";31"
GREEN=";32"
BLUE=";34"
PURPLE=";35"
WHITE=";37"

# Color variables
BG_BLACK=";40"
BG_RED=";41"
BG_GREEN=";42"
BG_BLUE=";44"
BG_PURPLE=";45"
BG_WHITE=";47"
clear="\033[0m"


s="\033[0"
e="m"

#function takeColour() {
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
#}

function systemInfo() {
    echo -e "$s$FN$BN$e HOSTNAME${clear} = $s$FT$BT$e $(ip -o link show | awk -F': ' '{print $2}' | awk '/^e/{printf "%s ", $0}')${clear}"
    echo -e "$s$FN$BN$e TIMEZONE${clear} = $s$FT$BT$e $(timedatectl | awk -F": " '/Time/{print $2}')${clear}"
    echo -e "$s$FN$BN$e USER${clear} = $s$FT$BT$e $(whoami)${clear}"
    echo -e "$s$FN$BN$e OS${clear} = $s$FT$BT$e $(hostnamectl |awk '/Op/{print $3, $4, $5}')${clear}"
    echo -e "$s$FN$BN$e DATE${clear} = $s$FT$BT$e $(date | awk '{print $2, $3, $4, $5}')${clear}"
    echo -e "$s$FN$BN$e UPTIME${clear} = $s$FT$BT$e $(uptime | awk '{print $3}') minutes${clear}"
    echo -e "$s$FN$BN$e UPTIME_SECv${clear} = $s$FT$BT$e $(uptime | awk '{print $3 * 60}') seconds${clear}"
    echo -e "$s$FN$BN$e IP${clear} = $s$FT$BT$e $(ifconfig | awk '/inet /{print $2}' | awk '{printf "%s ", $0}')${clear}"
    echo -e "$s$FN$BN$e MASK${clear} = $s$FT$BT$e $(ifconfig | awk '/netmask/{print $4}' | awk '{printf "%s ", $0}')${clear}"
    echo -e "$s$FN$BN$e GATEWAY${clear} = $s$FT$BT$e $(ip route | awk '/default/{print $3}')${clear}"
    echo -e "$s$FN$BN$e RAM_TOTAL${clear} = $s$FT$BT$e $(free --mega -t | awk '/Total:/{print $2 / 1000}') GB (also includes swap memory)${clear}"
    echo -e "$s$FN$BN$e RAM_USED${clear} = $s$FT$BT$e $(free --mega -t | awk '/Total:/{print $3 / 1000}') GB${clear}"
    echo -e "$s$FN$BN$e RAM_FREE${clear} = $s$FT$BT$e $(free --mega -t | awk '/Total:/{print $4 / 1000}') GB${clear}"
    echo -e "$s$FN$BN$e SPACE_ROOT${clear} = $s$FT$BT$e $(df / | sed -n '2p' | awk '{size = sprintf("%.2f", $2 / 1000); print size}') MB${clear}"
    echo -e "$s$FN$BN$e SPACE_ROOT_USED${clear} = $s$FT$BT$e $(df / | sed -n '2p' | awk '{size = sprintf("%.2f", $3 / 1000); print size}') MB${clear}"
    echo -e "$s$FN$BN$e SPACE_ROOT_FREE${clear} = $s$FT$BT$e $(df / | sed -n '2p' | awk '{size = sprintf("%.2f", $4 / 1000); print size}') MB$(tput sgr0)${clear}"
}

#takeColour
systemInfo


