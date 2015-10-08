#!/bin/sh

# e.sh: Opens explorer.

if [ $# -eq 0 ]
then
	explorer .
else
	explorer $@
fi