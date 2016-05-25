---
title: Checklist: Distribute Trust Anchors
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 182977c0-7682-4ba6-a040-65592ca36efe
author: vhorne
---
# Checklist: Distribute Trust Anchors
[Checklist: Deploy DNSSEC](../Topic/Checklist--Deploy-DNSSEC.md) > [Checklist: Sign a Zone](../Topic/Checklist--Sign-a-Zone.md) > **Checklist: Distribute Trust Anchors**  
  
This checklist includes procedures to help you distribute trust anchors for a signed zone.  
  
Before you complete the tasks in this checklist, make sure that you have performed the prerequisite tasks in the parent checklist, such as reviewing conceptual information about DNSSEC and signing a zone with the settings that you specify. You cannot distribute trust anchors until after a zone is signed with DNSSEC.  
  
You must re\-distribute trust anchors each time that a zone is re\-signed unless re\-signing occurs as part of an automatic key rollover and trust anchors are distributed automatically on key rollover \(RFC 5011\). Trust anchors can also be distributed automatically in Active Directory to all Active Directory\-integrated DNS servers within the replication scope for the zone.  
  
> [!NOTE]  
> Complete the tasks in this checklist in order. When a reference link takes you to a conceptual topic or to a subordinate checklist, return to this topic after you review the conceptual topic or after you complete the tasks in the subordinate checklist so that you can proceed with the remaining tasks in this checklist.  
  
![](../Image/bc6cea1a-1c6c-4124-8c8f-1df5adfe8c88.gif)**Checklist: Distribute Trust Anchors**  
  
||Task|Reference|  
|-|--------|-------------|  
|![](../Image/icon_checkboxo.gif)|Review concepts for managing trust anchors.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Trust Anchors](../Topic/Trust-Anchors.md)|  
|![](../Image/icon_checkboxo.gif)|Enable automatic update of trust anchors on key rollover.|![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)[Procedure: Enable Automatic Update of Trust Anchors on Key Rollover](../Topic/Procedure--Enable-Automatic-Update-of-Trust-Anchors-on-Key-Rollover.md) **Important:** Changes made to this setting do not take effect until the next automatic key rollover.|  
|![](../Image/icon_checkboxo.gif)|Enable distribution of trust anchors in Active Directory.|![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)[Procedure: Distribute Trust Anchors in Active Directory](../Topic/Procedure--Distribute-Trust-Anchors-in-Active-Directory.md)|  
|![](../Image/icon_checkboxo.gif)|Export and import trust anchors.|![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)[Procedure: Export a Trust Point](../Topic/Procedure--Export-a-Trust-Point.md)<br /><br />![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)[Procedure: Import a Trust Point](../Topic/Procedure--Import-a-Trust-Point.md)|  
|![](../Image/icon_checkboxo.gif)|Manually add a trust anchor.|![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)[Procedure: Add a Trust Point](../Topic/Procedure--Add-a-Trust-Point.md)|  
|![](../Image/icon_checkboxo.gif)|Deploy a root trust anchor.|![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)[Procedure: Deploy a Root Trust Point](../Topic/Procedure--Deploy-a-Root-Trust-Point.md)|  
  
## See also  
[Overview of DNSSEC](../Topic/Overview-of-DNSSEC.md)  
  
[DNSSEC in Windows](../Topic/DNSSEC-in-Windows.md)  
  
[DNSSEC Deployment Planning](../Topic/DNSSEC-Deployment-Planning.md)  
  
[Appendix A: DNSSEC Terminology](../Topic/Appendix-A--DNSSEC-Terminology.md)  
  
[Appendix B: Windows PowerShell for DNS Server](../Topic/Appendix-B--Windows-PowerShell-for-DNS-Server.md)  
  
