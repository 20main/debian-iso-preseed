1. `git clone git://github.com/20main/debian-iso-preseed.git`

2. `cd debian-iso-preseed`

3. extract an iso:

	`./extract-iso.sh /path/to/iso/file.iso`

4. customize iso and preseed.cfg file

5. build the custom iso:

	`./build-iso.sh`

#
preseed installation doc: http://www.debian.org/releases/stable/s390/apb.html

the `preseed.cfg` file is a copy of http://www.debian.org/releases/squeeze/example-preseed.txt
