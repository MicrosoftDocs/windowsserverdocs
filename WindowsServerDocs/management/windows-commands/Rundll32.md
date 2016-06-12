---
title: rundll32
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 46d9cd64-8186-4cd4-a500-44700340fe81
---
# rundll32
Loads and runs 32\-bit dynamic\-link libraries \(DLLs\). There are no configurable settings for rundll32. help information is provided for a specific DLL you run with the **rundll32** command.

You must run the **rundll32** command from an elevated command prompt. To open an elevated command prompt, click **start**, right\-click **Command prompt**, and then click **Run as administrator**.

## Syntax

```
rundll32 <DLLname>
```

## Commands

|Parameter|Description|
|-------------|---------------|
|[rundll32 printui.dll,printUIEntry]()|Displays the printer user interface|

## remarks
rundll32 can only call functions from a DLL that are explicitly written to be called by rundll32. for more information about rundll32 requirements see [article 164787](http://go.microsoft.com/fwlink/?LinkID=165773) in the Microsoft Knowledge Base \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=165773\).

#### additional references
[Command-Line Syntax Key](commandline-syntax-key.md)


