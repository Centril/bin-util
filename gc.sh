#!/bin/bash

msg=0
if [ ${1:0:1} != "-" ] ; then
	msg="$1"
	shift
fi

push=0
ARGS=()
for var in "$@"
do
	if [[ $var == '-ps' ]] ; then
		push=1
	else
		ARGS+=($var)
	fi
done

if [[ $msg == 0 ]] ; then
	git commit ${ARGS[*]}
else
	git commit -m "$msg" ${ARGS[*]}
fi

if [[ $push == 1 ]] ; then
	git push
fi