---
title: Supported Ubuntu virtual machines on Hyper-V
description: Lists the Ubuntu/Linux integration services and features included in each version
ms.topic: article
ms.assetid: 95ea5f7c-25c6-494b-8ffd-2a77f631ee94
ms.author: benarm
author: BenjaminArmstrong
ms.date: 01/08/2021
---
# Supported Ubuntu virtual machines on Hyper-V

>Applies To: Azure Stack HCI, version 20H2; Windows Server 2019, Hyper-V Server 2019, Windows Server 2016, Hyper-V Server 2016, Windows Server 2012 R2, Hyper-V Server 2012 R2, Windows 10, Windows 8.1

The following feature distribution map indicates the features in each version. The known issues and workarounds for each distribution are listed after the table.

## Table legend

* **Built in** - LIS are included as part of this Linux distribution. The Microsoft-provided LIS download package doesn't work for this distribution, so don't install it. The kernel module version numbers for the built in LIS (as shown by **lsmod**, for example) are different from the version number on the Microsoft-provided LIS download package. A mismatch doesn't indicate that the built in LIS is out of date.

* &#10004; - Feature available

* (*blank*) - Feature not available

|**Feature**|**Windows Server operating system version**|**20.04 LTS**|**18.04 LTS**|**16.04 LTS**|**14.04 LTS**|
|-|-|-|-|-|-|
|**Availability**||Built-in|Built-in|Built-in|Built-in|
|**[Core](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#core)**|2019, 2016, 2012 R2|&#10004;|&#10004;|&#10004;|&#10004;|
|Windows Server 2016 Accurate Time|2019, 2016|&#10004;|&#10004;|&#10004;||
|**[Networking](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#networking)**||||||
|Jumbo frames|2019, 2016, 2012 R2|&#10004;|&#10004;|&#10004;|&#10004;|
|VLAN tagging and trunking|2019, 2016, 2012 R2|&#10004;|&#10004;|&#10004;|&#10004;|
|Live migration|2019, 2016, 2012 R2|&#10004;|&#10004;|&#10004;|&#10004;|
|Static IP Injection|2019, 2016, 2012 R2|&#10004; Note 1|&#10004; Note 1|&#10004; Note 1|&#10004; Note 1|
|vRSS|2019, 2016, 2012 R2|&#10004;|&#10004;|&#10004;|&#10004;|
|TCP Segmentation and Checksum Offloads|2019, 2016, 2012 R2|&#10004;|&#10004;|&#10004;|&#10004;|
|SR-IOV|2019, 2016|&#10004;|&#10004;|&#10004;||
|**[Storage](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#storage)**|||||
|VHDX resize|2019, 2016, 2012 R2|&#10004;|&#10004;|&#10004;|&#10004;|
|Virtual Fibre Channel|2019, 2016, 2012 R2|&#10004; Note 2|&#10004; Note 2|&#10004; Note 2|&#10004; Note 2|
|Live virtual machine backup|2019, 2016, 2012 R2|&#10004; Note 3, 4, 5|&#10004; Note 3, 4, 5|&#10004; Note 3, 4, 5|&#10004; Note 3, 4, 5|
|TRIM support|2019, 2016, 2012 R2|&#10004;|&#10004;|&#10004;|&#10004;|
|SCSI WWN|2019, 2016, 2012 R2|&#10004;|&#10004;|&#10004;|&#10004;|
|**[Memory](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#memory)**|||||
|PAE Kernel Support|2019, 2016, 2012 R2|&#10004;|&#10004;|&#10004;|&#10004;|
|Configuration of MMIO gap|2019, 2016, 2012 R2|&#10004;|&#10004;|&#10004;|&#10004;|
|Dynamic Memory - Hot-Add|2019, 2016, 2012 R2|&#10004; Note 6, 7, 8|&#10004; Note 6, 7, 8|&#10004; Note 6, 7, 8|&#10004; Note 6, 7, 8|
|Dynamic Memory - Ballooning|2019, 2016, 2012 R2|&#10004; Note 6, 7, 8|&#10004; Note 6, 7, 8|&#10004; Note 6, 7, 8|&#10004; Note 6, 7, 8|
|Runtime Memory Resize|2019, 2016|&#10004;|&#10004;|&#10004;|&#10004;|
|**[Video](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#video)**||||||
|Hyper-V specific video device|2019, 2016, 2012 R2|&#10004;|&#10004;|&#10004;|&#10004;|
|**[Miscellaneous](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#miscellaneous)**|||||
|Key/value pair|2019, 2016, 2012 R2|&#10004; Note 5, 9|&#10004; Note 5, 9|&#10004; Note 5, 9|&#10004; Note 5, 9|
|Non-Maskable Interrupt|2019, 2016, 2012 R2|&#10004;|&#10004;|&#10004;|&#10004;|
|File copy from host to guest|2019, 2016, 2012 R2|&#10004;|&#10004;|&#10004;|&#10004;|
|lsvmbus command|2019, 2016, 2012 R2|&#10004;|&#10004;|&#10004;|&#10004;|
|Hyper-V Sockets|2019, 2016|&#10004;|&#10004;|&#10004;|&#10004;|
|PCI Passthrough/DDA|2019, 2016|&#10004;|&#10004;|&#10004;|&#10004;|
|**[Generation 2 virtual machines](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#generation-2-virtual-machines)**|||||
|Boot using UEFI|2019, 2016, 2012 R2|&#10004; Note 10, 11|&#10004; Note 10, 11|&#10004; Note 10, 11|&#10004; Note 10, 11|
|Secure boot|2019, 2016|&#10004;|&#10004;|&#10004;|&#10004;|

## Notes

1. Static IP injection may not work if **Network Manager** has been configured for a given Hyper-V-specific network adapter on the virtual machine. To ensure smooth functioning of static IP injection please ensure that Network Manager is turned off completely or has been turned off for a specific network adapter through its **ifcfg-ethX** file.

2. While using virtual fiber channel devices, ensure that logical unit number 0 (LUN 0) has been populated. If LUN 0 has not been populated, a Linux virtual machine might not be able to mount fiber channel devices natively.

3. If there are open file handles during a live virtual machine backup operation, then in some corner cases, the backed-up VHDs might have to undergo a file system consistency check (`fsck`) on restore.

4. Live backup operations can fail silently if the virtual machine has an attached iSCSI device or direct-attached storage (also known as a pass-through disk).

5. On long term support (LTS) releases use latest virtual Hardware Enablement (HWE) kernel for up to date Linux Integration Services.

   To install the Azure-tuned kernel on 16.04, 18.04 and 20.04, run the following commands as root (or sudo):

   ```bash
   # apt-get update
   # apt-get install linux-azure
   ```
6. Dynamic memory support is only available on 64-bit virtual machines.

7. Dynamic Memory operations can fail if the guest operating system is running too low on memory. The following are some best practices:

   * Startup memory and minimal memory should be equal to or greater than the amount of memory that the distribution vendor recommends.

   * Applications that tend to consume the entire available memory on a system are limited to consuming up to 80 percent of available RAM.

8. If you are using Dynamic Memory on Windows Server 2019, Windows Server 2016 or Windows Server 2012/2012 R2 operating systems, specify **Startup memory**, **Minimum memory**, and **Maximum memory** parameters in multiples of 128 megabytes (MB). Failure to do so can lead to Hot-Add failures, and you might not see any memory increase on a guest operating system.

9. In Windows Server 2019, Windows Server 2016 or Windows Server 2012 R2, the key/value pair infrastructure might not function correctly without a Linux software update. Contact your distribution vendor to obtain the software update in case you see problems with this feature.

10. On Windows Server 2012 R2, Generation 2 virtual machines have secure boot enabled by default and some Linux virtual machines will not boot unless the secure boot option is disabled. You can disable secure boot in the **Firmware** section of the settings for the virtual machine in **Hyper-V Manager** or you can disable it using Powershell:

    ```Powershell
    Set-VMFirmware -VMName "VMname" -EnableSecureBoot Off
    ```

11. Before attempting to copy the VHD of an existing Generation 2 VHD virtual machine to create new Generation 2 virtual machines, follow these steps:

    1. Log in to the existing Generation 2 virtual machine.

    2. Change directory to the boot EFI directory:

       ```bash
       # cd /boot/efi/EFI
       ```

    3. Copy the ubuntu directory in to a new directory named boot:

       ```bash
       # sudo cp -r ubuntu/ boot
       ```

    4. Change directory to the newly created boot directory:

       ```bash
       # cd boot
       ```

    5. Rename the shimx64.efi file:

       ```bash
       # sudo mv shimx64.efi bootx64.efi
       ```

## See Also

* [Supported CentOS and Red Hat Enterprise Linux virtual machines on Hyper-V](Supported-CentOS-and-Red-Hat-Enterprise-Linux-virtual-machines-on-Hyper-V.md)

* [Supported Debian virtual machines on Hyper-V](Supported-Debian-virtual-machines-on-Hyper-V.md)

* [Supported Oracle Linux virtual machines on Hyper-V](Supported-Oracle-Linux-virtual-machines-on-Hyper-V.md)

* [Supported SUSE virtual machines on Hyper-V](Supported-SUSE-virtual-machines-on-Hyper-V.md)

* [Feature Descriptions for Linux and FreeBSD virtual machines on Hyper-V](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md)

* [Best Practices for running Linux on Hyper-V](Best-Practices-for-running-Linux-on-Hyper-V.md)

* [Set-VMFirmware](/powershell/module/hyper-v/set-vmfirmware)

* [Ubuntu 14.04 in a Generation 2 VM - Ben Armstrong's Virtualization Blog](/archive/blogs/virtual_pc_guy/ubuntu-14-04-in-a-generation-2-vm)
