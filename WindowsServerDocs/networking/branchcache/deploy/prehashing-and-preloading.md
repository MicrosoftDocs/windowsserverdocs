---
title: Prehashing and Preloading Content on Hosted Cache Servers (Optional)
description: This topic is part of the BranchCache Deployment Guide for Windows Server 2016, which demonstrates how to deploy BranchCache in distributed and hosted cache modes to optimize WAN bandwidth usage in branch offices.
manager: brianlic
ms.prod: windows-server
ms.technology: networking-bc
ms.topic: get-started-article
ms.assetid: 5a09d9f1-1049-447f-a9bf-74adf779af27
ms.author: lizross
author: eross-msft
---
# Prehashing and Preloading Content on Hosted Cache Servers (Optional)

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this procedure to force the creation of content information - also called hashes - on BranchCache-enabled Web and file servers. You can also gather the data on file and web servers into packages that can be transferred to remote hosted cache servers.  This provides you with the ability to preload content on remote hosted cache servers so that data is available for the first client access.  
  
You must be a member of **Administrators**, or equivalent to perform this procedure.  
  
### To prehash content and preload the content on hosted cache servers  
  
1.  Log on to the file or Web server that contains the data that you wish to preload, and identify the folders and files that you wish to load on one or more remote hosted cache servers.  
  
2.  Run Windows PowerShell as an Administrator. For each folder and file, run either the `Publish-BCFileContent` command or the `Publish-BCWebContent` command, depending on the type of content server, to trigger hash generation and to add data to a data package.  
  
3.  After all the data has been added to the data package, export it by using the `Export-BCCachePackage` command to produce a data package file.  
  
4.  Move the data package file to the remote hosted cache servers by using your choice of file transfer technology.  FTP, SMB, HTTP, DVD and portable hard disks are all viable transports.  
  
5.  Import the data package file on the remote hosted cache servers by using the `Import-BCCachePackage` command.  
  

