---
title: Compression is recommended for replication traffic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: cf8be6e9-2909-4e4a-bb63-d1e1ebbc6930
author: KBDAzure
---
# Compression is recommended for replication traffic
\[This information is preliminary and subject to change.\]  
  
For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](http://go.microsoft.com/fwlink/p/?LinkID=223177).  
  
|||  
|-|-|  
|**Operating System**|[!INCLUDE[winthreshold_server_2](../../../includes/winthreshold_server_2_md.md)]|  
|**Product\/Feature**|Hyper\-V|  
|**Severity**|Warning|  
|**Category**|Configuration|  
  
In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.  
  
## Issue  
*The replication traffic sent across the network from the primary server to the Replica server is uncompressed.*  
  
## Impact  
*Replication traffic will use more bandwidth than necessary. This impacts the following virtual machines:*  
  
\<list of virtual machines>  
  
## Resolution  
*Configure Hyper\-V Replica to compress the data transmitted over the network in the settings for the virtual machine in Hyper\-V Manager. You can also use tools outside of Hyper\-V to perform compression.*  
  

