#!/bin/sh

add=$1
msg=$2
shift
shift

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

git add -A $add
git status -sb
git commit -m "$msg" ${ARGS[*]}

if [ $push -eq 1 ] ; then
	git push
fi