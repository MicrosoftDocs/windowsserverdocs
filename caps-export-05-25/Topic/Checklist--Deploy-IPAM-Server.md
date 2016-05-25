---
title: Checklist: Deploy IPAM Server
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6b4d904e-48b0-49c0-b70c-ffd4488d4846
---
# Checklist: Deploy IPAM Server
[Checklist: Deploy IPAM](../Topic/Checklist--Deploy-IPAM.md) > **Checklist: Deploy IPAM Server**  
  
This parent checklist includes cross\-reference links to important concepts about deploying an IP address management \(IPAM\) server. It also contains links to subordinate checklists that will help you complete the required tasks.  
  
Before completing the tasks in this checklist, ensure you have performed the prerequisite tasks in the parent checklist, such as reviewing conceptual information about IPAM and deciding on a deployment topology. The IPAM server that you deploy using procedures in this checklist can be a central IPAM server that monitors and manages several sites, or it can be a remote server that is responsible for managing a single site or a small number of sites. The role that is assigned to an IPAM server affects procedures in this checklist, such as configuring the scope of discovery and assigning the manageability status of discovered servers.  
  
> [!NOTE]  
> Complete the tasks in this checklist in order. When a reference link takes you to a conceptual topic or to a subordinate checklist, return to this topic after you review the conceptual topic or you complete the tasks in the subordinate checklist so that you can proceed with the remaining tasks in this checklist.  
  
![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)**Checklist: Deploy IPAM Server**  
  
||Task|Reference|  
|-|--------|-------------|  
|![](../Image/icon_checkboxo.gif)|Install the IPAM Server feature|![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)[Install IPAM Server](../Topic/Install-IPAM-Server.md)|  
|![](../Image/icon_checkboxo.gif)|Configure the IPAM Database|![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)[Configure the SQL Database for IPAM](../Topic/Configure-the-SQL-Database-for-IPAM.md)<br /><br />![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)[Specify the IPAM Database](../Topic/Specify-the-IPAM-Database.md)|  
|![](../Image/icon_checkboxo.gif)|Provision the IPAM server|![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)[Choose an IPAM Provisioning Method](../Topic/Choose-an-IPAM-Provisioning-Method.md)|  
|![](../Image/icon_checkboxo.gif)|Configure the scope of discovery|![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)[Configure Server Discovery](../Topic/Configure-Server-Discovery.md)|  
|![](../Image/icon_checkboxo.gif)|Start server discovery|![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)[Discover Servers on the Network](../Topic/Discover-Servers-on-the-Network.md)<br /><br />![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)[Manually Add a Server to Server Inventory](../Topic/Manually-Add-a-Server-to-Server-Inventory.md)|  
|![](../Image/icon_checkboxo.gif)|Configure settings on managed servers|![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)[Create IPAM Provisioning GPOs](../Topic/Create-IPAM-Provisioning-GPOs.md)<br /><br />![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)[Manually Configure DHCP Access Settings](../Topic/Manually-Configure-DHCP-Access-Settings.md)<br /><br />![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)[Manually Configure DNS Access Settings](../Topic/Manually-Configure-DNS-Access-Settings.md)<br /><br />![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)[Manually Configure DC and NPS Access Settings](../Topic/Manually-Configure-DC-and-NPS-Access-Settings.md)|  
|![](../Image/icon_checkboxo.gif)|Select manageability status on managed servers|![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)[Choose Managed Servers](../Topic/Choose-Managed-Servers.md)|  
|![](../Image/icon_checkboxo.gif)|Verify IPAM access to managed servers|![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)[Verify Managed Server Access](../Topic/Verify-Managed-Server-Access.md)|  
|![](../Image/icon_checkboxo.gif)|Retrieve data from managed servers|![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)[Retrieve Data from Managed Servers](../Topic/Retrieve-Data-from-Managed-Servers.md)|  
  
## See also  
[Checklist: Deploy IPAM Client](../Topic/Checklist--Deploy-IPAM-Client.md)  
  
[Checklist: Assign Roles](../Topic/Checklist--Assign-Roles.md)  
  
