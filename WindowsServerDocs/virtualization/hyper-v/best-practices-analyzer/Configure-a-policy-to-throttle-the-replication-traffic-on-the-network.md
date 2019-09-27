---
title: Configure a policy to throttle the replication traffic on the network
description: "Online version of the text for this Best Practices Analyzer rule."
ms.prod: windows-server
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.author: kathydav
ms.topic: article
ms.assetid: 82cb1aef-cdc3-4d0a-88d4-ef497ab79606
author: KBDAzure
ms.date: 8/16/2016
---
# Configure a policy to throttle the replication traffic on the network

>Applies To: Windows Server 2016

For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](https://go.microsoft.com/fwlink/p/?LinkID=223177).  
  
|Property|Details|  
|-|-|  
|**Operating System**|Windows Server 2016|  
|**Product/Feature**|Hyper-V|  
|**Severity**|Warning|  
|**Category**|Configuration|  
  
In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.  
  
## Issue  
*There might not be a limit on the amount of network bandwidth that replication is allowed to consume.*  
  
## Impact  
*Network bandwidth could become completely dominated by replication traffic, affecting other critical network activity. This impacts the following ports:*  
  
\<list of virtual machines>  
  
## Resolution  
*If you use another method to throttle network traffic, you can ignore this. Otherwise, use Group Policy Editor to configure a policy that will throttle the network traffic to the relevant port of the Replica server.*  
  
  


