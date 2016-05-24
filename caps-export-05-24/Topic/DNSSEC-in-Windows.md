---
title: DNSSEC in Windows
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b0d76b3a-1298-4e25-93f4-ddbc19b67fc0
---
# DNSSEC in Windows
Support for Domain Name System Security Extensions \(DNSSEC\) in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] is significantly enhanced in comparison to previous versions of Windows. See the following topics for more information:  
  
-   [DNS Servers](../Topic/DNS-Servers.md): Support for DNSSEC\-signed zones on primary, authoritative DNS servers was added with [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. However, support in [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] was limited to offline signing of static zones and standards such as NSEC3 and RSA\/SHA\-2 were not supported. DNSSEC support is enhanced significantly in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]and later operating systems.  
  
-   [DNS Clients](../Topic/DNS-Clients.md): The DNS Client service in [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] and later operating systems is DNSSEC\-aware. Previous operating systems were not DNSSEC\-aware. Operating systems that are DNSSEC aware can be configured to require DNSSEC validation.  
  
-   [DNS Zones](../Topic/DNS-Zones.md): Signing a zone with DNSSEC protects it from spoofing attacks. Before you can sign a zone with DNSSEC, you must specify several DNSSEC options and parameters. You can specify zone signing parameters and sign a zone with [!INCLUDE[wps_2](../Token/wps_2_md.md)], or you can use the Zone Signing Wizard that is provided in the DNS Manager console.  
  
-   [Trust Anchors](../Topic/Trust-Anchors.md): A trust anchor is a public cryptographic key that enables a DNS server to validate DNS responses in a namespace as genuine. If a DNS server has a trust anchor, it automatically attempts to validate DNS responses for that namespace. Trust anchors must be updated each time that a zone is signed.  
  
-   [The NRPT](../Topic/The-NRPT.md): The Name Resolution Policy Table \(NRPT\) is a table of namespaces and corresponding settings that are stored in the Windows registry. The registry determines the DNS client’s behavior when issuing queries and processing responses. You can use the NRPT to configure security\-aware DNS clients to require validation of DNS responses.  
  
## See also  
[Overview of DNSSEC](../Topic/Overview-of-DNSSEC.md)  
  
[DNSSEC Deployment Planning](../Topic/DNSSEC-Deployment-Planning.md)  
  
[Deploy DNSSEC with Windows Server 2012](../Topic/Deploy-DNSSEC-with-Windows-Server-2012.md)  
  
