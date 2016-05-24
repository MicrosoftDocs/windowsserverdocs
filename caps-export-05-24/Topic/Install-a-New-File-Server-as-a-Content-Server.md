---
title: Install a New File Server as a Content Server
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: dacadc91-6289-4002-9792-e8b01df1e91c
---
# Install a New File Server as a Content Server
You can use this procedure to install the File Services server role and the BranchCache for network files role service on a computer running [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)].  
  
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
  
1.  In Server Manager, click **Manage**, and then click **Add Roles and Features**. The Add Roles and Features Wizard opens. In **Before You Begin**, click **Next**.  
  
2.  
  
3.  In **Select Installation Type**, ensure that **Role\-based or feature\-based installation** is selected, and then click **Next**.  
  
4.  In **Select destination server**, ensure that the correct server is selected, and then click **Next**.  
  
5.  In **Select Server Roles**, in **Roles**, note that the **File And Storage Services** role is already installed; click the arrow to the left of the role name to expand the selection of role services, and then click the arrow to the left of **File and iSCSI Services**.  
  
6.  Select the check boxes for **File Server** and **BranchCache for Network Files**.  
  
    > [!TIP]  
    > It is recommended that you also select the check box for **Data Deduplication**. For more information about Data Deduplication, see [Additional Resources_10](../Topic/Additional-Resources_10.md).  
  
    Click **Next**.  
  
7.  In **Select features**, click **Next**.  
  
8.  In **Confirm Installation Selections**, review your selections, and then click **Install**. The **Installation progress** pane is displayed during installation. When installation is complete, click **Close**.  
  
