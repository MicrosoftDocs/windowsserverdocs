---
title: PVLAN configuration on a virtual switch must be consistent
description: "Online version of the text for this Best Practices Analyzer rule."
ms.prod: windows-server
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.author: kathydav
ms.topic: article
ms.assetid: 4db63bcc-7a54-4f19-98a6-c274c3956d51
author: KBDAzure
ms.date: 8/16/2016
---
# PVLAN configuration on a virtual switch must be consistent

>Applies To: Windows Server 2016

For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](https://go.microsoft.com/fwlink/p/?LinkID=223177).  
  
|Property|Details|  
|-|-|  
|**Operating System**|Windows Server 2016| 
|**Product/Feature**|Hyper-V|  
|**Severity**|Error|  
|**Category**|Configuration|  
  
In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.
  
## **Issue**  
*Private Virtual Local Area Network (PVLAN) is not configured correctly on one or more virtual network adapters.*  
  
## **Impact**  
*PVLAN might not isolate network traffic between virtual machines correctly.*  
  
## **Resolution**  
*Use the Windows PowerShell cmdlet, Set-VMNetworkAdapterVlan, to configure PVLAN correctly.*  
  


