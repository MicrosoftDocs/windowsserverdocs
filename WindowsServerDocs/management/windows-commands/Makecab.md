---
title: Makecab
description: "Windows Commands"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4da95297-c593-427b-9f76-2f389c46cbf4
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Makecab

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Package existing files into a cabinet (.cab) file.
## Syntax
```
makecab [/v[n]] [/d var=<value> ...] [/l <dir>] <source> [<destination>]
makecab [/v[<n>]] [/d var=<value> ...] /f <directives_file> [...]
```
### Parameters
|Parameter|Description|
|-------------|---------------|
|<source>|File to compress.|
|<destination>|File name to give compressed file. If omitted, the last character of the source file name is replaced with an underscore (_) and used as the destination.|
|/f <directives_file>|A file with **makecab** directives (may be repeated).|
|/d var=<value>|Defines variable with specified value.|
|/l <dir>|Location to place destination (default is current directory).|
|/v[<n>]|Set debugging verbosity level (0=none,...,3=full).|
|/?|Displays Help at the command prompt.|
## Remarks
-   Refer to [Microsoft Cabinet Format](http://go.microsoft.com/fwlink/?LinkId=226852) on MSDN for information on directive_file.
## Additional references
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)
-   [Command-Line Reference_1](Command-Line-Reference_1.md)
