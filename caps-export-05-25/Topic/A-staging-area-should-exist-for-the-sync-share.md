---
title: A staging area should exist for the sync share
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 14f73b70-e844-45b7-b7c4-420db2ef6362
author: JasonGerend
robots: noindex,nofollow
---
# A staging area should exist for the sync share
[!INCLUDE[win8_bpa_intro](../Token/win8_bpa_intro_md.md)]  
  
|||  
|-|-|  
|Operating System|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|  
|Product\/Feature|File and Storage Services|  
|Severity|Error|  
|Category|Configuration|  
  
## Issue  
*The staging area for a sync share does not exist.*  
  
## Impact  
*Users will not be able to sync with this sync share using Work Folders.*  
  
## Resolution  
*Reinitialize the sync share by using the Set\-SyncShare cmdlet from a Windows PowerShell session.*  
  
## See also  
T:SyncShare.Set\-SyncShare \-\- Code Entity  
  
