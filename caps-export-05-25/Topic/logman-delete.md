---
title: logman delete
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8f3b2422-3dce-4fb4-adbb-8536b1d7da2b
author: jaimeo
---
# logman delete
Delete an existing data collector.  
  
For examples of how this command can be used, see [Examples](#BKMK_examples).  
  
## Syntax  
  
```  
logman delete <[-n] <name>> [options]  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|\/?|Displays context\-sensitive help.|  
|\-s <computer name>|Perform the command on the specified remote computer.|  
|\-config <value>|Specifies the settings file containing command options.|  
|\[\-n\] <name>|Name of the target data collector.|  
|\-ets|Send commands to Event Trace Sessions directly without saving or scheduling.|  
|\-\[\-\]u <user \[password\]>|Specifies the user to Run As. Entering a \* for the password produces a prompt for the password. The password is not displayed when you type it at the password prompt.|  
  
## <a name="BKMK_examples"></a>Examples  
The following command deletes the data collector perf\_log.  
  
```  
logman delete perf_log  
```  
  
#### Additional references  
[Logman](../Topic/Logman.md)  
  
