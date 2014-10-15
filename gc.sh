#!/bin/sh

if [ ${1:0:1} == "-" ]
then
	git commit $@
else
	first="$1"
	shift
	git commit -m "$first" $@
fi