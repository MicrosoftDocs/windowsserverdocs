---
title: bootcfg
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3deb354c-5717-4066-bc79-b9323d559e44
author: jaimeo
---
# bootcfg
Configures, queries, or changes Boot.ini file settings.  
  
## Syntax  
  
```  
bootcfg <parameter> [arguments...]  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|[bootcfg addsw]()|adds operating system load options for a specified operating system entry.|  
|[bootcfg copy]()|Makes a copy of an existing boot entry, to which you can add command\-line options.|  
|[bootcfg dbg1394]()|Configures 1394 port debugging for a specified operating system entry.|  
|[bootcfg debug]()|adds or changes the debug settings for a specified operating system entry.|  
|[bootcfg default]()|Specifies the operating system entry to designate as the default.|  
|[bootcfg delete]()|deletes an operating system entry in the **\[operating systems\]** section of the Boot.ini file.|  
|[bootcfg ems]()|Enables the user to add or change the settings for redirection of the Emergency management Services console to a remote computer.|  
|[bootcfg query]()|Queries and displays the \[boot loader\] and **\[operating systems\]** section entries from Boot.ini.|  
|[bootcfg raw]()|adds operating system load options specified as a string to an operating system entry in the **\[operating systems\]** section of the Boot.ini file.|  
|[bootcfg rmsw]()|removes operating system load options for a specified operating system entry.|  
|[bootcfg timeout]()|changes the operating system time\-out value.|  
  

