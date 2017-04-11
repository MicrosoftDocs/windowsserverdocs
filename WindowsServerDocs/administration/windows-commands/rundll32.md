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
ms.date: 10/12/2016
---
# rundll32

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Loads and runs 32-bit dynamic-link libraries (DLLs). There are no configurable settings for rundll32. help information is provided for a specific DLL you run with the **rundll32** command.
You must run the **rundll32** command from an elevated command prompt. To open an elevated command prompt, click **start**, right-click **Command prompt**, and then click **Run as administrator**.
## Syntax
```
rundll32 <DLLname>
```
## Commands
|Parameter|Description|
|-------|--------|
|[rundll32 printui.dll,printUIEntry](rundll32-printui.md)|Displays the printer user interface|
## remarks
rundll32 can only call functions from a DLL that are explicitly written to be called by rundll32. For more information about rundll32 requirements see [article 164787](http://go.microsoft.com/fwlink/?LinkID=165773) in the Microsoft Knowledge Base (http://go.microsoft.com/fwlink/?LinkID=165773).
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
