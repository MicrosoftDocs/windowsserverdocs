---
title: PVLAN configuration on a virtual switch must be consistent
description: " "
ms.prod: windows-server-threshold
ms.service: na
manager: timlt
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4db63bcc-7a54-4f19-98a6-c274c3956d51
author: KBDAzure
---
# PVLAN configuration on a virtual switch must be consistent
[This information is preliminary and subject to change.]  
  
For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](http://go.microsoft.com/fwlink/p/?LinkID=223177).  
  
|||  
|-|-|  
|**Operating System**|Windows Server 2016 Technical Preview  
|**Product/Feature**|Hyper-V|  
|**Severity**|Error|  
|**Category**|Configuration|  
  
Note: The following sections provide details about the specific issue. Italics indicates UI text that appears in the Best Practices Analyzer tool for the specific issue.  
  
## **Issue**  
*Private Virtual Local Area Network (PVLAN) is not configured correctly on one or more virtual network adapters.*  
  
## **Impact**  
*PVLAN might not isolate network traffic between virtual machines correctly.*  
  
## **Resolution**  
*Use the Windows PowerShell cmdlet, Set-VMNetworkAdapterVlan, to configure PVLAN correctly.*  
  

