---
title: WSUS: WSUS should be installed on a non-domain controller
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 684666a4-228b-4af1-be32-f9c3e8b4fe70
author: britw
---
# WSUS: WSUS should be installed on a non-domain controller
*This topic is intended to address a specific issue identified by a [!INCLUDE[bpa](../Token/bpa_md.md)] scan. You should apply the information in this topic only to computers that have had the Windows Server Update Services \(WSUS\) [!INCLUDE[bpa](../Token/bpa_md.md)] run against them and are experiencing the issue addressed by this topic. For more information about [!INCLUDE[bpa](../Token/bpa_md.md)] and scans, see [Best Practices Analyzer](http://go.microsoft.com/fwlink/?LinkId=122786) on Microsoft TechNet.*  
  
|||  
|-|-|  
|**Operating System**|[!INCLUDE[firstref_server_7](../Token/firstref_server_7_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]|  
|**Product\/Feature**|Windows Server Update Services 3.0 SP2 \(WSUS 3.0 SP2\)|  
|**Severity**|Informational|  
|**Category**|Configuration|  
  
## Issue  
  
> *WSUS is installed on a domain controller.*  
  
## Impact  
  
> *If WSUS is installed a domain controller, this will cause database access issues due to how the database is configured.*  
  
Installing WSUS on a domain controller can also cause problems upgrading or installing WSUS in the future.  
  
## Resolution  
  
> *Uninstall WSUS from the domain controller, demote the server to a non\-domain controller, and reinstall WSUS.*  
  
Alternately, you can install WSUS on a different non\-domain controller machine.  
  
For detailed instructions about how to remove WSUS 3.0 SP2, see the Removal section in the Microsoft Support Article 972455: [Description of Windows Server Update Services 3.0 Service Pack 2](http://go.microsoft.com/fwlink/?LinkId=162639).  
  
