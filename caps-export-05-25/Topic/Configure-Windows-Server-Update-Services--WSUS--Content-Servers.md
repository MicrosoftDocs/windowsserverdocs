---
title: Configure Windows Server Update Services (WSUS) Content Servers
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: 9724aa8d-e4ae-404c-bee6-cef1534cd3ca
author: vhorne
---
# Configure Windows Server Update Services (WSUS) Content Servers
After installing the BranchCache feature and starting the BranchCache service, WSUS servers must be configured to store update files on the local computer. When you configure WSUS servers to store update files on the local computer, both the update metadata and the update files are downloaded by and stored directly upon the WSUS server. This ensures that BranchCache client computers receive Microsoft product update files from the WSUS server rather than directly from the Microsoft Update Web site.  
  
For more information about WSUS synchronization, see [Setting up Update Synchronizations](https://technet.microsoft.com/en-us/library/mt612311.aspx)  
  
