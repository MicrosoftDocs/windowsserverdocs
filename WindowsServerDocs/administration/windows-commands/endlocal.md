---
title: endlocal
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 765fae3c-0c0a-4639-99a4-cf613489b949
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# endlocal

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Ends localization of environment changes in a batch file, and restores environment variables to their values before the corresponding **setlocal** command was run.
for examples of how to use this command, see [Examples](#BKMK_examples).
## Syntax
```
endlocal
```
## Parameters
|Parameter|Description|
|-------|--------|
|/?|Displays help at the command prompt.|
## remarks
-   The **endlocal** command has no effect outside a script or batch file.
-   There is an implicit **endlocal** command at the end of a batch file.
-   if command extensions are enabled (command extensions are enabled by default), the **endlocal** command restores the state of command extensions (that is, enabled or disabled) to what it was before the corresponding **setlocal** command was run.
> [!NOTE]
> for more information about enabling and disabling command extensions, see [Cmd](Cmd.md).
## <a name="BKMK_examples"></a>Examples
You can localize environment variables in a batch file. For example, the following program starts the superapp batch program on the network, directs the output to a file, and displays the file in Notepad:
```
@echo off
setlocal
path=g:\programs\superapp;%path%
call superapp>c:\superapp.out
endlocal
start notepad c:\superapp.out
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
