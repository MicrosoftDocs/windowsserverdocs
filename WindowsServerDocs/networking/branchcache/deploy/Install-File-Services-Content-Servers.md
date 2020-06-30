---
title: Install File Services Content Servers
description: This topic is part of the BranchCache Deployment Guide for Windows Server 2016, which demonstrates how to deploy BranchCache in distributed and hosted cache modes to optimize WAN bandwidth usage in branch offices
manager: brianlic
ms.prod: windows-server
ms.technology: networking-bc
ms.topic: get-started-article
ms.assetid: 74b0a5ed-dc20-4974-9d4b-2426987a01a1
ms.author: lizross
author: eross-msft
---
# Install File Services Content Servers

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

To deploy content servers that are running the File Services server role, you must install the BranchCache for network files role service of the File Services server role. In addition, you must enable BranchCache on file shares according to your requirements.  
  
During the configuration of the content server, you can allow BranchCache publication of content for all file shares or you can select a subset of file shares to publish.  
  
> [!NOTE]  
> When you deploy a BranchCache enabled file server or Web server as a content server, content information is now calculated offline, well before a BranchCache client requests a file. Because of this improvement, you do not need to configure hash publication for content servers, as you did in the previous version of BranchCache.  
>   
> This automatic hash generation provides faster performance and more bandwidth savings, because content information is ready for the first client that requests the content, and calculations have already been performed.  
  
See the following topics to deploy content servers.  
  
-   [Configure the File Services server role](../../branchcache/deploy/Configure-the-File-Services-server-role.md)  
  
-   [Enable Hash Publication for File Servers](../../branchcache/deploy/Enable-Hash-Publication-for-File-Servers.md)  
  
-   [Enable BranchCache on a File Share &#40;Optional&#41;](../../branchcache/deploy/enable-bc-on-file-share.md)  
  


