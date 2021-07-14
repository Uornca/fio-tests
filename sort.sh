#!/bin/bash

for b in 1 2 4 8 16 32
do
	for a in 1 2 4 8 16 32
	do
		grep WRITE $b-node/randwrite$a.log | cut -d = -f 2 | cut -d M -f 1 > $b-node/speeds$a
		awk '{total+=$1} END {print total}' $b-node/speeds$a >> $b-node/speeds$a
		echo -n "$b nodes, $a jobs/node, $(($b*$a)) total jobs = " >> tmpSort
		tail -n 1 $b-node/speeds$a >> tmpSort	
	done
done

sort -nrk 9 tmpSort > sorted
rm tmpSort
