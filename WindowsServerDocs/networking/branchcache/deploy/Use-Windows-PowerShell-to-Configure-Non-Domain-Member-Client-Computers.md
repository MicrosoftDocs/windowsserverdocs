---
title: Use Windows PowerShell to Configure Non-Domain Member Client Computers
description: This topic is part of the BranchCache Deployment Guide for Windows Server 2016, which demonstrates how to deploy BranchCache in distributed and hosted cache modes to optimize WAN bandwidth usage in branch offices
manager: brianlic
ms.prod: windows-server
ms.technology: networking-bc
ms.topic: get-started-article
ms.assetid: 1b511e1a-686d-441f-a1c7-d4d029e1a061
ms.author: lizross
author: eross-msft
---
# Use Windows PowerShell to Configure Non-Domain Member Client Computers

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this procedure to manually configure a BranchCache client computer for distributed cache mode or hosted cache mode.  
  
> [!NOTE]  
> If you have configured BranchCache client computers using Group Policy, the Group Policy settings override any manual configuration of client computers to which the policies are applied.  
  
Membership in **Administrators**, or equivalent is the minimum required to perform this procedure.  
  
### To enable BranchCache distributed or hosted cache mode  
  
1.  On the BranchCache client computer that you want to configure, run Windows PowerShell as an Administrator, and then do one of the following.  
  
    -   To configure the client computer for BranchCache distributed cache mode, type the following command, and then press ENTER.  
  
        `Enable-BCDistributed`  
  
    -   To configure the client computer for BranchCache hosted cache mode, type the following command, and then press ENTER.  
  
        `Enable-BCHostedClient`  
  
        > [!TIP]  
        > If you want to specify the available hosted cache servers, use the `-ServerNames` parameter with a comma separated list of your hosted cache servers as the parameter value. For example, if you have two hosted cache servers named HCS1 and HCS2, configure the client computer for hosted cache mode with the following command.  
        >   
        > `Enable-BCHostedClient -ServerNames HCS1,HCS2`  
  


