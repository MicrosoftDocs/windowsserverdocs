---
title: Verify Client Computer Settings
description: This topic is part of the BranchCache Deployment Guide for Windows Server 2016, which demonstrates how to deploy BranchCache in distributed and hosted cache modes to optimize WAN bandwidth usage in branch offices
manager: brianlic
ms.prod: windows-server
ms.technology: networking-bc
ms.topic: get-started-article
ms.assetid: 31ea58b0-d407-4f62-8ec6-6a1b19174042
ms.author: lizross
author: eross-msft
---
# Verify Client Computer Settings

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this procedure to verify that the client computer is correctly configured for BranchCache.  
  
> [!NOTE]  
> This procedure includes steps for manually updating Group Policy and for restarting the BranchCache service. You do not need to perform these actions if you reboot the computer, as they will occur automatically in this circumstance.  
  
You must be a member of **Administrators**, or equivalent to perform this procedure.  
  
### To verify BranchCache client computer settings  
  
1.  To refresh Group Policy on the client computer whose BranchCache configuration you want to verify, run Windows PowerShell as an Administrator, type the following command, and then press ENTER.  
  
    `gpupdate /force`  
  
2.  For client computers that are configured in hosted cache mode and are configured to automatically discover hosted cache servers by service connection point, run the following commands to stop and restart the BranchCache service.  
  
    `net stop peerdistsvc`  
  
    `net start peerdistsvc`  
  
3.  Inspect the current BranchCache operational mode by running the following command.  
  
    `Get-BCStatus`  
  
4.  In Windows PowerShell, review the output of the **Get-BCStatus** command.  
  
    The value for **BranchCacheIsEnabled** should be **True**.  
  
    In **ClientSettings**, the value for **CurrentClientMode** should be **DistributedClient** or **HostedCacheClient**, depending on the mode that you configured using this guide.  
  
    In **ClientSettings**, if you configured hosted cache mode and provided the names of your hosted cache servers during configuration, or if the client has automatically located hosted cache servers using service connection points, **HostedCacheServerList** should have a value that is the same as the name or names of your hosted cache servers. For example, if your hosted cache server is named HCS1 and your domain is corp.contoso.com, the value for **HostedCacheServerList** is **HCS1.corp.contoso.com**.  
  
5.  If any of the BranchCache settings listed above do not have the correct values, use the steps in this guide to verify the Group Policy or Local Computer Policy settings, as well as the firewall exceptions, that you configured, and ensure that they are correct. In addition, either restart the computer or follow the steps in this procedure to refresh Group Policy and restart the BranchCache service.  
  


