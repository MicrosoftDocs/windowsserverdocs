---
title: bootcfg
description: "Windows Commands topic for **bootcfg** - Configures, queries, or changes Boot.ini file settings."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3deb354c-5717-4066-bc79-b9323d559e44

author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# bootcfg

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Configures, queries, or changes Boot.ini file settings.  
## Syntax  
```  
bootcfg <parameter> [arguments...]  
```  
## Parameters  
|Parameter|Description|  
|-------|--------|  
|[bootcfg addsw](bootcfg-addsw.md)|adds operating system load options for a specified operating system entry.|  
|[bootcfg copy](bootcfg-copy.md)|Makes a copy of an existing boot entry, to which you can add command-line options.|  
|[bootcfg dbg1394](bootcfg-dbg1394.md)|Configures 1394 port debugging for a specified operating system entry.|  
|[bootcfg debug](bootcfg-debug.md)|adds or changes the debug settings for a specified operating system entry.|  
|[bootcfg default](bootcfg-default.md)|Specifies the operating system entry to designate as the default.|  
|[bootcfg delete](bootcfg-delete.md)|deletes an operating system entry in the **[operating systems]** section of the Boot.ini file.|  
|[bootcfg ems](bootcfg-ems.md)|Enables the user to add or change the settings for redirection of the Emergency Management Services console to a remote computer.|  
|[bootcfg query](bootcfg-query.md)|Queries and displays the [boot loader] and **[operating systems]** section entries from Boot.ini.|  
|[bootcfg raw](bootcfg-raw.md)|adds operating system load options specified as a string to an operating system entry in the **[operating systems]** section of the Boot.ini file.|  
|[bootcfg rmsw](bootcfg-rmsw.md)|removes operating system load options for a specified operating system entry.|  
|[bootcfg timeout](bootcfg-timeout.md)|changes the operating system time-out value.|  
