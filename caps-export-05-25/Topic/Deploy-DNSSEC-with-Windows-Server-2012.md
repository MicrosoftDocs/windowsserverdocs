---
title: Deploy DNSSEC with Windows Server 2012
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c86e521c-e1f0-481c-9d1b-824d4b0f14eb
author: vhorne
---
# Deploy DNSSEC with Windows Server 2012
Use the following concepts and procedures to deploy Domain Name System Security Extensions \(DNSSEC\) in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
## Deploying DNSSEC  
To deploy DNSSEC, review DNSSEC conceptual information below, and then use the [DNSSEC deployment checklists](../Topic/Deploy-DNSSEC-with-Windows-Server-2012.md#chklsts_proc) that are provided in this guide.  
  
### <a name="concepts"></a>DNSSEC concepts  
  
-   [Overview of DNSSEC](../Topic/Overview-of-DNSSEC.md): Provides information about how DNSSEC works.  
  
-   [DNS Servers](../Topic/DNS-Servers.md): Describes DNSSEC support in Windows Server.  
  
-   [DNS Clients](../Topic/DNS-Clients.md): Describes the behavior of security\-aware and non\-security\-aware DNS clients.  
  
-   [DNS Zones](../Topic/DNS-Zones.md): Provides information about zone signing and unsigning with Windows PowerShell or DNS Manager.  
  
-   [Trust Anchors](../Topic/Trust-Anchors.md): Describes trust anchors, which are public cryptographic keys that must be installed on DNS servers to validate DNSSEC data.  
  
-   [The NRPT](../Topic/The-NRPT.md): Introduces and provides details about the Name Resolution Policy Table \(NRPT\).  
  
-   [Why DNSSEC](../Topic/Why-DNSSEC.md): Describes risks and benefits of DNSSEC.  
  
-   [Stage a DNSSEC Deployment](../Topic/Stage-a-DNSSEC-Deployment.md): Provides steps and considerations to help introduce DNSSEC to your environment.  
  
-   [DNSSEC Performance Considerations](../Topic/DNSSEC-Performance-Considerations.md): Describes the impact of zone signing on a DNS infrastructure.  
  
-   [DNSSEC Requirements](../Topic/DNSSEC-Requirements.md): Describes the requirements for deploying DNSSEC.  
  
### <a name="chklsts_proc"></a>DNSSEC deployment checklists  
  
|Checklist|Description|  
|-------------|---------------|  
|[Checklist: Deploy DNSSEC](../Topic/Checklist--Deploy-DNSSEC.md)|Use this parent checklist to get started deploying DNSSEC.|  
|[Checklist: Sign a Zone](../Topic/Checklist--Sign-a-Zone.md)|Sign a DNS zone and verify DNSSEC signing.|  
|[Checklist: Distribute Trust Anchors](../Topic/Checklist--Distribute-Trust-Anchors.md)|Export from authoritative DNS servers and import or add trust anchors to validating DNS servers.|  
|[Checklist: Deploy DNSSEC Policies to DNS Clients](../Topic/Checklist--Deploy-DNSSEC-Policies-to-DNS-Clients.md)|Configure and verify name resolution policy.|  
|[Checklist: Review and Manage a Signed Zone](../Topic/Checklist--Review-and-Manage-a-Signed-Zone.md)|Administer your signed zone.|  
|[Checklist: Revert to an Unsigned Zone](../Topic/Checklist--Revert-to-an-Unsigned-Zone.md)|Unsign a zone.|  
|[Checklist: Manage Signing Keys](../Topic/Checklist--Manage-Signing-Keys.md)|Review and replace zone signing keys.|  
|[Checklist: Move the Key Master Role](../Topic/Checklist--Move-the-Key-Master-Role.md)|Change the DNS server that is designated to be the Key Master.|  
|[Checklist: Reconfigure Zone Signing Parameters on a Signed Zone](../Topic/Checklist--Reconfigure-Zone-Signing-Parameters-on-a-Signed-Zone.md)|Change zone signing parameters.|  
|[Checklist: Perform an Emergency Key Revocation](../Topic/Checklist--Perform-an-Emergency-Key-Revocation.md)|Unsign a zone and replace signing keys.|  
|[Checklist: Perform a Manual Key Rollover](../Topic/Checklist--Perform-a-Manual-Key-Rollover.md)|Roll over signing keys manually and update trust anchors.|  
  
## See also  
[Overview of DNSSEC](../Topic/Overview-of-DNSSEC.md)  
  
[DNSSEC in Windows](../Topic/DNSSEC-in-Windows.md)  
  
[DNSSEC Deployment Planning](../Topic/DNSSEC-Deployment-Planning.md)  
  
[Appendix A: DNSSEC Terminology](../Topic/Appendix-A--DNSSEC-Terminology.md)  
  
[Appendix B: Windows PowerShell for DNS Server](../Topic/Appendix-B--Windows-PowerShell-for-DNS-Server.md)  
  
