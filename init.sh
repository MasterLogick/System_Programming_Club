#!/bin/bash
BASEDIR=$(pwd)
MACHINE_NAME="SPC"
vboxmanage createvm --basefolder $BASEDIR --ostype Other --name $MACHINE_NAME --register
vboxmanage storagectl $MACHINE_NAME --name SATA --add sata --controller IntelAhci --portcount 1 --bootable on