#!/bin/sh
# /etc/acpi/default.sh
# Default acpi script that takes an entry for all actions

set $*

group=${1%%/*}
action=${1#*/}
device=$2
id=$3
value=$4

log_unhandled() {
	logger "ACPI event unhandled: $*"
}


function net_wlp_state {
	rc-status -C | sed -n 's/ net.wlp3s0 *\[ \(.*\) \]/\1/p'
}

case "$group" in
	button)
		case "$action" in
			lid)
				case "$id" in
					close) 
						/etc/init.d/dhcpcd stop
						/etc/init.d/net.wlp3s0 stop
						echo "mem" > /sys/power/state
						;;
					open) 
						while [ $(net_wlp_state) = "stopped" ]; do 
							/etc/init.d/net.wlp3s0 start
						done
						while [ $(net_wlp_state) = "inactive" ]; do : ; done
						/etc/init.d/dhcpcd start
						;;
					*) uhd $*;;
				esac
				;;
			power)
				/etc/acpi/actions/powerbtn.sh
				;;

			# if your laptop doesnt turn on/off the display via hardware
			# switch and instead just generates an acpi event, you can force
			# X to turn off the display via dpms.  note you will have to run
			# 'xhost +local:0' so root can access the X DISPLAY.
			#lid)
			#	xset dpms force off
			#	;;

			*)	log_unhandled $* ;;
		esac
		;;

	ac_adapter)
		case "$value" in
			# Add code here to handle when the system is unplugged
			# (maybe change cpu scaling to powersave mode).  For
			# multicore systems, make sure you set powersave mode
			# for each core!
			#*0)
			#	cpufreq-set -g powersave
			#	;;

			# Add code here to handle when the system is plugged in
			# (maybe change cpu scaling to performance mode).  For
			# multicore systems, make sure you set performance mode
			# for each core!
			#*1)
			#	cpufreq-set -g performance
			#	;;

			*)	log_unhandled $* ;;
		esac
		;;

	*)	log_unhandled $* ;;
esac
