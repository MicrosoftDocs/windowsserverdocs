---
title: Dynamic Memory is enabled but not responding on some virtual machines
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 91b7f50f-a071-4ab6-beb1-1b29f92f52b6
author: KBDAzure
---
# Dynamic Memory is enabled but not responding on some virtual machines
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
*One or more virtual machines are experiencing problems with the driver required for Dynamic Memory in the guest operating system.*  
  
## Impact  
*The guest operating system in the following virtual machines might not run or might run unreliably because Hyper\-V cannot adjust the memory dynamically to respond to changes in memory demand. This impacts the following virtual machines:*  
  
\<list of virtual machines>  
  
## Resolution  
*This is expected behavior if the virtual machine is booting. If the virtual machine is not booting, make sure that integration services are upgraded to the latest version and that the guest operating system supports Dynamic Memory.*  
  
As of [!INCLUDE[winthreshold_server_2_md](../../../includes/winthreshold_server_2_md.md)], integration services are delivered through Windows Update. Ensure the virtual machines are configured to receive updates to get the latest version of integration services.  
  
Dynamic Memory works with specific versions of supported guests. See [Hyper-V Dynamic Memory Overview](https://technet.microsoft.com/library/hh831766.aspx) for versions older than Windows Server 2016 and Windows 10.  
  

