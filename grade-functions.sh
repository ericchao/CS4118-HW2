#
# Scoring
#

pts=5
part=0
partpos=0
total=0
totalpos=0

showpart () {
	echo "Part $1 score: $part/$partpos"
	echo
	total=`expr $total + $part`
	totalpos=`expr $totalpos + $partpos`
	part=0
	partpos=0
}

showfinal () {
	total=`expr $total + $part`
	totalpos=`expr $totalpos + $partpos`
	echo "Score: $total/$totalpos"
	if [ $total -lt $totalpos ]; then
		exit 1
	fi
}

passfailmsg () {
	msg="$1"
	shift
	if [ $# -gt 0 ]; then
		msg="$msg,"
	fi

	t1=`date +%s.%N 2>/dev/null`
	time=`echo "scale=1; ($t1-$t0)/1" | sed 's/.N/.0/g' | bc 2>/dev/null`

	echo $msg "$@" "(${time}s)"
}

pass () {
	passfailmsg OK "$@"
	part=`expr $part + $pts`
	partpos=`expr $partpos + $pts`
}

fail () {
	passfailmsg WRONG "$@"
	partpos=`expr $partpos + $pts`
}


#
# User tests
#

# Usage: runtest <prog name> <input file> <output file> <timeout>
runtest () {
	perl -e "print '$1: '"
	t0=`date +%s.%N 2> /dev/null`
	(
		exec $QEMU -nographic $QEMUOPTS < $2 > $3
	) > /dev/null 2> /dev/null &
	pid=$!
	sleep $4
	kill $pid > /dev/null 2>&1
}

