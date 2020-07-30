---
title: Enable Hash Publication for Domain Member File Servers
description: This topic is part of the BranchCache Deployment Guide for Windows Server 2016, which demonstrates how to deploy BranchCache in distributed and hosted cache modes to optimize WAN bandwidth usage in branch offices
manager: brianlic
ms.prod: windows-server
ms.technology: networking-bc
ms.topic: get-started-article
ms.assetid: a3f1f7c4-d9b2-43e6-8bfa-fac707bbd4d3
ms.author: lizross
author: eross-msft
---
# Enable Hash Publication for Domain Member File Servers

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

When you're using Active Directory Domain Services (AD DS), you can use domain Group Policy to enable BranchCache hash publication for multiple file servers. To do so, you must create an organizational unit (OU), add file servers to the OU, create a BranchCache hash publication Group Policy Object (GPO), and then configure the GPO.  
  
See the following topics to enable hash publication for multiple file servers.  
  
-   [Create the BranchCache File Servers Organizational Unit](../../branchcache/deploy/Create-the-BranchCache-File-Servers-Organizational-Unit.md)  
  
-   [Move File Servers to the BranchCache File Servers Organizational Unit](../../branchcache/deploy/Move-File-Servers-to-the-BranchCache-File-Servers-Organizational-Unit.md)  
  
-   [Create the BranchCache Hash Publication Group Policy Object](../../branchcache/deploy/Create-the-BranchCache-Hash-Publication-Group-Policy-Object.md)  
  
-   [Configure the BranchCache Hash Publication Group Policy Object](../../branchcache/deploy/Configure-the-BranchCache-Hash-Publication-Group-Policy-Object.md)  
  


