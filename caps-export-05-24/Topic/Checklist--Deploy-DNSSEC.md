---
title: Checklist: Deploy DNSSEC
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7dc2db31-94bf-413f-9128-e9211f818c06
---
# Checklist: Deploy DNSSEC
This parent checklist includes cross\-reference links to topics that provide important conceptual information about DNSSEC. It also contains links to subordinate checklists that help you complete the required tasks.  
  
Before you complete the tasks in this checklist, make sure that you have performed the prerequisite tasks in the parent checklist, such as reviewing conceptual information about DNSSEC and deciding on a deployment method and DNSSEC parameter values to use.  
  
The DNS server that you use to perform procedures in this checklist is intended to be the Key Master. For more information, see [The Key Master](../Topic/DNS-Servers.md#KM). You can also use a different DNS server than the Key Master but you might have to adjust some steps in these procedures accordingly.  
  
> [!NOTE]  
> Complete the tasks in this checklist in order. When a reference link takes you to a conceptual topic or to a subordinate checklist, return to this topic after you review the conceptual topic or after you complete the tasks in the subordinate checklist so that you can proceed with the remaining tasks in this checklist.  
  
![](../Image/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)**Checklist: Deploy DNSSEC**  
  
||Task|Reference|  
|-|--------|-------------|  
|![](../Image/icon_checkboxo.gif)|Review DNSSEC concepts, terminology, components, requirements, and specifications.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Overview of DNSSEC](../Topic/Overview-of-DNSSEC.md)<br /><br />![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[DNSSEC in Windows](../Topic/DNSSEC-in-Windows.md)<br /><br />![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Appendix A: DNSSEC Terminology](../Topic/Appendix-A--DNSSEC-Terminology.md)|  
|![](../Image/icon_checkboxo.gif)|Decide on a deployment method; identify pilot servers and zones.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[DNSSEC Deployment Planning](../Topic/DNSSEC-Deployment-Planning.md)|  
|![](../Image/icon_checkboxo.gif)|Sign a zone.|![](../Image/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Checklist: Sign a Zone](../Topic/Checklist--Sign-a-Zone.md)|  
|![](../Image/icon_checkboxo.gif)|Deploy trust anchors.|![](../Image/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Checklist: Distribute Trust Anchors](../Topic/Checklist--Distribute-Trust-Anchors.md)|  
|![](../Image/icon_checkboxo.gif)|Configure and deploy DNS client policies.|![](../Image/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Checklist: Deploy DNSSEC Policies to DNS Clients](../Topic/Checklist--Deploy-DNSSEC-Policies-to-DNS-Clients.md)|  
|![](../Image/icon_checkboxo.gif)|Review zone signing parameters and manage the signed zone.|![](../Image/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Checklist: Review and Manage a Signed Zone](../Topic/Checklist--Review-and-Manage-a-Signed-Zone.md)|  
|![](../Image/icon_checkboxo.gif)|Deploy IPsec policy to protect zone transfers|![](../Image/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)[Checklist: Secure Zone Transfers](../Topic/Checklist--Secure-Zone-Transfers.md)|  
|![](../Image/icon_checkboxo.gif)|Review DNS client requirements for DNSSEC validation.|![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)[Procedure: Review Name Resolution Policy Settings](../Topic/Procedure--Review-Name-Resolution-Policy-Settings.md)|  
  
## See also  
[Overview of DNSSEC](../Topic/Overview-of-DNSSEC.md)  
  
[DNSSEC in Windows](../Topic/DNSSEC-in-Windows.md)  
  
[DNSSEC Deployment Planning](../Topic/DNSSEC-Deployment-Planning.md)  
  
[Appendix A: DNSSEC Terminology](../Topic/Appendix-A--DNSSEC-Terminology.md)  
  
[Appendix B: Windows PowerShell for DNS Server](../Topic/Appendix-B--Windows-PowerShell-for-DNS-Server.md)  
  
