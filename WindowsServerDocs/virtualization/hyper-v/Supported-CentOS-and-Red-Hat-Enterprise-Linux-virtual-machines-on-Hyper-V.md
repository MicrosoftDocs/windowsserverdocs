---
title: Supported CentOS and Red Hat Enterprise Linux virtual machines on Hyper-V
description: Lists the versions of Linux integration services for supported CentOS and Red Hat Enterprise distributions
ms.topic: article
ms.assetid: 4bf8783d-dee5-4b3e-8cce-2b11b117c189
author: kkkashan        
ms.author: kkashanjat
ms.date: 09/27/2023
---
# Supported CentOS and Red Hat Enterprise Linux virtual machines on Hyper-V

> Applies To: Azure Stack HCI, Windows Server 2022, Windows Server Windows Server 2019, Hyper-V Server Windows Server 2019, Windows Server 2016, Hyper-V Server 2016, Windows Server 2012 R2, Hyper-V Server 2012 R2, Windows 11, Windows 10, Windows 8.1

The following feature distribution maps indicate the features that are present
in built-in and downloadable versions of Linux Integration Services. The known
issues and workarounds for each distribution are listed after the tables.

The built-in Red Hat Enterprise Linux Integration Services drivers for Hyper-V
(available since Red Hat Enterprise Linux 6.4) are sufficient for Red Hat
Enterprise Linux guests to run using the high performance synthetic devices on
Hyper-V hosts. These built-in drivers are certified by Red Hat for this use.
Certified configurations can be viewed on this Red Hat web page: [Red Hat
Certification
Catalog](https://access.redhat.com/ecosystem/search/#/ecosystem/Red%20Hat%20Enterprise%20Linux?sort=sortTitle%20asc&vendors=Microsoft&category=Server).
It isn't necessary to download and install Linux Integration Services packages
from the Microsoft Download Center, and doing so may limit your Red Hat support
as described in Red Hat Knowledgebase article 1067: [Red Hat Knowledgebase
1067](https://access.redhat.com/articles/1067).

Because of potential conflicts between the built-in LIS support and the
downloadable LIS support when you upgrade the kernel, disable automatic updates,
uninstall the LIS downloadable packages, update the kernel, reboot, and then
install the latest LIS release, and reboot again.

> [!NOTE]
> Official Red Hat Enterprise Linux certification information is available through the [Red Hat Customer Portal](https://access.redhat.com/ecosystem/search/#/category/Server?sort=sortTitle%20asc&query=windows%20server&ecosystem=Red%20Hat%20Enterprise%20Linux).

In this section:

-   [RHEL/CentOS 9.x Series](#rhelcentos-9x-series)

-   [RHEL/CentOS 8.x Series](#rhelcentos-8x-series)

-   [RHEL/CentOS 7.x Series](#rhelcentos-7x-series)

-   [RHEL/CentOS 6.x Series](#rhelcentos-6x-series)

-   [RHEL/CentOS 5.x Series](#rhelcentos-5x-series)

-   [Notes](#notes)

## Table legend

-   **Built in** - LIS are included as part of this Linux distribution. The
    kernel module version numbers for the built-in LIS (as shown by **lsmod**,
    for example) are different from the version number on the Microsoft-provided
    LIS download package. A mismatch does not indicate that the built-in LIS is
    out of date.

-   ✔ - Feature available

-   (*blank*) - Feature not available
## RHEL/CentOS 9.x Series
| **Feature** | **Host OS** | **9.x** |
|--|--|--|
| LIS Availability |  | Built in |
| [Core](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#core) | Windows Server 2022, 2019, 2016, 2012 R2 Azure Stack HCI | ✔ |
| Windows Server 2016 Accurate Time | Windows Server 2022, 2019, 2016<br/> Azure Stack HCI | ✔ |
| \>256 vCPUs |  | ✔ |
| [Networking](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#networking) |  |  |
| Jumbo frames | Windows Server 2022, 2019, 2016, 2012 R2 <br/>Azure Stack HCI | ✔ |
| VLAN tagging and trunking | Windows Server 2022, 2019, 2016, 2012 R2 <br/>Azure Stack HCI | ✔ |
| Live Migration | Windows Server 2022, 2019, 2016, 2012 R2 <br/>Azure Stack HCI | ✔ |
| Static IP Injection | Windows Server 2022, 2019, 2016, 2012 R2 <br/>Azure Stack HCI | ✔ Note 2 |
| vRSS | Windows Server 2022, 2019, 2016, 2012 R2 <br/>Azure Stack HCI | ✔ |
| TCP Segmentation and Checksum Offloads | Windows Server 2022, 2019, 2016, 2012 R2 <br/>Azure Stack HCI | ✔ |
| SR-IOV | Windows Server 2022, 2019, 2016 <br/>Azure Stack HCI | ✔ |
| [Storage](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#storage) |  |  |
| VHDX resize | Windows Server 2022, 2019, 2016, 2012 R2 <br/>Azure Stack HCI | ✔ |
| Virtual Fibre Channel | Windows Server 2022, 2019, 2016, 2012 R2 <br/>Azure Stack HCI | ✔ Note 3 |
| Live virtual machine backup | Windows Server 2022, 2019, 2016, 2012 R2 <br/>Azure Stack HCI | ✔ Note 5 |
| TRIM support | Windows Server 2022, 2019, 2016, 2012 R2 <br/>Azure Stack HCI | ✔ |
| SCSI WWN | Windows Server 2022, 2019, 2016, 2012 R2 <br/>Azure Stack HCI | ✔ |
| [Memory](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#memory) |  |  |
| PAE Kernel Support | Windows Server 2022, 2019, 2016, 2012 R2 <br/>Azure Stack HCI |  |
| Configuration of MMIO gap | Windows Server 2022, 2019, 2016, 2012 R2 <br/>Azure Stack HCI | ✔ |
| Dynamic Memory - Hot-Add | Windows Server 2022, 2019, 2016, 2012 R2 <br/>Azure Stack HCI | ✔ Note 9, 10 |
| Dynamic Memory - Ballooning | Windows Server 2022, 2019, 2016, 2012 R2 <br/>Azure Stack HCI | ✔ Note 9,10 |
| Runtime Memory Resize | Windows Server 2022, 2019, 2016 <br/>Azure Stack HCI | ✔ |
| [Video](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#video) |  |  |
| Hyper-V-specific video device | Windows Server 2022, 2019, 2016, 2012 R2 <br/>Azure Stack HCI | ✔ |
| [Miscellaneous](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#miscellaneous) |  |  |
| Key-Value Pair | Windows Server 2022, 2019, 2016, 2012 R2 <br/>Azure Stack HCI | ✔ |
| Non-Maskable Interrupt | Windows Server 2022, 2019, 2016, 2012 R2 <br/>Azure Stack HCI | ✔ |
| File copy from host to guest | Windows Server 2022, 2019, 2016, 2012 R2 <br/>Azure Stack HCI | ✔ |
| lsvmbus command | Windows Server 2022, 2019, 2016, 2012 R2 <br/>Azure Stack HCI | ✔ |
| Hyper-V Sockets | Windows Server 2022, 2019, 2016 <br/>Azure Stack HCI | ✔ |
| PCI Passthrough/DDA | Windows Server 2022, 2019, 2016 <br/>Azure Stack HCI | ✔ |
| [Generation 2 virtual machines](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#generation-2-virtual-machines) |  |  |
| Boot using UEFI | Windows Server 2022, 2019, 2016, 2012 R2 <br/>Azure Stack HCI | ✔ Note 14, 17 |
| Secure boot | Windows Server 2022, 2019, 2016 <br/>Azure Stack HCI | ✔ |

## RHEL/CentOS 8.x Series

| **Feature** | **Host OS** | **8.1-8.6+** | **8.0** |
|--|--|--|--|
| LIS Availability |  | Built in | Built in |
| [Core](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#core) | Windows Server 2022, 2019, 2016, 2012 R2 <br/>Azure Stack HCI | ✔ | ✔ |
| Windows Server 2016 Accurate Time | Windows Server 2022, 2019, 2016 <br/>Azure Stack HCI | ✔ | ✔ |
| \>256 vCPUs |  | ✔ |  |
| [Networking](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#networking) |  |  |  |
| Jumbo frames | Windows Server 2022, 2019, 2016, 2012 R2 <br/>Azure Stack HCI | ✔ | ✔ |
| VLAN tagging and trunking | Windows Server 2022, 2019, 2016, 2012 R2 <br/>Azure Stack HCI | ✔ | ✔ |
| Live Migration | Windows Server 2022, 2019, 2016, 2012 R2 <br/>Azure Stack HCI | ✔ | ✔ |
| Static IP Injection | Windows Server 2022, 2019, 2016, 2012 R2 <br/>Azure Stack HCI | ✔ Note 2 | ✔ Note 2 |
| vRSS | Windows Server 2022, 2019, 2016, 2012 R2 <br/>Azure Stack HCI | ✔ | ✔ |
| TCP Segmentation and Checksum Offloads | Windows Server 2022, 2019, 2016, 2012 R2 <br/>Azure Stack HCI | ✔ | ✔ |
| SR-IOV | Windows Server 2022, 2019, 2016 <br/>Azure Stack HCI | ✔ | ✔ |
| [Storage](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#storage) |  |  |  |
| VHDX resize | Windows Server 2022, 2019, 2016, 2012 R2 <br/>Azure Stack HCI | ✔ | ✔ |
| Virtual Fibre Channel | Windows Server 2022, 2019, 2016, 2012 R2 <br/>Azure Stack HCI | ✔ Note 3 | ✔ Note 3 |
| Live virtual machine backup | Windows Server 2022, 2019, 2016, 2012 R2 <br/>Azure Stack HCI | ✔ Note 5 | ✔ Note 5 |
| TRIM support | Windows Server 2022, 2019, 2016, 2012 R2 <br/>Azure Stack HCI | ✔ | ✔ |
| SCSI WWN | Windows Server 2022, 2019, 2016, 2012 R2 <br/>Azure Stack HCI | ✔ | ✔ |
| [Memory](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#memory) |  |  |  |
| PAE Kernel Support | Windows Server 2022, 2019, 2016, 2012 R2 <br/>Azure Stack HCI | N/A | N/A |
| Configuration of MMIO gap | Windows Server 2022, 2019, 2016, 2012 R2 <br/>Azure Stack HCI | ✔ | ✔ |
| Dynamic Memory - Hot-Add | Windows Server 2022, 2019, 2016, 2012 R2 <br/>Azure Stack HCI | ✔ Note 9, 10 | ✔ Note 9, 10 |
| Dynamic Memory - Ballooning | Windows Server 2022, 2019, 2016, 2012 R2 <br/>Azure Stack HCI | ✔ Note 9, 10 | ✔ Note 9, 10 |
| Runtime Memory Resize | Windows Server 2022, 2019, 2016 <br/>Azure Stack HCI | ✔ | ✔ |
| [Video](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#video) |  |  |  |
| Hyper-V-specific video device | Windows Server 2022, 2019, 2016, 2012 R2 <br/>Azure Stack HCI | ✔ | ✔ |
| [Miscellaneous](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#miscellaneous) |  |  |  |
| Key-Value Pair | Windows Server 2022, 2019, 2016, 2012 R2 <br/>Azure Stack HCI | ✔ | ✔ |
| Non-Maskable Interrupt | Windows Server 2022, 2019, 2016, 2012 R2 <br/>Azure Stack HCI | ✔ | ✔ |
| File copy from host to guest | Windows Server 2022, 2019, 2016, 2012 R2 <br/>Azure Stack HCI | ✔ | ✔ |
| lsvmbus command | Windows Server 2022, 2019, 2016, 2012 R2 <br/>Azure Stack HCI | ✔ | ✔ |
| Hyper-V Sockets | Windows Server 2022, 2019, 2016 <br/>Azure Stack HCI | ✔ | ✔ |
| PCI Passthrough/DDA | Windows Server 2022, 2019, 2016 <br/>Azure Stack HCI | ✔ | ✔ |
| [Generation 2 virtual machines](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#generation-2-virtual-machines) |  |  |  |
| Boot using UEFI | Windows Server 2022, 2019, 2016, 2012 R2 <br/>Azure Stack HCI | ✔ Note 14, 17 | ✔ Note 14 |
| Secure boot | Windows Server 2022, 2019, 2016 <br/>Azure Stack HCI | ✔ | ✔ |

RHEL/CentOS 7.x Series
----------------------

This series only has 64-bit kernels.

| **Feature** | **Host OS** | **7.5-7.7** | **7.3-7.4** | **7.0-7.2** | **7.6-7.9** | **7.5** | **7.4** | **7.3** | **7.2** | **7.1** | **7.0** |
|--|--|--|--|--|--|--|--|--|--|--|--|
| LIS Availability |  | [LIS 4.3](https://www.microsoft.com/download/details.aspx?id=55106) | [LIS 4.3](https://www.microsoft.com/download/details.aspx?id=55106) | [LIS 4.3](https://www.microsoft.com/download/details.aspx?id=55106) | Built in | Built in | Built in | Built in | Built in | Built in | Built in |
| [Core](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#core) | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |
| Windows Server 2016 Accurate Time | Windows Server 2022, 2019, 2016<br />Azure Stack HCI | ✔ | ✔ |  | ✔ | ✔ | ✔ |  |  |  |
| \>256 vCPUs |  |  |  |  | ✔ Note 16 |  |  |  |  |  |  |
| [Networking](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#networking) |  |  |  |  |  |  |  |  |  |  |  |
| Jumbo frames | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |
| VLAN tagging and trunking | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |
| Live Migration | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |
| Static IP Injection | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ Note 2 | ✔ Note 2 | ✔ Note 2 | ✔ Note 2 | ✔ Note 2 | ✔ Note 2 | ✔ Note 2 | ✔ Note 2 | ✔ Note 2 | ✔ Note 2 |
| vRSS | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |  |
| TCP Segmentation and Checksum Offloads | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |  |
| SR-IOV | Windows Server 2022, 2019, 2016<br />Azure Stack HCI | ✔ | ✔ |  | ✔ | ✔ | ✔ |  |  |  |
| [Storage](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#storage) |  |  |  |  |  |  |  |  |  |  |  |
| VHDX resize | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |  |  |
| Virtual Fibre Channel | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ Note 3 | ✔ Note 3 | ✔ Note 3 | ✔ Note 3 | ✔ Note 3 | ✔ Note 3 | ✔ Note 3 | ✔ Note 3 | ✔ Note 3 | ✔ Note 3 |
| Live virtual machine backup | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ Note 5 | ✔ Note 5 | ✔ Note 5 | ✔ Note 4,5 | ✔ Note 4,5 | ✔ Note 4, 5 | ✔ Note 4, 5 | ✔ Note 4, 5 | ✔ Note 4, 5 | ✔ Note 4, 5 |
| TRIM support | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |  |
| SCSI WWN | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ | ✔ | ✔ | ✔ |  |  |  |  |  |
| [Memory](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#memory) |  |  |  |  |  |  |  |  |  |  |  |
| PAE Kernel Support | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | N/A | N/A | N/A | N/A | N/A | N/A | N/A | N/A | N/A | N/A |
| Configuration of MMIO gap | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |
| Dynamic Memory - Hot-Add | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ Note 8, 9, 10 | ✔ Note 8, 9, 10 | ✔ Note 8, 9, 10 | ✔ Note 8, 9, 10 | ✔ Note 9, 10 | ✔ Note 9, 10 | ✔ Note 9, 10 | ✔ Note 9, 10 | ✔ Note 9, 10 | ✔ Note 8, 9, 10 |
| Dynamic Memory - Ballooning | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ Note 9, 10 | ✔ Note 9, 10 | ✔ Note 9, 10 | ✔ Note 9, 10 | ✔ Note 9, 10 | ✔ Note 9, 10 | ✔ Note 9, 10 | ✔ Note 9, 10 | ✔ Note 9, 10 | ✔ Note  9, 10 |
| Runtime Memory Resize | Windows Server 2022, 2019, 2016<br />Azure Stack HCI | ✔ | ✔ | ✔ |  |  |  |  |  |  |
| [Video](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#video) |  |  |  |  |  |  |  |  |  |  |  |
| Hyper-V-specific video device | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |
| [Miscellaneous](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#miscellaneous) |  |  |  |  |  |  |  |  |  |  |  |
| Key-Value Pair | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ | ✔ | ✔ | ✔ Note 4 | ✔ Note 4 | ✔ Note 4 | ✔ Note 4 | ✔ Note 4 | ✔ Note 4 | ✔ Note 4 |
| Non-Maskable Interrupt | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |
| File copy from host to guest | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ | ✔ | ✔ | ✔ Note 4 | ✔ Note 4 | ✔ Note 4 | ✔ Note 4 | ✔ Note 4 | ✔ Note 4 |
| lsvmbus command | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ | ✔ | ✔ |  |  |  |  |  |  |
| Hyper-V Sockets | Windows Server 2022, 2019, 2016 | ✔ | ✔ | ✔ |  |  |  |  |  |  |
| PCI Passthrough/DDA | Windows Server 2022, 2019, 2016<br />Azure Stack HCI | ✔ | ✔ |  | ✔ | ✔ | ✔ | ✔ |  |  |
| [Generation 2 virtual machines](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#generation-2-virtual-machines) |  |  |  |  |  |  |  |  |  |  |  |
| Boot using UEFI | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ Note 14 | ✔ Note 14 | ✔ Note 14 | ✔ Note 14 | ✔ Note 14 | ✔ Note 14 | ✔ Note 14 | ✔ Note 14 | ✔ Note 14 | ✔ Note 14 |
| Secure boot | Windows Server 2022, 2019, 2016<br />Azure Stack HCI | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |

RHEL/CentOS 6.x Series
----------------------

The 32-bit kernel for this series is PAE enabled. There is no built-in LIS
support for RHEL/CentOS 6.0-6.3.

| **Feature** | **Host OS** | **6.7-6.10** | **6.4-6.6** | **6.0-6.3** | **6.10, 6.9, 6.8** | **6.6, 6.7** | **6.5** | **6.4** |
|--|--|--|--|--|--|--|--|--|
| LIS Availability |  | [LIS 4.3](https://www.microsoft.com/download/details.aspx?id=55106) | [LIS 4.3](https://www.microsoft.com/download/details.aspx?id=55106) | [LIS 4.3](https://www.microsoft.com/download/details.aspx?id=55106) | Built in | Built in | Built in | Built in |
| [Core](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#core) | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |
| Windows Server 2016 Accurate Time | Windows Server 2022, 2019, 2016<br />Azure Stack HCI |  |  |  |  |  |  |  |
| \>256 vCPUs |  |  |  |  |  |  |  |  |
| [Networking](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#networking) |  |  |  |  |  |  |  |  |
| Jumbo frames | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |
| VLAN tagging and trunking | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ Note 1 | ✔ Note 1 | ✔ Note 1 | ✔ Note 1 | ✔ Note 1 | ✔ Note 1 | ✔ Note 1 |
| Live Migration | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |
| Static IP Injection | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ Note 2 | ✔ Note 2 | ✔ Note 2 | ✔ Note 2 | ✔ Note 2 | ✔ Note 2 | ✔ Note 2 |
| vRSS | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ | ✔ | ✔ | ✔ | ✔ |  |  |
| TCP Segmentation and Checksum Offloads | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ | ✔ | ✔ | ✔ | ✔ |  |  |
| SR-IOV | Windows Server 2022, 2019, 2016<br />Azure Stack HCI |  |  |  |  |  |  |  |
| [Storage](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#storage) |  |  |  |  |  |  |  |  |
| VHDX resize | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |  |
| Virtual Fibre Channel | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ Note 3 | ✔ Note 3 | ✔ Note 3 | ✔ Note 3 | ✔ Note 3 | ✔ Note 3 |  |
| Live virtual machine backup | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ Note 5 | ✔ Note 5 | ✔ Note 5 | ✔ Note 4, 5 | ✔ Note 4, 5 | ✔ Note 4, 5, 6 | ✔ Note 4, 5, 6 |
| TRIM support | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ | ✔ | ✔ | ✔ |  |  |  |
| SCSI WWN | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ | ✔ | ✔ |  |  |  |  |
| [Memory](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#memory) |  |  |  |  |  |  |  |  |
| PAE Kernel Support | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |
| Configuration of MMIO gap | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |
| Dynamic Memory - Hot-Add | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ Note 7, 9, 10 | ✔ Note 7, 9, 10 | ✔ Note 7, 9, 10 | ✔ Note 7, 9, 10 | ✔ Note 7, 8, 9, 10 | ✔ Note 7, 8, 9, 10 |  |
| Dynamic Memory - Ballooning | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ Note 7, 9, 10 | ✔ Note 7, 9, 10 | ✔ Note 7, 9, 10 | ✔ Note 7, 9, 10 | ✔ Note 7, 9, 10 | ✔ Note 7, 9, 10 | ✔ Note 7, 9, 10, 11 |
| Runtime Memory Resize | Windows Server 2022, 2019, 2016<br />Azure Stack HCI |  |  |  |  |  |  |  |
| [Video](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#video) |  |  |  |  |  |  |  |  |
| Hyper-V-specific video device | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |  |
| [Miscellaneous](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#miscellaneous) |  |  |  |  |  |  |  |  |
| Key-Value Pair | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ | ✔ | ✔ | ✔ Note 12 | ✔ Note 12 | ✔ Note 12, 13 | ✔ Note 12, 13 |
| Non-Maskable Interrupt | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |
| File copy from host to guest | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ | ✔ | ✔ | ✔ Note 12 | ✔ Note 12 |  |  |
| lsvmbus command | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ | ✔ | ✔ |  |  |  |  |
| Hyper-V Sockets | Windows Server 2022, 2019, 2016<br />Azure Stack HCI | ✔ | ✔ | ✔ |  |  |  |  |
| PCI Passthrough/DDA | Windows Server 2022, 2019, 2016<br />Azure Stack HCI | ✔ |  |  |  |  |  |  |
| [Generation 2 virtual machines](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#generation-2-virtual-machines) |  |  |  |  |  |  |  |  |
| Boot using UEFI | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ Note 14 | ✔ Note 14 | ✔ Note 14 | ✔ Note 14 |  |  |  |
| Secure boot | Windows Server 2022, 2019, 2016<br />Azure Stack HCI |  |  |  |  |  |  |  |

RHEL/CentOS 5.x Series
----------------------

This series has a supported 32-bit PAE kernel available. There is no built-in
LIS support for RHEL/CentOS before 5.9.

| **Feature** | **Host OS** | 5.2 -5.11 | **5.2-5.11** | **5.9 - 5.11** |
|--|--|--|--|--|
| LIS Availability |  | [LIS 4.3](https://www.microsoft.com/download/details.aspx?id=55106) | LIS 4.1 | Built in |
| [Core](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#core) | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ | ✔ | ✔ |
| Windows Server 2016 Accurate Time | Windows Server 2022, 2019, 2016<br />Azure Stack HCI |  |  |  |
| \>256 vCPUs |  |  |  |  |
| [Networking](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#networking) |  |  |  |  |
| Jumbo frames | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ | ✔ | ✔ |
| VLAN tagging and trunking | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ Note 1 | ✔ Note 1 | ✔ Note 1 |
| Live Migration | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ | ✔ | ✔ |
| Static IP Injection | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ Note 2 | ✔ Note 2 | ✔ Note 2 |
| vRSS | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI |  |  |  |
| TCP Segmentation and Checksum Offloads | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ | ✔ |  |
| SR-IOV | Windows Server 2022, 2019, 2016<br />Azure Stack HCI |  |  |  |
| [Storage](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#storage) |  |  |  |  |
| VHDX resize | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ | ✔ |  |
| Virtual Fibre Channel | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ Note 3 | ✔ Note 3 |  |
| Live virtual machine backup | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ Note 5, 15 | ✔ Note 5 | ✔ Note 4, 5, 6 |
| TRIM support | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI |  |  |  |
| SCSI WWN | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI |  |  |  |
| [Memory](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#memory) |  |  |  |  |
| PAE Kernel Support | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ | ✔ | ✔ |
| Configuration of MMIO gap | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ | ✔ | ✔ |
| Dynamic Memory - Hot-Add | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI |  |  |  |
| Dynamic Memory - Ballooning | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ Note 7, 9, 10, 11 | ✔ Note 7, 9, 10, 11 |  |
| Runtime Memory Resize | Windows Server 2022, 2019, 2016<br />Azure Stack HCI |  |  |  |
| [Video](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#video) |  |  |  |  |
| Hyper-V-specific video device | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ | ✔ |  |
| [Miscellaneous](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#miscellaneous) |  |  |  |  |
| Key-Value Pair | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ | ✔ |  |
| Non-Maskable Interrupt | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ | ✔ | ✔ |
| File copy from host to guest | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI | ✔ | ✔ |  |
| lsvmbus command | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI |  |  |  |
| Hyper-V Sockets | Windows Server 2022, 2019, 2016<br />Azure Stack HCI |  |  |  |
| PCI Passthrough/DDA | Windows Server 2022, 2019, 2016<br />Azure Stack HCI |  |  |  |
| [Generation 2 virtual machines](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#generation-2-virtual-machines) |  |  |  |  |
| Boot using UEFI | Windows Server 2022, 2019, 2016, 2012 R2<br />Azure Stack HCI |  |  |  |
| Secure boot | Windows Server 2022, 2019, 2016<br />Azure Stack HCI |  |  |  |

Notes
-----

1.  For this RHEL/CentOS release, VLAN tagging works but VLAN trunking does not.

2.  Static IP injection may not work if Network Manager has been configured for a given synthetic network adapter on the virtual machine. For smooth functioning of static IP injection please make sure that either Network Manager is either turned off completely or has been turned off for a specific network adapter through its ifcfg-ethX file.

3.  On Windows Server 2012 R2 while using virtual fibre channel devices, make sure that logical unit number 0 (LUN 0) has been populated. If LUN 0 has not been populated, a Linux virtual machine might not be able to mount fibre channel devices natively.

4.  For built-in LIS, the "hyperv-daemons" package must be installed for this functionality.

5.  If there are open file handles during a live virtual machine backup operation, then in some corner cases, the backed-up VHDs might have to undergo a file system consistency check (fsck) on restore. Live backup operations can fail silently if the virtual machine has an attached iSCSI device or direct-attached storage (also known as a pass-through disk).

6.  While the Linux Integration Services download is preferred, live backup support for RHEL/CentOS 5.9 - 5.11/6.4/6.5 is also available through
    [Hyper-V Backup Essentials for
    Linux](https://github.com/LIS/backupessentials/tree/1.0).

7.  Dynamic memory support is only available on 64-bit virtual machines.

8.  Hot-Add support is not enabled by default in this distribution. To enable Hot-Add support you need to add a udev rule under /etc/udev/rules.d/ as follows:
    
    1. Create a file **/etc/udev/rules.d/100-balloon.rules**. You may use any other desired name for the file.

    2. Add the following content to the file: `SUBSYSTEM=="memory", ACTION=="add", ATTR{state}="online"`

    3. Reboot the system to enable Hot-Add support.
   
    While the Linux Integration Services download creates this rule on installation, the rule is also removed when LIS is uninstalled, so the rule must be recreated if dynamic memory is needed after uninstallation.

9.  Dynamic memory operations can fail if the guest operating system is running too low on memory. The following are some best practices:

    * Startup memory and minimal memory should be equal to or greater than the
    amount of memory that the distribution vendor recommends.

    * Applications that tend to consume the entire available memory on a system
    are limited to consuming up to 80 percent of available RAM.

10. If you are using Dynamic Memory on a Windows Server 2016 or Windows Server 2012 R2 operating system, specify **Startup memory**, **Minimum memory**, and **Maximum memory** parameters in multiples of 128 megabytes (MB). Failure to do so can lead to hot-add failures, and you may not see any memory increase in a guest operating system.

11. Certain distributions, including those using LIS 4.0 and 4.1, only provide Ballooning support and do not provide Hot-Add support. In such a scenario, the dynamic memory feature can be used by setting the Startup memory parameter to a value which is equal to the Maximum memory parameter. This results in all the requisite memory being Hot-Added to the virtual machine at boot time and then later depending upon the memory requirements of the host, Hyper-V can freely allocate or deallocate memory from the guest using Ballooning. Please configure **Startup Memory** and **Minimum Memory** at or above the recommended value for the distribution.

12. To enable key/value pair (KVP) infrastructure, install the hypervkvpd or
    hyperv-daemons rpm package from your RHEL ISO. Alternatively the package can
    be installed directly from RHEL repositories.

13. The key/value pair (KVP) infrastructure might not function correctly without a Linux software update. Contact your distribution vendor to obtain the software update in case you see problems with this feature.

14.  On Windows Server 2012 R2 Generation 2 virtual machines have secure boot enabled by default and some Linux virtual machines will not boot unless the secure boot option is disabled. You can disable secure boot in the **Firmware** section of the settings for the virtual machine in **Hyper-V Manager** or you can disable it using PowerShell:

        ```Powershell
        Set-VMFirmware -VMName "VMname" -EnableSecureBoot Off
        ```
        The Linux Integration Services download can be applied to existing Generation 2 VMs but does not impart Generation 2 capability.

15. In Red Hat Enterprise Linux or CentOS 5.2, 5.3, and 5.4 the filesystem freeze functionality is not available, so Live Virtual Machine Backup is also not available.

16. For RHEL 7.6, support for >256 vcpus is available in kernel 3.10.0-957.38.1 or later and kernel 3.10.0-1062.4.1 or later is required for RHEL 7.7.

17. RHEL 8.5 requires Windows Server 2019 or newer, or Azure Stack HCI 20H2 or newer.

See Also

-   [Set-VMFirmware](/powershell/module/hyper-v/set-vmfirmware)

-   [Supported Debian virtual machines on
    Hyper-V](Supported-Debian-virtual-machines-on-Hyper-V.md)

-   [Supported Oracle Linux virtual machines on
    Hyper-V](Supported-Oracle-Linux-virtual-machines-on-Hyper-V.md)

-   [Supported SUSE virtual machines on
    Hyper-V](Supported-SUSE-virtual-machines-on-Hyper-V.md)

-   [Supported Ubuntu virtual machines on
    Hyper-V](Supported-Ubuntu-virtual-machines-on-Hyper-V.md)

-   [Supported FreeBSD virtual machines on
    Hyper-V](Supported-FreeBSD-virtual-machines-on-Hyper-V.md)

-   [Feature Descriptions for Linux and FreeBSD virtual machines on
    Hyper-V](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md)

-   [Best Practices for running Linux on
    Hyper-V](Best-Practices-for-running-Linux-on-Hyper-V.md)

-   [Red Hat Hardware
    Certification](https://hardware.redhat.com/&quicksearch=Microsoft)
