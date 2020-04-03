---
title: Supported CentOS and Red Hat Enterprise Linux virtual machines on Hyper-V
description: "Lists the versions of Linux integration services for supported CentOS and Red Hat Enterprise distributions"
ms.prod: windows-server
ms.service: na
ms.technology: compute-hyper-v
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4bf8783d-dee5-4b3e-8cce-2b11b117c189
author: danihalfin
ms.author: vichen
ms.date: 06/13/2019
---
# Supported CentOS and Red Hat Enterprise Linux virtual machines on Hyper-V

>Applies To: Windows Server 2019, Hyper-V Server 2019, Windows Server 2016, Hyper-V Server 2016, Windows Server 2012 R2, Hyper-V Server 2012 R2, Windows 10, Windows 8.1

The following feature distribution maps indicate the features that are present in built-in and downloadable versions of Linux Integration Services. The known issues and workarounds for each distribution are listed after the tables.

The built-in Red Hat Enterprise Linux Integration Services drivers for Hyper-V (available since Red Hat Enterprise Linux 6.4) are sufficient for Red Hat Enterprise Linux guests to run using the high performance synthetic devices on Hyper-V hosts.These built-in drivers are certified by Red Hat for this use. Certified configurations can be viewed on this Red Hat web page: [Red Hat Certification Catalog](https://access.redhat.com/ecosystem/search/#/ecosystem/Red%20Hat%20Enterprise%20Linux?sort=sortTitle%20asc&vendors=Microsoft&category=Server). It isn't necessary to download and install Linux Integration Services packages from the Microsoft Download Center, and doing so may limit your Red Hat support as described in Red Hat Knowledgebase article 1067: [Red Hat Knowledgebase 1067](https://access.redhat.com/articles/1067).

Because of potential conflicts between the built-in LIS support and the downloadable LIS support when you upgrade the kernel, disable automatic updates, uninstall the LIS downloadable packages, update the kernel, reboot, and then install the latest LIS release, and reboot again.

> [!NOTE]
> Official Red Hat Enterprise Linux certification information is available through the [Red Hat Customer Portal](https://access.redhat.com/ecosystem/search/#/category/Server?sort=sortTitle%20asc&query=windows%20server&ecosystem=Red%20Hat%20Enterprise%20Linux).

In this section:

* [RHEL/CentOS 8.x Series](#rhelcentos-8x-series)

* [RHEL/CentOS 7.x Series](#rhelcentos-7x-series)

* [RHEL/CentOS 6.x Series](#rhelcentos-6x-series)

* [RHEL/CentOS 5.x Series](#rhelcentos-5x-series)

* [Notes](#notes)

## Table legend

* **Built in** - LIS are included as part of this Linux distribution. The kernel module version numbers for the built in LIS (as shown by **lsmod**, for example) are different from the version number on the Microsoft-provided LIS download package. A mismatch does not indicate that the built in LIS is out of date.

* &#10004; - Feature available

* (*blank*) - Feature not available

## RHEL/CentOS 8.x Series

|       **Feature**     |       **Windows Server version**      |       **8.1**     |       **8.0**     | 
|-----------------------|---------------------------------------|-------------------|-------------------|
|       **Availability**        |   |   |
|       **[Core](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#core)**      | 2019, 2016, 2012 R2 | &#10004; | &#10004;
|       Windows Server 2016 Accurate Time       | 2019, 2016 | &#10004; | &#10004; 
|       **[Networking](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#networking)**      |   |  |
|       Jumbo frames        | 2019, 2016, 2012 R2 | &#10004; | &#10004;|
|       VLAN tagging and trunking       | 2019, 2016, 2012 R2 | &#10004;  | &#10004; |
|       Live Migration      | 2019, 2016, 2012 R2 | &#10004; | &#10004;|
|       Static IP Injection     |  2019, 2016, 2012 R2 | &#10004; Note 2 | &#10004; Note 2|
|       vRSS     | 2019, 2016, 2012 R2 | &#10004; | &#10004;|
|       TCP Segmentation and Checksum Offloads | 2019, 2016, 2012 R2 | &#10004;|  &#10004; |
|       SR-IOV  | 2019, 2016 |  &#10004;   | &#10004; |
|       **[Storage](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#storage)** |  |  |
|       VHDX resize  | 2019, 2016, 2012 R2 | &#10004; | &#10004; |
|       Virtual Fibre Channel | 2019, 2016, 2012 R2 | &#10004; Note 3  | &#10004; Note 3 |
|       Live virtual machine backup  | 2019, 2016, 2012 R2 | &#10004; Note 5 | &#10004; Note 5|
|       TRIM support | 2019, 2016, 2012 R2 | &#10004;  | &#10004; |
|       SCSI WWN | 2019, 2016, 2012 R2 | &#10004;  | &#10004; |
|       **[Memory](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#memory)** | |  |
|       PAE Kernel Support  | 2019, 2016, 2012 R2 |  N/A | N/A
|       Configuration of MMIO gap  | 2019, 2016, 2012 R2 | &#10004; | &#10004;  |
|       Dynamic Memory - Hot-Add | 2019, 2016, 2012 R2  | &#10004; Note 8, 9, 10 | &#10004; Note 8, 9, 10 |
|       Dynamic Memory - Ballooning | 2019, 2016, 2012 R2 | &#10004; Note 8, 9, 10 | &#10004; Note 8, 9, 10 |
|       Runtime Memory Resize | 2019, 2016  | &#10004;  | &#10004; |
|       **[Video](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#video)** | | |
|       Hyper-V-specific video device | 2019, 2016, 2012 R2 | &#10004;   | &#10004; |
|       **[Miscellaneous](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#miscellaneous)** | | |
|       Key-Value Pair  | 2019, 2016, 2012 R2 | &#10004;   | &#10004;  |
|       Non-Maskable Interrupt | 2019, 2016, 2012 R2 | &#10004;  | &#10004; |
|       File copy from host to guest | 2019, 2016, 2012 R2 | &#10004;  | &#10004; |
|       lsvmbus command | 2019, 2016, 2012 R2 | &#10004;  | &#10004; |
|       Hyper-V Sockets | 2019, 2016 | &#10004;  | &#10004; |
|       PCI Passthrough/DDA | 2019, 2016 | &#10004; | &#10004; |
| **[Generation 2 virtual machines](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#generation-2-virtual-machines)** | |  |
|       Boot using UEFI | 2019, 2016, 2012 R2 |  &#10004; Note 14  | &#10004; Note 14   
|       Secure boot | 2019, 2016 |  &#10004; |  &#10004; |


## RHEL/CentOS 7.x Series

This series only has 64-bit kernels.


|                                                                 **Feature**                                                                  |     **Windows Server version**     |                             **7.5-7.8**                             |                             **7.3-7.4**                             |                             **7.0-7.2**                             |     **7.5-7.8**     |       **7.4**       |       **7.3**       |       **7.2**       |       **7.1**       |        **7.0**         |
|----------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------|---------------------------------------------------------------------|---------------------------------------------------------------------|---------------------------------------------------------------------|---------------------|---------------------|---------------------|---------------------|---------------------|------------------------|
|                                                               **Availability**                                                               |                                    | [LIS 4.3](https://www.microsoft.com/download/details.aspx?id=55106) | [LIS 4.3](https://www.microsoft.com/download/details.aspx?id=55106) | [LIS 4.3](https://www.microsoft.com/download/details.aspx?id=55106) |      Built in       |      Built in       |      Built in       |      Built in       |      Built in       |        Built in        |
|                          **[Core](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#core)**                          | 2019, 2016, 2012 R2 |                              &#10004;                               |                              &#10004;                               |                              &#10004;                               |      &#10004;       |      &#10004;       |      &#10004;       |      &#10004;       |      &#10004;       |        &#10004;        |
|                                                      Windows Server 2016 Accurate Time                                                       |             2019, 2016             |                              &#10004;                               |                              &#10004;                               |                                                                     |                     |                     |                     |                     |                     |                        |
|                    **[Networking](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#networking)**                    |                                    |                                                                     |                                                                     |                                                                     |                     |                     |                     |                     |                     |                        |
|                                                                 Jumbo frames                                                                 | 2019, 2016, 2012 R2 |                              &#10004;                               |                              &#10004;                               |                              &#10004;                               |      &#10004;       |      &#10004;       |      &#10004;       |      &#10004;       |      &#10004;       |        &#10004;        |
|                                                          VLAN tagging and trunking                                                           | 2019, 2016, 2012 R2 |                              &#10004;                               |                              &#10004;                               |                              &#10004;                               |      &#10004;       |      &#10004;       |      &#10004;       |      &#10004;       |      &#10004;       |        &#10004;        |
|                                                                Live Migration                                                                | 2019, 2016, 2012 R2 |                              &#10004;                               |                              &#10004;                               |                              &#10004;                               |      &#10004;       |      &#10004;       |      &#10004;       |      &#10004;       |      &#10004;       |        &#10004;        |
|                                                             Static IP Injection                                                              |     2019, 2016, 2012 R2      |                           &#10004; Note 2                           |                           &#10004; Note 2                           |                           &#10004; Note 2                           |   &#10004; Note 2   |   &#10004; Note 2   |   &#10004; Note 2   |   &#10004; Note 2   |   &#10004; Note 2   |    &#10004; Note 2     |
|                                                                     vRSS                                                                     |        2019, 2016, 2012 R2         |                              &#10004;                               |                              &#10004;                               |                              &#10004;                               |      &#10004;       |      &#10004;       |      &#10004;       |      &#10004;       |      &#10004;       |                        |
|                                                    TCP Segmentation and Checksum Offloads                                                    | 2019, 2016, 2012 R2 |                              &#10004;                               |                              &#10004;                               |                              &#10004;                               |      &#10004;       |      &#10004;       |      &#10004;       |      &#10004;       |      &#10004;       |                        |
|                                                                    SR-IOV                                                                    |             2019, 2016             |                              &#10004;                               |                              &#10004;                               |                                                                     |      &#10004;       |      &#10004;       |      &#10004;       |                     |                     |                        |
|                       **[Storage](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#storage)**                       |                                    |                                                                     |                                                                     |                                                                     |                     |                     |                     |                     |                     |                        |
|                                                                 VHDX resize                                                                  |        2019, 2016, 2012 R2         |                              &#10004;                               |                              &#10004;                               |                              &#10004;                               |      &#10004;       |      &#10004;       |      &#10004;       |      &#10004;       |                     |                        |
|                                                            Virtual Fibre Channel                                                             |        2019, 2016, 2012 R2         |                           &#10004; Note 3                           |                           &#10004; Note 3                           |                           &#10004; Note 3                           |   &#10004; Note 3   |   &#10004; Note 3   |   &#10004; Note 3   |   &#10004; Note 3   |   &#10004; Note 3   |    &#10004; Note 3     |
|                                                         Live virtual machine backup                                                          |        2019, 2016, 2012 R2         |                           &#10004; Note 5                           |                           &#10004; Note 5                           |                           &#10004; Note 5                           |  &#10004; Note 4,5  | &#10004; Note 4, 5  | &#10004; Note 4, 5  | &#10004; Note 4, 5  | &#10004; Note 4, 5  |   &#10004; Note 4, 5   |
|                                                                 TRIM support                                                                 |        2019, 2016, 2012 R2         |                              &#10004;                               |                              &#10004;                               |                              &#10004;                               |      &#10004;       |      &#10004;       |      &#10004;       |      &#10004;       |                     |                        |
|                                                                   SCSI WWN                                                                   |        2019, 2016, 2012 R2         |                              &#10004;                               |                              &#10004;                               |                              &#10004;                               |      &#10004;       |                     |                     |                     |                     |                        |
|                        **[Memory](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#memory)**                        |                                    |                                                                     |                                                                     |                                                                     |                     |                     |                     |                     |                     |                        |
|                                                              PAE Kernel Support                                                              | 2019, 2016, 2012 R2 |                                 N/A                                 |                                 N/A                                 |                                 N/A                                 |         N/A         |         N/A         |         N/A         |         N/A         |         N/A         |          N/A           |
|                                                          Configuration of MMIO gap                                                           |        2019, 2016, 2012 R2         |                              &#10004;                               |                              &#10004;                               |                              &#10004;                               |      &#10004;       |      &#10004;       |      &#10004;       |      &#10004;       |      &#10004;       |        &#10004;        |
|                                                           Dynamic Memory - Hot-Add                                                           |     2019, 2016, 2012 R2      |                       &#10004; Note 8, 9, 10                        |                       &#10004; Note 8, 9, 10                        |                       &#10004; Note 8, 9, 10                        | &#10004; Note 9, 10 | &#10004; Note 9, 10 | &#10004; Note 9, 10 | &#10004; Note 9, 10 | &#10004; Note 9, 10 | &#10004; Note 8, 9, 10 |
|                                                         Dynamic Memory - Ballooning                                                          |     2019, 2016, 2012 R2      |                       &#10004; Note 8, 9, 10                        |                       &#10004; Note 8, 9, 10                        |                       &#10004; Note 8, 9, 10                        | &#10004; Note 9, 10 | &#10004; Note 9, 10 | &#10004; Note 9, 10 | &#10004; Note 9, 10 | &#10004; Note 9, 10 | &#10004; Note 8, 9, 10 |
|                                                            Runtime Memory Resize                                                             |             2019, 2016             |                              &#10004;                               |                              &#10004;                               |                              &#10004;                               |                     |                     |                     |                     |                     |                        |
|                         **[Video](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#video)**                         |                                    |                                                                     |                                                                     |                                                                     |                     |                     |                     |                     |                     |                        |
|                                                        Hyper-V-specific video device                                                         | 2019, 2016, 2012 R2 |                              &#10004;                               |                              &#10004;                               |                              &#10004;                               |      &#10004;       |      &#10004;       |      &#10004;       |      &#10004;       |      &#10004;       |        &#10004;        |
|                 **[Miscellaneous](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#miscellaneous)**                 |                                    |                                                                     |                                                                     |                                                                     |                     |                     |                     |                     |                     |                        |
|                                                                Key-Value Pair                                                                | 2019, 2016, 2012 R2 |                              &#10004;                               |                              &#10004;                               |                              &#10004;                               |      &#10004;       |      &#10004;       |      &#10004;       |      &#10004;       |      &#10004;       |        &#10004;        |
|                                                            Non-Maskable Interrupt                                                            |        2019, 2016, 2012 R2         |                              &#10004;                               |                              &#10004;                               |                              &#10004;                               |      &#10004;       |      &#10004;       |      &#10004;       |      &#10004;       |      &#10004;       |        &#10004;        |
|                                                         File copy from host to guest                                                         |        2019, 2016, 2012 R2         |                              &#10004;                               |                              &#10004;                               |                              &#10004;                               |      &#10004;       |      &#10004;       |      &#10004;       |      &#10004;       |      &#10004;       |                        |
|                                                               lsvmbus command                                                                | 2019, 2016, 2012 R2 |                              &#10004;                               |                              &#10004;                               |                              &#10004;                               |                     |                     |                     |                     |                     |                        |
|                                                               Hyper-V Sockets                                                                |             2019, 2016             |                              &#10004;                               |                              &#10004;                               |                              &#10004;                               |                     |                     |                     |                     |                     |                        |
|                                                             PCI Passthrough/DDA                                                              |             2019, 2016             |                              &#10004;                               |                              &#10004;                               |                                                                     |      &#10004;       |      &#10004;       |      &#10004;       |                     |                     |                        |
| **[Generation 2 virtual machines](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#generation-2-virtual-machines)** |                                    |                                                                     |                                                                     |                                                                     |                     |                     |                     |                     |                     |                        |
|                                                               Boot using UEFI                                                                |        2019, 2016, 2012 R2         |                          &#10004; Note 14                           |                          &#10004; Note 14                           |                          &#10004; Note 14                           |  &#10004; Note 14   |  &#10004; Note 14   |  &#10004; Note 14   |  &#10004; Note 14   |  &#10004; Note 14   |    &#10004; Note 14    |
|                                                                 Secure boot                                                                  |             2019, 2016             |                              &#10004;                               |                              &#10004;                               |                              &#10004;                               |      &#10004;       |      &#10004;       |      &#10004;       |      &#10004;       |      &#10004;       |        &#10004;        |


## RHEL/CentOS 6.x Series

The 32-bit kernel for this series is PAE enabled. There is no built-in LIS support for RHEL/CentOS 6.0-6.3.

|  **Feature**  | **Windows Server version** |  **6.7-6.10** |  **6.4-6.6** | **6.0-6.3** |   **6.10, 6.9, 6.8**   |       **6.6, 6.7**        |          **6.5**          |          **6.4**           |
|---------------|----------------------------|---------------|--------------|-------------|------------------------|---------------------------|----------------------------|---------------------------|
|  **Availability** |   | [LIS 4.3](https://www.microsoft.com/download/details.aspx?id=55106) | [LIS 4.3](https://www.microsoft.com/download/details.aspx?id=55106) | [LIS 4.3](https://www.microsoft.com/download/details.aspx?id=55106) |        Built in        |         Built in          |         Built in          |          Built in          |
|  **[Core](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#core)** | 2019, 2016, 2012 R2 |  &#10004; | &#10004;  | &#10004;  | &#10004; | &#10004; | &#10004;| &#10004; |
|  Windows Server 2016 Accurate Time | 2019, 2016 | |  | |  |  |   |   |
|  **[Networking](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#networking)**  | |   |  | |  |  |   |  |
|  Jumbo frames | 2019, 2016, 2012 R2 | &#10004; |  &#10004; | &#10004; | &#10004; | &#10004; | &#10004; | &#10004; |
|  VLAN tagging and trunking | 2019, 2016, 2012 R2 | &#10004; Note 1 | &#10004; Note 1 | &#10004; Note 1 | &#10004; Note 1 | &#10004; Note 1|  &#10004; Note 1 |&#10004; Note 1 |
|  Live Migration | 2019, 2016, 2012 R2 | &#10004; | &#10004; | &#10004;| &#10004; | &#10004; | &#10004;  | &#10004; |
|  Static IP Injection |  2019, 2016, 2012 R2 | &#10004; Note 2 |  &#10004; Note 2  | &#10004; Note 2 | &#10004; Note 2 | &#10004; Note 2 | &#10004; Note 2  | &#10004; Note 2 |
|  vRSS  | 2019, 2016, 2012 R2 | &#10004; | &#10004; |  &#10004; | &#10004; | &#10004;  |   |   |
|  TCP Segmentation and Checksum Offloads | 2019, 2016, 2012 R2 | &#10004; | &#10004; | &#10004; | &#10004; | &#10004;  |   |    |
|  SR-IOV   | 2019, 2016 |    |  |   |   |   |   |  |
|  **[Storage](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#storage)**  |  |   |   |  | |  |  | |
|  VHDX resize | 2019, 2016, 2012 R2| &#10004; | &#10004; | &#10004; | &#10004; | &#10004; | &#10004; |  |
|  Virtual Fibre Channel  | 2019, 2016, 2012 R2 |  &#10004; Note 3  | &#10004; Note 3  | &#10004; Note 3  | &#10004; Note 3 | &#10004; Note 3  | &#10004; Note 3  |    |
|  Live virtual machine backup | 2019, 2016, 2012 R2 | &#10004; Note 5  | &#10004; Note 5  | &#10004; Note 5 | &#10004; Note 4, 5 | &#10004; Note 4, 5 | &#10004; Note 4, 5, 6 | &#10004; Note 4, 5, 6 |
|  TRIM support  | 2019, 2016, 2012 R2  | &#10004; | &#10004; | &#10004; | &#10004; |  |  |  |
|  SCSI WWN  | 2019, 2016, 2012 R2  | &#10004; | &#10004;  | &#10004;  |  |   |  |  |
|  **[Memory](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#memory)** | |  | | |  | |  |  |
|  PAE Kernel Support | 2019, 2016, 2012 R2 | &#10004;  | &#10004;  | &#10004; | &#10004; |  &#10004;  |  &#10004; |  &#10004; |
|  Configuration of MMIO gap  | 2019, 2016, 2012 R2 | &#10004;  | &#10004;  | &#10004;  |  &#10004;  | &#10004;  |  &#10004; |  &#10004; |
|  Dynamic Memory - Hot-Add | 2019, 2016, 2012 R2 |  &#10004; Note 7, 9, 10  | &#10004; Note 7, 9, 10 | &#10004; Note 7, 9, 10 | &#10004; Note 7, 9, 10 | &#10004; Note 7, 8, 9, 10 | &#10004; Note 7, 8, 9, 10 | |
|  Dynamic Memory - Ballooning | 2019, 2016, 2012 R2 | &#10004; Note 7, 9, 10  | &#10004; Note 7, 9, 10  | &#10004; Note 7, 9, 10 | &#10004; Note 7, 9, 10 |  &#10004; Note 7, 9, 10   |  &#10004; Note 7, 9, 10   | &#10004; Note 7, 9, 10, 11 |
| Runtime Memory Resize | 2019, 2016  |  |   |  |  | |  |  |
| **[Video](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#video)** || | | |  |  |  | |
| Hyper-V-specific video device | 2019, 2016, 2012 R2 | &#10004;  | &#10004;  | &#10004;  | &#10004; | &#10004; | &#10004; | |
| **[Miscellaneous](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#miscellaneous)** |  |  |  |   |  | |  |  |
| Key-Value Pair | 2019, 2016, 2012 R2 | &#10004; | &#10004;| &#10004; | &#10004; Note 12 | &#10004; Note 12 | &#10004; Note 12, 13 | &#10004; Note 12, 13 |
| Non-Maskable Interrupt | 2019, 2016, 2012 R2 | &#10004;  | &#10004;  | &#10004; | &#10004; | &#10004;  |  &#10004;| &#10004; |
| File copy from host to guest | 2019, 2016, 2012 R2 | &#10004;  |  &#10004; | &#10004; | &#10004; | &#10004; | |  |
| lsvmbus command | 2019, 2016, 2012 R2 |  &#10004; |  &#10004;  |  &#10004; |   |   |    |  |
| Hyper-V Sockets | 2019, 2016  | &#10004;  |  &#10004;  |  &#10004; |  |   |   |  |
| PCI Passthrough/DDA | 2019, 2016 | &#10004;  | |   |  |  | |   |
| **[Generation 2 virtual machines](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#generation-2-virtual-machines)** | |  | | | | | | |
| Boot using UEFI  | 2012 R2 |  |  |  |  |  | |
|  |2019, 2016 | &#10004; Note 14 | &#10004; Note 14| &#10004; Note 14 |    &#10004; Note 14    |  | |  |
|Secure boot| 2019, 2016|  ||  |  |  | ||



## RHEL/CentOS 5.x Series

This series has a supported 32-bit PAE kernel available. There is no built-in LIS support for RHEL/CentOS before 5.9.


|                                                                 **Feature**                                                                  |     **Windows Server version**     |                              5.2 -5.11                              |                            **5.2-5.11**                             |    **5.9 - 5.11**     |
|----------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------|---------------------------------------------------------------------|---------------------------------------------------------------------|-----------------------|
|                                                               **Availability**                                                               |                                    | [LIS 4.3](https://www.microsoft.com/download/details.aspx?id=55106) | [LIS 4.1](https://www.microsoft.com/download/details.aspx?id=51612) |       Built in        |
|                          **[Core](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#core)**                          | 2019, 2016, 2012 R2 |                              &#10004;                               |                              &#10004;                               |       &#10004;        |
|                                                      Windows Server 2016 Accurate Time                                                       |             2019, 2016             |                                                                     |                                                                     |                       |
|                    **[Networking](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#networking)**                    |                                    |                                                                     |                                                                     |                       |
|                                                                 Jumbo frames                                                                 | 2019, 2016, 2012 R2 |                              &#10004;                               |                              &#10004;                               |       &#10004;        |
|                                                          VLAN tagging and trunking                                                           | 2019, 2016, 2012 R2 |                           &#10004; Note 1                           |                           &#10004; Note 1                           |    &#10004; Note 1    |
|                                                                Live Migration                                                                | 2019, 2016, 2012 R2 |                              &#10004;                               |                              &#10004;                               |       &#10004;        |
|                                                             Static IP Injection                                                              |     2019, 2016, 2012 R2      |                           &#10004; Note 2                           |                           &#10004; Note 2                           |    &#10004; Note 2    |
|                                                                     vRSS                                                                     |        2019, 2016, 2012 R2         |                                                                     |                                                                     |                       |
|                                                    TCP Segmentation and Checksum Offloads                                                    | 2019, 2016, 2012 R2 |                              &#10004;                               |                              &#10004;                               |                       |
|                                                                    SR-IOV                                                                    |             2019, 2016             |                                                                     |                                                                     |                       |
|                       **[Storage](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#storage)**                       |                                    |                                                                     |                                                                     |                       |
|                                                                 VHDX resize                                                                  |        2019, 2016, 2012 R2         |                              &#10004;                               |                              &#10004;                               |                       |
|                                                            Virtual Fibre Channel                                                             |        2019, 2016, 2012 R2         |                           &#10004; Note 3                           |                           &#10004; Note 3                           |                       |
|                                                         Live virtual machine backup                                                          |        2019, 2016, 2012 R2         |                         &#10004; Note 5, 15                         |                           &#10004; Note 5                           | &#10004; Note 4, 5, 6 |
|                                                                 TRIM support                                                                 |        2019, 2016, 2012 R2         |                                                                     |                                                                     |                       |
|                                                                   SCSI WWN                                                                   |        2019, 2016, 2012 R2         |                                                                     |                                                                     |                       |
|                        **[Memory](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#memory)**                        |                                    |                                                                     |                                                                     |                       |
|                                                              PAE Kernel Support                                                              | 2019, 2016, 2012 R2 |                              &#10004;                               |                              &#10004;                               |       &#10004;        |
|                                                          Configuration of MMIO gap                                                           |        2019, 2016, 2012 R2         |                              &#10004;                               |                              &#10004;                               |       &#10004;        |
|                                                           Dynamic Memory - Hot-Add                                                           |     2019, 2016, 2012 R2      |                                                                     |                                                                     |                       |
|                                                         Dynamic Memory - Ballooning                                                          |     2019, 2016, 2012 R2      |                     &#10004; Note 7, 9, 10, 11                      |                     &#10004; Note 7, 9, 10, 11                      |                       |
|                                                            Runtime Memory Resize                                                             |             2019, 2016             |                                                                     |                                                                     |                       |
|                         **[Video](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#video)**                         |                                    |                                                                     |                                                                     |                       |
|                                                        Hyper-V-specific video device                                                         | 2019, 2016, 2012 R2 |                              &#10004;                               |                              &#10004;                               |                       |
|                 **[Miscellaneous](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#miscellaneous)**                 |                                    |                                                                     |                                                                     |                       |
|                                                                Key-Value Pair                                                                | 2019, 2016, 2012 R2 |                              &#10004;                               |                              &#10004;                               |                       |
|                                                            Non-Maskable Interrupt                                                            |        2019, 2016, 2012 R2         |                              &#10004;                               |                              &#10004;                               |       &#10004;        |
|                                                         File copy from host to guest                                                         |        2019, 2016, 2012 R2         |                              &#10004;                               |                              &#10004;                               |                       |
|                                                               lsvmbus command                                                                | 2019, 2016, 2012 R2 |                                                                     |                                                                     |                       |
|                                                               Hyper-V Sockets                                                                |             2019, 2016             |                                                                     |                                                                     |                       |
|                                                             PCI Passthrough/DDA                                                              |             2019, 2016             |                                                                     |                                                                     |                       |
| **[Generation 2 virtual machines](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#generation-2-virtual-machines)** |                                    |                                                                     |                                                                     |                       |
|                                                               Boot using UEFI                                                                |        2019, 2016, 2012 R2         |                                                                     |                                                                     |                       |
|                                                                 Secure boot                                                                  |             2019, 2016             |                                                                     |                                                                     |                       |

## Notes

1. For this RHEL/CentOS release, VLAN tagging works but VLAN trunking does not.

2. Static IP injection may not work if Network Manager has been configured for a given synthetic network adapter on the virtual machine. For smooth functioning of static IP injection please make sure that either Network Manager is either turned off completely or has been turned off for a specific network adapter through its ifcfg-ethX file.

3. On Windows Server 2012 R2 while using virtual fibre channel devices, make sure that logical unit number 0 (LUN 0) has been populated. If LUN 0 has not been populated, a Linux virtual machine might not be able to mount fibre channel devices natively.

4. For built-in LIS, the "hyperv-daemons" package must be installed for this functionality.

5. If there are open file handles during a live virtual machine backup operation, then in some corner cases, the backed-up VHDs might have to undergo a file system consistency check (fsck) on restore. Live backup operations can fail silently if the virtual machine has an attached iSCSI device or direct-attached storage (also known as a pass-through disk).

6. While the Linux Integration Services download is preferred, live backup support for RHEL/CentOS 5.9 - 5.11/6.4/6.5 is also available through [Hyper-V Backup Essentials for Linux](https://github.com/LIS/backupessentials/tree/1.0).

7. Dynamic memory support is only available on 64-bit virtual machines.

8. Hot-Add support is not enabled by default in this distribution. To enable Hot-Add support you need to add a udev rule under /etc/udev/rules.d/ as follows:

   1. Create a file **/etc/udev/rules.d/100-balloon.rules**. You may use any other desired name for the file.

   2. Add the following content to the file: `SUBSYSTEM=="memory", ACTION=="add", ATTR{state}="online"`

   3. Reboot the system to enable Hot-Add support.

   While the Linux Integration Services download creates this rule on installation, the rule is also removed when LIS is uninstalled, so the rule must be recreated if dynamic memory is needed after uninstallation.

9. Dynamic memory operations can fail if the guest operating system is running too low on memory. The following are some best practices:

   * Startup memory and minimal memory should be equal to or greater than the amount of memory that the distribution vendor recommends.

   * Applications that tend to consume the entire available memory on a system are limited to consuming up to 80 percent of available RAM.

10. If you are using Dynamic Memory on a Windows Server 2016 or Windows Server 2012 R2 operating system, specify **Startup memory**, **Minimum memory**, and **Maximum memory** parameters in multiples of 128 megabytes (MB). Failure to do so can lead to hot-add failures, and you may not see any memory increase in a guest operating system.

11. Certain distributions, including those using LIS 4.0 and 4.1, only provide Ballooning support and do not provide Hot-Add support. In such a scenario, the dynamic memory feature can be used by setting the Startup memory parameter to a value which is equal to the Maximum memory parameter. This results in all the requisite memory being Hot-Added to the virtual machine at boot time and then later depending upon the memory requirements of the host, Hyper-V can freely allocate or deallocate memory from the guest using Ballooning. Please configure **Startup Memory** and **Minimum Memory** at or above the recommended value for the distribution.

12. To enable key/value pair (KVP) infrastructure, install the hypervkvpd or hyperv-daemons rpm package from your RHEL ISO. Alternatively the package can be installed directly from RHEL repositories.

13. The key/value pair (KVP) infrastructure might not function correctly without a Linux software update. Contact your distribution vendor to obtain the software update in case you see problems with this feature.

14. On Windows Server 2012 R2 Generation 2 virtual machines have secure boot enabled by default and some Linux virtual machines will not boot unless the secure boot option is disabled. You can disable secure boot in the **Firmware** section of the settings for the virtual machine in **Hyper-V Manager** or you can disable it using Powershell:

    ```Powershell
    Set-VMFirmware -VMName "VMname" -EnableSecureBoot Off
    ```

    The Linux Integration Services download can be applied to existing Generation 2 VMs but does not impart Generation 2 capability.

15. In Red Hat Enterprise Linux or CentOS 5.2, 5.3, and 5.4 the filesystem freeze functionality is not available, so Live Virtual Machine Backup is also not available.

See Also

* [Set-VMFirmware](https://technet.microsoft.com/library/dn464287.aspx)

* [Supported Debian virtual machines on Hyper-V](Supported-Debian-virtual-machines-on-Hyper-V.md)

* [Supported Oracle Linux virtual machines on Hyper-V](Supported-Oracle-Linux-virtual-machines-on-Hyper-V.md)

* [Supported SUSE virtual machines on Hyper-V](Supported-SUSE-virtual-machines-on-Hyper-V.md)

* [Supported Ubuntu virtual machines on Hyper-V](Supported-Ubuntu-virtual-machines-on-Hyper-V.md)

* [Supported FreeBSD virtual machines on Hyper-V](Supported-FreeBSD-virtual-machines-on-Hyper-V.md)

* [Feature Descriptions for Linux and FreeBSD virtual machines on Hyper-V](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md)

* [Best Practices for running Linux on Hyper-V](Best-Practices-for-running-Linux-on-Hyper-V.md)

* [Red Hat Hardware Certification](https://hardware.redhat.com/&quicksearch=Microsoft)
