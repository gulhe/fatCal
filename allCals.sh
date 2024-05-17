#!/usr/bin/env bash

#  First param OR current month
startM=${1:-$(( $(date +%m) + 0 ))}
#  Second param OR current year
startY=${2:-$(date +%Y)}

# The next two are confusing as 🦭 because the third param defaults to 4 and the fourth to 3
## month per "line"
pL=${3:-4}
## amount of desired "lines"
nL=${4:-3}

for line in $(seq 0 $(( nL-1 )))
do
	tmpDir=$(mktemp -d)
	for col in $(seq 0 $(( pL-1 )))
	do
		offset=$(( (line * pL) + col ))
		oM=$(( offset + startM ))
		ncal -bMh -m $(( ( (oM-1) % 12 ) + 1 )) $(( startY + ( oM / 12 ) )) > "${tmpDir}/${line}-${col}.cal"
	done
	(cd "${tmpDir}" && paste $(ls -v))

done
