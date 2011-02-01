#!/bin/sh

. ./grade-functions.sh

$make

pts=10

# test1
echo '\nhw2-test1\n' > xv6.in
runtest "hw2-test1" "xv6.in" "xv6.out" 5
if grep 'hw2-test1 succeed' xv6.out > /dev/null
then
	pass
else
	fail
fi

showpart A

pts=5

showpart B

showfinal

