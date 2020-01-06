---
title: The WFP virtual switch extension should be enabled if it is required by third party extensions
description: "Online version of the text for this Best Practices Analyzer rule."
ms.prod: windows-server
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.author: kathydav
ms.topic: article
ms.assetid: 8aa8a9a5-e3fa-4c9b-8331-ba5a3de22429
author: KBDAzure
ms.date: 8/16/2016
---
# The WFP virtual switch extension should be enabled if it is required by third party extensions

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
*The Windows Filtering Platform (WFP) virtual switch extension is disabled.*  
  
## **Impact**  
*Some third party virtual switch extensions may not operate correctly on the following virtual switches:*  
  
\<list of virtual machines>  
  
## **Resolution**  
*Use the Windows PowerShell cmdlet, Enable-VMSwitchExtension, to enable the Windows Filtering Platform if it is required by third party extensions.*  
  
### Enable the Windows Filtering Platform using Windows PowerShell  
  
1.  Open Windows PowerShell. (From the desktop, click **Start** and start typing **Windows PowerShell**.)  
  
2.  Right-click **Windows PowerShell** and click **Run as administrator**.  
  
3.  Run this command after replacing External with the name  of your external switch:  
  
```  
Enable-VMSwitchExtension -VMSwitchName External -Name "Microsoft Windows Filtering Platform"  
```  
  
## See Also  
[Enable-VMSwitchExtension](https://technet.microsoft.com/library/hh848541.aspx)  
  


