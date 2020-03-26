---
title: Enable Hash Publication for Non-Domain Member File Servers
description: This topic is part of the BranchCache Deployment Guide for Windows Server 2016, which demonstrates how to deploy BranchCache in distributed and hosted cache modes to optimize WAN bandwidth usage in branch offices
manager: brianlic
ms.prod: windows-server
ms.technology: networking-bc
ms.topic: get-started-article
ms.assetid: 11584b73-f9e2-4530-afa5-b8df970e6b24
ms.author: lizross
author: eross-msft
---
# Enable Hash Publication for Non-Domain Member File Servers

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this procedure to configure hash publication for BranchCache using local computer Group Policy on a file server that is running Windows Server 2016 with the **BranchCache for Network Files** role service of the File Services server role installed.  
  
This procedure is intended for use on a non-domain member file server. If you perform this procedure on a domain member file server and you also configure BranchCache using domain Group Policy, domain Group Policy settings override local Group Policy settings.  
  
Membership in **Administrators**, or equivalent is the minimum required to perform this procedure.  
  
> [!NOTE]  
> If you have one or more domain member file servers, you can add them to an organizational unit (OU) in Active Directory Domain Services and then use Group Policy to configure hash publication for all of the file servers at one time, rather than individually configuring each file server. For more information, see [Enable Hash Publication for Domain Member File Servers](../../branchcache/deploy/Enable-Hash-Publication-for-Domain-Member-File-Servers.md).  
  
### To enable hash publication for one file server  
  
1.  Open Windows PowerShell, type **mmc**, and then press ENTER. The Microsoft Management Console (MMC) opens.  
  
2.  In the MMC, on the **File** menu, click **Add/Remove Snap-in**. The **Add or Remove Snap-ins** dialog box opens.  
  
3.  In **Add or Remove Snap-ins**, in **Available snap-ins**, double-click **Group Policy Object Editor**. The Group Policy Wizard opens with the Local Computer object selected. Click **Finish**, and then click **OK**.  
  
4.  In the Local Group Policy Editor MMC, expand the following path: **Local Computer Policy**, **Computer Configuration**, **Administrative Templates**, **Network**, **Lanman Server**. Click **Lanman Server**.  
  
5.  In the details pane, double-click **Hash Publication for BranchCache**. The **Hash Publication for BranchCache** dialog box opens.  
  
6.  In the **Hash Publication for BranchCache** dialog box, click **Enabled**.  
  
7.  In **Options**, click **Allow hash publication for all shared folders**, and then click one of the following:  
  
    1.  To enable hash publication for all shared folders on this computer, click **Allow hash publication for all shared folders**.  
  
    2.  To enable hash publication only for shared folders for which BranchCache is enabled, click **Allow hash publication only for shared folders on which BranchCache is enabled**.  
  
    3.  To disallow hash publication for all shared folders on the computer even if BranchCache is enabled on the file shares, click **Disallow hash publication on all shared folders**.  
  
8.  Click **OK**.  
  


