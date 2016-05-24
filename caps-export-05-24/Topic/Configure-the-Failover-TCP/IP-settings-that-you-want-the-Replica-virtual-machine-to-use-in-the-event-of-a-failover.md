---
title: Configure the Failover TCP/IP settings that you want the Replica virtual machine to use in the event of a failover
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 035e7db2-7b72-4c97-a37f-4bdc28ffe3e9
author: KBDAzure
---
# Configure the Failover TCP/IP settings that you want the Replica virtual machine to use in the event of a failover
\[This information is preliminary and subject to change.\]  
  
For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](http://go.microsoft.com/fwlink/p/?LinkID=223177).  
  
|||  
|-|-|  
|**Operating System**|[!INCLUDE[winthreshold_server_2_md](/Token/winthreshold_server_2_md.md)]|  
|**Product\/Feature**|Hyper\-V|  
|**Severity**|Warning|  
|**Category**|Configuration|  
  
Note: The following sections provide details about the specific issue. Italics indicates UI text that appears in the Best Practices Analyzer tool for the specific issue.  
  
## Issue  
*Replica virtual machines configured with a static IP address should be configured to use a different IP address from their primary virtual machine counterpart in the event of failover.*  
  
## Impact  
*Clients using the workload supported by the primary virtual machine might not be able to connect to the Replica virtual machine after a failover. Also, the primary virtual machine's original IP address will not be valid in the Replica virtual machine network topology. This impacts the following virtual machines:*  
  
\<list of virtual machines>  
  
## Resolution  
*Use Hyper\-V Manager to configure the IP address that the Replica virtual machine should use in the event of failover.*  
  
