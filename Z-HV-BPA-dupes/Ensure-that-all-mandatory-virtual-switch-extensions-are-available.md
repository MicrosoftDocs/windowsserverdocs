---
title: Ensure that all mandatory virtual switch extensions are available
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2f2f2698-f5ec-4cad-aa64-d6987e8142a1
author: KBDAzure
---
# Ensure that all mandatory virtual switch extensions are available
\[This information is preliminary and subject to change.\]  
  
For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](http://go.microsoft.com/fwlink/p/?LinkID=223177).  
  
|||  
|-|-|  
|**Operating System**|[!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)]|  
|**Product\/Feature**|Hyper\-V|  
|**Severity**|Warning|  
|**Category**|Configuration|  
  
In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.  
  
## Issue  
*One or more virtual network adapters are connected to a virtual switch with mandatory extensions that are disabled or not installed.*  
  
## Impact  
*Network traffic is blocked on one or more virtual network adapters on the following virtual machines:*  
  
\<list of virtual machines>  
  
## Resolution  
*First, make sure that the mandatory extension has been installed on the host and install the extension if necessary. Then, if the mandatory extension is disabled, use Virtual Switch Manager or the Windows PowerShell cmdlet Enable\-VMSwitchExtension to enable the extension.*  
  

