---
title: All nodes in a failover cluster should be reachable to Work Folders
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f3d1c6bd-0325-45bf-a263-b783252fa380
author: JasonGerend
robots: noindex,nofollow
---
# All nodes in a failover cluster should be reachable to Work Folders
[!INCLUDE[win8_bpa_intro](../Token/win8_bpa_intro_md.md)]  
  
|||  
|-|-|  
|Operating System|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|  
|Product\/Feature|File and Storage Services|  
|Severity|Error|  
|Category|Operation|  
  
## Issue  
*The following nodes in a failover cluster cannot be verified because the nodes are not reachable, or because the BPA scan was performed against a remote failover cluster*  
  
## Impact  
*Best Practices Analyzer will not be able to check the status of Work Folders on the following nodes*  
  
## Resolution  
*Confirm that the nodes are online, log on to the nodes locally \(or by using Remote Desktop\), and then run the Best Practices Analyzer scan again.*  
  
## See also  
