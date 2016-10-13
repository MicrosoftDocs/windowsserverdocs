---
title: Help_1
description: "Windows Commands"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 75dbf94f-d79c-45b2-9463-c06648218f4a
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Help_1

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Displays a list of the available commands or detailed help information on a specified command.  
  
For examples of how this command can be used, see [Examples](#BKMK_examples).  
  
## Syntax  
  
```  
help [<command>]  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|<command>|Specifies the command for which to display detailed help information.|  
  
## Remarks  
  
-   If no command is specified, **help** will display all possible commands.  
  
## <a name="BKMK_examples"></a>Examples  
To display a list of all commands available in DiskPart, type:  
  
```  
help  
```  
  
To display detailed help information about how to use the **create partition primary** command in DiskPart, type:  
  
```  
help create partition primary  
```  
  
#### Additional references  
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  

  

