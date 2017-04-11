---
title: mklink
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0ce4df22-2dbc-48fc-9c16-b721ae85f857
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# mklink
creates a symbolic link.

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

for examples of how to use this command, see [Examples](#BKMK_examples).
## Syntax
```
mklink [[/d] | [/h] | [/j]] <Link> <Target>
```
## Parameters
|Parameter|Description|
|-------|--------|
|/d|creates a directory symbolic link. By default, **mklink** creates a file symbolic link.|
|/h|creates a hard link instead of a symbolic link.|
|/j|creates a directory Junction.|
|<Link>|Specifies the name of the symbolic link that is being created.|
|<Target>|Specifies the path (relative or absolute) that the new symbolic link refers to.|
|/?|Displays help at the command prompt.|
## <a name="BKMK_examples"></a>Examples
To create a symbolic link named MyDocs from the root directory to the \Users\User1\Documents directory, type:
```
mklink /d \MyDocs \Users\User1\Documents
```
