---
title: What's New in DHCP
description: This topic provides an overview of new features for Dynamic Host Configuration Protocol (DHCP) in Windows Server 2016. 
manager: brianlic
ms.prod: windows-server
ms.technology: networking-dhcp
ms.topic: get-started-article
ms.assetid: c6f36998-5b64-45d1-b1f0-0f0d6604dbe3
ms.author: lizross
author: eross-msft
---
# What's New in DHCP

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

This topic describes the Dynamic Host Configuration Protocol (DHCP) functionality that is new or changed in Windows Server 2016.
  
DHCP is an Internet Engineering Task Force (IETF) standard that is designed to reduce the administrative burden and complexity of configuring hosts on a TCP/IP\-based network, such as a private intranet. By using the DHCP Server service, the process of configuring TCP/IP on DHCP clients is automatic.

The following sections provide information about new features and changes in functionality for DHCP.

## DHCP Subnet Selection Options

DHCP now supports options 118 and 82 \(sub-option 5\). You can use these options to allow DHCP proxy clients and relay agents to request an IP address for a specific subnet, and from a specific IP address range and scope.


If you are using a DHCP relay agent that is configured with DHCP option 82, sub\-option 5, the relay agent can request an IP address lease for DHCP clients from a specific IP address range.

For more information, see [DHCP Subnet Selection Options](dhcp-subnet-options.md).

## New Logging Events for DNS Registration Failures by the DHCP Server

DHCP now includes logging events for circumstances in which DHCP server DNS record registrations fail on the DNS server.

For more information, see [DHCP Logging Events for DNS Record Registrations](dhcp-dns-events.md).

## DHCP NAP Is Not Supported in Windows Server 2016

Network Access Protection \(NAP\) is deprecated in Windows Server 2012 R2, and in Windows Server 2016 the DHCP Server role no longer supports NAP. For more information, see [Features Removed or Deprecated in Windows Server 2012 R2](https://technet.microsoft.com/library/dn303411.aspx).  
  
NAP support was introduced to the DHCP Server role with  Windows Server 2008, and is supported in Windows client and server operating systems prior to Windows 10 and Windows Server 2016. The following table summarizes support for NAP in Windows Server.  
  
|Operating system|NAP support|  
|--------------------|---------------|  
| Windows Server 2008 |Supported|  
| Windows Server 2008 R2 |Supported|  
| Windows Server 2012 |Supported|  
| Windows Server 2012 R2 |Supported|  
| Windows Server 2016|Not supported|  
  
In a NAP deployment, a DHCP server running an operating system that supports NAP can function as a NAP enforcement point for the NAP DHCP enforcement method. For more information about DHCP in NAP, see [Checklist: Implementing a DHCP Enforcement Design](https://technet.microsoft.com/library/dd314186.aspx).  
  
In Windows Server 2016, DHCP servers do not enforce NAP policies, and DHCP scopes cannot be NAP\-enabled. DHCP client computers that are also NAP clients send a statement of health \(SoH\) with the DHCP request. If the DHCP server is running Windows Server 2016, these requests are processed as if no SoH is present. The DHCP server grants a normal DHCP lease to the client. 

If servers that are running Windows Server 2016 are RADIUS proxies that forward authentication requests to a Network Policy Server \(NPS\) that supports NAP, these NAP clients are evaluated by NPS as non NAP\-capable, and NAP processing fails.
  
## See also  
  
-   [Dynamic Host Configuration Protocol (DHCP)](Dynamic-Host-Configuration-Protocol--DHCP-.md)  
  

