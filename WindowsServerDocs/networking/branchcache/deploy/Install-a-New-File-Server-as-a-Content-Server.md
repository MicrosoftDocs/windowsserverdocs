---
title: Install a New File Server as a Content Server
description: This topic is part of the BranchCache Deployment Guide for Windows Server 2016, which demonstrates how to deploy BranchCache in distributed and hosted cache modes to optimize WAN bandwidth usage in branch offices
manager: brianlic
ms.prod: windows-server
ms.technology: networking-bc
ms.topic: get-started-article
ms.assetid: 1f49fc3c-28a6-4d3d-b787-1be9e61e792f
ms.author: lizross
author: eross-msft
---
# Install a New File Server as a Content Server

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this procedure to install the File Services server role and the **BranchCache for Network Files** role service on a computer running  Windows Server 2016.  
  
Membership in **Administrators**, or equivalent is the minimum required to perform this procedure.  
  
> [!NOTE]  
> To perform this procedure by using Windows PowerShell, run Windows PowerShell as an Administrator, type the following commands at the Windows PowerShell prompt, and then press ENTER.  
>   
> `Install-WindowsFeature FS-BranchCache -IncludeManagementTools`  
>   
> `Restart-Computer`  
>   
> To install the Data Deduplication role service, type the following command, and then press ENTER.  
>   
> `Install-WindowsFeature FS-Data-Deduplication -IncludeManagementTools`  
  
### To install File Services and the BranchCache for network files role service  
  
1.  In Server Manager, click **Manage**, and then click **Add Roles and Features**. The Add Roles and Features Wizard opens. In **Before you begin**, click **Next**.  
  
2.  In **Select installation type**, ensure that **Role-based or feature-based installation** is selected, and then click **Next**.  
  
3.  In **Select destination server**, ensure that the correct server is selected, and then click **Next**.  
  
4.  In **Select server roles**, in **Roles**, note that the **File And Storage Services** role is already installed; click the arrow to the left of the role name to expand the selection of role services, and then click the arrow to the left of **File and iSCSI Services**.  
  
5.  Select the check boxes for **File Server** and **BranchCache for Network Files**.  
  
    > [!TIP]  
    > It is recommended that you also select the check box for **Data Deduplication**.
  
    Click **Next**.  
  
6.  In **Select features**, click **Next**.  
  
7.  In **Confirm installation selections**, review your selections, and then click **Install**. The **Installation progress** pane is displayed during installation. When installation is complete, click **Close**.
