#!/bin/bash

# Get current memory usage percentage
mem_usage=$(free | awk 'NR==2{printf "%.2f\n", $3/$2*100}')

# Check if memory usage is greater than 80%
if (( $(echo "$mem_usage > 80.0" | bc -l) )); then
    # Execute the second script
    ./passengerKill.sh
fi

