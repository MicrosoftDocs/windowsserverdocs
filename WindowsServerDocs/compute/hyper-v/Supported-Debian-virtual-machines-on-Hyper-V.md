---
title: Supported Debian virtual machines on Hyper-V
description: " "
ms.prod: windows-server-threshold
ms.service: na
manager: timlt
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3cc62c10-02a3-4633-960c-23bf91a45bd5
author: cwatsonmsft
---
# Supported Debian virtual machines on Hyper-V

>Applies To: Hyper-V Server 2012, Hyper-V Server 2012 R2, Microsoft Hyper-V Server Technical Preview, Windows 10, Windows 8, Windows 8.1, Windows Server 2012, Windows Server 2012 R2, Windows Server Technical Preview

The following feature distribution map indicates the features that are present in each version. The known issues and workarounds for each distribution are listed after the table.  
  
**Table legend**  
  
-   **Built in** - LIS are included as part of this Linux distribution. The Microsoft-provided LIS download package doesn't work for this distribution so do not install it. The kernel module version numbers for the built in LIS (as shown by **lsmod**, for example) are different from the version number on the Microsoft-provided LIS download package. A mismatch does not indicate that the built in LIS is out of date.  
  
-   **√** - Feature available  
  
-   (*blank*) - Feature not available  
  
|**Feature**|**Windows Server operating system version**|**8.0-8.4 (jessie)**|**7.0-7.10 (wheezy)**|  
|-|-|-|-|  
|**Availability**||Built in|Built in (Note 6)|  
|**[Core](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#BKMK_core)**|2016, 2012 R2, 2012, 2008 R2|**√**|**√**|  
|**[Networking](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#BKMK_Networking)**|  
|Jumbo frames|2016, 2012 R2, 2012, 2008 R2|**√**|**√**|  
|VLAN tagging and trunking|2016, 2012 R2, 2012, 2008 R2|**√**|**√**|  
|Live Migration|2016, 2012 R2, 2012, 2008 R2|**√**|**√**|  
|Static IP Injection|2016, 2012 R2, 2012|||  
|vRSS|2016, 2012 R2|||  
|TCP Segmentation and Checksum Offloads|2016, 2012 R2, 2012, 2008 R2|||  
|**[Storage](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#BKMK_Storage)**|  
|VHDX resize|2016, 2012 R2|**√** Note 1|**√** Note 1|  
|Virtual Fibre Channel|2016, 2012 R2|||  
|Live virtual machine backup|2016, 2012 R2|**√** Note 4,5|**√** Note 4|  
|TRIM support|2016, 2012 R2|||  
|SCSI WWN|2016, 2012 R2|||  
|**[Memory](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#BKMK_Memory)**|  
|Configuration of MMIO gap|2016, 2012 R2|**√**|**√**|  
|Dynamic Memory - Hot Add|2016, 2012 R2, 2012|||  
|Dynamic Memory - Ballooning|2016, 2012 R2, 2012|||  
|Manual Memory Hot Add|2016|||  
|**[Video](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#BKMK_Video)**|  
|Hyper-V-specific  video device|2016, 2012 R2, 2012, 2008 R2|**√**||  
|**[Miscellaneous](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#BKMK_Misc)**|  
|Key-Value Pair|2016, 2012 R2, 2012, 2008 R2|**√** Note 4||  
|Non-Maskable Interrupt|2016, 2012 R2|**√**|**√**|  
|PAE Kernel Support|2016, 2012 R2, 2012, 2008 R2|**√**|**√**|  
|File copy from host to guest|2016, 2012 R2|**√** Note 4||  
|lsvmbus command|2016, 2012 R2, 2012, 2008 R2|||  
|Hyper-V Sockets|2016|||  
|**[Generation 2 virtual machines](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#BKMK_gen2)**|  
|Boot using UEFI|2016, 2012 R2|||  
|Secure boot|2016|||  
  
## <a name="BKMK_notes"></a>Notes  
  
1.  Creating file systems on VHDs larger than 2TB is not supported.  
  
2.  On Windows Server 2008 R2, SCSI disks create 8 different entries in /dev/sd*.  
  
3.   Windows Server 2012 R2 , a VM with 8 cores or more will have all interrupts routed to a single vCPU.  
  
4.  Starting with Debian 8.3 the manually-installed Debian package "hyperv-daemons" contains the key-value pair, fcopy, and VSS daemons. On Debian 7.x and 8.0-8.2 the hyperv-daemons package must come from [Debian backports](https://wiki.debian.org/Backports).  
  
5. Live virtual machine backup will not work with ext2 file systems. The default layout created by the Debian installer includes ext2 filesystems, you you must customize the layout to not create this filesystem type.  
  
6. The kernel included in [Debian backports](https://wiki.debian.org/Backports) has improved Hyper-V support compared to the stable kernel.  
  
See Also  
  
-   [Supported CentOS and Red Hat Enterprise Linux virtual machines on Hyper-V](Supported-CentOS-and-Red-Hat-Enterprise-Linux-virtual-machines-on-Hyper-V.md)  
  
-   [Supported Oracle Linux virtual machines on Hyper-V](Supported-Oracle-Linux-virtual-machines-on-Hyper-V.md)  
  
-   [Supported SUSE virtual machines on Hyper-V](Supported-SUSE-virtual-machines-on-Hyper-V.md)  
  
-   [Supported Ubuntu virtual machines on Hyper-V](Supported-Ubuntu-virtual-machines-on-Hyper-V.md)  
  
-   [Supported FreeBSD virtual machines on Hyper-V](Supported-FreeBSD-virtual-machines-on-Hyper-V.md)  
  
-   [Feature Descriptions for Linux and FreeBSD virtual machines on Hyper-V](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md)  
  
-   [Best Practices for running Linux on Hyper-V](Best-Practices-for-running-Linux-on-Hyper-V.md)  


