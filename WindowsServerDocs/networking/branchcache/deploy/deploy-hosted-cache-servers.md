---
title: Deploy Hosted Cache Servers (Optional)
description: This topic is part of the BranchCache Deployment Guide for Windows Server 2016, which demonstrates how to deploy BranchCache in distributed and hosted cache modes to optimize WAN bandwidth usage in branch offices
manager: brianlic
ms.prod: windows-server
ms.technology: networking-bc
ms.topic: get-started-article
ms.assetid: 96d03b42-6cd9-4905-b6a2-dc36130dd24f
ms.author: lizross
author: eross-msft
---
# Deploy Hosted Cache Servers (Optional)

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this procedure to install and configure BranchCache hosted cache servers that are located in branch offices where you want to deploy BranchCache hosted cache mode. With BranchCache in Windows Server 2016, you can deploy multiple hosted cache servers in one branch office.  
  
> [!IMPORTANT]  
> This step is optional because distributed cache mode does not require a hosted cache server computer in branch offices. If you are not planning on deploying hosted cache mode in any branch offices, you do not need to deploy a hosted cache server, and you do not need to perform the steps in this procedure.  
  
You must be a member of **Administrators**, or equivalent to perform this procedure.  
  
### To install and configure a hosted cache server  
  
1.  On the computer that you want to configure as a hosted cache server, run the following command at a Windows PowerShell prompt to install the BranchCache feature.  
  
    `Install-WindowsFeature BranchCache -IncludeManagementTools`  
  
2.  Configure the computer as a hosted cache server by using one of the following commands:  
  
    -   To configure a non-domain joined computer as a hosted cache server, type the following command at the Windows PowerShell prompt, and then press ENTER.  
  
        `Enable-BCHostedServer`  
  
    -   To configure a domain joined computer as a hosted cache server, and to register a service connection point in Active Directory for automatic hosted cache server discovery by client computers, type the following command at the Windows PowerShell prompt, and then press ENTER.  
  
        `Enable-BCHostedServer -RegisterSCP`  
  
3.  To verify the correct configuration of the hosted cache server, type the following command at the Windows PowerShell prompt, and then press ENTER.  
  
    `Get-BCStatus`  
  
    > [!NOTE]  
    > After you run this command, in the section **HostedCacheServerConfiguration**, the value for **HostedCacheServerIsEnabled** is **True**. If you configured a domain joined hosted cache server to register a service connection point (SCP) in Active Directory, the value for **HostedCacheScpRegistrationEnabled** is **True**.  
  

