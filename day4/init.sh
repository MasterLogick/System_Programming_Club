#!/bin/bash
BASEDIR=$(pwd)
MACHINE_NAME="SPC2"
BUILD_DIR="out"
BINARY_IMAGE="boot.img"
vboxmanage createvm --basefolder $BASEDIR --ostype Other --name $MACHINE_NAME --register
vboxmanage storagectl $MACHINE_NAME --name SATA --add sata --controller IntelAhci --portcount 1 --bootable on
make extract_image
vboxmanage convertfromraw $BUILD_DIR/$BINARY_IMAGE $MACHINE_NAME/$MACHINE_NAME.vdi --format VDI
vboxmanage storageattach $MACHINE_NAME --storagectl SATA --port 1 --type hdd --medium $MACHINE_NAME/$MACHINE_NAME.vdi
