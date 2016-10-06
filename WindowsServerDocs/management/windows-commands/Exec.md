---
title: Exec
description: "Windows Commands"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 364e8baf-576f-401b-a431-7d3c06621614
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Exec

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Executes a file on the local computer. The file can be a **cmd** script.  
  
## Syntax  
  
```  
exec <ScriptFile.cmd>  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|<ScriptFile.cmd>|Specifies the script file to execute.|  
  
## Remarks  
  
-   This command is used to duplicate or restore data as part of a backup or restore sequence.  
  
-   If the script fails, an error is returned and DiskShadow quits.  
  
#### Additional references  
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  

