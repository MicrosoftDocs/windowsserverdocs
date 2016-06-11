---
title: Virtual machines configured with a virtual Fibre Channel adapter should be configured for high availability to the Fibre Channel-based storage
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 73127bdd-8086-4268-a93c-2fdf1623e91b
author: KBDAzure
---
# Virtual machines configured with a virtual Fibre Channel adapter should be configured for high availability to the Fibre Channel-based storage
\[This information is preliminary and subject to change.\]  
  
For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](http://go.microsoft.com/fwlink/p/?LinkID=223177).  
  
|||  
|-|-|  
|**Operating System**|[!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)]|  
|**Product\/Feature**|Hyper\-V|  
|**Severity**|Information|  
|**Category**|Configuration|  
  
Note: The following sections provide details about the specific issue. Italics indicates UI text that appears in the Best Practices Analyzer tool for the specific issue.  
  
## **Issue**  
*One or more virtual machines lack a highly available connection to Fibre Channel\-based storage because those virtual machines are configured with a virtual Fibre Channel adapter that is connected to only one host bus adapter \(HBA\).*  
  
## **Impact**  
*A failure of the host bus adapter might block the Fibre Channel connection between the storage and the virtual machines. This impacts the following virtual machines:*  
  
\<list of virtual machines>  
  
## **Resolution**  
*Add another connection from the virtual machine to the host bus adapter and configure multipath I\/O \(MPIO\) in the guest operating system to establish redundant Fibre Channel connections.*  
  

