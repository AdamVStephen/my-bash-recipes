#!/usr/bin/env bash
set -x
echo "Download, configure, compile a basic raspberry pi image using yocto"
echo "You need plenty of disk space for this."
echo "As of 2020-05-22 choosing to use the dunfell branch 3.1 April 2020"
echo "We assume the system has been configured in terms of prerequisite software."
echo "my-bash-recipes intentionally excludes package installation and setup"
#
#
echo "Preferred standard execution of this script is "
echo "./yocto-poky-rpi.sh | tee yocto-poky-rpi-basic-dunfell-\$(date \"+%Y-%m-%d@%H:%M:%S\").log 2>&1"
###
t0=$(date "+%s")
mkdir -p yocto-rpi-basic-dunfell && cd yocto-rpi-basic-dunfell
# On lin-css-kphd-0001 cannot access git: protocol but can use https
# git clone git://git.yoctoproject.org/poky && cd poky
git clone https://git.yoctoproject.org/git/poky && cd poky
# git clone https://gitlab.com/yoctoproject/poky.git && cd poky
export POKYTOPLEVEL=$(realpath $PWD)
git checkout dunfell
echo "Pull down the raspberry pi layer"
#git clone git://git.yoctoproject.org/meta-raspberrypi && cd meta-raspberrypi && git checkout dunfell & cd ../
git clone https://git.yoctoproject.org/git/meta-raspberrypi && cd meta-raspberrypi && git checkout dunfell & cd ../
pwd
echo "Create a build directory"
source oe-init-build-env rpi-dunfell-build 
echo "Update the default build target"
sed -i -e "s/qemux86-64/raspberrypi/g" conf/local.conf
echo "Append the meta-raspberrypi layer to the bblayers.conf file"
export PIMETA=$(realpath ${POKYTOPLEVEL}/meta-raspberrypi)
sed -i -e "/bsp/a ${PIMETA} \\" conf/bblayers.conf
###
### The next step can take a lot of time, resource ,disk, network
###
t1=$(date "+%s")
bitbake rpi-basic-image
t2=$(date "+%s")
preptime=$(expr $t1 - $t0)
comptime=$(expr $t2 - $t1)
tottime=$(expr $t2 - $t0)
printf "Prep %5d seconds\nComp %5d seconds\nAll  %d seconds\n" $preptime $comptime $tottime

