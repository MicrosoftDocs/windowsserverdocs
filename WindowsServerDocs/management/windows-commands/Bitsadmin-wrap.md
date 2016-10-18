---
title: Bitsadmin wrap
description: "Windows Commands topic for **Bitsadmin wrap** -- Wraps any line of output text extending beyond the rightmost edge of the command window to the next line."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 14e57522-539d-4621-ad15-09f7a44ccab7
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Bitsadmin wrap

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Wraps any line of output text extending beyond the rightmost edge of the command window to the next line.
## Syntax
```
bitsadmin /Wrap Job
```
## Parameters
|Parameter|Description|
|-------------|---------------|
|Job|The job's display name or GUID|
## Remarks
Specify before other commands. By default, all commands, except the [Bitsadmin monitor](Bitsadmin-monitor.md) command, wrap the output.
## <a name="BKMK_examples"></a>Examples
The following example retrieves information for the job named *myDownloadJob* and wraps the output.
```
C:\>bitsadmin /Wrap /Info myDownloadJob /verbose
```
## Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
