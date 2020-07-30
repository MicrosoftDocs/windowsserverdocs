---
title: Configure the BranchCache Hash Publication Group Policy Object
description: This topic is part of the BranchCache Deployment Guide for Windows Server 2016, which demonstrates how to deploy BranchCache in distributed and hosted cache modes to optimize WAN bandwidth usage in branch offices
manager: brianlic
ms.prod: windows-server
ms.technology: networking-bc
ms.topic: get-started-article
ms.assetid: da74fea7-52b2-4d6d-9d21-19184eedbe3c
ms.author: lizross
author: eross-msft
---
# Configure the BranchCache Hash Publication Group Policy Object

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this procedure to configure the BranchCache hash publication Group Policy Object (GPO) so that all file servers that you added to your OU have the same hash publication policy setting applied to them.  
  
Membership in **Domain Admins**, or equivalent is the minimum required to perform this procedure.  
  
> [!NOTE]  
> Before performing this procedure, you must create the BranchCache file servers organizational unit, move file servers into the OU, and create the BranchCache hash publication GPO. For more information, see [Enable Hash Publication for Domain Member File Servers](../../branchcache/deploy/Enable-Hash-Publication-for-Domain-Member-File-Servers.md).  
  
### To configure the BranchCache hash publication Group Policy Object  
  
1.  Run Windows PowerShell as an Administrator, type **mmc**, and then press ENTER. The Microsoft Management Console (MMC) opens.  
  
2.  In the MMC, on the **File** menu, click **Add/Remove Snap-in**. The **Add or Remove Snap-ins** dialog box opens.  
  
3.  In **Add or Remove Snap-ins**, in **Available snap-ins**, double-click **Group Policy Management**, and then click **OK**.  
  
4.  In the Group Policy Management MMC, expand the path to the BranchCache hash publication GPO that you previously created. For example, if your forest is named example.com, your domain is named example1.com, and your GPO is named **BranchCache Hash Publication**, expand the following path: **Group Policy Management**, **Forest: example.com**, **Domains**, **example1.com**, **Group Policy Objects**, **BranchCache Hash Publication**.  
  
5.  Right-click the **BranchCache Hash Publication** GPO and click **Edit**. The Group Policy Management Editor console opens.  
  
6.  In the Group Policy Management Editor console, expand the following path: **Computer Configuration**, **Policies**, **Administrative Templates**, **Network**, **Lanman Server**.  
  
7.  In the Group Policy Management Editor console, click **Lanman Server**. In the details pane, double-click **Hash Publication for BranchCache**. The **Hash Publication for BranchCache** dialog box opens.  
  
8.  In the **Hash Publication for BranchCache** dialog box, click **Enabled**.  
  
9. In **Options**, click **Allow hash publication for all shared folders**, and then click one of the following:  
  
    1.  To enable hash publication for all shared folders for all file servers that you added to the OU, click **Allow hash publication for all shared folders**.  
  
    2.  To enable hash publication only for shared folders for which BranchCache is enabled, click **Allow hash publication only for shared folders on which BranchCache is enabled**.  
  
    3.  To disallow hash publication for all shared folders on the computer even if BranchCache is enabled on the file shares, click **Disallow hash publication on all shared folders**.  
  
10. Click **OK**.  
  
> [!NOTE]  
> In most cases, you must save the MMC console and refresh the view to display the configuration changes you have made.  
  


