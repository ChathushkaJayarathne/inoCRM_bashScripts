#!/bin/bash

# Define the name of the passenger process to search for
passenger_process="Passenger AppPreloader: /var/www/inova-crm/current (forking...)"

# Get the process IDs for all passenger processes
pids=$( ps -ef | grep " $passenger_process " | grep -v "grep" | awk '{print $2}')

# Sort the PIDs by memory usage in descending order
sorted_pids=$(echo "$pids" | xargs -n1 | sort -nk2 | xargs)

# Loop through the sorted PIDs and kill the processes
for pid in $sorted_pids; do
  echo "Killing process $pid"
  kill -9 $pid

  # Get current memory usage percentage
  mem_usage=$(free | awk 'NR==2{printf "%.2f\n", $3/$2*100}')

  # Check if memory usage is still greater than 20%
  if (( $(echo "$mem_usage > 20.0" | bc -l) )); then
      continue
  else
      break
  fi

done

