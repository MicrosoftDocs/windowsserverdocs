---
title: help
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 75dbf94f-d79c-45b2-9463-c06648218f4a
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# help

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays a list of the available commands or detailed help information on a specified command.  
  
  
  
## Syntax  
  
```  
help [<command>]  
```  
  
## Parameters  
  
| Parameter |                              Description                              |
|-----------|-----------------------------------------------------------------------|
| <command> | Specifies the command for which to display detailed help information. |
  
## Remarks  
  
-   if no command is specified, **help** will display all possible commands.  
  
## <a name="BKMK_examples"></a>Examples  
To display a list of all commands available in DiskPart, type:  
  
```  
help  
```  
  
To display detailed help information about how to use the **create partition primary** command in DiskPart, type:  
  
```  
help create partition primary  
```  
  
#### additional references  
[Command-Line Syntax Key](command-line-syntax-key.md)  
  

  

