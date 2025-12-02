---
title: Best Practices for running Linux on Hyper-V
description: Provides recommendations and best practices for running Linux on a virtual machine on Hyper-V in Windows Server.
ms.topic: best-practice
ms.author: roharwoo
author: robinharwood
ms.date: 02/19/2025
---
# Best Practices for running Linux on Hyper-V

This article has a list of recommendations for running Linux virtual machine on Hyper-V.

## Tuning Linux File Systems on Dynamic VHDX Files

Some Linux file systems may consume significant amounts of real disk space even when the file system is mostly empty. To reduce the amount of real disk space usage of dynamic VHDX files, consider the following recommendations:

* When creating the VHDX, use 1 MB BlockSizeBytes (from the default 32 MB) in PowerShell, for example:

```Powershell
PS > New-VHD -Path C:\MyVHDs\test.vhdx -SizeBytes 127GB -Dynamic -BlockSizeBytes 1MB
```

* The ext4 format is preferred to ext3 because ext4 is more space efficient than ext3 when used with dynamic VHDX files.

* When creating the filesystem specify the number of groups to be 4096, for example:

```bash
# mkfs.ext4 -G 4096 /dev/sdX1

```

## Grub Menu Timeout on Generation 2 Virtual Machines

Because legacy hardware was removed from emulation in Generation 2 virtual machines, the grub menu timer counts down too quickly for the grub menu to be displayed, immediately loading the default entry. Until grub is fixed to use the EFI-supported timer, modify **/boot/grub/grub.conf**, /**etc/default/grub**, or equivalent to have **"timeout=100000"** instead of the default **"timeout=5"**.

## PxE Boot on Generation 2 Virtual Machines

Because the PIT timer isn't present in Generation 2 Virtual Machines, network connections to the PxE TFTP server are terminated and prevent the bootloader from reading Grub configuration and loading a kernel from the server.

On RHEL 6.x, the legacy grub v0.97 EFI bootloader can be used instead of grub2 as described here: [https://access.redhat.com/documentation/Red_Hat_Enterprise_Linux/6/html/Installation_Guide/s1-netboot-pxe-config-efi.html](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/installation_guide/s1-netboot-pxe-config-efi)

On Linux distributions other than RHEL 6.x, similar steps can be followed to configure grub v0.97 to load Linux kernels from a PxE server.

Additionally, on RHEL/CentOS 6.6 keyboard and mouse input don't work with the preinstalled kernel which prevents specifying installation options in the menu. A serial console must be configured to allow choosing installation options.

* In the **efidefault** file on the PxE server, add the following kernel parameter **"console=ttyS1"**

* On the VM in Hyper-V, set up a COM port using this PowerShell cmdlet:

```Powershell
Set-VMComPort -VMName <Name> -Number 2 -Path \\.\pipe\dbg1
```

Specifying a kickstart file to the kernel would also avoid the need for keyboard and mouse input during installation.

## Use static MAC addresses with failover clustering

Linux virtual machines deployed using failover clustering should be configured with a static media access control (MAC) address for each virtual network adapter. In some versions of Linux, the networking configuration may be lost after failover because a new MAC address is assigned to the virtual network adapter. To avoid losing the network configuration, ensure that each virtual network adapter has a static MAC address. You can configure the MAC address by editing the settings of the virtual machine in Hyper-V Manager or Failover Cluster Manager.

## Use Hyper-V-specific network adapters, not the legacy network adapter

Configure and use the virtual Ethernet adapter, which is a Hyper-V-specific network card with enhanced performance. If both legacy and Hyper-V-specific network adapters are attached to a virtual machine, the network names in the output of **ifconfig -a** might show random values such as **_tmp12000801310**. To avoid this issue, remove all legacy network adapters when using Hyper-V-specific network adapters in a Linux virtual machine.

> [!IMPORTANT]
> Hyper-V supports up to 64 virtual Ethernet adapters per guest. In some Linux guest configurations, the maximum number of virtual Ethernet adapters may be less than 64. For more information about Hyper-V scale limits see: [Hyper-V maximum scale limits in Windows Server](maximum-scale-limits.md)

## Use I/O scheduler noop/none for better disk I/O performance

The Linux kernel offers two sets of disk I/O schedulers to reorder requests.  One set is for the older 'blk' subsystem and one set is for the newer 'blk-mq' subsystem. In either case, with today’s solid state disks it's recommended to use a scheduler that passes the scheduling decisions to the underlying Hyper-V hypervisor. For Linux kernels using the 'blk' subsystem, this is the "noop" scheduler. For Linux kernels using the 'blk-mq' subsystem, this is the "none" scheduler.

For a particular disk, the available schedulers can be seen at this file system location: /sys/class/block/`<diskname>`/queue/scheduler, with the currently selected scheduler in square brackets. You can change the scheduler by writing to this file system location. The change must be added to an initialization script in order to persist across reboots. Consult your Linux distro documentation for details.

## NUMA

Linux kernel versions earlier than 2.6.37 don't support NUMA on Hyper-V with larger VM sizes. This issue primarily impacts older distributions using the upstream Red Hat 2.6.32 kernel, and was fixed in Red Hat Enterprise Linux (RHEL) 6.6 (kernel-2.6.32-504). Systems running custom kernels older than 2.6.37, or RHEL-based kernels older than 2.6.32-504 must set the boot parameter `numa=off` on the kernel command line in grub.conf. For more information, see [Red Hat KB 436883](https://access.redhat.com/solutions/436883).

## Reserve more memory for kdump

In case the dump capture kernel ends up with a panic on boot, reserve more memory for the kernel. For example, change the parameter **crashkernel=384M-:128M** to **crashkernel=384M-:256M** in the Ubuntu grub configuration file.

## Shrinking VHDX or expanding VHD and VHDX files can result in erroneous GPT partition tables

Hyper-V allows shrinking virtual disk (VHDX) files without regard for any partition, volume, or file system data structures that may exist on the disk. If the VHDX is shrunk to where the end of the VHDX comes before the end of a partition, data is lost, that partition can become corrupt, or invalid data is returned when the partition is read.

After resizing a VHD or VHDX, administrators should use a utility like fdisk or parted to update the partition, volume, and file system structures to reflect the change in the size of the disk. Shrinking or expanding the size of a VHD or VHDX that has a GUID Partition Table (GPT) causes a warning when a partition management tool is used to check the partition layout, and the administrator is warned to fix the first and secondary GPT headers. This manual step is safe to perform without data loss.

## Related content

* [Supported Linux and FreeBSD virtual machines for Hyper-V on Windows](Supported-Linux-and-FreeBSD-virtual-machines-for-Hyper-V-on-Windows.md)

* [Best practices for running FreeBSD on Hyper-V](Best-practices-for-running-FreeBSD-on-Hyper-V.md)

* [Create Linux Images for Azure](/azure/virtual-machines/linux/create-upload-generic)

* [Optimize your Linux VM on Azure](/azure/virtual-machines/linux/optimization)
