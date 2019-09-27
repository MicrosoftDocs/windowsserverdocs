---
ms.assetid: 835fc6f1-cc84-4189-b29a-dde90792469e
title: Fsutil hardlink
ms.prod: windows-server
manager: dmoss
ms.author: toklima
author: toklima
ms.technology: storage
audience: "IT Pro"
ms.topic: article
ms.date: 10/16/2017
---
# Fsutil hardlink
>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows 10, Windows Server 2012 R2, Windows 8.1, Windows Server 2012, Windows 8, Windows Server 2008 R2, Windows 7

Creates a hard link between an existing file and a new file.

## Syntax

```
fsutil hardlink create <NewFileName> <ExistingFileName>
fsutil hardlink list <Filename>
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|create|Establishes an NTFS hard link between an existing file and a new file. (An NTFS hard link is similar to a POSIX hard link.)|
|\<NewFileName>|Specifies the file that you want to create a hard link to.|
|\<ExistingFileName>|Specifies the file that you want to create a hard link from.|
|list|Lists the hardlinks to *Filename*.<br /><br />This parameter applies to:  Windows Server 2008 R2  and  Windows 7 .|

## Remarks

-   A hard link is a directory entry for a file. Every file can be considered to have at least one hard link. On NTFS volumes, each file can have multiple hard links, so a single file can appear in many directories (or even in the same directory with different names). Because all of the links reference the same file, programs can open any of the links and modify the file. A file is deleted from the file system only after all links to it have been deleted. After you create a hard link, programs can use it like any other file name.

#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)

[Fsutil](Fsutil.md)


