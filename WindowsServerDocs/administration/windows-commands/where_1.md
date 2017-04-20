---
title: where_1
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0b3486a5-896b-4d92-84b8-e463a0b76487

author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# where_1

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays the location of files that match the given search pattern.  
for examples of how to use this command, see [Examples](#BKMK_examples).  
## Syntax  
```  
where [/r <dir>] [/q] [/f] [/t] [$<ENV>:|<path>:]<Pattern>[ ...]   
```  
## Parameters  
|Parameter|Description|  
|-------|--------|  
|/r <dir>|Indicates a recursive search, starting with the specified directory.|  
|/q|Returns an exit code (**0** for success, **1** for failure) without displaying the list of matched files.|  
|/f|Displays the results of the **where** command in quotation marks.|  
|/t|Displays the file size and the last modified date and time of each matched file.|  
|[$<ENV>:&#124;<path>:]<Pattern>[ ...]|Specifies the search pattern for the files to match. at least one pattern is required, and the pattern can include wildcard characters (**\*** and **?**). By default, **where** searches the current directory and the paths that are specified in the path environment variable. You can specify a different path to search by using the format $*ENV*:*Pattern* (where *ENV* is an existing environment variable containing one or more paths) or by using the format *path*:*Pattern* (where *path* is the directory path you want to search). These optional formats should not be used with the **/r** command-line option.|  
|/?|Displays help at the command prompt.|  
## remarks  
-   if you do not specify a file name extension, the extensions listed in the pathEXT environment variable are appended to the pattern by default.  
-   **Where** can run recursive searches, display file information such as date or size, and accept environment variables in place of paths on local computers.  
## <a name="BKMK_examples"></a>Examples  
To find all files named Test in drive C of the current computer and its subdirectories, type:  
```  
where /r c:\ test   
```  
To list all files in the Public directory, type:  
```  
where $public:*.*  
```  
To find all files named Notepad in drive C of the remote computer, computer1, and its subdirectories, type:  
```  
where /r \\computer1\c notepad.*  
```  
#### additional references  
[Command-Line Syntax Key](command-line-syntax-key.md)  
