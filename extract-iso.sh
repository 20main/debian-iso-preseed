#!/bin/bash
#
# Copyright (c) 2001, 20main@github.com
# All rights reserved.
#
# Chicken Dance License v0.2
# http://supertunaman.com/cdl/
#

[ -z "$1" ] && { echo "missing parameter"; exit 1; }
isopath="$1"
iso_dir_name=$(echo ${isopath} | awk -F/ '{print $NF}')
basename=$(echo ${iso_dir_name} | sed "s/\.iso//")
[ -d "${basename}" ] && { echo "ERROR: ${basename} directory already exists."; exit 1; }

# dependency
which bsdtar > /dev/null || sudo aptitude install bsdtar

mkdir ${basename}
bsdtar -C ${basename} -xf ${isopath} || exit
chmod -R u+w ${basename}
echo ${basename} > iso_dir_name
echo "ISO image extracted in ${basename} directory."
