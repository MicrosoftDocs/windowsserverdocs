---
title: fsutil hardlink
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 940b06f3-c078-4bf2-bb58-3ef1dbe208a3
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# fsutil hardlink

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

creates a hard link between an existing file and a new file.  
  
## Syntax  
  
```  
fsutil hardlink create <NewFileName> <ExistingFileName>  
fsutil hardlink list <Filename>  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------|--------|  
|create|Establishes an NTFS hard link between an existing file and a new file. \(An NTFS hard link is similar to a POSIX hard link.\)|  
|<NewFileName>|Specifies the file that you want to create a hard link to.|  
|<ExistingFileName>|Specifies the file that you want to create a hard link from.|  
|list|lists the hardlinks to *Filename*.<br /><br />This parameter applies to:  Windows Server 2008 R2  and  Windows 7 .|  
  
## remarks  
  
-   A hard link is a directory entry for a file. Every file can be considered to have at least one hard link. On NTFS volumes, each file can have multiple hard links, so a single file can appear in many directories \(or even in the same directory with different names\). Because all of the links reference the same file, programs can open any of the links and modify the file. A file is deleted from the file system only after all links to it have been deleted. After you create a hard link, programs can use it like any other file name.  
  
#### additional references  
[Command-Line Syntax Key](command-line-syntax-key.md)  
  
[fsutil](fsutil.md)  
  

