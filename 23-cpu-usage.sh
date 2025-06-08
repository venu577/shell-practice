#!/bin/bash

# Set the threshold for CPU usage (percentage)
THRESHOLD=80

# Set the email recipient
EMAIL="your_email@example.com"

# Get CPU usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*,  \([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')

# Check if CPU usage exceeds the threshold
if (( $(echo "$CPU_USAGE > $THRESHOLD" | bc -l) )); then
  # Get the top CPU-consuming processes
  TOP_PROCESSES=$(top -bn1 | head -n 12 | tail -n +8)

  # Compose the email message
  MESSAGE="Subject: High CPU Usage Alert\n\n"
  MESSAGE+="CPU usage is above $THRESHOLD% (currently $CPU_USAGE%).\n\n"
  MESSAGE+="Top processes consuming CPU:\n$TOP_PROCESSES\n"

  # Send the email
  echo "$MESSAGE" | mail -s "High CPU Usage Alert" "$EMAIL"

  echo "Email sent!"
else
  echo "CPU usage is normal ($CPU_USAGE%)."
fi


