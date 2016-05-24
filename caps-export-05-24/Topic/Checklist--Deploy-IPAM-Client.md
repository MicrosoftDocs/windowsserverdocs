---
title: Checklist: Deploy IPAM Client
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6c42802b-0cc7-4886-8f79-3cbe592b5ba6
---
# Checklist: Deploy IPAM Client
This parent checklist includes cross\-reference links to important concepts about deploying an IP address management \(IPAM\) client. It also contains links to subordinate checklists that will help you complete the required tasks.  
  
> [!NOTE]  
> Complete the tasks in this checklist in order. When a reference link takes you to a conceptual topic or to a subordinate checklist, return to this topic after you review the conceptual topic or you complete the tasks in the subordinate checklist so that you can proceed with the remaining tasks in this checklist.  
  
![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)**Checklist: Deploy IPAM Client**  
  
||Task|Reference|  
|-|--------|-------------|  
|![](../Image/icon_checkboxo.gif)|Review operating system and software requirements for IPAM Client, and choose an installation option.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[IPAM Client](../Topic/IPAM-Architecture.md#client)|  
|![](../Image/icon_checkboxo.gif)|Install Remote Server Administration Tools \(RSAT\) for Windows 8 \(optional\).<br /><br />If the IPAM client computer is running [!INCLUDE[win8_client_1](../Token/win8_client_1_md.md)], you must download and install RSAT from Microsoft.<br /><br />If the computer is running [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)], RSAT is installed automatically. Continue to the next task.|![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)[Install RSAT](../Topic/Install-RSAT.md)|  
|![](../Image/icon_checkboxo.gif)|Install IPAM Client.<br /><br />Perform this task if the IPAM client computer is running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and IPAM Client has not already been installed in parallel with the IPAM Server feature.<br /><br />If the IPAM client computer is running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] and you have installed RSAT for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], IPAM Client is already available. Continue to the next task.|![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)[Install IPAM Client](../Topic/Install-IPAM-Client.md)|  
|![](../Image/icon_checkboxo.gif)|Ensure the IPAM Server is available in the Server Manager server pool, and connect to the IPAM Server.|![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)[Connect to an IPAM Server](../Topic/Connect-to-an-IPAM-Server.md)|  
  
## See Also  
[Checklist: Deploy IPAM Server](../Topic/Checklist--Deploy-IPAM-Server.md)  
  
