---
title: Certificate-based authentication is recommended for replication
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d931cc57-414f-4bdf-9ebd-08fd5e22b19d
author: KBDAzure
---
# Certificate-based authentication is recommended for replication
\[This information is preliminary and subject to change.\]  
  
For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](http://go.microsoft.com/fwlink/p/?LinkID=223177).  
  
|||  
|-|-|  
|**Operating System**|[!INCLUDE[winthreshold_server_2](../Token/winthreshold_server_2_md.md)]|  
|**Product\/Feature**|Hyper\-V|  
|**Severity**|Warning|  
|**Category**|Configuration|  
  
In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.  
  
## **Issue**  
*One or more virtual machines selected for replication are configured for Kerberos authentication.*  
  
## **Impact**  
*The replication network traffic from the primary server to the replication server is unencrypted. This impacts the following virtual machines:*  
  
\<list of virtual machines>  
  
## **Resolution**  
*If another method is being used to perform encryption, you can ignore this. Otherwise, modify the virtual machine settings to choose certificate\-based authentication.*  
  
