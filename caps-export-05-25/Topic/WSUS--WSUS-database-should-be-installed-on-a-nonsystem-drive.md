---
title: WSUS: WSUS database should be installed on a nonsystem drive
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4fe9622c-cc33-4981-a58b-47b41e64cbb1
author: britw
---
# WSUS: WSUS database should be installed on a nonsystem drive
*This topic is intended to address a specific issue identified by a [!INCLUDE[bpa](../Token/bpa_md.md)] scan. You should apply the information in this topic only to computers that have had the Windows Server Update Services \(WSUS\) [!INCLUDE[bpa](../Token/bpa_md.md)] run against them and are experiencing the issue addressed by this topic. For more information about [!INCLUDE[bpa](../Token/bpa_md.md)] and scans, see [Best Practices Analyzer](http://go.microsoft.com/fwlink/?LinkId=122786) on Microsoft TechNet.*  
  
|||  
|-|-|  
|**Operating System**|[!INCLUDE[firstref_server_7](../Token/firstref_server_7_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]|  
|**Product\/Feature**|Windows Server Update Services 3.0 SP2 \(WSUS 3.0 SP2\)|  
|**Severity**|Warning|  
|**Category**|Performance|  
  
## Issue  
  
> *WSUS database is installed on the system drive.*  
  
## Impact  
  
> *If the system drive runs out of disk space, this can lead to corruption of the operating system and denial of service.*  
  
## Resolution  
  
> *Move the database to a non\-system drive.*  
  
Move the WSUS database \(**SUSDB**\) by following the procedure in [Moving User Databases](http://go.microsoft.com/fwlink/?LinkId=166062) on MSDN.  
  
