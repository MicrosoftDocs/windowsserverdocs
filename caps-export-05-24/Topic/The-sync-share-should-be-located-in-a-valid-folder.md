---
title: The sync share should be located in a valid folder
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c56266f2-1299-4d89-85cf-d3b7aac2fbec
robots: noindex,nofollow
---
# The sync share should be located in a valid folder
[!INCLUDE[win8_bpa_intro](../Token/win8_bpa_intro_md.md)]  
  
|||  
|-|-|  
|Operating System|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|  
|Product\/Feature|File and Storage Services|  
|Severity|Error|  
|Category|Configuration|  
  
## Issue  
*The path for the sync share does not exist*  
  
## Impact  
*Users will not be able to sync with this sync share using Work Folders.*  
  
## Resolution  
*Reinitialize the sync share by using the Set\-SyncShare cmdlet from a Windows PowerShell session.*  
  
## See also  
T:SyncShare.Set\-SyncShare  
  
