---
title: Ftp: ?
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: cd3ad2d5-0905-4ae6-a572-297f05f2a12c
author: vhorne
---
# Ftp: ?
Displays the valid ftp commands that are available from the ftp prompt. For examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).  
  
## Syntax  
  
```  
? [!] [?] [append] [ascii] [bell [binary] [bye] [cd] [close] [delete] [debug] [dir] [disconnect] [get] [glob] [hash] [help] [lcd] [literal] [ls] [mdelete] [mdir] [mget] [mkdir] [mls] [mput] [open] [prompt] [put] [pwd] [quit] [quote] [recv] [remotehelp] [rename] [rmdir] [send] [status] [trace] [type] [user] [verbose]  
```  
  
### Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|\[<valid ftp subcommand>\]|Displays the description for a valid ftp command.|  
  
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
  
-   [Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
