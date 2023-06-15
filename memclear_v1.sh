#!/bin/bash
# Check the Memory usage

# Get the current usage of memory
memUsage=$(free -g | awk '/Mem/{print $3}')

# Print the usage
echo "Current Memory Usage: $memUsage GB"

# Sleep for 1 second
sleep 1

#Save current memory usage in to a variable
a=$memUsage
#Enter desired cutoff memory size in Giga to b variable -  Ex :- b=10
b=8

if [ "$a" -gt "$b" ]; then
while [ "$a" -gt "$b" ]
do
   pid=`ps aux | grep "Passenger AppPreloader: /var/www/inova-crm/current" | sort -rnk 4 | head -1 | awk '{print $2}'`

   kill $pid
   sleep 10 # give it a chance to exit gracefully
   kill -9 $pid # otherwise, kill forcefully
   echo "Killed this process ID : $pid";
   echo "Memory Cleared";
   memUsage=$(free -g | awk '/Mem/{print $3}')
   a=$memUsage
done
else 
   echo "No need to clear memory because less usage of memory than cutoff memory size";

fi
