---
title: netsh delete
description: Reference article for the netsh delete command that removes a helper dll.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 07/24/2025
---

# netsh delete

The `netsh delete` command is used to remove helper Dynamic Link Libraries (DLL) allowing for more specialized network configurations.

## Syntax

```
netsh delete helper [file]
```

## Parameters

| Command | Description |
|--|--|
| helper | Calls the helper DLL file. |

## Example

To remove a helper DLL located at **C:\dlls\HelperDLL.dll**, run the following command:

```cmd
netsh delete helper C:\dlls\HelperDLL.dll
```
