#!/bin/bash

CPU_USAGE=$(top | grep -v filesystem)
CPU_THRESHOLD=1 #In projects it will be 75
MSG=""
IP=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)

while IFS= read line
do
    USAGE=$(top -b -n2 -p 1 | fgrep "Cpu(s)" | tail -1 | awk -F'id,' -v prefix="$prefix" '{ split($1, vs, ","); v=vs[length(vs)]; sub("%", "", v); printf "%s%.1f%%\n", prefix, 100 - v }')
    PARTITION=$(echo $line | awk '{print $9F}')
    if [ $USAGE -ge $CPU_THRESHOLD ]
    then
        MSG+="high CPU usage on $PARTITION: $USAGE % <br>"
    fi

done <<< $CPU_USAGE
    echo -e $MSG
sh mail.sh "devops team" "high cpu usage" "$IP" "$MSG" "venubonkuri1234@gmail.com" "alert disk usage"
