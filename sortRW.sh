#!/bin/bash

for b in 1 2 4 8 16 32 64 96 128 150
do
	rm randrw/bws/bw$b
	for a in 1 2 4 8 16 32 64
	do
		grep READ randrw/$b-node/randrw$a.log | cut -d = -f 2 | cut -d i -f 1 > randrw/$b-node/speeds$a
		cat randrw/$b-node/speeds$a | while read line || [[ -n $line ]]
		do
			if [ "${line: -1}" == "K" ]
			then
				echo "${line:0:1}.${line:1}" >> tmpSort
			else
				echo $line >> tmpSort
			fi
		done

		grep READ randrw/$b-node/randrw$a.log | cut -d = -f 2 | cut -d i -f 1 > randrw/$b-node/speeds$a
		cat randrw/$b-node/speeds$a | while read line || [[ -n $line ]]
		do
			if [ "${line: -1}" == "K" ]
			then
				echo "${line:0:1}.${line:1}" >> tmpSort
			else
				echo $line >> tmpSort
			fi
		done

		sed -i 's/.$//' tmpSort
		awk '{total+=$1} END {print total}' tmpSort >> tmpSort
		echo -n "$b nodes $a jobs ($(($b*$a)) total jobs); " >> tmpSortA
		echo -n " $(tail -n 1 tmpSort) MB/s ; iops: " >> tmpSortA
		tail -n 1 tmpSort >> randrw/bws/bw$b

		grep IOPS randrw/$b-node/randrw$a.log | cut -d = -f 2 | cut -d , -f 1 > randrw/$b-node/iops$a
		awk '{n += $1}; END{print n}' randrw/$b-node/iops$a >> tmpSortA
		rm tmpSort
	done
done

sort -nrk 8 tmpSortA > randrw/sortedMixed
rm tmpSortA
