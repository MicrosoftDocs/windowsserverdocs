---
title: rundll32
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 46d9cd64-8186-4cd4-a500-44700340fe81
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# rundll32



Loads and runs 32-bit dynamic-link libraries (DLLs). There are no configurable settings for Rundll32. Help information is provided for a specific DLL you run with the **rundll32** command.

You must run the **rundll32** command from an elevated command prompt. To open an elevated command prompt, click **Start**, right-click **Command Prompt**, and then click **Run as administrator**.

## Syntax

```
Rundll32 <DLLname>
```

## Commands

|Parameter|Description|
|---------|-----------|
|[Rundll32 printui.dll,PrintUIEntry](rundll32-printui.md)|Displays the printer user interface|

## Remarks

Rundll32 can only call functions from a DLL that are explicitly written to be called by Rundll32. For more information about Rundll32 requirements see [article 164787](https://go.microsoft.com/fwlink/?LinkID=165773) in the Microsoft Knowledge Base (https://go.microsoft.com/fwlink/?LinkID=165773).

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)