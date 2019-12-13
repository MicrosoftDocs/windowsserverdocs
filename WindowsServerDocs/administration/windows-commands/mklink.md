---
title: mklink
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0ce4df22-2dbc-48fc-9c16-b721ae85f857
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# mklink
Creates a symbolic link.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
mklink [[/d] | [/h] | [/j]] <Link> <Target>
```

## Parameters

|Parameter|Description|
|---------|-----------|
|/d|Creates a directory symbolic link. By default, **mklink** creates a file symbolic link.|
|/h|Creates a hard link instead of a symbolic link.|
|/j|Creates a Directory Junction.|
|\<Link>|Specifies the name of the symbolic link that is being created.|
|\<Target>|Specifies the path (relative or absolute) that the new symbolic link refers to.|
|/?|Displays help at the command prompt.|

## <a name="BKMK_examples"></a>Examples

The following example demonstrates the creation and removal of a symbolic link named MyFolder and MyFile.file from the root directory to the \Users\User1\Documents directory and a example.file located within the directory:
```
mklink /d \MyFolder \Users\User1\Documents
mklink /h \MyFile.file \User1\Documents\example.file
rd \MyFolder
del \MyFile.file
```
## Additional references
-   [New-Item](https://docs.microsoft.com/powershell/module/microsoft.powershell.management/new-item?view=powershell-6)
-   [del](https://docs.microsoft.com/windows-server/administration/windows-commands/del)
-   [rmdir](https://docs.microsoft.com/windows-server/administration/windows-commands/rd)
