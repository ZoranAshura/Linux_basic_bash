#!/bin/bash

function systemInfo() {
    echo '========================================='
    echo "HOSTNAME = $(ip -o link show | awk -F': ' '{print $2}' | awk '/^e/{printf "%s ", $0}')"
    echo "TIMEZONE = $(timedatectl | awk -F": " '/Time/{print $2}')"
    echo "USER = $(whoami)"
    echo "OS = $(hostnamectl |awk '/Op/{print $3, $4, $5}')"
    echo "DATE = $(date | awk '{print $2, $3, $4, $5}')"
    echo "UPTIME = $(uptime | awk '{print $3}') minutes"
    echo "UPTIME_SEC = $(uptime | awk '{print $3 * 60}') seconds"
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

function saveFile() {
    echo '========================================='
    echo "Do you want to write this data to a file? (Y/N)"
    echo '========================================='
    flag=1
    while [ $flag -eq 1 ]
    do
        read answer
        if [[ $answer =~ ^[^yY]*[yY][^yY]*$ ]]; then
            date1=$(date | awk '{print $2"_"$3"_"$4"_"}')
            date2=$(date | awk '{print $5}' | awk -F: '{print $1"_"$2"_"$3}')
            echo ========================================= > $date1$date2.status
            systemInfo > $date1$date2.status
            echo "Data was successful writted to the status file!"
            flag=0
        elif [[ $answer =~ ^[^nN]*[nN][^nN]*$ ]]; then
            echo "Bye! Thanks for using this script"
            flag=0
        else
            echo "Wrong input value, try again! (Y/N)"
        fi
    done
}

systemInfo
saveFile

