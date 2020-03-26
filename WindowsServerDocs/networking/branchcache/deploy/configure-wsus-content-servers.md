---
title: Configure Windows Server Update Services (WSUS) Content Servers
description: This topic is part of the BranchCache Deployment Guide for Windows Server 2016, which demonstrates how to deploy BranchCache in distributed and hosted cache modes to optimize WAN bandwidth usage in branch offices.
manager: brianlic
ms.prod: windows-server
ms.technology: networking-bc
ms.topic: get-started-article
ms.assetid: 9724aa8d-e4ae-404c-bee6-cef1534cd3ca
ms.author: lizross
author: eross-msft
---
# Configure Windows Server Update Services (WSUS) Content Servers

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

After installing the BranchCache feature and starting the BranchCache service, WSUS servers must be configured to store update files on the local computer. 

When you configure WSUS servers to store update files on the local computer, both the update metadata and the update files are downloaded by and stored directly upon the WSUS server. This ensures that BranchCache client computers receive Microsoft product update files from the WSUS server rather than directly from the Microsoft Update Web site.  
  
For more information about WSUS synchronization, see [Setting up Update Synchronizations](https://technet.microsoft.com/library/mt612311.aspx)  