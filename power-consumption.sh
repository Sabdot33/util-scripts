#!/bin/bash

sleep_time=1
declare -a T0=($(sudo cat /sys/class/powercap/*/energy_uj))
sleep $sleep_time
declare -a T1=($(sudo cat /sys/class/powercap/*/energy_uj))

for i in "${!T0[@]}"; do 
    awk -v t0="${T0[i]}" -v t1="${T1[i]}" -v st="$sleep_time" 'BEGIN {printf "%.1f W\n", (t1-t0) / st / 1e6}'
done
