---
title: logman query
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1116a0f0-5415-4369-a045-12f79f8f66de
author: jaimeo
---
# logman query
query data collector or data collector set properties.  
  
for examples of how this command can be used, see [Examples](#BKMK_examples).  
  
## Syntax  
  
```  
logman query [providers|"Data Collector Set name"] [options]  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|\/?|Displays context\-sensitive help.|  
|\-s <computer name>|Perform the command on the specified remote computer.|  
|\-config <value>|Specifies the settings file containing command options.|  
|\[\-n\] <name>|Name of the target object.|  
|\-ets|Send commands to Event Trace Sessions directly without saving or scheduling.|  
  
## <a name="BKMK_examples"></a>Examples  
The following command lists all Data Collector Sets configured on the target system.  
  
```  
logman query  
```  
  
The following command lists the data collectors contained in the Data Collector Set named perf\_log.  
  
```  
logman query "perf_log"  
```  
  
The following command lists all available providers of data collectors on the target system.  
  
```  
logman query providers  
```  
  
#### additional references  
[logman](logman.md)  
  

