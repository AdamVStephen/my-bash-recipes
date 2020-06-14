#!/usr/bin/env bash
# Buildroot minimal demo.
# Collated from 
# 1. Manuals at https://bootlin.com/doc/training/buildroot/buildroot-slides.pdf
# 2. Article http://pressreset.net/2013/09/buildroot-and-qemu-the-quickest-receipe-for-your-own-linux/
#
# Tested on Ubuntu 18.04 2020-06-14 using kernel 5.6
git clone git://git.buildroot.net/buildroot
cd buildroot && git checkout 2020.05 && cd ..
mkdir br-minimal-arm && cd $_
make -C ../buildroot O=$(pwd) qemu_arm_versatile_defconfig
make
# Create a driver script
cat > run-qemu.sh <<EndOfQemuFile
qemu-system-arm -M versatilepb -kernel images/zImage -dtb images/versatile-pb.dtb -drive file=images/rootfs.ext2,if=scsi -append "root=/dev/sda console=ttyAMA0,115200" -nographic
EndOfQemuFile
