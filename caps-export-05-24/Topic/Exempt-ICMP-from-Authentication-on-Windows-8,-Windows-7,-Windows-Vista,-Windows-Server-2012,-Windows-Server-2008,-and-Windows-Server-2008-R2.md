---
title: Exempt ICMP from Authentication on Windows 8, Windows 7, Windows Vista, Windows Server 2012, Windows Server 2008, and Windows Server 2008 R2
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ddef183e-984d-4caa-bed3-ed2e658f8730
author: vhorne
---
# Exempt ICMP from Authentication on Windows 8, Windows 7, Windows Vista, Windows Server 2012, Windows Server 2008, and Windows Server 2008 R2
This procedure shows you how to add exemptions for any network traffic that uses the ICMP protocol.  
  
> [!IMPORTANT]  
> Because of its usefulness in troubleshooting network connectivity problems, we recommend that you exempt all ICMP network traffic from authentication requirements unless your network risk analysis indicates a need to protect this traffic.  
  
**Administrative credentials**  
  
To complete this procedure, you must be a member of the Domain Administrators group, or otherwise be delegated permissions to modify the GPOs.  
  
### To exempt ICMP network traffic from authentication  
  
1.  [Open the Group Policy Management Console to Windows Firewall with Advanced Security](../Topic/Open-the-Group-Policy-Management-Console-to-Windows-Firewall-with-Advanced-Security.md).  
  
2.  On the main [!INCLUDE[wfas](../Token/wfas_md.md)] page, click **Windows Firewall Properties**.  
  
3.  On the **IPsec settings** tab, change **Exempt ICMP from IPsec** to **Yes**, and then click **OK**.  
  
If you arrived at this page by clicking a link in a checklist, use your browser’s **Back** button to return to the checklist.  
  
