---
title: pushprinterconnections
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c30afb97-b149-478f-a4b9-2cbc25361818 vhorne
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# pushprinterconnections

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Reads Deployed printer Connection settings from Group Policy, and deploys/removes printer connections as needed.  
## Syntax  
```  
pushprinterconnections <-log> <-?>  
```  
### Parameters  
|Parameter|Description|  
|-------|--------|  
|<-log>|Writes a per user debug log file to %temp, or writes a per machine debug log to %windir%\temp.|  
|<-?>|Displays help at the command prompt.|  
## remarks  
This utility is for use in machine startup or user logon scripts, and should not be run from the command line.  
## additional references  
-   [Command-Line Syntax Key](command-line-syntax-key.md)  
-   [Deploy printers by Using Group Policy](http://go.microsoft.com/fwlink/?LinkId=230627)  
