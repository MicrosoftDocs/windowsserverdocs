---
title: Create the BranchCache Hash Publication Group Policy Object
description: This topic is part of the BranchCache Deployment Guide for Windows Server 2016, which demonstrates how to deploy BranchCache in distributed and hosted cache modes to optimize WAN bandwidth usage in branch offices
manager: brianlic
ms.prod: windows-server
ms.technology: networking-bc
ms.topic: get-started-article
ms.assetid: c3d33bed-83ef-4eb8-acf9-0719ecb4a931
ms.author: lizross
author: eross-msft
---
# Create the BranchCache Hash Publication Group Policy Object

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this procedure to create the BranchCache hash publication Group Policy Object (GPO).  
  
Membership in **Domain Admins**, or equivalent is the minimum required to perform this procedure.  
  
> [!NOTE]  
> Before performing this procedure, you must create the BranchCache file servers organizational unit and move file servers into the OU. For more information, see [Enable Hash Publication for Domain Member File Servers](../../branchcache/deploy/Enable-Hash-Publication-for-Domain-Member-File-Servers.md).  
  
### To create the BranchCache hash publication Group Policy Object  
  
1.  Open Windows PowerShell, type **mmc**, and then press ENTER. The Microsoft Management Console (MMC) opens.  
  
2.  In the MMC, on the **File** menu, click **Add/Remove Snap-in**. The **Add or Remove Snap-ins** dialog box opens.  
  
3.  In **Add or Remove Snap-ins**, in **Available snap-ins**, double-click **Group Policy Management**, and then click **OK**.  
  
4.  In the Group Policy Management MMC, expand the path to the BranchCache file servers OU that you previously created. For example, if your forest is named example.com, your domain is named example1.com, and your OU is named BranchCache file servers, expand the following path: **Group Policy Management**, **Forest: example.com**, **Domains**, **example1.com**, **BranchCache file servers**.  
  
5.  Right-click **BranchCache file servers**, and then click **Create a GPO in this domain, and Link it here**. The **New GPO** dialog box opens. In **Name**, type a name for the new GPO. For example, if you want to name the object BranchCache Hash Publication, type **BranchCache Hash Publication**. Click **OK**.  
  


