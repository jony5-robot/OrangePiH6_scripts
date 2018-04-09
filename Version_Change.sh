#!/bin/bash
set -e
########################################
##
## Change different platform
########################################
if [ -z $ROOT ]; then
	export ROOT=`cd .. && pwd`
fi

if [ -z $1 ]; then
	PLATFORM="OrangePiH6_OnePlus"
else
	PLATFORM=$1
fi

VERSION=$ROOT/scripts/version
# Create Version state file
if [ ! -f $VERSION ]; then
	echo "$PLATFORM" > $VERSION
fi
OLD_PLATFORM=`cat $VERSION`
./Version_check.sh "$OLD_PLATFORM"

if [ $PLATFORM = $OLD_PLATFORM ]; then
	exit 0
else
	rm -f $ROOT/external/sys_config.fex
	rm -f $ROOT/kernel/.config
	rm -f $ROOT/uboot/include/configs/sun50iw6p1.h

	./Version_check.sh "$PLATFORM"

	echo "$PLATFORM" > $VERSION
fi 
