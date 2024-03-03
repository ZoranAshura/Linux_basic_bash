#!/bin/bash

CLEAN_COLOUR="\033[0m"

BLACK="\033[30m"
RED="\033[31m"
GREEN="\033[32m"
BLUE="\033[34m"
PURPLE="\033[35m"
WHITE="\033[37m"

BLACK_BACK="\033[40m"
RED_BACK="\033[41m"
GREEN_BACK="\033[42m"
BLUE_BACK="\033[44m"
PURPLE_BACK="\033[45m"
WHITE_BACK="\033[47m"


function takeColour () {
nameFont=$(grep "column1_font_color=" colors.conf | awk -F= '{ print $2 }')
nameBackground=$(grep "column1_background=" colors.conf | awk -F= '{ print $2 }')
textFont=$(grep "column2_font_color=" colors.conf | awk -F= '{ print $2 }')
textBackground=$(grep "column2_background=" colors.conf | awk -F= '{ print $2 }')

case $nameFont in 
    1) FONT_NAME=$WHITE; propertyNameFont="1  (white)"  ;;
    2) FONT_NAME=$RED; propertyNameFont="2  (red)"  ;;
    3) FONT_NAME=$GREEN; propertyNameFont="3  (green)"  ;;
    4) FONT_NAME=$BLUE; propertyNameFont="4  (blue)"  ;;
    5) FONT_NAME=$PURPLE; propertyNameFont="5  (purple)"  ;;
    6) FONT_NAME=$BLACK; propertyNameFont="6  (black)"  ;;
    *) FONT_NAME=$RED; propertyNameFont="default  (red)"  ;;
esac

case $nameBackground in 
    1) BACK_NAME=$WHITE_BACK; propertyNameBack="1  (white)" ;;
    2) BACK_NAME=$RED_BACK; propertyNameBack="2  (red)"  ;;
    3) BACK_NAME=$GREEN_BACK; propertyNameBack="3  (green)"  ;;
    4) BACK_NAME=$BLUE_BACK; propertyNameBack="4  (blue)" ;;
    5) BACK_NAME=$PURPLE_BACK; propertyNameBack="5  (purple)"  ;;
    6) BACK_NAME=$BLACK_BACK; propertyNameBack="6  (black)"  ;;
    *) BACK_NAME=$BLUE_BACK; propertyNameBack="default  (blue)"  ;;
esac

case $textFont in 
    1) FONT_TEXT=$WHITE; propertyTextFont="1  white"  ;;
    2) FONT_TEXT=$RED; propertyTextFont="2  (red)"  ;;
    3) FONT_TEXT=$GREEN; propertyTextFont="3  (green)"  ;;
    4) FONT_TEXT=$BLUE; propertyTextFont="4  (blue)"  ;;
    5) FONT_TEXT=$PURPLE; propertyTextFont="5  (purple)"  ;;
    6) FONT_TEXT=$BLACK; propertyTextFont="6  (black)"  ;;
    *) FONT_TEXT=$GREEN; propertyTextFont="default  (green)"   ;;

esac  

case $textBackground in 
    1) BACK_TEXT=$WHITE_BACK; propertyTextBack="1  (white)"  ;;
    2) BACK_TEXT=$RED_BACK; propertyTextBack="2  (red)" ;;
    3) BACK_TEXT=$GREEN_BACK; propertyTextBack="3  (green)"  ;;
    4) BACK_TEXT=$BLUE_BACK; propertyTextBack="4  (blue)"  ;;
    5) BACK_TEXT=$PURPLE_BACK; propertyTextBack="5  (purple)"  ;;
    6) BACK_TEXT=$BLACK_BACK; propertyTextBack="6  (black)"  ;;
    *) BACK_TEXT=$WHITE_BACK; propertyTextBack="default  (white)"  ;;
esac
}

function showInfo {
    echo "HOSTNAME = $(ip -o link show | awk -F': ' '{print $2}' | awk '/^e/{printf "%s ", $0}')"
    echo "TIMEZONE = $(timedatectl | awk -F": " '/Time/{print $2}')"
    echo "USER = $(whoami)"
    echo "OS = $(hostnamectl |awk '/Op/{print $3, $4, $5}')"
    echo "DATE = $(date | awk '{print $2, $3, $4, $5}')"
    echo "UPTIME = $(uptime | awk '{print $3}') minutes"
    echo "UPTIME_SECv = $(uptime | awk '{print $3 * 60}') seconds"
    echo "IP = $(ifconfig | awk '/inet /{print $2}' | awk '{printf "%s ", $0}')"
    echo "MASK = $(ifconfig | awk '/netmask/{print $4}' | awk '{printf "%s ", $0}')"
    echo "GATEWAY = $(ip route | awk '/default/{print $3}')"
    echo "RAM_TOTAL = $(free --mega -t | awk '/Total:/{print $2 / 1000}') GB (also includes swap memory)"
    echo "RAM_USED = $(free --mega -t | awk '/Total:/{print $3 / 1000}') GB"
    echo "RAM_FREE = $(free --mega -t | awk '/Total:/{print $4 / 1000}') GB"
    echo "SPACE_ROOT = $(df / | sed -n '2p' | awk '{size = sprintf("%.2f", $2 / 1000); print size}') MB"
    echo "SPACE_ROOT_USED = $(df / | sed -n '2p' | awk '{size = sprintf("%.2f", $3 / 1000); print size}') MB"
    echo "SPACE_ROOT_FREE = $(df / | sed -n '2p' | awk '{size = sprintf("%.2f", $4 / 1000); print size}') MB"
}

function colourInfo {
  echo ""
  echo "Column 1 background = $propertyNameBack"
  echo "Column 1 font color = $propertyNameFont"
  echo "Column 2 background = $propertyTextBack"
  echo "Column 2 font color = $propertyTextFont"
}
