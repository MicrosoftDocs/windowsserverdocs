---
title: Supported Oracle Linux virtual machines on Hyper-V
description: Lists the Oracle Linux integration services and features included in each version
ms.topic: article
ms.assetid: c02fdb5b-62f3-43cb-a190-ab74b3ebcf77
ms.author: kkashanjat
author: kkkashan
ms.date: 09/27/2023
---
# Supported Oracle Linux virtual machines on Hyper-V

>Applies to: Azure Stack HCI, Windows Server 2022, Windows Server 2019, Windows Server 2016, Hyper-V Server 2016, Windows Server 2012 R2, Hyper-V Server 2012 R2, Windows 10, Windows 8.1

The following feature distribution map indicates the features that are present in each version. The known issues and workarounds for each distribution are listed after the table.

In this section:

* [Oracle Linux 9.x Series](#oracle-linux-9x-series)
* [Oracle Linux 8.x Series](#oracle-linux-8x-series)
* [Oracle Linux 7.x Series](#oracle-linux-7x-series)
* [Oracle Linux 6.x Series](#oracle-linux-6x-series)


## Table legend

* **Built in** - LIS are included as part of this Linux distribution. The kernel module version numbers for the built in LIS (as shown by **lsmod**, for example) are different from the version number on the Microsoft-provided LIS download package. A mismatch doesn't indicate that the built in LIS is out of date.

* &#10004; - Feature available
* (*blank*) - Feature not available
* **RHCK** - Red Hat Compatible Kernel
* **UEK** - Unbreakable Enterprise Kernel (UEK)
   * UEK4 - built on upstream Linux Kernel release 4.1.12
   * UEK5 - built on upstream Linux Kernel release 4.14
   * UEK6 - built on upstream Linux Kernel release 5.4

## Oracle Linux 9.x Series

| **Feature** | **Windows Server version** | **9.0 (RHCK)** |
|--|--|--|
| **Availability** |  |
| **[Core](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#core)** | 2019, 2016, 2012 R2 | &#10004; |
| Windows Server 2016 Accurate Time | 2019, 2016 | &#10004; |
| **[Networking](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#networking)** |  |
| Jumbo frames | 2019, 2016, 2012 R2 | &#10004; |
| VLAN tagging and trunking | 2019, 2016, 2012 R2 | &#10004; |
| Live Migration | 2019, 2016, 2012 R2 | &#10004; |
| Static IP Injection | 2019, 2016, 2012 R2 | &#10004; Note 2 |
| vRSS | 2019, 2016, 2012 R2 | &#10004; |
| TCP Segmentation and Checksum Offloads | 2019, 2016, 2012 R2 | &#10004; |
| SR-IOV | 2019, 2016 | &#10004; |
| **[Storage](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#storage)** |  |
| VHDX resize | 2019, 2016, 2012 R2 | &#10004; |
| Virtual Fibre Channel | 2019, 2016, 2012 R2 | &#10004; Note 3 |
| Live virtual machine backup | 2019, 2016, 2012 R2 | &#10004; Note 5 |
| TRIM support | 2019, 2016, 2012 R2 | &#10004; |
| SCSI WWN | 2019, 2016, 2012 R2 | &#10004; |
| **[Memory](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#memory)** |  |
| PAE Kernel Support | 2019, 2016, 2012 R2 | N/A |
| Configuration of MMIO gap | 2019, 2016, 2012 R2 | &#10004; |
| Dynamic Memory - Hot-Add | 2019, 2016, 2012 R2 | &#10004; Note 7, 8, 9 |
| Dynamic Memory - Ballooning | 2019, 2016, 2012 R2 | &#10004; Note 7, 8, 9 |
| Runtime Memory Resize | 2019, 2016 | &#10004; |
| **[Video](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#video)** |  |
| Hyper-V-specific video device | 2019, 2016, 2012 R2 | &#10004; |
| **[Miscellaneous](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#miscellaneous)** |  |
| Key-Value Pair | 2019, 2016, 2012 R2 | &#10004; |
| Non-Maskable Interrupt | 2019, 2016, 2012 R2 | &#10004; |
| File copy from host to guest | 2019, 2016, 2012 R2 | &#10004; |
| lsvmbus command | 2019, 2016, 2012 R2 | &#10004; |
| Hyper-V Sockets | 2019, 2016 | &#10004; |
| PCI Passthrough/DDA | 2019, 2016 | &#10004; |
| **[Generation 2 virtual machines](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#generation-2-virtual-machines)** |  |  |
| Boot using UEFI | 2019, 2016, 2012 R2 | &#10004; Note 12 |
| Secure boot | 2019, 2016 | &#10004; |

## Oracle Linux 8.x Series

| **Feature** | **Windows Server version** | **8.0-8.5 (RHCK)** |
|--|--|--|
| **Availability** |  |
| **[Core](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#core)** | 2019, 2016, 2012 R2 | &#10004; |
| Windows Server 2016 Accurate Time | 2019, 2016 | &#10004; |
| **[Networking](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#networking)** |  |
| Jumbo frames | 2019, 2016, 2012 R2 | &#10004; |
| VLAN tagging and trunking | 2019, 2016, 2012 R2 | &#10004; |
| Live Migration | 2019, 2016, 2012 R2 | &#10004; |
| Static IP Injection | 2019, 2016, 2012 R2 | &#10004; Note 2 |
| vRSS | 2019, 2016, 2012 R2 | &#10004; |
| TCP Segmentation and Checksum Offloads | 2019, 2016, 2012 R2 | &#10004; |
| SR-IOV | 2019, 2016 | &#10004; |
| **[Storage](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#storage)** |  |
| VHDX resize | 2019, 2016, 2012 R2 | &#10004; |
| Virtual Fibre Channel | 2019, 2016, 2012 R2 | &#10004; Note 3 |
| Live virtual machine backup | 2019, 2016, 2012 R2 | &#10004; Note 5 |
| TRIM support | 2019, 2016, 2012 R2 | &#10004; |
| SCSI WWN | 2019, 2016, 2012 R2 | &#10004; |
| **[Memory](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#memory)** |  |
| PAE Kernel Support | 2019, 2016, 2012 R2 | N/A |
| Configuration of MMIO gap | 2019, 2016, 2012 R2 | &#10004; |
| Dynamic Memory - Hot-Add | 2019, 2016, 2012 R2 | &#10004; Note 7, 8, 9 |
| Dynamic Memory - Ballooning | 2019, 2016, 2012 R2 | &#10004; Note 7, 8, 9 |
| Runtime Memory Resize | 2019, 2016 | &#10004; |
| **[Video](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#video)** |  |
| Hyper-V-specific video device | 2019, 2016, 2012 R2 | &#10004; |
| **[Miscellaneous](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#miscellaneous)** |  |
| Key-Value Pair | 2019, 2016, 2012 R2 | &#10004; |
| Non-Maskable Interrupt | 2019, 2016, 2012 R2 | &#10004; |
| File copy from host to guest | 2019, 2016, 2012 R2 | &#10004; |
| lsvmbus command | 2019, 2016, 2012 R2 | &#10004; |
| Hyper-V Sockets | 2019, 2016 | &#10004; |
| PCI Passthrough/DDA | 2019, 2016 | &#10004; |
| **[Generation 2 virtual machines](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#generation-2-virtual-machines)** |  |  |
| Boot using UEFI | 2019, 2016, 2012 R2 | &#10004; Note 12 |
| Secure boot | 2019, 2016 | &#10004; |

## Oracle Linux 7.x Series

This series only has 64-bit kernels.

<table width="100%">
<tr height="50px">
<td width="20%" rowspan="2">

Feature
</td>
<td width="20%" rowspan="2">

Windows Server Version
</td>
<td width="30%" colspan="3">

7.5-7.8
</td>
<td width="30%" colspan="3">

7.3-7.4
</td>
</tr>
<tr>
<td width="20%" colspan="2">

RHCK
</td>
<td width="10%">

UEK5
</td>
<td width="20%" colspan="2">

RHCK
</td>
<td width="10%">

UEK4
</td>
</tr>
<tr>
<td width="20%">

Availability
</td>
<td width="20%">


</td>
<td width="10%">

LIS 4.3
</td>
<td width="10%">

Built in
</td>
<td width="10%">

Built in
</td>
<td width="10%">

LIS 4.3
</td>
<td width="10%">

Built in
</td>
<td width="10%">

Built in
</td>
</tr>
<tr height="50px">
<td width="20%">

**[Core](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#core)**
</td>
<td width="20%">

2019, 2016, 2012 R2
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
</tr>
<tr height="50px">
<td width="20%">

Windows Server 2016 Accurate Time
</td>
<td width="20%">

2019, 2016
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

</td>
<td width="10%">

</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

</td>
<td width="10%">

</td>
</tr>
<tr height="50px">
<td width="20%">

 **[Networking](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#networking)**
</td>
<td width="20%">

</td>
<td width="10%">

</td>
<td width="10%">

</td>
<td width="10%">

</td>
<td width="10%">

</td>
<td width="10%">

</td>
<td width="10%">

</td>
</tr>
<tr height="50px">
<td width="20%">

Jumbo frames
</td>
<td width="20%">

2019, 2016, 2012 R2
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
</tr>
<tr height="50px">
<td width="20%">
VLAN tagging and trunking
</td>
<td width="20%">
2019, 2016, 2012 R2
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
</tr>
<tr height="50px">
<td width="20%">

Live Migration
</td>
<td width="20%">

2019, 2016, 2012 R2
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
</tr>
<tr height="50px">
<td width="20%">

Static IP injection
</td>
<td width="20%">

2019, 2016, 2012 R2
</td>
<td width="10%">

&#10004; Note 2
</td>
<td width="10%">

&#10004; Note 2
</td>
<td width="10%">

&#10004; Note 2
</td>
<td width="10%">

&#10004; Note 2
</td>
<td width="10%">

&#10004; Note 2
</td>
<td width="10%">

&#10004; Note 2
</td>
</tr>
<tr height="50px">
<td width="20%">

vRSS
</td>
<td width="20%">

2019, 2016, 2012 R2
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
</tr>
<tr height="50px">
<td width="20%">

TCP Segmentation and Checksum Offloads
</td>
<td width="20%">

2019, 2016, 2012 R2
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
</tr>
<tr height="50px">
<td width="20%">

SR-IOV
</td>
<td width="20%">

2019, 2016
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
</tr>
<tr height="50px">
<td width="20%">

**[Storage](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#storage)**
</td>
<td width="20%">

</td>
<td width="10%">

</td>
<td width="10%">

</td>
<td width="10%">

</td>
<td width="10%">

</td>
<td width="10%">

</td>
<td width="10%">

</td>
</tr>
<tr height="50px">
<td width="20%">

VHDX resize
</td>
<td width="20%">

2019, 2016, 2012 R2
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
</tr>
<tr height="50px">
<td width="20%">

Virtual Fibre Channel
</td>
<td width="20%">

2019, 2016, 2012 R2
</td>
<td width="10%">

&#10004; Note 3
</td>
<td width="10%">

&#10004; Note 3
</td>
<td width="10%">

&#10004; Note 3
</td>
<td width="10%">

&#10004; Note 3
</td>
<td width="10%">

&#10004; Note 3
</td>
<td width="10%">

&#10004; Note 3
</td>
</tr>
<tr height="50px">
<td width="20%">

Live virtual machine backup
</td>
<td width="20%">

2019, 2016, 2012 R2
</td>
<td width="10%">

&#10004; Note 5
</td>
<td width="10%">

&#10004; Note 4,5
</td>
<td width="10%">

&#10004; Note 5
</td>
<td width="10%">

&#10004; Note 5
</td>
<td width="10%">

&#10004; Note 4,5
</td>
<td width="10%">

&#10004; Note 5
</td>
</tr>
<tr height="50px">
<td width="20%">

TRIM support
</td>
<td width="20%">

2019, 2016, 2012 R2
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
</tr>
<tr height="50px">
<td width="20%">

SCSI WWN
</td>
<td width="20%">

2019, 2016, 2012 R2
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

</td>
</tr>
<tr height="50px">
<td width="20%">

**[Memory](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#memory)**
</td>
<td width="20%">


</td>
<td width="10%">

</td>
<td width="10%">

</td>
<td width="10%">

</td>
<td width="10%">

</td>
<td width="10%">

</td>
<td width="10%">

</td>
</tr>
<tr height="50px">
<td width="20%">

PAE Kernel Support
</td>
<td width="20%">

2019, 2016, 2012 R2
</td>
<td width="10%">

N/A
</td>
<td width="10%">

N/A
</td>
<td width="10%">

N/A
</td>
<td width="10%">

N/A
</td>
<td width="10%">

N/A
</td>
<td width="10%">

N/A
</td>
</tr>
<tr height="50px">
<td width="20%">

Configuration of MMIO gap
</td>
<td width="20%">

2019, 2016, 2012 R2
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
</tr>
<tr height="50px">
<td width="20%">

Dynamic Memory Hot-Add
</td>
<td width="20%">

2019, 2016, 2012 R2
</td>
<td width="10%">

&#10004; Note 7,8,9
</td>
<td width="10%">

&#10004; Note 8,9
</td>
<td width="10%">

&#10004; Note 8,9
</td>
<td width="10%">

&#10004; Note 8,9
</td>
<td width="10%">

&#10004; Note 8,9
</td>
<td width="10%">

&#10004; Note 8,9
</td>
</tr>
<tr height="50px">
<td width="20%">

Dynamic Memory Ballooning
</td>
<td width="20%">

2019, 2016, 2012 R2
</td>
<td width="10%">

&#10004; Note 7,8,9
</td>
<td width="10%">

&#10004; Note 8,9
</td>
<td width="10%">

&#10004; Note 8,9
</td>
<td width="10%">

&#10004; Note 8,9
</td>
<td width="10%">

&#10004; Note 8,9
</td>
<td width="10%">

&#10004; Note 8,9
</td>
</tr>
<tr height="50px">
<td width="20%">

Runtime Memory Resize
</td>
<td width="20%">

2019, 2016
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">


</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">


</td>
<td width="10%">

</td>
</tr>
<tr height="50px">
<td width="20%">

**[Video](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#video)**
</td>
<td width="20%">

</td>
<td width="10%">

</td>
<td width="10%">

</td>
<td width="10%">

</td>
<td width="10%">

</td>
<td width="10%">

</td>
<td width="10%">

</td>
</tr>
<tr height="50px">
<td width="20%">

Hyper-V specific video
</td>
<td width="20%">

2019, 2016, 2012 R2
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
</tr>
<tr height="50px">
<td width="20%">

**[Miscellaneous](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#miscellaneous)**
</td>
<td width="20%">

</td>
<td width="10%">

</td>
<td width="10%">

</td>
<td width="10%">

</td>
<td width="10%">

</td>
<td width="10%">

</td>
<td width="10%">

</td>
</tr>
<tr height="50px">
<td width="20%">

Key-value pair
</td>
<td width="20%">

2019, 2016, 2012 R2
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
</tr>
<tr height="50px">
<td width="20%">

Non-Maskable Interrupt
</td>
<td width="20%">

2019, 2016, 2012 R2
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
</tr>
<tr height="50px">
<td width="20%">

File copy from host to guest
</td>
<td width="20%">

2019, 2016, 2012 R2
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
</tr>
<tr height="50px">
<td width="20%">

lsvmbus command
</td>
<td width="20%">

2019, 2016, 2012 R2
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">


</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">


</td>
<td width="10%">

&#10004;
</td>
</tr>
<tr height="50px">
<td width="20%">

Hyper-V Sockets
</td>
<td width="20%">

2019, 2016
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">


</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">


</td>
<td width="10%">

&#10004;
</td>
</tr>
<tr height="50px">
<td width="20%">

PCI Passthrough/DDA
</td>
<td width="20%">

2019, 2016
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
</tr>
<tr height="50px">
<td width="20%">

**[Generation 2 virtual machines](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#generation-2-virtual-machines)**
</td>
<td width="20%">

</td>
<td width="10%">

</td>
<td width="10%">

</td>
<td width="10%">

</td>
<td width="10%">

</td>
<td width="10%">

</td>
<td width="10%">

</td>
</tr>
<tr height="50px">
<td width="20%">

Boot using UEFI
</td>
<td width="20%">

2019, 2016, 2012 R2
</td>
<td width="10%">

&#10004; Note 12
</td>
<td width="10%">

&#10004; Note 12
</td>
<td width="10%">

&#10004; Note 12
</td>
<td width="10%">

&#10004; Note 12
</td>
<td width="10%">

&#10004; Note 12
</td>
<td width="10%">

&#10004; Note 12
</td>
</tr>
<tr height="50px">
<td width="20%">

Secure boot
</td>
<td width="20%">

2019, 2016, 2012 R2
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
<td width="10%">

&#10004;
</td>
</tr>
</table>


## Oracle Linux 6.x Series

This series only has 64-bit kernels.

| **Feature** | **Windows Server version** | **6.8-6.10 (RHCK)** | **6.8-6.10 (UEK4)** |
|--|--|--|--|
| **Availability** |  | LIS 4.3 | Built in |
| **[Core](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#core)** | 2019, 2016, 2012 R2 | &#10004; | &#10004; |
| Windows Server 2016 Accurate Time | 2019, 2016 |  |
| **[Networking](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#networking)** |  |  |
| Jumbo frames | 2019, 2016, 2012 R2 | &#10004; | &#10004; |
| VLAN tagging and trunking | 2019, 2016, 2012 R2 | &#10004; Note 1 | &#10004; Note 1 |
| Live Migration | 2019, 2016, 2012 R2 | &#10004; | &#10004; |
| Static IP Injection | 2019, 2016, 2012 R2 | &#10004; Note 2 | &#10004; |
| vRSS | 2019, 2016, 2012 R2 | &#10004; | &#10004; |
| TCP Segmentation and Checksum Offloads | 2019, 2016, 2012 R2 | &#10004; | &#10004; |
| SR-IOV | 2019, 2016 |  |  |
| **[Storage](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#storage)** |  |  |
| VHDX resize | 2019, 2016, 2012 R2 | &#10004; | &#10004; |
| Virtual Fibre Channel | 2019, 2016, 2012 R2 | &#10004; Note 3 | &#10004; Note 3 |
| Live virtual machine backup | 2019, 2016, 2012 R2 | &#10004; Note 5 | &#10004; Note 5 |
| TRIM support | 2019, 2016, 2012 R2 | &#10004; | &#10004; |
| SCSI WWN | 2019, 2016, 2012 R2 | &#10004; | &#10004; |
| **[Memory](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#memory)** |  |  |
| PAE Kernel Support | 2019, 2016, 2012 R2 | N/A | N/A |
| Configuration of MMIO gap | 2019, 2016, 2012 R2 | &#10004; | &#10004; |
| Dynamic Memory - Hot-Add | 2019, 2016, 2012 R2 | &#10004; Note 6, 8, 9 | &#10004; Note 6, 8, 9 |
| Dynamic Memory - Ballooning | 2019, 2016, 2012 R2 | &#10004; Note 6, 8, 9 | &#10004; Note 6, 8, 9 |
| Runtime Memory Resize | 2019, 2016 |  |  |
| **[Video](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#video)** |  |  |
| Hyper-V-specific video device | 2019, 2016, 2012 R2 | &#10004; | &#10004; |
| **[Miscellaneous](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#miscellaneous)** |  |  |
| Key-Value Pair | 2019, 2016, 2012 R2 | &#10004; Note 10,11 | &#10004; Note 10,11 |
| Non-Maskable Interrupt | 2019, 2016, 2012 R2 | &#10004; | &#10004; |
| File copy from host to guest | 2019, 2016, 2012 R2 | &#10004; | &#10004; |
| lsvmbus command | 2019, 2016, 2012 R2 | &#10004; | &#10004; |
| Hyper-V Sockets | 2019, 2016 | &#10004; | &#10004; |
| PCI Passthrough/DDA | 2019, 2016 | &#10004; | &#10004; |
| **[Generation 2 virtual machines](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#generation-2-virtual-machines)** |  |  |
| Boot using UEFI | 2019, 2016, 2012 R2 | &#10004; Note 12 | &#10004; Note 12 |
| Secure boot | 2019, 2016 |  |  |



## <a name="BKMK_notes"></a>Notes

1. For this Oracle Linux release, VLAN tagging works but VLAN trunking does not.

2. Static IP injection may not work if Network Manager has been configured for a given synthetic network adapter on the virtual machine. For smooth functioning of static IP injection please make sure that either Network Manager is either turned off completely or has been turned off for a specific network adapter through its ifcfg-ethX file.

3.	On Windows Server 2012 R2 while using virtual fibre channel devices, make sure that logical unit number 0 (LUN 0) has been populated. If LUN 0 has not been populated, a Linux virtual machine might not be able to mount fibre channel devices natively.

4. For built-in LIS, the "hyperv-daemons" package must be installed for this functionality.

5.	If there are open file handles during a live virtual machine backup operation, then in some corner cases, the backed-up VHDs might have to undergo a file system consistency check (fsck) on restore. Live backup operations can fail silently if the virtual machine has an attached iSCSI device or direct-attached storage (also known as a pass-through disk).

6. Dynamic memory support is only available on 64-bit virtual machines.

7. Hot-Add support is not enabled by default in this distribution. To enable Hot-Add support you need to add a udev rule under /etc/udev/rules.d/ as follows:

   1. Create a file **/etc/udev/rules.d/100-balloon.rules**. You may use any other desired name for the file.

   2. Add the following content to the file: `SUBSYSTEM=="memory", ACTION=="add", ATTR{state}="online"`

   3. Reboot the system to enable Hot-Add support.

   While the Linux Integration Services download creates this rule on installation, the rule is also removed when LIS is uninstalled, so the rule must be recreated if dynamic memory is needed after uninstallation.

8. Dynamic memory operations can fail if the guest operating system is running too low on memory. The following are some best practices:

   * Startup memory and minimal memory should be equal to or greater than the amount of memory that the distribution vendor recommends.

   * Applications that tend to consume the entire available memory on a system are limited to consuming up to 80 percent of available RAM.

9. If you are using Dynamic Memory on a Windows Server 2016 or Windows Server 2012 R2 operating system, specify **Startup memory**, **Minimum memory**, and **Maximum memory** parameters in multiples of 128 megabytes (MB). Failure to do so can lead to hot-add failures, and you may not see any memory increase in a guest operating system.

10.	To enable key/value pair (KVP) infrastructure, install the hypervkvpd or hyperv-daemons rpm package from your Oracle Linux ISO. Alternatively the package can be installed directly from Oracle Linux Yum repositories.

11.	The key/value pair (KVP) infrastructure might not function correctly without a Linux software update. Contact your distribution vendor to obtain the software update in case you see problems with this feature.

12. On Windows Server 2012 R2 Generation 2 virtual machines have secure boot enabled by default and some Linux virtual machines will not boot unless the secure boot option is disabled. You can disable secure boot in the **Firmware** section of the settings for the virtual machine in **Hyper-V Manager** or you can disable it using PowerShell:

    ```Powershell
    Set-VMFirmware -VMName "VMname" -EnableSecureBoot Off
    ```

    The Linux Integration Services download can be applied to existing Generation 2 VMs but does not impart Generation 2 capability.


See Also

* [Set-VMFirmware](/powershell/module/hyper-v/set-vmfirmware)

* [Supported CentOS and Red Hat Enterprise Linux virtual machines on Hyper-V](Supported-CentOS-and-Red-Hat-Enterprise-Linux-virtual-machines-on-Hyper-V.md)

* [Supported Debian virtual machines on Hyper-V](Supported-Debian-virtual-machines-on-Hyper-V.md)

* [Supported SUSE virtual machines on Hyper-V](Supported-SUSE-virtual-machines-on-Hyper-V.md)

* [Supported Ubuntu virtual machines on Hyper-V](Supported-Ubuntu-virtual-machines-on-Hyper-V.md)

* [Supported FreeBSD virtual machines on Hyper-V](Supported-FreeBSD-virtual-machines-on-Hyper-V.md)

* [Feature Descriptions for Linux and FreeBSD virtual machines on Hyper-V](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md)

* [Best Practices for running Linux on Hyper-V](Best-Practices-for-running-Linux-on-Hyper-V.md)
