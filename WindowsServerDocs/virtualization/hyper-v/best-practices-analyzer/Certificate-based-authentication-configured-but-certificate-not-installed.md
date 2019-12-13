---
title: Certificate-based authentication is configured, but the specified certificate is not installed on the Replica server or failover cluster nodes
description: "Online version of the text for this Best Practices Analyzer rule."
ms.prod: windows-server
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.author: kathydav
ms.topic: article
ms.assetid: 4cabbce3-9367-4ddc-a108-1e5e1ab2bcff
author: KBDAzure
ms.date: 8/16/2016
---
# Certificate-based authentication is configured, but the specified certificate is not installed on the Replica server or failover cluster nodes

>Applies To: Windows Server 2016


  
*For more information about best practices and scans, see* [Best Practices Analyzer](https://go.microsoft.com/fwlink/?LinkId=122786).  
  
|Property|Details|  
|-|-|  
|**Operating System**|Windows Server 2016|  
|**Product/Feature**|Hyper-V|  
|**Severity**|Error|  
|**Category**|Configuration|  

In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.

## Issue  
  
*The security certificate that Hyper-V Replica has been configured to use to provide certificate-based replication is not installed on the Replica server (or any failover cluster nodes).*  
  
## Impact  
  
*In the event of a cluster failover or move to another node, Hyper-V replication will pause if the new node does not also have the appropriate certificate installed. This impacts the following nodes:*  
  
\<list of nodes>  
  
## Resolution  
  
*Install the configured certificate on the Replica server (and all associated nodes in the failover cluster, if any).*  
  


