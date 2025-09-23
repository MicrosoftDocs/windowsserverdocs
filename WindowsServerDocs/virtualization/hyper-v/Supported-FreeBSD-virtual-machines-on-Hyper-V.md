---
title: Supported FreeBSD virtual machines on Hyper-V
description: Lists the FreeBSD/Linux integration services and features included in each version
ms.topic: concept-article
ms.author: daknappe
author: dknappettmsft
ms.date: 06/19/2025
---
# Supported FreeBSD virtual machines on Hyper-V

The following feature distribution map indicates the features in each version. The known issues and workarounds for each distribution are listed after the table.

## Table legend

* **Built in** - BIS (FreeBSD Integration Service) are included as part of this FreeBSD release.

* &#10004; - Feature available

* (*blank*) - Feature not available

|**Feature** | **Windows Server operating system version** | **13.0-13.5** | **12.0-12.4** | **11.0-11.4** |
|--|--|--|--|--|
| **Availability** |  | Built in | Built in | Built in |
| **[Core](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#core)** | 2025, 2022, 2019, 2016, 2012 R2 | ✔ | ✔ | ✔ |
| Windows Server 2016 Accurate Time | 2025, 2022, 2019, 2016 | ✔ | ✔ | ✔ |
| **[Networking](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#networking)** |  |  |  |  |
| Jumbo frames | 2025, 2022, 2019, 2016, 2012 R2 | ✔ Note 2 | ✔ Note 2 | ✔ Note 2 |
| VLAN tagging and trunking | 2025, 2022, 2019, 2016, 2012 R2 | ✔ | ✔ | ✔ |
| Live migration | 2025, 2022, 2019, 2016, 2012 R2 | ✔ | ✔ | ✔ |
| Static IP Injection | 2025, 2022, 2019, 2016, 2012 R2 | ✔ Note 3 | ✔ Note 3 | ✔ Note 3 |
| vRSS | 2025, 2022, 2019, 2016, 2012 R2 | ✔ | ✔ | ✔ |
| TCP Segmentation and Checksum Offloads | 2025, 2022, 2019, 2016, 2012 R2 | ✔ | ✔ | ✔ |
| Large Receive Offload (LRO) | 2025, 2022, 2019, 2016, 2012 R2 | ✔ | ✔ | ✔ |
| SR-IOV | 2025, 2022, 2019, 2016 | ✔ | ✔ | ✔ |
| **[Storage](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#storage)** |  | Note 1 | Note1 | Note 1 |
| VHDX resize | 2025, 2022, 2019, 2016, 2012 R2 | ✔ Note 6 | ✔ Note 6 | ✔ Note 6 |
| Virtual Fibre Channel | 2025, 2022, 2019, 2016, 2012 R2 |  |  |  |
| Live virtual machine backup | 2025, 2022, 2019, 2016, 2012 R2 | ✔ | ✔ | ✔ |
| TRIM support | 2025, 2022, 2019, 2016, 2012 R2 | ✔ | ✔ | ✔ |
| SCSI WWN | 2025, 2022, 2019, 2016, 2012 R2 |  |  |  |
| **[Memory](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#memory)** |  |  |  |  |
| PAE Kernel Support | 2025, 2022, 2019, 2016, 2012 R2 |  |  |  |
| Configuration of MMIO gap | 2025, 2022, 2019, 2016, 2012 R2 | ✔ | ✔ | ✔ |
| Dynamic Memory - Hot-Add | 2025, 2022, 2019, 2016, 2012 R2 |  |  |  |
| Dynamic Memory - Ballooning | 2025, 2022, 2019, 2016, 2012 R2 |  |  |  |
| Runtime Memory Resize | 2025, 2022, 2019, 2016 |  |  |  |
| **[Video](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#video)** |  |  |  |  |
| Hyper-V specific video device | 2025, 2022, 2019, 2016, 2012 R2 |  |  |  |
| **[Miscellaneous](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#miscellaneous)** |  |  |  |  |
| Key/value pair | 2025, 2022, 2019, 2016, 2012 R2 | ✔ | ✔ | ✔ |
| Non-Maskable Interrupt | 2025, 2022, 2019, 2016, 2012 R2 | ✔ | ✔ | ✔ |
| File copy from host to guest | 2025, 2022, 2019, 2016, 2012 R2 |  |  |  |
| lsvmbus command | 2025, 2022, 2019, 2016, 2012 R2 |  |  |  |
| Hyper-V Sockets | 2025, 2022, 2019, 2016 |  |  |  |
| PCI Passthrough/DDA | 2025, 2022, 2019, 2016 | ✔ | ✔ | ✔ |
| **[Generation 2 virtual machines](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#generation-2-virtual-machines)** |  |  |  |  |
| Boot using UEFI | 2025, 2022, 2019, 2016, 2012 R2 | ✔ | ✔ | ✔ |
| Secure boot | 2025, 2022, 2019, 2016 |  |  |  |

## Notes

1. Suggest to [Label Disk Devices]( https://www.freebsd.org/doc/handbook/geom-glabel.html) to avoid ROOT MOUNT ERROR during startup.

1. 9126 is the maximum supported MTU size.

1. In a failover scenario, you cannot set a static IPv6 address in the replica server. Use an IPv4 address instead.

## Related content

* [Feature Descriptions for Linux and FreeBSD virtual machines on Hyper-V](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md)
* [Best practices for running FreeBSD on Hyper-V](Best-practices-for-running-FreeBSD-on-Hyper-V.md)


