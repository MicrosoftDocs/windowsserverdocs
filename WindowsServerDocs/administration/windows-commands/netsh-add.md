---
title: netsh add
description: Reference article for the netsh add command that adds a helper dll.
ms.topic: reference
ms.author: daknappe
author: dknappettmsft
ms.date: 07/24/2025
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
| helper | Adds a helper DLL file. |

## Example

To add a helper DLL located at **C:\dlls\HelperDLL.dll**, run the following command:

```cmd
netsh add helper C:\dlls\HelperDLL.dll
```
