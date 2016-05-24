---
title: Checklist: Revert to an Unsigned Zone
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c9357bb1-1dbd-410c-9c4d-24d57d760ed5
---
# Checklist: Revert to an Unsigned Zone
[Checklist: Deploy DNSSEC](../Topic/Checklist--Deploy-DNSSEC.md) > [Checklist: Sign a Zone](../Topic/Checklist--Sign-a-Zone.md) > [Checklist: Distribute Trust Anchors](../Topic/Checklist--Distribute-Trust-Anchors.md) > [Checklist: Deploy DNSSEC Policies to DNS Clients](../Topic/Checklist--Deploy-DNSSEC-Policies-to-DNS-Clients.md) > **Checklist: Revert to an Unsigned Zone**  
  
This parent checklist includes links to procedures that help you complete the required tasks.  
  
Before you complete the tasks in this checklist, make sure that you have performed the prerequisite tasks in the parent checklist.  
  
> [!NOTE]  
> Complete the tasks in this checklist in order. When a reference link takes you to a conceptual topic or to a subordinate checklist, return to this topic after you review the conceptual topic or after you complete the tasks in the subordinate checklist so that you can proceed with the remaining tasks in this checklist.  
  
![](../Image/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)**Checklist: Revert to an Unsigned Zone**  
  
||Task|Reference|  
|-|--------|-------------|  
|![](../Image/icon_checkboxo.gif)|Review concepts about the consequences of unsigning a zone. If trust anchors are deployed, or name resolution policy requires validation, DNS resolution can fail when a zone is unsigned.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Trust Anchors](../Topic/Trust-Anchors.md)<br /><br />![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[The NRPT](../Topic/The-NRPT.md)|  
|![](../Image/icon_checkboxo.gif)|Configure the NRPT so that validation is not required for the zone.|![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)[Procedure: Configure the NRPT](../Topic/Procedure--Configure-the-NRPT.md)|  
|![](../Image/icon_checkboxo.gif)|Verify that name resolution policy does not require DNSSEC validation for the zone.|![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)[Procedure: Verify Name Resolution Policy](../Topic/Procedure--Verify-Name-Resolution-Policy.md)|  
|![](../Image/icon_checkboxo.gif)|Remove trust anchors for the zone from validating DNS servers.|![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)[Procedure: Remove a Trust Point](../Topic/Procedure--Remove-a-Trust-Point.md)|  
|![](../Image/icon_checkboxo.gif)|Unsign the zone.|![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)[Procedure: Unsign a Zone](../Topic/Procedure--Unsign-a-Zone.md)|  
|![](../Image/icon_checkboxo.gif)|Verify that DNS clients can resolve names in the domain.|![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)[Procedure: Verify DNS Resolution](../Topic/Procedure--Verify-DNS-Resolution.md)|  
  
## See also  
[Overview of DNSSEC](../Topic/Overview-of-DNSSEC.md)  
  
[DNSSEC in Windows](../Topic/DNSSEC-in-Windows.md)  
  
[DNSSEC Deployment Planning](../Topic/DNSSEC-Deployment-Planning.md)  
  
[Appendix A: DNSSEC Terminology](../Topic/Appendix-A--DNSSEC-Terminology.md)  
  
[Appendix B: Windows PowerShell for DNS Server](../Topic/Appendix-B--Windows-PowerShell-for-DNS-Server.md)  
  
