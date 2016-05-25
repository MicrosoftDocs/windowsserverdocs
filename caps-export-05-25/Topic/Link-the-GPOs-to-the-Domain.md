---
title: Link the GPOs to the Domain
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6a328472-a6ff-4b06-8008-826aed1cb5bb
author: coreyp
---
# Link the GPOs to the Domain
Use this procedure to link the GPOs that you created earlier to the domain container in the Active Directory hierarchy. Because the assignment of the GPOs is controlled by the combination of the security group and WMI filters, you do not have to assign the GPOs to OU containers.  
  
> [!IMPORTANT]  
> Linking GPOs to the domain container is appropriate for GPOs that must be used by computers throughout the Active Directory hierarchy. Link GPOs that apply only to a subset of the computers in the network to the OU container that is lowest in the hierarchy but still includes all of the targeted computers in the containers below it.  
  
Membership in **Domain Admins** is the minimum required to complete this procedure.  
  
### To link the GPOs to the domain container  
  
1.  On AD\-DNS\-01, in Server Manager, click **Tools**, and then click **Group Policy Management**. The Group Policy Management Console \(GPMC\) opens.  
  
2.  In the GPMC navigation pane, expand **Forest:** *your forest name*, expand **Domains**, expand your domain, and then click **Group Policy Objects**.  
  
3.  Drag each GPO in the **Group Policy Objects** node to the node for your domain container. In the confirmation dialog box, click **OK**.  
  
