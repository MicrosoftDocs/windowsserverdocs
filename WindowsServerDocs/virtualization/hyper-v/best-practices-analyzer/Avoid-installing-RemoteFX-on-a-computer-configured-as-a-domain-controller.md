---
title: Avoid installing RemoteFX on a computer that is configured as an Active Directory domain controller
description: "Online version of the text for this Best Practices Analyzer rule."
ms.prod: windows-server
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.author: kathydav
ms.topic: article
ms.assetid: da58694e-91f6-45d8-a599-18966db165f4
author: KBDAzure
ms.date: 8/16/2016
---
# Avoid installing RemoteFX on a computer that is configured as an Active Directory domain controller

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
*RemoteFX is installed on a domain controller.*  
  
## **Impact**  
*Virtual computers configured for RemoteFX cannot be used on these computers.*  
  
## **Resolution**  
*Decide if you want this server to be configured either with RemoteFX for Hyper-V or as an Active Directory Domain Controller, then reconfigure the server as necessary.*  
  


