---
title: Supported Debian virtual machines on Hyper-V
description: "Lists the Linux integration services and features included in each version"
ms.prod: windows-server
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3cc62c10-02a3-4633-960c-23bf91a45bd5
author: shirgall
ms.author: kathydav
ms.date: 10/03/2016
---
# Supported Debian virtual machines on Hyper-V

>Applies To: Windows Server 2016, Hyper-V Server 2016, Windows Server 2012 R2, Hyper-V Server 2012 R2, Windows Server 2012, Hyper-V Server 2012, Windows Server 2008 R2, Windows 10, Windows 8.1, Windows 8, Windows 7.1, Windows 7

The following feature distribution map indicates the features that are present in each version. The known issues and workarounds for each distribution are listed after the table.

## Table legend

* **Built in** - LIS are included as part of this Linux distribution. The Microsoft-provided LIS download package doesn't work for this distribution so do not install it. The kernel module version numbers for the built in LIS (as shown by **lsmod**, for example) are different from the version number on the Microsoft-provided LIS download package. A mismatch does not indicate that the built in LIS is out of date.

* &#10004; - Feature available

* (*blank*) - Feature not available

| **Feature**                                                                                                                                  | **Windows Server operating system version** | **10.0-10.3 (buster)** | **9.0-9.12 (stretch)** | **8.0-8.11 (jessie)** | **7.0-7.11 (wheezy)** |
|----------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------|-----------------------|-----------------------|-----------------------|-----------------------|
| **Availability**                                                                                                                             |                                             | Built in              | Built in              | Built in              | Built in (Note 6)     |
| **[Core](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#core)**                                                   | 2019, 2016, 2012 R2, 2012, 2008 R2          | &#10004;              | &#10004;              | &#10004;              | &#10004;              |
| Windows Server 2016 Accurate Time                                                                                                            | 2019, 2016                                  | &#10004; Note 8       | &#10004; Note 8       |                       |                       |
| **[Networking](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#networking)**                                       |                                             |                       |                       |                       |                       |
| Jumbo frames                                                                                                                                 | 2019, 2016, 2012 R2, 2012, 2008 R2          | &#10004;              | &#10004;              | &#10004;              | &#10004;              |
| VLAN tagging and trunking                                                                                                                    | 2019, 2016, 2012 R2, 2012, 2008 R2          | &#10004;              | &#10004;              | &#10004;              | &#10004;              |
| Live Migration                                                                                                                               | 2019, 2016, 2012 R2, 2012, 2008 R2          | &#10004;              | &#10004;              | &#10004;              | &#10004;              |
| Static IP Injection                                                                                                                          | 2019, 2016, 2012 R2, 2012                   |                       |                       |                       |                       |
| vRSS                                                                                                                                         | 2019, 2016, 2012 R2                         | &#10004; Note 8       | &#10004; Note 8       |                       |                       |
| TCP Segmentation and Checksum Offloads                                                                                                       | 2019, 2016, 2012 R2, 2012, 2008 R2          | &#10004; Note 8       | &#10004; Note 8       |                       |                       |
| SR-IOV                                                                                                                                       | 2019, 2016                                  | &#10004; Note 8       | &#10004; Note 8       |                       |                       |
| **[Storage](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#storage)**                                             |                                             |                       |                       |                       |                       |
| VHDX resize                                                                                                                                  | 2019, 2016, 2012 R2                         | &#10004; Note 1       | &#10004; Note 1       | &#10004; Note 1       | &#10004; Note 1       |
| Virtual Fibre Channel                                                                                                                        | 2019, 2016, 2012 R2                         |                       |                       |                       |                       |
| Live virtual machine backup                                                                                                                  | 2019, 2016, 2012 R2                         | &#10004; Note 4,5     | &#10004; Note 4,5     | &#10004; Note 4,5     | &#10004; Note 4       |
| TRIM support                                                                                                                                 | 2019, 2016, 2012 R2                         | &#10004; Note 8       | &#10004; Note 8       |                       |                       |
| SCSI WWN                                                                                                                                     | 2019, 2016, 2012 R2                         | &#10004; Note 8       | &#10004; Note 8       |                       |                       |
| **[Memory](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#memory)**                                               |                                             |                       |                       |                       |                       |
| PAE Kernel Support                                                                                                                           | 2019, 2016, 2012 R2, 2012, 2008 R2          | &#10004;              | &#10004;              | &#10004;              | &#10004;              |
| Configuration of MMIO gap                                                                                                                    | 2019, 2016, 2012 R2                         | &#10004;              | &#10004;              | &#10004;              | &#10004;              |
| Dynamic Memory - Hot-Add                                                                                                                     | 2019, 2016, 2012 R2, 2012                   | &#10004; Note 8       | &#10004; Note 8       |                       |                       |
| Dynamic Memory - Ballooning                                                                                                                  | 2019, 2016, 2012 R2, 2012                   | &#10004; Note 8       | &#10004; Note 8       |                       |                       |
| Runtime Memory Resize                                                                                                                        | 2019, 2016                                  | &#10004; Note 8       | &#10004; Note 8       |                       |                       |
| **[Video](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#video)**                                                 |                                             |                       |                       |                       |                       |
| Hyper-V-specific video device                                                                                                                | 2019, 2016, 2012 R2, 2012, 2008 R2          | &#10004;              | &#10004;              | &#10004;              |                       |
| **[Miscellaneous](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#miscellaneous)**                                 |                                             |                       |                       |                       |                       |
| Key-Value Pair                                                                                                                               | 2019, 2016, 2012 R2, 2012, 2008 R2          | &#10004; Note 4       | &#10004; Note 4       | &#10004; Note 4       |                       |
| Non-Maskable Interrupt                                                                                                                       | 2019, 2016, 2012 R2                         | &#10004;              | &#10004;              | &#10004;              |                       |
| File copy from host to guest                                                                                                                 | 2019, 2016, 2012 R2                         | &#10004; Note 4       | &#10004; Note 4       | &#10004; Note 4       |                       |
| lsvmbus command                                                                                                                              | 2019, 2016, 2012 R2, 2012, 2008 R2          |                       |                       |                       |                       |
| Hyper-V Sockets                                                                                                                              | 2019, 2016                                  | &#10004; Note 8       | &#10004; Note 8       |                       |                       |
| PCI Passthrough/DDA                                                                                                                          | 2019, 2016                                  | &#10004; Note 8       | &#10004; Note 8       |                       |                       |
| **[Generation 2 virtual machines](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#generation-2-virtual-machines)** |                                             |                       |                       |                       |                       |
| Boot using UEFI                                                                                                                              | 2019, 2016, 2012 R2                         | &#10004; Note 7       | &#10004; Note 7       | &#10004; Note 7       |                       |
| Secure boot                                                                                                                                  | 2019, 2016                                  | &#10004;              |                       |                       |                       |


## <a name="BKMK_notes"></a>Notes

1. Creating file systems on VHDs larger than 2TB is not supported.

2. On Windows Server 2008 R2 SCSI disks create 8 different entries in /dev/sd*.

3. Windows Server 2012 R2 a VM with 8 cores or more will have all interrupts routed to a single vCPU.

4. Starting with Debian 8.3 the manually-installed Debian package "hyperv-daemons" contains the key-value pair, fcopy, and VSS daemons. On Debian 7.x and 8.0-8.2 the hyperv-daemons package must come from [Debian backports](https://wiki.debian.org/Backports).

5. Live virtual machine backup will not work with ext2 file systems. The default layout created by the Debian installer includes ext2 filesystems, you must customize the layout to not create this filesystem type.

6. While Debian 7.x is out of support and uses an older kernel, the kernel included in [Debian backports](https://wiki.debian.org/Backports) for Debian 7.x has improved Hyper-V capabilities.

7. On Windows Server 2012 R2 Generation 2 virtual machines have secure boot enabled by default and some Linux virtual machines will not boot unless the secure boot option is disabled. You can disable secure boot in the **Firmware** section of the settings for the virtual machine in **Hyper-V Manager** or you can disable it using Powershell:

   ```Powershell
   Set-VMFirmware -VMName "VMname" -EnableSecureBoot Off

   ```
8. The latest upstream kernel capabilities are only available by using the kernel included [Debian backports](https://wiki.debian.org/Backports).

See Also

* [Supported CentOS and Red Hat Enterprise Linux virtual machines on Hyper-V](Supported-CentOS-and-Red-Hat-Enterprise-Linux-virtual-machines-on-Hyper-V.md)

* [Supported Oracle Linux virtual machines on Hyper-V](Supported-Oracle-Linux-virtual-machines-on-Hyper-V.md)

* [Supported SUSE virtual machines on Hyper-V](Supported-SUSE-virtual-machines-on-Hyper-V.md)

* [Supported Ubuntu virtual machines on Hyper-V](Supported-Ubuntu-virtual-machines-on-Hyper-V.md)

* [Supported FreeBSD virtual machines on Hyper-V](Supported-FreeBSD-virtual-machines-on-Hyper-V.md)

* [Feature Descriptions for Linux and FreeBSD virtual machines on Hyper-V](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md)

* [Best Practices for running Linux on Hyper-V](Best-Practices-for-running-Linux-on-Hyper-V.md)
