---
title: Best Practices for running Linux on Hyper-V
description: "Provides recommendations for running Linux on a virtual machine"
ms.prod: windows-server-threshold
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a08648eb-eea0-4e2b-87fb-52bfe8953491
author: shirgall
ms.author: kathydav
ms.date: 10/17/2016
---
# Best Practices for running Linux on Hyper-V

>Applies To: Windows Server 2016, Hyper-V Server 2016, Windows Server 2012 R2, Hyper-V Server 2012 R2, Windows Server 2012, Hyper-V Server 2012, Windows Server 2008 R2, Windows 10, Windows 8.1, Windows 8, Windows 7.1, Windows 7

This topic contains a list of recommendations for running Linux virtual machine on Hyper-V.

## Tuning Linux File Systems on Dynamic VHDX Files

Some Linux file systems may consume significant amounts of real disk space even when the file system is mostly empty. To reduce the amount of real disk space usage of dynamic VHDX files, consider the following recommendations:

* When creating the VHDX, use 1MB BlockSizeBytes (from the default 32MB) in PowerShell, for example:

```Powershell
PS > New-VHD -Path C:\MyVHDs\test.vhdx -SizeBytes 127GB -Dynamic -BlockSizeBytes 1MB
```

* The ext4 format is preferred to ext3 because ext4 is more space efficient than ext3 when used with dynamic VHDX files.

* When creating the filesystem specify the number of groups to be 4096, for example:

```bash
# mkfs.ext4 -G 4096 /dev/sdX1

```

## Grub Menu Timeout on Generation 2 Virtual Machines

Because of legacy hardware being removed from emulation in Generation 2 virtual machines, the grub menu countdown timer counts down too quickly for the grub menu to be displayed, immediately loading the default entry. Until grub is fixed to use the EFI-supported timer, modify **/boot/grub/grub.conf**, /**etc/default/grub**, or equivalent to have "timeout=100000" instead of the default "timeout=5".

## PxE Boot on Generation 2 Virtual Machines

Because the PIT timer is not present in Generation 2 Virtual Machines, network connections to the PxE TFTP server can be prematurely terminated and prevent the bootloader from reading Grub configuration and loading a kernel from the server.

On RHEL 6.x, the legacy grub v0.97 EFI bootloader can be used instead of grub2 as described here: [https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Installation_Guide/s1-netboot-pxe-config-efi.html](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Installation_Guide/s1-netboot-pxe-config-efi.html)

On Linux distributions other than RHEL 6.x, similar steps can be followed to configure grub v0.97 to load Linux kernels from a PxE server.

Additionally, on RHEL/CentOS 6.6 keyboard and mouse input will not work with the pre-install kernel which prevents specifying installation options in the menu. A serial console must be configured to allow choosing installation options.

* In the **efidefault** file on the PxE server, add the following kernel parameter **"console=ttyS1"**

* On the VM in Hyper-V, setup a COM port using this PowerShell cmdlet:

```Powershell
Set-VMComPort -VMName <Name> -Number 2 -Path \\.\pipe\dbg1

```

Specifying a kickstart file to the pre-install kernel would also avoid the need for keyboard and mouse input during installation.

## Use static MAC addresses with failover clustering

Linux virtual machines that will be deployed using failover clustering should be configured with a static media access control (MAC) address for each virtual network adapter. In some versions of Linux, the networking configuration may be lost after failover because a new MAC address is assigned to the virtual network adapter. To avoid losing the network configuration, ensure that each virtual network adapter has a static MAC address. You can configure the MAC address by editing the settings of the virtual machine in Hyper-V Manager or Failover Cluster Manager.

## Use Hyper-V-specific network adapters, not the legacy network adapter

Configure and use the virtual Ethernet adapter, which is a Hyper-V-specific network card with enhanced performance. If both legacy and Hyper-V-specific network adapters are attached to a virtual machine, the network names in the output of **ifconfig -a** might show random values such as **_tmp12000801310**. To avoid this issue, remove all legacy network adapters when using Hyper-V-specific network adapters in a Linux virtual machine.

## Use I/O scheduler NOOP for better disk I/O performance

The Linux kernel has four different I/O schedulers to reorder requests with different algorithms. NOOP is a first-in first-out queue that passes the schedule decision to be made by the hypervisor. It is recommended to use NOOP as the scheduler when running Linux virtual machine on Hyper-V. To change the scheduler for a specific device, in the boot loader's configuration (/etc/grub.conf, for example), add **elevator=noop** to the kernel parameters, and then restart.

## Add "numa=off" if the Linux virtual machine has more than 7 virtual processors or more than 30 GB RAM

Linux virtual machines configured to use more than 7 virtual processors should add **numa=off** to the GRUB boot.cfg to work around a known issue in the 2.6.x Linux kernels. Linux virtual machines configured to use more than 30 GB RAM should also add **numa=off** to the GRUB boot.cfg.

## Reserve more memory for kdump

In case the dump capture kernel ends up with a panic on boot, reserve more memory for the kernel. For example, change the parameter **crashkernel=384M-:128M** to **crashkernel=384M-:256M** in the Ubuntu grub configuration file.

## Shrinking VHDX or expanding VHD and VHDX files can result in erroneous GPT partition tables

Hyper-V allows shrinking virtual disk (VHDX) files without regard for any partition, volume, or file system data structures that may exist on the disk. If the VHDX is shrunk to where the end of the VHDX comes before the end of a partition, data can be lost, that partition can become corrupted, or invalid data can be returned when the partition is read.

After resizing a VHD or VHDX, administrators should use a utility like fdisk or parted to update the partition, volume, and file system structures to reflect the change in the size of the disk. Shrinking or expanding the size of a VHD or VHDX that has a GUID Partition Table (GPT) will cause a warning when a partition management tool is used to check the partition layout, and the administrator will be warned to fix the first and secondary GPT headers. This manual step is safe to perform without data loss.

## See also

* [Supported Linux and FreeBSD virtual machines for Hyper-V on Windows](Supported-Linux-and-FreeBSD-virtual-machines-for-Hyper-V-on-Windows.md)

* [Best practices for running FreeBSD on Hyper-V](Best-practices-for-running-FreeBSD-on-Hyper-V.md)

* [Deploy a Hyper-V Cluster](https://technet.microsoft.com/library/jj863389.aspx)