---
title: A current SSL certificate should be configured for this Work Folders server
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5c96a345-8254-402d-820a-87de371493d0
author: JasonGerend
robots: noindex,nofollow
---
# A current SSL certificate should be configured for this Work Folders server
[!INCLUDE[win8_bpa_intro](../Token/win8_bpa_intro_md.md)]  
  
|||  
|-|-|  
|Operating System|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|  
|Product\/Feature|File and Storage Services|  
|Severity|Error|  
|Category|Configuration|  
  
## Issue  
*An SSL certificate is either not configured or is expired.*  
  
## Impact  
*Users will not be able to sync with this sync share using the encrypted HTTPS protocol. Users might be able to sync with the unencrypted HTTP protocol, if it’s configured.*  
  
## Resolution  
*Install a new SSL certificate and bind it to the server*  
  
## See also  
