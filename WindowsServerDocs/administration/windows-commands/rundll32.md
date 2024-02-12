---
title: rundll32
description: Reference article for the rundll32 command, which loads and runs 32-bit dynamic-link libraries (DLLs).
ms.topic: reference
ms.assetid: 46d9cd64-8186-4cd4-a500-44700340fe81
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# rundll32

Loads and runs 32-bit dynamic-link libraries (DLLs). There are no configurable settings for Rundll32. Help information is provided for a specific DLL you run with the **rundll32** command.

You must run the **rundll32** command from an elevated command prompt. To open an elevated command prompt, click **Start**, right-click **Command Prompt**, and then click **Run as administrator**.

## Syntax

```
rundll32 <DLLname>
```

### Parameters

| Parameter | Description |
|--|--|
| [Rundll32 printui.dll,PrintUIEntry](rundll32-printui.md) | Displays the printer user interface. |

## Remarks

Rundll32 can only call functions from a DLL explicitly written to be called by Rundll32.

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
