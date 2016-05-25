---
title: Ensure that the virtual function driver operates correctly when a virtual machine is configured to use SR-IOV
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d21e4b93-29bf-423a-a635-71c6d48dc49e
author: KBDAzure
---
# Ensure that the virtual function driver operates correctly when a virtual machine is configured to use SR-IOV
\[This information is preliminary and subject to change.\]  
  
For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](http://go.microsoft.com/fwlink/p/?LinkID=223177).  
  
|||  
|-|-|  
|**Operating System**|[!INCLUDE[winthreshold_server_2](../Token/winthreshold_server_2_md.md)]|  
|**Product\/Feature**|Hyper\-V|  
|**Severity**|Warning|  
|**Category**|Configuration|  
  
In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.  
  
## Issue  
*The virtual function driver is not operating correctly in the guest operating system of one or more virtual machines.*  
  
## Impact  
*Networking performance is not optimal on the following virtual machines:*  
  
\<list of virtual machines>  
  
## Resolution  
*In the guest operating system, do the following: Verify that appropriate drivers are installed and all networking devices are enabled, and check the Event log for errors or warnings.*  
  
