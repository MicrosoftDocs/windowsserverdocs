---
ms.assetid: c28a1b8b-5bec-4eed-8c95-a1a29cfc957c
title: Install the AD FS Role Service
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adfs
---

# Install the AD FS Role Service

You can use the following procedure to install the AD FS role service on a computer that is running  Windows Server 2012 R2  to become the first federation server in a federation server farm or a federation server in an existing federation server farm.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum requirement to complete this procedure.  Review details about using the appropriate accounts and group memberships at [Local and Domain Default Groups](https://go.microsoft.com/fwlink/?LinkId=83477).   
  
### To install the AD FS server role via the Add roles and features wizard  
  
1.  Open Server Manager. To open Server Manager, click **Server Manager** on the **Start** screen, or **Server Manager** in the taskbar on the desktop. In the **Quick Start** tab of the **Welcome** tile on the **Dashboard** page, click **Add roles and features**. Alternatively, you can click **Add Roles and Features** on the **Manage** menu.  
  
2.  On the **Before you begin** page, click **Next**.  
  
3.  On the **Select installation type** page, click **Role\-based or Feature\-based installation**, and then click **Next**.  
  
4.  On the **Select destination server** page, click **Select a server from the server pool**, verify that the target computer is selected, and then click **Next**.  
  
5.  On the **Select server roles** page, click **Active Directory Federation Services**, and then click **Next**.  
  
6.  On the **Select features** page, click **Next**. The required prerequisites are preselected for you. You do not have to select any other features.  
  
7.  On the **Active Directory Federation Service \(AD FS\)** page, click **Next**.  
  
8.  After you verify the information on the **Confirm installation selections** page, click **Install**.  
  
9. On the **Installation progress** page, verify that everything installed correctly, and then click **Close**.  
  
### To install the AD FS server role via Windows PowerShell  
  
1.  On the computer that you want to configure as a federation server, open the Windows PowerShell command window, and then run the following command: `Install-windowsfeature adfs-federation –IncludeManagementTools`.  
  
## See Also 

[AD FS Deployment](../../ad-fs/AD-FS-Deployment.md)  

[Windows Server 2012 R2 AD FS Deployment Guide](../../ad-fs/deployment/Windows-Server-2012-R2-AD-FS-Deployment-Guide.md)  
 
[Deploying a Federation Server Farm](../../ad-fs/deployment/Deploying-a-Federation-Server-Farm.md)  
  

