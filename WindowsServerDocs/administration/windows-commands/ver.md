---
title: ver
description: Reference article for the ver command, which displays the operating system version number.
ms.topic: reference
ms.assetid: 5a9c6cd4-b67d-4b30-8c56-5f9798eafd2a
ms.author: lizross
author: eross-msft
manager: mtillman
ms.date: 10/16/2017
---

# ver

Displays the operating system version number. This command is supported in the Windows Command prompt (Cmd.exe), but not in PowerShell.

## Syntax

```
ver
```

### Parameters

| Parameter | Description |
|--|--|
| /? | Displays help at the command prompt. |

## Examples

To obtain the version number of the operating system from the Command shell (cmd.exe), type:

```
ver
```

The **ver** command doesn't work in PowerShell. If you want to get the operating system version number through PowerShell, type:

```powershell
$PSVersionTable.BuildVersion
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)
