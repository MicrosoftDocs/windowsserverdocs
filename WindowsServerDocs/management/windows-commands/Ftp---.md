---
title: Ftp: ?
description: "Windows Commands"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: cd3ad2d5-0905-4ae6-a572-297f05f2a12c vhorne
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Ftp: ?

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Displays the valid ftp commands that are available from the ftp prompt.   
## Syntax  
```  
? [!] [?] [append] [ascii] [bell [binary] [bye] [cd] [close] [delete] [debug] [dir] [disconnect] [get] [glob] [hash] [help] [lcd] [literal] [ls] [mdelete] [mdir] [mget] [mkdir] [mls] [mput] [open] [prompt] [put] [pwd] [quit] [quote] [recv] [remotehelp] [rename] [rmdir] [send] [status] [trace] [type] [user] [verbose]  
```  
### Parameters  
|Parameter|Description|  
|-------------|---------------|  
|[<valid ftp subcommand>]|Displays the description for a valid ftp command.|  
## <a name="BKMK_Examples"></a>Examples  
Display the valid ftp commands that are available from the ftp prompt.  
```  
?  
```  
Display the description for the hash command.  
```  
? hash  
```  
Display the description for the hash and trace commands.  
```  
? hash trace  
```  
## Additional references  
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
