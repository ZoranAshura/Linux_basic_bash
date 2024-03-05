#!/bin/bash
startTime=$(date +%s.%N)

if [ $# -ne 1 ]; then
    echo "Please enter path to directory"
    exit 1
fi

if [ "${1: -1}" != "/" ]; then
    echo "Directory path must end with '/'"
    exit 1
fi

if [ ! -d "$1" ]; then
    echo "Error: '$1' the specified directory does not exist."
    exit 1
fi

echo "Total number of folders (including all nested ones) = $(find "$1" -type d | wc -l)"
echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
echo "$(du -h --max-depth=1 $1 | sort -rh | head -n 6| awk ' NR>1' | awk '{print NR " - " $2 ", " $1}')"
echo "Total number of files = $(find "$1" -type f | wc -l)"
echo "Number of:"
echo "Configuration files (with the .conf extension) = $(find "$1" -type f -name "*.conf" | wc -l)"
echo "Text files = $(find "$1" -type f -name "*.txt" | wc -l)"
echo "Executable files = $(find "$1" -type f -executable | wc -l)"
echo "Log files (with the extension .log) = $(find "$1" -type f -name "*.log" | wc -l)"
echo "Archive files = $(find "$1" -type f \( -name "*.zip" -o -name "*.7z" -o -name "*.tar" -o -name "*.rar" -o -name "*.gz" \) | wc -l)"
echo "Symbolic links = $(find "$1" -type l | wc -l)"
echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
echo "$(find "$1" -type f -exec du -h {} + | sort -rh | sed -n '1,10'p | awk '{printf("%d - %s, %s, ", NR, $2, $1); system("bash -c '\''file -b --mime-type "$2"'\''")}')"
echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"
echo "$(find "$1" -type f -executable -exec du -h {} +| sort -rh | head -n 10 | awk '{printf "%d - %s, %s, ", NR, $2, $1; system("md5sum " $2 " | cut -d\" \" -f1")}')"

endTime=$(date +%s.%N)
totalTime=$(echo "$startTime $endTime" | awk '{print $1 - $2}')
echo "Script execution time (in seconds) = $totalTime"
