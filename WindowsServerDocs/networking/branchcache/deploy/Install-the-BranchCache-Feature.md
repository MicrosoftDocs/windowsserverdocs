---
title: Install the BranchCache Feature
description: This topic is part of the BranchCache Deployment Guide for Windows Server 2016, which demonstrates how to deploy BranchCache in distributed and hosted cache modes to optimize WAN bandwidth usage in branch offices
manager: brianlic
ms.prod: windows-server
ms.technology: networking-bc
ms.topic: get-started-article
ms.assetid: 4f31dc61-2dbe-4c7e-b3f9-85ae49a45049
ms.author: lizross
author: eross-msft
---
# Install the BranchCache Feature

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this procedure to install the BranchCache feature and start the BranchCache service on a computer running Windows Server&reg; 2016, Windows Server 2012 R2, or Windows Server 2012.  
  
Membership in **Administrators** or equivalent is the minimum required to perform this procedure.  
  
Before you perform this procedure, it is recommended that you install and configure your BITS-based application or Web server.  
  
> [!NOTE]  
> To perform this procedure by using Windows PowerShell, run Windows PowerShell as an Administrator, type the following commands at the Windows PowerShell prompt, and then press ENTER.  
>   
> `Install-WindowsFeature BranchCache`  
>   
> `Restart-Computer`  
  
### To install and enable the BranchCache feature  
  
1.  In Server Manager, click **Manage**, and then click **Add Roles and Features**. The Add Roles and Features wizard opens. Click **Next**.  
  
2.  In **Select installation type**, ensure that **Role-based or feature-based installation** is selected, and then click **Next**.  
  
3.  In **Select destination server**, ensure that the correct server is selected, and then click **Next**.  
  
4.  In **Select server roles**, click **Next**.  
  
5.  In **Select features**, click **BranchCache**, and then click **Next**.  
  
6.  In **Confirm installation selections**, click **Install**. In **Installation progress**, the BranchCache feature installation proceeds. When installation is complete, click **Close**.  
  
After you install the BranchCache feature, the BranchCache service - also called the PeerDistSvc - is enabled, and the start type is Automatic.  
  


