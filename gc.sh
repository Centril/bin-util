#!/bin/sh

first="$1"
shift
git commit -m "$first" "$@"