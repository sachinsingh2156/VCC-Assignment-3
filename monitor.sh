#!/bin/bash

CPU_THRESHOLD=75
RAM_THRESHOLD=75

# Get CPU usage (average over 1 minute)
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}' | cut -d. -f1)

# Get RAM usage percentage
MEM_TOTAL=$(grep MemTotal /proc/meminfo | awk '{print $2}')
MEM_FREE=$(grep MemAvailable /proc/meminfo | awk '{print $2}')
MEM_USAGE=$((100 - (MEM_FREE * 100 / MEM_TOTAL)))

echo "CPU Usage: $CPU_USAGE%"
echo "RAM Usage: $MEM_USAGE%"

if [[ "$CPU_USAGE" -gt "$CPU_THRESHOLD" || "$MEM_USAGE" -gt "$RAM_THRESHOLD" ]]; then
    echo "High resource usage detected. Triggering auto-scaling to GCP..."
    bash ~/autoscale.sh
fi
