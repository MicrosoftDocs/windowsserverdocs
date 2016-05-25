---
title: Fsutil hardlink
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 940b06f3-c078-4bf2-bb58-3ef1dbe208a3
author: JasonGerend
---
# Fsutil hardlink
Creates a hard link between an existing file and a new file.  
  
## Syntax  
  
```  
fsutil hardlink create <NewFileName> <ExistingFileName>  
fsutil hardlink list <Filename>  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|create|Establishes an NTFS hard link between an existing file and a new file. \(An NTFS hard link is similar to a POSIX hard link.\)|  
|<NewFileName>|Specifies the file that you want to create a hard link to.|  
|<ExistingFileName>|Specifies the file that you want to create a hard link from.|  
|list|Lists the hardlinks to *Filename*.<br /><br />This parameter applies to: [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)] and [!INCLUDE[nextref_client_7](includes/nextref_client_7_md.md)].|  
  
## Remarks  
  
-   A hard link is a directory entry for a file. Every file can be considered to have at least one hard link. On NTFS volumes, each file can have multiple hard links, so a single file can appear in many directories \(or even in the same directory with different names\). Because all of the links reference the same file, programs can open any of the links and modify the file. A file is deleted from the file system only after all links to it have been deleted. After you create a hard link, programs can use it like any other file name.  
  
#### Additional references  
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  
[Fsutil](Fsutil.md)  
  

