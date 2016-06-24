---
title: logman start | stop
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a40006a1-876e-474b-aaf1-f365c730deea
author: jaimeo
---
# logman start | stop
Start a data collector and set the begin time to manual, or stop a data collector set and set the end time to manual.  
  
For examples of how this command can be used, see [Examples](#BKMK_examples).  
  
## Syntax  
  
```  
logman start <[-n] <name>> [options]  
logman stop <[-n] <name>> [options]  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|-?|Displays context-sensitive help.|  
|-s <computer name>|Perform the command on the specified remote computer.|  
|-config <value>|Specifies the settings file containing command options.|  
|[-n] <name>|Name of the target object.|  
|-ets|Send commands to Event Trace Sessions directly without saving or scheduling.|  
|-as|Perform the requested operation asynchronously.|  
  
## <a name="BKMK_examples"></a>Examples  
The following command starts the data collector perf_log on the remote computer server_1.  
  
```  
logman start perf_log -s server_1  
```  
  
#### Additional references  
[Logman](Logman.md)  
  

