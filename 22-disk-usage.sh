#!/bin/bash

DISK_USAGE=$(df -hT | grep -v filesystem)
DISK_THRESHOLD=1 #In projects it will be 75
MSG=""

while IFS= read line
do
    USAGE=$(echo $line | awk '{print $6F}' | cut -d "%" -f1)
    PARTITION=$(echo $line | awk '{print $7F}')
    if [ $USAGE -ge $DISK_THRESHOLD ]
    then
        MSG+="high disk usage on $PARTITION: $USAGE \n"
    fi

done <<< $DISK_USAGE
    echo -e $MSG