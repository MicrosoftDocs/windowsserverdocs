---
title: Work Folders should be installed on all nodes of the failover cluster
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6dd93443-73c2-44d6-936a-1cb0ea12aa46
author: JasonGerend
robots: noindex,nofollow
---
# Work Folders should be installed on all nodes of the failover cluster
[!INCLUDE[win8_bpa_intro](../Token/win8_bpa_intro_md.md)]  
  
|||  
|-|-|  
|Operating System|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|  
|Product\/Feature|File and Storage Services|  
|Severity|Error|  
|Category|Configuration|  
  
## Issue  
*Work Folders is not installed on a node of a failover cluster that is hosting sync shares.*  
  
## Impact  
*Work Folders will not fail over to any nodes that do not have the role service installed, potentially resulting in users not being able to sync with this clustered file server instance.*  
  
## Resolution  
*Install the Work Folders role service on the cluster node.*  
  
## See also  
