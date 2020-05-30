---
title: Configure an Existing File Server as a Content Server
description: This topic is part of the BranchCache Deployment Guide for Windows Server 2016, which demonstrates how to deploy BranchCache in distributed and hosted cache modes to optimize WAN bandwidth usage in branch offices
manager: brianlic
ms.prod: windows-server
ms.technology: networking-bc
ms.topic: get-started-article
ms.assetid: bdac7d2a-25b4-4f61-bed1-b290700c18f3
ms.author: lizross
author: eross-msft
---
# Configure an Existing File Server as a Content Server

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this procedure to install the **BranchCache for Network Files** role service of the File Services server role on a computer running Windows Server 2016.  
  
> [!IMPORTANT]  
> If the File Services server role is not already installed, do not follow this procedure. Instead, see [Install a New File Server as a Content Server](../../branchcache/deploy/Install-a-New-File-Server-as-a-Content-Server.md).  
  
Membership in **Administrators**, or equivalent is the minimum required to perform this procedure.  
  
> [!NOTE]  
> To perform this procedure by using Windows PowerShell, run Windows PowerShell as an Administrator, type the following commands at the Windows PowerShell prompt, and then press ENTER.  
>   
> `Install-WindowsFeature FS-BranchCache -IncludeManagementTools`  
>   
> To install the Data Deduplication role service, type the following command, and then press ENTER.  
>   
> `Install-WindowsFeature FS-Data-Deduplication -IncludeManagementTools`  
  
### To install the BranchCache for Network Files role service  
  
1.  In Server Manager, click **Manage**, and then click **Add Roles and Features**. The Add Roles and Features wizard opens. Click **Next**.  
  
2.  In **Select installation type**, ensure that **Role-based or feature-based installation** is selected, and then click **Next**.  
  
3.  In **Select destination server**, ensure that the correct server is selected, and then click **Next**.  
  
4.  In **Select server roles**, in **Roles**, note that the **File And Storage Services** role is already installed; click the arrow to the left of the role name to expand the selection of role services, and then click the arrow to the left of **File and iSCSI Services**.  
  
5.  Select the check box for **BranchCache for Network Files**.  
  
    > [!TIP]  
    > If you have not already done so, it is recommended that you also select the check box for **Data Deduplication**.  
  
    Click **Next**.  
  
6.  In **Select features**, click **Next**.  
  
7.  In **Confirm installation selections**, review your selections, and then click **Install**. The **Installation progress** pane is displayed during installation. When installation is complete, click **Close**.  
  


