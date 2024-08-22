#!/bin/bash

#~ This command retrieves the public IP address of the system using the curl utility.
#~ 'curl'is a command for transferring data from or to a server.
#~ '-s' instructs curl to operate in silent mode, suppressing progress or error messages.
#~ 'ifconfig.co' is the URL from which the command fetches the public IP address.
IPX=$(curl -s ifconfig.co)
	echo "Your public IP Address is $IPX"
sleep 1
echo ''

#~ This command retrieves the internal IP address of the machine.
IP=$(ifconfig | grep broadcast | awk '{print$2}')
	echo "Your internal IP address of the machine is $IP"
sleep 1
echo ''

#~ This command retrieves the MAC address of the machine and censors the first part.
#~ 'grep ether' filters the output of ifconfig to only include lines containing the word "ether" (MAC address).
#~ 'split($2, a, ":")' splits the second field of the MAC address by ":" and stores the parts in array "a".
#~ 'print("XX:XX:XX:" a[4] ":" a[5] ":" a[6])' prints the censored MAC address, replacing the first three parts with "XX:XX:XX".
MAC_Addr=$(ifconfig | grep ether | awk '{split($2, a, ":"); print("XX:XX:XX:" a[4] ":" a[5] ":" a[6])}')
	echo "Your MAC address is $MAC_Addr"
sleep 1
echo ''

#~ This command retrieves the top 5 processes' CPU usage and % from the output of the 'top' command.
#~ 'top': Command to display dynamic real-time information about running processes.
top5_processes=$(top | head -n12 | tail -n5 | awk '{print$(NF-4),$(NF-1)}')
	echo "Your top 5 processes' CPU usage is:"
	echo "%Command"
	echo "$top5_processes"
	sleep 1
	echo ''

#~ These commands retrieve the value of available and free memory from the /proc/meminfo file.
#~ Used memory = memory available - memory free
mem_avail=$(cat /proc/meminfo | grep -i memavailable | awk '{print$2}')
mem_free=$(cat /proc/meminfo | grep -i memfree | awk '{print$2}')
used_memory=$((mem_avail - mem_free))
	echo "The amount of memory available is $mem_avail kB"
	echo "The amount of memory free is $mem_free kB"
	echo "The amount of memory used is $used_memory kB"
	sleep 1
	echo ''

#~ This command retrieves a list of network connections and associated processes using systemctl.
active_system=$(sudo systemctl list-units --type=service --state=active)
	echo "Below are your active system services and status:"
	echo ""

	#~ Loop through each line of the active_system output
	echo "$active_system" | while IFS= read -r line
	do
		#~ Echo everyline with sleep 0.5
		echo "$line"
		sleep 0.5
	done
	echo ''

#~ This command finds files in the /home directory and prints their sizes and paths.
#~ 'find /home' searches for files within the /home directory.
#~ '-type f' specifies that only regular files should be included in the search.
#~ '-printf '%s %p\n'' specifies the format for the output.
	#~ '%s' prints the size of each file.
	#~ '%p' prints the file path.
	#~ '\n' adds a newline character after each entry.
largest_files=$(sudo find /home -type f -printf '%s %p \n' | sort -nr | head -10)
	echo "Your 10 largest files are:"
	echo ""
	
	#~ Echo everyline with sleep 0.5
	echo "$largest_files" | while IFS= read -r line
	do
		#~ Echo everyline with sleep 0.5
		echo "$line"
		sleep 0.5
	done
	echo ''




