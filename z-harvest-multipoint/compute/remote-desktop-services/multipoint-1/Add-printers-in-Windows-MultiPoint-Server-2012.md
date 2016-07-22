---
title: Add printers in Windows MultiPoint Server 2012
ms.custom: na
ms.date: 07/22/2016
ms.prod: multipoint-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e1f6d3ca-8caf-4aa0-b0ea-93cdfd3f3f37
author: lizap
manager: jwhit
---
# Add printers in Windows MultiPoint Server 2012
Use the procedures in this topic to make a local printer available to all users on a [!INCLUDE[win8_server_multipoint_2](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint_2_md.md)].  
  
> [!NOTE]  
> If you are using domain accounts in [!INCLUDE[win8_server_multipoint_2](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint_2_md.md)], users can use any network printer from their stations.  
  
### To make a local printer available to all users on a [!INCLUDE[win8_server_multipoint_2](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint_2_md.md)] system  
  
1.  Connect the printer to the [!INCLUDE[win8_server_multipoint_2](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint_2_md.md)] computer.  
  
2.  Configure the printer as a shared printer:  
  
    1.  Log on to the MultiPoint Server computer as an administrator.  
  
    2.  From the **Start** screen, open **Control Panel**.  
  
    3.  In Control Panel, click **Hardware**, and then click **Devices and Printers**.  
  
    4.  Under **Printers and Faxes**, right\-click the printer, and then click **Printer Properties**.  
  
    5.  Click the **Sharing** tab.  
  
    6.  Click **Share this printer**, specify a share name for the printer, and then click **OK**.  
  
Users logged on to any station that is connected to the [!INCLUDE[win8_server_multipoint_2](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint_2_md.md)] computer will be able to see and use the printer.  
  
