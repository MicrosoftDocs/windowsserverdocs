---
title: A team bound to a virtual switch should only have one exposed team interface
description: "Online version of the text for this Best Practices Analyzer rule."
ms.prod: windows-server
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.author: kathydav
ms.topic: article
ms.assetid: 1074f086-1a2e-42e1-b58c-f55e657d5ce1
author: KBDAzure
ms.date: 8/16/2016
---
# A team bound to a virtual switch should only have one exposed team interface

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
*One or more virtual switches are bound to a team that has multiple team interfaces.*  
  
## **Impact**  
*The following virtual switches might not have access to VLANs and bandwidth used by other team interfaces:*  
  
\<list of virtual switches>  
  
## **Resolution**  
*Use the Windows PowerShell cmdlet Remove-NetLbfoTeamNic to remove all team interfaces from the team other than the default team interface.*  
  


