---
title: append
description: "Windows Commands topic for "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9c3fea20-9502-40ad-a442-7a927aad88eb
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# append

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Allows programs to open data files in specified directories as if they were in the current directory. If used without parameters, **append** displays the appended directory list.
for examples of how to use this command, see [Examples](#BKMK_examples).
## Syntax
```
append [[<Drive>:]<path>[;...]] [/x[:on|:off]] [/path:[:on|:off] [/e] 
append ;
```
## Parameters
|Parameter|Description|
|-------|--------|
|[<Drive>:]<path>|Specifies a drive and directory to append.|
|/x:on|Applies appended directories to file searches and launching applications.|
|/x:off|Applies appended directories only to requests to open files.<br /><br />**/x:off** is the default setting.|
|/path:on|Applies appended directories to file requests that already specify a path. **/path:on** is the default setting.|
|/path:off|Turns off the effect of **/path:on**.|
|/e|Stores a copy of the appended directory list in an environment variable named append. **/e** may be used only the first time you use **append** after starting your system.|
|;|Clears the appended directory list.|
|/?|Displays help at the command prompt.|
## <a name="BKMK_examples"></a>Examples
To clear the appended directory list, type:
```
append ;
```
To store a copy of the appended directory to an environment variable named append, type:
```
append /e
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
