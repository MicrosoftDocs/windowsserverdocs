---
title: What's New in DNS Client in Windows Server
description: This topic provides an overview of new features in DNS Client in Windows Server and Windows 10
manager: brianlic
ms.prod: windows-server
ms.technology: networking-dns
ms.topic: article
ms.assetid: 6edaba84-4595-4fd8-95d7-64d4d975a38a
ms.author: lizross
author: eross-msft
---
# What's New in DNS Client in Windows Server 2016

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

This topic describes the Domain Name System (DNS) client functionality that is new or changed in Windows 10 and Windows Server 2016 and later versions of these operating systems.
  
## Updates to DNS Client

**DNS Client service binding**: In Windows 10, the DNS Client service offers enhanced support for computers with more than one network interface. For multi-homed computers, DNS resolution is optimized in the following ways:  
  
-   When a DNS server that is configured on a specific interface is used to resolve a DNS query, the DNS Client service will bind to this interface before sending the DNS query.  
  
    By binding to a specific interface, the DNS client can clearly specify the interface where name resolution occurs, enabling applications to optimize communications with the DNS client over this network interface.  
  
-   If the DNS server that is used is designated by a Group Policy setting from the Name Resolution Policy Table (NRPT), the DNS Client service does not bind to a specific interface.  
  
> [!NOTE]  
> Changes to the DNS Client service in Windows 10 are also present in computers running Windows Server 2016 and later versions.  
  
## See also  
  
-   [What's New in DNS Server in Windows Server 2016](What-s-New-in-DNS-Server.md)  
  

