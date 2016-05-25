---
title: Checklist: Deploy DNSSEC Policies to DNS Clients
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 10756a73-cddb-4f65-85d0-93e0e0835d04
author: vhorne
---
# Checklist: Deploy DNSSEC Policies to DNS Clients
[Checklist: Deploy DNSSEC](../Topic/Checklist--Deploy-DNSSEC.md) > [Checklist: Sign a Zone](../Topic/Checklist--Sign-a-Zone.md) > [Checklist: Distribute Trust Anchors](../Topic/Checklist--Distribute-Trust-Anchors.md) > **Checklist: Deploy DNSSEC Policies to DNS Clients**  
  
This checklist includes procedures to help you deploy name resolution policy to DNS clients on your network by using the Name Resolution Policy Table \(NRPT\).  
  
Before you complete the tasks in this checklist, make sure that you have performed the prerequisite tasks in the parent checklist, such as reviewing conceptual information about DNSSEC, signing a zone, and deploying trust anchors. If you deploy name resolution policy to DNS clients before you have signed a zone and have deployed trust anchors, you can break DNS resolution on your network.  
  
> [!NOTE]  
> Complete the tasks in this checklist in order. When a reference link takes you to a conceptual topic or to a subordinate checklist, return to this topic after you review the conceptual topic or after you complete the tasks in the subordinate checklist so that you can proceed with the remaining tasks in this checklist.  
  
![](../Image/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)**Checklist: Deploy DNSSEC Policies to DNS Clients**  
  
||Task|Reference|  
|-|--------|-------------|  
|![](../Image/icon_checkboxo.gif)|Review concepts about security\-aware DNS clients and the NRPT.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[DNS Clients](../Topic/DNS-Clients.md)<br /><br />![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[The NRPT](../Topic/The-NRPT.md)|  
|![](../Image/icon_checkboxo.gif)|Configure name resolution policy.|![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)[Procedure: Configure the NRPT](../Topic/Procedure--Configure-the-NRPT.md)|  
|![](../Image/icon_checkboxo.gif)|Review name resolution policy settings.|![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)[Procedure: Verify Name Resolution Policy](../Topic/Procedure--Verify-Name-Resolution-Policy.md)|  
  
## See also  
[Overview of DNSSEC](../Topic/Overview-of-DNSSEC.md)  
  
[DNSSEC in Windows](../Topic/DNSSEC-in-Windows.md)  
  
[DNSSEC Deployment Planning](../Topic/DNSSEC-Deployment-Planning.md)  
  
[Appendix A: DNSSEC Terminology](../Topic/Appendix-A--DNSSEC-Terminology.md)  
  
[Appendix B: Windows PowerShell for DNS Server](../Topic/Appendix-B--Windows-PowerShell-for-DNS-Server.md)  
  
