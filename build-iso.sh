#!/bin/bash
#
# Copyright (c) 2011, 20main@github.com
# All rights reserved.
#
# Chicken Dance License v0.2
# http://supertunaman.com/cdl/
#

[ -f "iso_dir_name" ] || { echo "ERROR: Well, not sure that iso is extracted..."; exit 1; }

sourcedir="$(cat iso_dir_name)"
[ -d "${sourcedir}" ] || { echo "ERROR: ${sourcedir} directory is missing."; exit 1; }
[ -f "preseed.cfg" ] || { echo "ERROR: preseed.cfg file is missing."; exit 1; }
[ -d "initrd" ] && sudo rm -rf initrd
 
# check architecture (amd64 and i386 only...)
if [ -d "${sourcedir}/install.amd" ]; then
	installdir="install.amd"
elif [ -d "${sourcedir}/install.386" ]; then
	installdir="install.386"
else
	echo "ERROR: Architecture not supported."; exit 1
fi

# dependency
which mkisofs > /dev/null || sudo aptitude install mkisofs

# extract initrd.gz somewhere else
mkdir initrd; cd initrd
gunzip -c ../${sourcedir}/${installdir}/initrd.gz | sudo cpio -id

# build a new initrd.gz including preseed.cfg
cp ../preseed.cfg .
find . | sudo cpio --create --format='newc' | gzip  > ../initrd.gz
mv ../initrd.gz ../${sourcedir}/${installdir}/

# prepare and build iso
cd ../${sourcedir}
md5sum $(find -type f ! -name "md5sum.txt" ! -path "./isolinux/*" ! -name "debian") > md5sum.txt
cd ..
chmod -R u-w ${sourcedir}
sudo mkisofs -o ${sourcedir}_custom.iso \
	-V di$(date -u +%m%d%H%M%S) \
	-r -J -no-emul-boot -boot-load-size 4 -boot-info-table \
	-b isolinux/isolinux.bin -c isolinux/boot.cat \
	${sourcedir}

# some cleaning
sudo rm -rf initrd
chmod -R u+w ${sourcedir}
me=$(id -u)
sudo chown ${me}:${me} ${sourcedir}_custom.iso

echo "Custom iso created: ${sourcedir}_custom.iso"

