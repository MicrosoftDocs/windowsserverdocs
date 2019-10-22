---
ms.assetid: 692bd2af-deee-44cf-9af9-f364677e267f
title: Planning Domain Controller Placement
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Planning Domain Controller Placement

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

After you have gathered all of the network information that will be used to design your site topology, plan where you want to place domain controllers, including forest root domain controllers, regional domain controllers, operations master role holders, and global catalog servers.  
  
In  Windows Server 2008 , you can also take advantage of read-only domain controllers (RODCs). An RODC is a new type of domain controller that hosts read-only partitions of the Active Directory database. Except for account passwords, an RODC holds all the Active Directory objects and attributes that a writable domain controller holds. However, changes cannot be made to the database that is stored on the RODC. Changes must be made on a writable domain controller and then replicated back to the RODC.  
  
An RODC is designed primarily to be deployed in remote or branch office environments, which typically have relatively few users, poor physical security, relatively poor network bandwidth to a hub site, and personnel with limited knowledge of information technology (IT). Deploying RODCs results in improved security and more efficient access to network resources. For more information about RODC features, see AD DS: Read-Only Domain Controllers ([https://go.microsoft.com/fwlink/?LinkID=106616](https://go.microsoft.com/fwlink/?LinkID=106616)). For information about how to deploy an RODC, see the Step-by-Step Guide for Read-Only Domain Controllers ([https://go.microsoft.com/fwlink/?LinkID=92728](https://go.microsoft.com/fwlink/?LinkID=92728)).  
  
> [!NOTE]  
> This guide does not explain how you determine the proper number of domain controllers and the domain controller hardware requirements for each domain that is represented in each site.  
  
## In this section  
  
-   [Planning Forest Root Domain Controller Placement](../../ad-ds/plan/Planning-Forest-Root-Domain-Controller-Placement.md)  
  
-   [Planning Regional Domain Controller Placement](../../ad-ds/plan/Planning-Regional-Domain-Controller-Placement.md)  
  
-   [Planning Global Catalog Server Placement](../../ad-ds/plan/Planning-Global-Catalog-Server-Placement.md)  
  
-   [Planning Operations Master Role Placement](../../ad-ds/plan/Planning-Operations-Master-Role-Placement.md)  
  


