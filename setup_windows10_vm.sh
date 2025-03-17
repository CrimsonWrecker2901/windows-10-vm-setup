#!/bin/bash

# Variables
VM_NAME="Windows10"
ISO_PATH="/path/to/Windows10.iso"  # Update this path to your Windows 10 ISO location
VBOX_FOLDER="/path/to/virtualbox/vms"  # Update to your desired VM storage path

# Create a new VirtualBox VM
VBoxManage createvm --name "$VM_NAME" --ostype "Windows10_64" --register --basefolder "$VBOX_FOLDER"

# Set VM memory and CPU settings
VBoxManage modifyvm "$VM_NAME" --memory 4096 --cpus 2 --nic1 nat

# Create a virtual hard disk
VBoxManage createmedium disk --filename "$VBOX_FOLDER/$VM_NAME/$VM_NAME.vdi" --size 50000 --format VDI

# Attach the hard disk to the VM
VBoxManage storagectl "$VM_NAME" --name "SATA Controller" --add sata --controller IntelAhci
VBoxManage storageattach "$VM_NAME" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$VBOX_FOLDER/$VM_NAME/$VM_NAME.vdi"

# Attach the Windows 10 ISO
VBoxManage storageattach "$VM_NAME" --storagectl "SATA Controller" --port 1 --device 0 --type dvddrive --medium "$ISO_PATH"

# Start the VM
VBoxManage startvm "$VM_NAME" --type headless
