---
title: What&#39;s New in DNS Client in Windows Server Technical Preview
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6edaba84-4595-4fd8-95d7-64d4d975a38a
author: vhorne
---
# What&#39;s New in DNS Client in Windows Server Technical Preview
This topic describes the Domain Name System \(DNS\) client functionality that is new or changed in [!INCLUDE[winthreshold_client_1](../Token/winthreshold_client_1_md.md)].  
  
## <a name="BKMK_DNSClient2012R2"></a>Updates to DNS Client in Windows Technical Preview  
**DNS Client service binding**: In [!INCLUDE[winthreshold_client_2](../Token/winthreshold_client_2_md.md)], the DNS Client service offers enhanced support for computers with more than one network interface. For multi\-homed computers, DNS resolution is optimized in the following ways:  
  
-   When a DNS server that is configured on a specific interface is used to resolve a DNS query, the DNS Client service will bind to this interface before sending the DNS query.  
  
    By binding to a specific interface, the DNS client can clearly specify the interface where name resolution occurs, enabling applications to optimize communications with the DNS client over this network interface.  
  
-   If the DNS server that is used is designated by a Group Policy setting from the Name Resolution Policy Table \(NRPT\), the DNS Client service does not bind to a specific interface.  
  
> [!NOTE]  
> Changes to the DNS Client service in [!INCLUDE[winthreshold_client_2](../Token/winthreshold_client_2_md.md)] are also present in computers running [!INCLUDE[winthreshold_server_2](../Token/winthreshold_server_2_md.md)].  
  
## See also  
  
-   [What's New in DNS Server in Windows Server Technical Preview](../Topic/What-s-New-in-DNS-Server-in-Windows-Server-Technical-Preview.md)  
  
