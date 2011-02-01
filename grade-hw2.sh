#!/bin/sh

. ./grade-functions.sh

$make

pts=10

echo '\nstrace\n' > xv6.in
runtest "strace" "xv6.in" "xv6.out" 5
if grep "strace succeeded!" xv6.out > /dev/null
then
	pass
else
	fail
fi

showpart A

pts=5

showpart B

showfinal

