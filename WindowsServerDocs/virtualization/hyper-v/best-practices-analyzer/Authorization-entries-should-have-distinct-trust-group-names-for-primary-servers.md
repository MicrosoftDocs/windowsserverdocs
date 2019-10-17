---
title: Authorization entries should have distinct trust group names for primary servers with virtual machines that are not part of the same trust group
description: "Online version of the text for this Best Practices Analyzer rule."
ms.prod: windows-server
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.author: kathydav
ms.topic: article
ms.assetid: 8827a3a7-9f3c-4f51-826a-8e2ec43e01df
author: KBDAzure
ms.date: 8/16/2016
---
# Authorization entries should have distinct trust group names for primary servers with virtual machines that are not part of the same trust group

>Applies To: Windows Server 2016

For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](https://go.microsoft.com/fwlink/p/?LinkID=223177).  
  
|Property|Details|  
|-|-|  
|**Operating System**|Windows Server 2016|  
|**Product/Feature**|Hyper-V|  
|**Severity**|Warning|  
|**Category**|Configuration|  
  
In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.  
  
## **Issue**  
*The server will accept replication requests for the replica virtual machine from any of the servers in the authorization list associated with the same replication tag as the virtual machine.*  
  
## **Impact**  
*There might be privacy and security concerns with a virtual machine accepting replication from primary servers belonging to different authorization entries. This impacts the following authorization entries: \<list of authorization entries>*  
  
## **Resolution**  
*Use different tags in the authorization entries for primary servers with virtual machines that are not part of the same security group. Modify the Hyper-V settings to configure the replication tags.*  
  


