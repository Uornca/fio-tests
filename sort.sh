#!/bin/bash

for b in 1 2 4 8 16 32 64
do
	for a in 1 2 4 8 16 32
	do
		rm tmpSort
		grep WRITE randwrite/$b-node/randwrite$a.log | cut -d = -f 2 | cut -d i -f 1 > randwrite/$b-node/speeds$a
		cat randwrite/$b-node/speeds$a | while read line || [[ -n $line ]]
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
		echo -n "$b nodes, $a jobs/node, $(($b*$a)) total jobs = " >> tmpSortA
		tail -n 1 tmpSort >> tmpSortA
	done
done

sort -nrk 9 tmpSortA > randwrite/sortedWrite
rm tmpSortA
rm tmpSort
