---
title: Configure guest operating systems for VSS-based backups to enable application-consistent snapshots for Hyper-V Replica
description: " "
ms.prod: windows-server-threshold
ms.service: na
manager: timlt
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.author: kathydav
ms.topic: article
ms.assetid: 7638e996-d42d-47b8-a670-1e09e7183850
author: KBDAzure
---
# Configure guest operating systems for VSS-based backups to enable application-consistent snapshots for Hyper-V Replica

>Applies To: Windows Server Technical Preview

[This information is preliminary and subject to change.]  
  
For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](http://go.microsoft.com/fwlink/p/?LinkID=223177).  
  
|Property|Details|  
|-|-|  
|**Operating System**|Windows Server 2016 Technical Preview|  
|**Product/Feature**|Hyper-V|  
|**Severity**|Error|  
|**Category**|Configuration|  
  
In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.  
  
## Issue  
*Application-consistent snapshots requires that Volume Shadow Copy Services (VSS) is enabled and configured in the guest operating systems of virtual machines participating in replication.*  
  
## Impact  
*Even if application-consistent snapshots are specified in the replication configuration, Hyper-V will not use them unless VSS is configured. This impacts the following virtual machines:*  
  
\<list of virtual machines>  
  
## Resolution  
*Use Virtual Machine Connection to install integration services in the virtual machine.*  
  


