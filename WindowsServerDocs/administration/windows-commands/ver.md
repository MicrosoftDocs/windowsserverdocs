---
title: ver
description: Windows Commands topic for ver, which displays the operating system version number. 
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: 5a9c6cd4-b67d-4b30-8c56-5f9798eafd2a
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# ver



Displays the operating system version number.

This command is supported in the Windows Command prompt (Cmd.exe), but not in PowerShell.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
ver
```

## Parameters

|Parameter|Description|
|---------|-----------|
|/?|Displays help at the command prompt.|

## <a name=BKMK_examples></a>Examples

To obtain the version number of the operating system from the Command shell (cmd.exe), type:

```
ver
```

The ver command does not work in PowerShell. To obtain the OS version from PowerShell, type:

```powershell
$PSVersionTable.BuildVersion
````


## Additional References

[Command-Line Syntax Key](command-line-syntax-key.md)
