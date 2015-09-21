#!/bin/sh

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

echo $msg
echo $push
echo "${ARGS[*]}"

if [ $msg -eq 0 ] ; then
	git commit ${ARGS[*]}
else
	git commit -m "$msg" ${ARGS[*]}
fi

if [ $push -eq 1 ] ; then
	git push
fi