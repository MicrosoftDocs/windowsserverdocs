---
title: The number of logical processors in use must not exceed the supported maximum
description: " "
ms.prod: windows-server-threshold
ms.service: na
manager: timlt
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 66df8b02-91d1-424b-8934-a39c214d530e
author: KBDAzure
---
# The number of logical processors in use must not exceed the supported maximum
[This information is preliminary and subject to change.]  
  
*For more information about best practices and scans, see* [Best Practices Analyzer](http://go.microsoft.com/fwlink/?LinkId=122786).  
  
|||  
|-|-|  
|**Operating System**|Windows Server 2016 Technical Preview|  
|**Product/Feature**|Hyper-V|  
|**Severity**|Error|  
|**Category**|Policy|  
  
In the following sections, italics indicates text that appears in the Best Practices Analyzer tool for this issue.  
  
## Issue  
  
*The server is configured with too many logical processors.*  
  
## Impact  
  
*Microsoft does not support running Hyper-V on this computer.*  
  
## Resolution  
  
*Remove some processors from this machine or use msconfig to limit the number of available processors.*  
  
See the following instructions to use Msconfig. For details about removing processors, see the instructions that came with the computer or contact the hardware manufacturer. For details about maximum supported configurations for Hyper-V, see [Plan for Hyper-V scalability in Windows Server 2016](../plan/Plan-for-Hyper-V-scalability-in-Windows-Server-2016.md).  
  
### To limit the number of available processors  
  
1.  Open the System Configuration app (Msconfig.exe). To do this, click **Start**, type **msconfig**, right-click the **System Configuration** desktop app and click **Run as administrator**.  
  
2.  From the **Boot** tab, click **Advanced options**.  
  
3.  Select **Number of processors** and then select a number in the list. Click **OK**.  
  
4.  Restart the computer to run it using the new number of processors.  
  

