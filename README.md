1. extract an iso:

	`./extract-iso.sh /path/to/iso/file.iso`

2. `cp preseed.cfg.example preseed.cfg`, customize iso and preseed.cfg file

3. build the custom iso:

	`./build-iso.sh`

# info
preseed installation doc: http://www.debian.org/releases/stable/s390/apb.html

the `preseed.cfg.example` file is a copy of http://www.debian.org/releases/squeeze/example-preseed.txt
