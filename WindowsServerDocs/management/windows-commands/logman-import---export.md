---
title: logman import | export
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c258daba-fb93-47c0-a53b-2fe83ed2c743
author: coreyp
ms.author: coreyp-at-msft
ms.date: 09/14/2016
---
# logman import | export
Import a Data Collector Set from an XML file, or export a Data Collector Set to an XML file.  
For examples of how this command can be used, see [Examples](#BKMK_examples).  
## Syntax  
```  
logman import <[-n] <name>> <-xml <name>> [options]  
logman export <[-n] <name>> <-xml <name>> [options]  
```  
## Parameters  
|Parameter|Description|  
|-------------|---------------|  
|-?|Displays context-sensitive help.|  
|-s <computer name>|Perform the command on the specified remote computer.|  
|-config <value>|Specifies the settings file containing command options.|  
|[-n] <name>|Name of the target object.|  
|-xml <name>|Name of the XML file to import or export.|  
|-ets|Send commands to Event Trace Sessions directly without saving or scheduling.|  
|-[-]u <user [password]>|User to Run As. Entering a * for the password produces a prompt for the password. The password is not displayed when you type it at the password prompt.|  
|-y|Answer yes to all questions without prompting.|  
## <a name="BKMK_examples"></a>Examples  
The following command imports the XML file c:\windows\perf_log.xml from the computer server_1 as a data collector set called perf_log.  
```  
logman import perf_log -s server_1 -xml "c:\windows\perf_log.xml"  
```  
#### Additional references  
[Logman](Logman.md)  
