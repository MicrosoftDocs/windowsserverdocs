---
title: recover
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: cf9be2e3-90c8-4773-a201-dc503b91948e
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# recover

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

recovers readable information from a bad or defective disk.
for examples of how to use this command, see [Examples](#BKMK_examples).
## Syntax
```
recover [<Drive>:][<path>]<FileName>
```
## Parameters
|Parameter|Description|
|-------|--------|
|[<Drive>:][<path>]<FileName>|Specifies the location and name of the file that you want to recover. *FileName* is required.|
|/?|Displays help at the command prompt.|
## remarks
-   The **recover** command reads a file, sector-by-sector, and recovers data from the good sectors. Data in bad sectors is lost.
-   Bad sectors reported by **chkdsk** were marked as "bad" when your disk was prepared for operation. They pose no danger, and **recover** does not affect them.
-   Because all data in bad sectors is lost when you recover a file, you should recover only one file at a time.
-   You cannot use wildcard characters (**\*** and **?**) with the **recover** command. You must specify a file (and the location of the file if it is not in the current directory).
## <a name="BKMK_examples"></a>Examples
To recover the file Story.txt in the \Fiction directory on drive D, type:
```
recover d:\fiction\story.txt 
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
