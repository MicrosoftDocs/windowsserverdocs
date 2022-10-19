---
title: Supported Debian virtual machines on Hyper-V
description: Lists the Debin/Linux integration services and features included in each version
ms.topic: article
ms.assetid: 3cc62c10-02a3-4633-960c-23bf91a45bd5
ms.author: kkashanjat
author: kkkashan
ms.date: 01/08/2021
---
# Supported Debian virtual machines on Hyper-V

>Applies to: Windows Server 2022, Azure Stack HCI, version 20H2; Windows Server 2019, Hyper-V Server 2019, Windows Server 2016, Hyper-V Server 2016, Windows Server 2012 R2, Hyper-V Server 2012 R2, Windows 10, Windows 8.1

The following feature distribution map indicates the features that are present in each version. The known issues and workarounds for each distribution are listed after the table.

## Table legend

* **Built in** - LIS are included as part of this Linux distribution. The Microsoft-provided LIS download package doesn't work for this distribution so do not install it. The kernel module version numbers for the built in LIS (as shown by **lsmod**, for example) are different from the version number on the Microsoft-provided LIS download package. A mismatch does not indicate that the built in LIS is out of date.

* &#10004; - Feature available

* (*blank*) - Feature not available

| **Feature**                                                                                                                                  | **Windows Server operating system version** | **11 Bullseye** | **10.0-10.3 (buster)** |
|----------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------|-----------------|------------------------|
| **Availability**                                                                                                                             |                                             | Built in        | Built in               |
| **[Core](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#core)**                                                   | 2019, 2016, 2012 R2                         | ✔               | ✔                      |
| Windows Server 2016 Accurate Time                                                                                                            | 2019, 2016                                  | ✔ Note 4        | ✔ Note 4               |
| **[Networking](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#networking)**                                       |                                             |                 |                        |
| Jumbo frames                                                                                                                                 | 2019, 2016, 2012 R2                         | ✔               | ✔                      |
| VLAN tagging and trunking                                                                                                                    | 2019, 2016, 2012 R2                         | ✔               | ✔                      |
| Live Migration                                                                                                                               | 2019, 2016, 2012 R2                         | ✔               | ✔                      |
| Static IP Injection                                                                                                                          | 2019, 2016, 2012 R2                         |                 |                        |
| vRSS                                                                                                                                         | 2019, 2016, 2012 R2                         | ✔ Note 4        | ✔ Note 4               |
| TCP Segmentation and Checksum Offloads                                                                                                       | 2019, 2016, 2012 R2                         | ✔ Note 4        | ✔ Note 4               |
| SR-IOV                                                                                                                                       | 2019, 2016                                  | ✔ Note 4        | ✔ Note 4               |
| **[Storage](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#storage)**                                             |                                             |                 |                        |
| VHDX resize                                                                                                                                  | 2019, 2016, 2012 R2                         | ✔ Note 1        | ✔ Note 1               |
| Virtual Fibre Channel                                                                                                                        | 2019, 2016, 2012 R2                         |                 |                        |
| Live virtual machine backup                                                                                                                  | 2019, 2016, 2012 R2                         | ✔ Note 2        | ✔ Note 2               |
| TRIM support                                                                                                                                 | 2019, 2016, 2012 R2                         | ✔ Note 4        | ✔ Note 4               |
| SCSI WWN                                                                                                                                     | 2019, 2016, 2012 R2                         | ✔ Note 4        | ✔ Note 4               |
| **[Memory](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#memory)**                                               |                                             |                 |                        |
| PAE Kernel Support                                                                                                                           | 2019, 2016, 2012 R2                         | ✔               | ✔                      |
| Configuration of MMIO gap                                                                                                                    | 2019, 2016, 2012 R2                         | ✔               | ✔                      |
| Dynamic Memory - Hot-Add                                                                                                                     | 2019, 2016, 2012 R2                         | ✔ Note 4        | ✔ Note 4               |
| Dynamic Memory - Ballooning                                                                                                                  | 2019, 2016, 2012 R2                         | ✔ Note 4        | ✔ Note 4               |
| Runtime Memory Resize                                                                                                                        | 2019, 2016                                  | ✔ Note 4        | ✔ Note 4               |
| **[Video](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#video)**                                                 |                                             |                 |                        |
| Hyper-V-specific video device                                                                                                                | 2019, 2016, 2012 R2                         | ✔               | ✔                      |
| **[Miscellaneous](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#miscellaneous)**                                 |                                             |                 |                        |
| Key-Value Pair                                                                                                                               | 2019, 2016, 2012 R2                         | ✔ Note 2        | ✔ Note 2               |
| Non-Maskable Interrupt                                                                                                                       | 2019, 2016, 2012 R2                         | ✔               | ✔                      |
| File copy from host to guest                                                                                                                 | 2019, 2016, 2012 R2                         | ✔ Note 2        | ✔ Note 2               |
| lsvmbus command                                                                                                                              | 2019, 2016, 2012 R2                         |                 |                        |
| Hyper-V Sockets                                                                                                                              | 2019, 2016                                  | ✔ Note 4        | ✔ Note 4               |
| PCI Passthrough/DDA                                                                                                                          | 2019, 2016                                  | ✔ Note 4        | ✔ Note 4               |
| **[Generation 2 virtual machines](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#generation-2-virtual-machines)** |                                             |                 |                        |
| Boot using UEFI                                                                                                                              | 2019, 2016, 2012 R2                         | ✔ Note 3        | ✔ Note 3               |
| Secure boot                                                                                                                                  | 2019, 2016                                  | ✔               | ✔                      |


## Notes

1. Creating file systems on VHDs larger than 2TB is not supported.

2. Starting with Debian 8.3 the manually-installed Debian package "hyperv-daemons" contains the key-value pair, fcopy, and VSS daemons. On Debian 7.x and 8.0-8.2 the hyperv-daemons package must come from [Debian backports](https://wiki.debian.org/Backports).

3. On Windows Server 2012 R2 Generation 2 virtual machines have secure boot enabled by default and some Linux virtual machines will not boot unless the secure boot option is disabled. You can disable secure boot in the **Firmware** section of the settings for the virtual machine in **Hyper-V Manager** or you can disable it using Powershell:

   ```Powershell
   Set-VMFirmware -VMName "VMname" -EnableSecureBoot Off
   ```
4. The latest upstream kernel capabilities are only available by using the kernels available in the [Debian Backports repository](https://wiki.debian.org/Backports).

5. While Debian 7.x is out of support and uses an older kernel, the kernel included in Debian backports for Debian 7.x has improved Hyper-V capabilities.

## See Also

* [Supported CentOS and Red Hat Enterprise Linux virtual machines on Hyper-V](Supported-CentOS-and-Red-Hat-Enterprise-Linux-virtual-machines-on-Hyper-V.md)

* [Supported Oracle Linux virtual machines on Hyper-V](Supported-Oracle-Linux-virtual-machines-on-Hyper-V.md)

* [Supported SUSE virtual machines on Hyper-V](Supported-SUSE-virtual-machines-on-Hyper-V.md)

* [Supported Ubuntu virtual machines on Hyper-V](Supported-Ubuntu-virtual-machines-on-Hyper-V.md)

* [Supported FreeBSD virtual machines on Hyper-V](Supported-FreeBSD-virtual-machines-on-Hyper-V.md)

* [Feature Descriptions for Linux and FreeBSD virtual machines on Hyper-V](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md)

* [Best Practices for running Linux on Hyper-V](Best-Practices-for-running-Linux-on-Hyper-V.md)
