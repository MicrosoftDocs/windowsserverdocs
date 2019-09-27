---
title: To participate in replication, servers in failover clusters must have a Hyper-V Replica Broker configured
description: "Online version of the text for this Best Practices Analyzer rule."
ms.prod: windows-server
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.author: kathydav
ms.topic: article
ms.assetid: 5ec88ce5-a8b2-4ece-9062-366523c8b17f
author: KBDAzure
ms.date: 8/16/2016
---
# To participate in replication, servers in failover clusters must have a Hyper-V Replica Broker configured

>Applies To: Windows Server 2016

For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](https://go.microsoft.com/fwlink/p/?LinkID=223177).  
  
|Property|Details|  
|-|-|  
|**Operating System**|Windows Server 2016|  
|**Product/Feature**|Hyper-V|  
|**Severity**|Error|  
|**Category**|Configuration|  
  
In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.  
  
## Issue  
*For failover clusters, Hyper-V Replica requires the use of a Hyper-V Replica Broker name instead of an individual server name.*  
  
## Impact  
*If the virtual machine is moved to a different failover cluster node, replication cannot continue.*  
  
## Resolution  
*Use Failover Cluster Manager to configure the Hyper-V Replica Broker. In Hyper-V Manager, ensure that the replication configuration uses the Hyper-V Replica Broker name as the server name.*  
  


