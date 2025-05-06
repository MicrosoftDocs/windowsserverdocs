---
title: netsh add
description: Reference article for the netsh add command which adds a helper dll.
ms.topic: reference
ms.author: alalve
author: xelu86
ms.date: 05/06/2025
---

# netsh add

The `netsh add` command is used to install helper Dynamic Link Libraries (DLL) allowing for more specialized network configurations.

## Syntax

```
netsh add helper [file]
```

## Parameters

| Command | Description |
|--|--|
| helper | Installs a helper DLL file. |

## Example

To install a helper DLL located at "C:\Helpers\HelperDLL.dll", run the following command:

```cmd
netsh add helper C:\Helpers\HelperDLL.dll
```
