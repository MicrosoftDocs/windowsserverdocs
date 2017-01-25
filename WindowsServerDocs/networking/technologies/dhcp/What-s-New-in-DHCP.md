---
title: What's New in DHCP
description: This topic provides an overview of new features for Dynamic Host Configuration Protocol (DHCP) in Windows Server 2016. 
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - networking-dhcp
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: c6f36998-5b64-45d1-b1f0-0f0d6604dbe3
ms.author: jamesmci
author: jamesmci
---
# What's New in DHCP

>Applies To: Windows Server 2016

This topic describes the Dynamic Host Configuration Protocol (DHCP) functionality that is new or changed in Windows Server 2016.  
  
DHCP is an Internet Engineering Task Force (IETF) standard that is designed to reduce the administrative burden and complexity of configuring hosts on a TCP/IP-based network, such as a private intranet. By using the DHCP Server service, the process of configuring TCP/IP on DHCP clients is automatic.  
  
## <a name="BKMK_DHCP2012R2"></a>What's new in DHCP  

Network Access Protection (NAP) is deprecated in  Windows Server 2012 R2, and in Windows Server 2016 the DHCP Server role no longer supports NAP. For more information, see [Features Removed or Deprecated in Windows Server 2012 R2](http://technet.microsoft.com/library/dn303411.aspx).  
  
NAP support was introduced to the DHCP Server role with  Windows Server 2008  and is supported in Windows client and server operating systems prior to Windows 10 and Windows Server 2016. The following table summarizes support for NAP in Windows Server.  
  
|Operating system|NAP support|  
|--------------------|---------------|  
| Windows Server 2008 |Supported|  
| Windows Server 2008 R2 |Supported|  
| Windows Server 2012 |Supported|  
| Windows Server 2012 R2 |Supported|  
| Windows Server 2016|Not supported|  
  
In a NAP deployment, a DHCP server running an operating system that supports NAP can function as a NAP enforcement point for the NAP DHCP enforcement method. For more information about DHCP in NAP, see [Checklist: Implementing a DHCP Enforcement Design](http://technet.microsoft.com/library/dd314186.aspx).  
  
In Windows Server 2016, DHCP servers will not enforce NAP policies, and DHCP scopes cannot be NAP-enabled. DHCP client computers that are also NAP clients will send a statement of health (SoH) with the DHCP request. If the DHCP server is running Windows Server 2016, these requests will be treated as if no SoH is present and will grant a normal DHCP lease. If servers running Windows Server 2016 are RADIUS proxies that forward authentication requests to a Network Policy Server (NPS) that supports NAP, these NAP clients will be evaluated as non NAP-capable.  
  
## See also  
  
-   [Dynamic Host Configuration Protocol (DHCP)](Dynamic-Host-Configuration-Protocol--DHCP-.md)  
  

