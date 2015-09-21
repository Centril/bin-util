#!/bin/sh

add="$1"
msg="$2"
shift
shift

git add -A $add
git status -sb
git commit -m "$msg" $@