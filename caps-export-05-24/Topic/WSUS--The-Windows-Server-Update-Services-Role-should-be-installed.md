---
title: WSUS: The Windows Server Update Services Role should be installed
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 58d995c6-7d1a-4294-9f64-ec536e4b604c
author: britw
---
# WSUS: The Windows Server Update Services Role should be installed
This information is intended to address a specific issue identified prior to running a [!INCLUDE[bpa](../Token/bpa_md.md)] scan. You should apply the information in this topic only to computers that will have the Windows Server Upgrade Services \(WSUS\) [!INCLUDE[bpa](../Token/bpa_md.md)] run against them and are experiencing the issue addressed by this topic. For more information about [!INCLUDE[bpa](../Token/bpa_md.md)] and scans, see [Best Practices Analyzer](http://go.microsoft.com/fwlink/?LinkId=122786) on Microsoft TechNet.  
  
|||  
|-|-|  
|**Operating System**|[!INCLUDE[firstref_server_7](../Token/firstref_server_7_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]|  
|**Product\/Feature**|Windows Server Update Services 3.0 SP2 \(WSUS 3.0 SP2\)|  
|**Severity**|Warning|  
|**Category**|Prerequisite|  
  
## Issue  
  
> *The Windows Server Update Services Role is not installed.*  
  
## Impact  
  
> *The WSUS Best Practices Analyzer scan will not run unless the WSUS Role is installed on the machine.*  
  
## Resolution  
  
> *Install the WSUS Role through [!INCLUDE[rmt](../Token/rmt_md.md)]*.  
  
After you verify that the server meets the minimum system requirements and that the necessary account permissions were granted, install WSUS 3.0 SP2. Start the installation of WSUS 3.0 SP2 by using [!INCLUDE[rmt](../Token/rmt_md.md)].  
  
For detailed installation instructions, see [Step 2: Install WSUS Server or Administration Console](http://go.microsoft.com/fwlink/?LinkId=168524) on Microsoft TechNet or download the [Windows Server Update Services 3.0 SP2 Step By Step Guide](http://go.microsoft.com/fwlink/?LinkId=139836) from the Microsoft Download Center.  
  
