#!/bin/bash

OUTDIR=out/target/product/tiny4412
AHOSTBIN=out/host/linux-x86/bin

# install vendor files
if [ -d vendor/friendly-arm/tiny4412/rootdir/system/ ]; then
	cp -af vendor/friendly-arm/tiny4412/rootdir/system/* ${OUTDIR}/system/
fi
if [ -d vendor/friendly-arm/tiny4412/rootdir/data/ ]; then
	cp -af vendor/friendly-arm/tiny4412/rootdir/data/*   ${OUTDIR}/data/
fi

# make images
LOPTS="-T -1 -S ${OUTDIR}/root/file_contexts"
${AHOSTBIN}/make_ext4fs -s ${LOPTS} -l 629145600 -a system system.img ${OUTDIR}/system

# eMMC Size | UserData partition Size
#------------------------------------------------
#        4G |  2149580800  (2G)  2050*1024*1024
#        8G |  4299161600  (4G)
#       16G | 10747904000 (10G) 10250*1024*1024
#------------------------------------------------
${AHOSTBIN}/make_ext4fs -s ${LOPTS} -l  2149580800 -a data userdata-4g.img  ${OUTDIR}/data
${AHOSTBIN}/make_ext4fs -s ${LOPTS} -l  4299161600 -a data userdata-8g.img  ${OUTDIR}/data
${AHOSTBIN}/make_ext4fs -s ${LOPTS} -l 10485760000 -a data userdata-16g.img ${OUTDIR}/data
cp userdata-4g.img userdata.img

# ramdisk
${AHOSTBIN}/mkbootfs ${OUTDIR}/root | ${AHOSTBIN}/minigzip > ${OUTDIR}/ramdisk.img
mkimage -A arm -O linux -T ramdisk -C none -a 0x40800000 -n "ramdisk" \
		-d ${OUTDIR}/ramdisk.img ramdisk-u.img

# minitools support
MINITOOLS_PATH=/opt/MiniTools/tiny4412/images/Android5.0
if [ -d ${MINITOOLS_PATH} ]; then
	cp -f ramdisk-u.img ${MINITOOLS_PATH}/
	cp -f system.img ${MINITOOLS_PATH}/
	cp -f userdata*.img ${MINITOOLS_PATH}/
	ls -l ${MINITOOLS_PATH}/ramdisk-u.img
	ls -l ${MINITOOLS_PATH}/system.img
	ls -l ${MINITOOLS_PATH}/userdata*.img
fi

