---
title: DNSSEC Requirements
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7bc65a7f-e18c-4522-bcb5-22a0521d454d
---
# DNSSEC Requirements
The following table shows the requirements for DNSSEC deployment.  
  
|Category|Requirement|Details|  
|------------|---------------|-----------|  
|**Operating system**|[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], or a later operating system is required.|DNS servers must be running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or a later operating system to sign a zone with DNSSEC or validate DNSSEC signatures.<br /><br />To allow for staged migration of server operating systems, DNSSEC deployment does not require that all DNS servers are running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]or later. A mixed\-mode environment is supported, with limitations.<br /><br />A server running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] can host a static, offline\-signed zone, however DNSSEC settings on a zone signed with [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] cannot be modified by DNS servers running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or a later operating system. DNSSEC\-related resource records in this type of zone will be loaded and can be validated on DNS servers running a later operating system, but for most operations the zone is treated as if it is unsigned.<br /><br />A zone that is signed on a DNS server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]or later will be loaded as an unsigned zone on a secondary or Active Directory\-integrated primary DNS server running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].|  
|**Server roles**|The DNS Server role is required.|Computers that host DNSSEC\-signed zones must have the DNS Server role installed and running.<br /><br />To host an Active Directory\-integrated DNS zone, DNS servers must also be running the Active Directory Domain Services \(AD DS\) role.<br /><br />Additional roles and role services are optional.|  
|**Features**|Features are required to perform administrative tasks.|No features are required to host a DNSSEC\-signed DNS zone. However, some features are required to perform administrative tasks.<br /><br />For example, Group Policy Management is required to configure the NRPT, and DNS Server Tools are required to sign or unsign a zone using DNS Manager, Windows PowerShell, or dnscmd.exe.<br /><br />If a DNS server does not have any features installed, it can still host a zone that was signed on a different DNS server.|  
|**Network**|The network requirements for DNSSEC are the same as those for the DNS protocol.<br /><br />**Note**: See EDNS0 requirements.|DNS servers can be on the same network or on different networks.<br /><br />DNS servers are recommended to have static IP addresses configured on all network adapters.<br /><br />The network infrastructure must support DNSSEC. See EDNS0 requirements later in this table.|  
|**EDNS0**|DNS servers must support EDNS0.|DNSSEC requires that EDNS0 is enabled on all DNS servers that will host or validate DNSSEC\-signed zones.<br /><br />EDNS0 enables large \(greater than 512 byte\) UDP packet support in DNS, which is required to send DNSSEC\-enabled DNS responses.<br /><br />There are known issues with network infrastructure devices such as routers and firewalls dropping, fragmenting, or changing the arrival order of greater than 512 byte UDP packets. This limitation can cause DNS queries to fail. Make sure that your network infrastructure is capable of passing large UDP\-formatted network packets.|  
|**DNS servers**|At least one primary, authoritative DNS server is required.|One or more primary, authoritative DNS servers are required to sign or unsign a zone with DNSSEC.<br /><br />At least one primary, authoritative DNS server is required to be the Key Master.<br /><br />Additional DNS servers are optional and can be primary, secondary, or resolving DNS servers.|  
|**DNS zones**|At least one primary DNS zone is required.|Both forward and reverse lookup zones can be signed with DNSSEC. Zones can be Active Directory\-integrated or file\-backed.<br /><br />When a zone is signed on a DNS server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or a later operating system, the zone will automatically be signed on all other primary DNS servers running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]or later. Zone signing on other primary DNS servers is delayed and staggered.<br /><br />A secondary DNS server depends on the primary DNS server to sign the zone and transfers a signed version of the zone from the primary server that supports DNSSEC validation.|  
|**Domain membership**|Not required.|DNS servers can be workgroup computers or domain member computers. However, workgroup computers cannot host Active Directory\-integrated DNS zones.|  
  
## See also  
[Why DNSSEC](../Topic/Why-DNSSEC.md)  
  
[Stage a DNSSEC Deployment](../Topic/Stage-a-DNSSEC-Deployment.md)  
  
[DNSSEC Performance Considerations](../Topic/DNSSEC-Performance-Considerations.md)  
  
