---
title: Supported Windows guest operating systems for Hyper-V on Windows Server
description: Lists the Windows operating systems supported for use as a guest in a virtual machine. Also gives links to similar articles for previous versions of Hyper-V.
ms.prod: windows-server
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 06b35897-2192-48b7-8c2d-125c520b0786
author: lizap
ms.author: elizapo
ms.date: 01/08/2019
---
# Supported Windows guest operating systems for Hyper-V on Windows Server

>Applies To: Windows Server 2016, Windows Server 2019

Hyper-V supports several versions of Windows Server, Windows, and Linux distributions to run in virtual machines, as guest operating systems. This article covers supported Windows Server and Windows guest operating systems. For Linux and FreeBSD distributions, see [Supported Linux and FreeBSD virtual machines for Hyper-V on Windows](Supported-Linux-and-FreeBSD-virtual-machines-for-Hyper-V-on-Windows.md).  
    
Some operating systems have the integration services built-in. Others require that you install or upgrade integration services as a separate step after you set up the operating system in the virtual machine. For more information, see the sections below and  [Integration Services](https://docs.microsoft.com/virtualization/hyper-v-on-windows/reference/integration-services).  
  
## Supported Windows Server guest operating systems  

Following are the versions of Windows Server that are supported as guest operating systems for Hyper-V in Windows Server 2016 and Windows Server 2019. 
  
|Guest operating system (server)|Maximum number of virtual processors|Integration Services|Notes|  
|-------------------------------------|----------------------------------------|------------------------|---------| 
|Windows Server, version 1909 |240 for generation 2;<br>64 for generation 1|Built-in|Greater than 240 virtual processor support requires Windows Server, version 1903 or later guest operating systems.| 
|Windows Server, version 1903 |240 for generation 2;<br>64 for generation 1|Built-in||
|Windows Server, version 1809 |240 for generation 2;<br>64 for generation 1|Built-in|| 
|Windows Server 2019 |240 for generation 2;<br>64 for generation 1|Built-in||
|Windows Server, version 1803 |240 for generation 2;<br>64 for generation 1|Built-in|| 
|Windows Server 2016 |240 for generation 2;<br>64 for generation 1|Built-in|| 
|Windows Server 2012 R2 |64|Built-in||  
|Windows Server 2012 |64|Built-in||  
|Windows Server 2008 R2 with Service Pack 1 (SP 1)|64|Install all critical Windows updates after you set up the guest operating system.|Datacenter, Enterprise, Standard and Web editions.|
|Windows Server 2008 with Service Pack 2 (SP2)|8|Install all critical Windows updates after you set up the guest operating system.|Datacenter, Enterprise, Standard and Web editions (32-bit and 64-bit).|  
  
## Supported Windows client guest operating systems  

Following are the versions of Windows client that are supported as guest operating systems for Hyper-V in Windows Server 2016 and Windows Server 2019.
  
|Guest operating system (client)|Maximum number of virtual processors|Integration Services|Notes|  
|-------------------------------------|----------------------------------------|------------------------|---------|  
|Windows 10|32|Built-in||  
|Windows 8.1|32|Built-in||  
|Windows 7 with Service Pack 1 (SP 1)|4|Upgrade the integration services after you set up the guest operating system.|Ultimate, Enterprise, and Professional editions (32-bit and 64-bit).|  
  
## Guest operating system support on other versions of Windows  

The following table gives links to information about guest operating systems supported for Hyper-V on other versions of Windows.  
  
|Host operating system|Topic|  
|-------------------------|---------|  
|Windows 10|[Supported Guest Operating Systems for Client Hyper-V in Windows 10](https://docs.microsoft.com/virtualization/hyper-v-on-windows/about/supported-guest-os)|  
|Windows Server 2012 R2 and Windows 8.1|-   [Supported Windows Guest Operating Systems for Hyper-V in Windows Server 2012 R2 and Windows 8.1](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn792027(v=ws.11))<br />-   [Linux and FreeBSD Virtual Machines on Hyper-V](Supported-Linux-and-FreeBSD-virtual-machines-for-Hyper-V-on-Windows.md)|  
|Windows Server 2012 and Windows 8|[Supported Windows Guest Operating Systems for Hyper-V in Windows Server 2012 and Windows 8](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn792028(v=ws.11))|  
|Windows Server 2008 and Windows Server 2008 R2|[About Virtual Machines and Guest Operating Systems](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc794868(v=ws.10))|  
  
## How Microsoft provides support for guest operating systems  

Microsoft provides support for guest operating systems in the following manner:  
  
-   Issues found in Microsoft operating systems and in integration services are supported by Microsoft support.  
  
-   For issues found in other operating systems that have been certified by the operating system vendor to run on Hyper-V, support is provided by the vendor.  
  
-   For issues found in other operating systems, Microsoft submits the issue to the multi-vendor support community, [TSANet](https://www.tsanet.org/).  
  
## See also  
  
-   [Linux and FreeBSD Virtual Machines on Hyper-V](Supported-Linux-and-FreeBSD-virtual-machines-for-Hyper-V-on-Windows.md)  
  
-   [Supported Guest Operating Systems for Client Hyper-V in Windows 10](https://docs.microsoft.com/virtualization/hyper-v-on-windows/about/supported-guest-os)  
  



