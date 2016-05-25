---
title: Install File Services Content Servers
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b14bffe2-695a-4b62-bde3-ac9709a3209e
author: vhorne
---
# Install File Services Content Servers
To deploy content servers that are running the File Services server role, you must install the BranchCache for network files role service of the File Services server role. In addition, you must enable BranchCache on file shares according to your requirements.  
  
During the configuration of the content server, you can allow BranchCache publication of content for all file shares or you can select a subset of file shares to publish.  
  
> [!NOTE]  
> When you deploy a BranchCache enabled file server or Web server as a content server, content information is now calculated offline, well before a BranchCache client requests a file. Because of this improvement, you do not need to configure hash publication for content servers, as you did in the previous version of BranchCache.  
>   
> This automatic hash generation provides faster performance and more bandwidth savings, because content information is ready for the first client that requests the content, and calculations have already been performed.  
  
See the following topics to deploy content servers.  
  
-   [Configure the File Services server role_2](../Topic/Configure-the-File-Services-server-role_2.md)  
  
-   [Enable Hash Publication for File Servers_1](../Topic/Enable-Hash-Publication-for-File-Servers_1.md)  
  
-   [Enable BranchCache on a File Share &#40;Optional&#41;_1](../Topic/Enable-BranchCache-on-a-File-Share--Optional-_1.md)  
  
