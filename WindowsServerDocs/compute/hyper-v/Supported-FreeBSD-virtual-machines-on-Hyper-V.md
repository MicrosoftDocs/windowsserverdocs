---
title: Supported FreeBSD virtual machines on Hyper-V
description: " "
ms.prod: windows-server-threshold
ms.service: na
manager: timlt
ms.technology: compute-hyper-v
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 930e758f-bd50-46b4-a3a4-9857110f17b4
author: shirgall
ms.author: cwatson
ms.date: 8/16/2016
---
# Supported FreeBSD virtual machines on Hyper-V

>Applies To: Windows Server 2016 Technical Preview, Hyper-V Server 2016 Technical Preview, Windows Server 2012 R2, Hyper-V Server 2012 R2, Windows Server 2012, Hyper-V Server 2012, Windows Server 2008 R2, Windows Server 2008, Windows 10, Windows 8.1, Windows 8, Windows 7.1, Windows 7

The following feature distribution map indicates the features in each version. The known issues and workarounds for each distribution are listed after the table.  
  
**Table legend**  
  
-   **Built in** - BIS are included as part of this FreeBSD release.  
  
-   &#10004; - Feature available  
  
-   (*blank*) - Feature not available  
  
  
|**Feature**|**Windows Server operating system version**|**10.3**|**10.2**|**10 - 10.1**|**9.1 - 9.3**|**8.4**|  
|-|-|-|-|-|-|-|  
|**Availability**||Built in|Built in|Built in|[Ports](http://svnweb.freebsd.org/ports/head/emulators/hyperv-is/) Note 1|[Ports](http://svnweb.freebsd.org/ports/head/emulators/hyperv-is/) Note 2|  
|**[Core](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#BKMK_core)**|2016, 2012 R2, 2012, 2008 R2|&#10004;|&#10004;|&#10004;|&#10004; Note 3|&#10004; Note 3|  
|**[Networking](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#BKMK_Networking)**||||||| 
|Jumbo frames|2016, 2012 R2, 2012, 2008 R2|&#10004; Note 4|&#10004; Note 4|&#10004; Note 4|&#10004; Note 4|&#10004; Note 4|  
|VLAN tagging and trunking|2016, 2012 R2, 2012, 2008 R2|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|  
|Live migration|2016, 2012 R2, 2012, 2008 R2|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|  
|Static IP Injection|2016, 2012 R2, 2012|&#10004; Note 5|&#10004; Note 5|&#10004; Note 5|&#10004;|&#10004;|  
|vRSS|2016, 2012 R2||||||  
|TCP Segmentation and Checksum Offloads|2016, 2012 R2, 2012, 2008 R2|&#10004;|&#10004;||||  
|Large Receive Offload (LRO)|2016, 2012 R2, 2012, 2008 R2|&#10004;|||||
|**[Storage](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#BKMK_Storage)**|||||||
|VHDX resize|2016, 2012 R2||||||  
|Virtual Fibre Channel|2016, 2012 R2||||||  
|Live virtual machine backup|2016, 2012 R2||||||  
|TRIM support|2016, 2012 R2||||||  
|SCSI WWN|2016, 2012 R2||||||  
|**[Memory](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#BKMK_Memory)**||||||| 
|PAE Kernel Support|2016, 2012 R2, 2012, 2008 R2||||||
|Configuration of MMIO gap|2016, 2012 R2|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|  
|Dynamic Memory - Hot-Add|2016, 2012 R2, 2012|||||| 
|Dynamic Memory - Ballooning|2016, 2012 R2, 2012||||||  
|Runtime Memory Resize|2016||||||  
|**[Video](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#BKMK_Video)**|||||||
|Hyper-V specific video device|2016, 2012 R2, 2012, 2008 R2||||||  
|**[Miscellaneous](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#BKMK_Misc)**||||||| 
|Key/value pair|2016, 2012 R2, 2012, 2008 R2|&#10004; Note 7|&#10004; Note 7|&#10004; Note 6, 7|&#10004; Note 7|&#10004; Note 7|  
|Non-Maskable Interrupt|2016, 2012 R2|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|   
|File copy from host to guest|2016, 2012 R2||||||  
|lsvmbus command|2016, 2012 R2, 2012, 2008 R2||||||  
|Hyper-V Sockets|2016||||||  
|PCI Passthrough/DDA|2016||||||
|**[Generation 2 virtual machines](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#BKMK_gen2)**|||||||  
|Boot using UEFI|2016, 2012 R2||||||  
|Secure boot|2016||||||| 
  
## <a name="BKMK_notes"></a>Notes  
  
1.  To install BIS on FreeBSD 9.x, you need to add UUIDs for all devices listed in fstab before installation. For more information, see [Add UUIDs for all devices listed in fstab](Best-practices-for-running-FreeBSD-on-Hyper-V.md#BKMK_UUID).  
  
2.  To install BIS on FreeBSD 8.x, you need to disable the fast IDE driver or create GEOM labels. For more information, see [Disable the Fast IDE Driver](Best-practices-for-running-FreeBSD-on-Hyper-V.md#BKMK_IDE) or [Create GEOM labels on FreeBSD 8.x](Best-practices-for-running-FreeBSD-on-Hyper-V.md#BKMK_GEOM).  
  
3.  The virtual DVD drive will not be recognized when BIS drivers are loaded on FreeBSD 8.x and 9.x unless you disable the fast IDE driver. For more information, see [Disable the Fast IDE Driver](Best-practices-for-running-FreeBSD-on-Hyper-V.md#BKMK_IDE).  
  
4.  9K is the maximum supported MTU size.  
  
5.  In a failover scenario, you cannot set a static IPv6 address in the replica server. Use an IPv4 address instead.  
  
6.  KVP is provided by ports on FreeBSD 10. See the [FreeBSD 10 ports](http://svnweb.freebsd.org/ports/head/emulators/hyperv-is/) on FreeBSD.org for more information.  
  
7.  KVP may not work on Windows Server 2008 R2.  
  
**See Also**  
  
-   [Feature Descriptions for Linux and FreeBSD virtual machines on Hyper-V](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md)  
  
-   [Best practices for running FreeBSD on Hyper-V](Best-practices-for-running-FreeBSD-on-Hyper-V.md)  
  


