#!/usr/bin/env bash
#
# Just for fun
echo "TO FIX : THis example from tldp.org does not work."
exit 1
E_BADARGS=85
if [ -z "$1" ]
then
echo "Usage $(basename $0) filename : creates filename from template"
exit ${E_BADARGS}
fi

TARGETFILE=$1
vi ${TARGETFILE} <<EndOfVimCommands
i
This is the first line.
This is the second line.
This is the third line.

ZZ
EndOfVimCommands

exit
