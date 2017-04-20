---
title: clip
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 85322d85-3376-4806-845b-93ac77fe27bf
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# clip

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Redirects command output from the command line to the Windows clipboard. You can then paste this text output into other programs.
for examples of how to use this command, see [Examples](#BKMK_examples).
## Syntax
```
<Command> | clip
clip < <FileName>
```
## Parameters
|Parameter|Description|
|-------|--------|
|<Command>|Specifies a command whose output you want to send to the Windows clipboard.|
|<FileName>|Specifies a file whose contents you want to send to the Windows clipboard.|
|/?|Displays help at the command prompt.|
## remarks
You can use the **clip** command to copy data directly into any application that can receive text from the clipboard.
## <a name="BKMK_examples"></a>Examples
To copy the current directory listing to the Windows clipboard, type:
```
dir | clip
```
To copy the output of a program called Generic.awk to the Windows clipboard, type:
```
awk -f generic.awk input.txt | clip
```
To copy the contents of a file called Readme.txt to the Windows clipboard, type:
```
clip < readme.txt
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
