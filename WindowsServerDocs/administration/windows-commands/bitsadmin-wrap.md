---
title: bitsadmin wrap
description: "Windows Commands topic for **bitsadmin wrap** - Wraps any line of output text extending beyond the rightmost edge of the command window to the next line."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 14e57522-539d-4621-ad15-09f7a44ccab7
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# bitsadmin wrap

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Wraps output to fit in a command window.

## Syntax

```
bitsadmin /Wrap Job
```

## Parameters

|Parameter|Description|
|-------|--------|
|Job|The job's display name or GUID|

## Remarks

Specify before other switches. By default, all switches, except the [bitsadmin monitor](bitsadmin-monitor.md) switch, wrap the output.

## <a name="BKMK_examples"></a>Examples

The following example retrieves information for the job named *myDownloadJob* and wraps the output.

```
C:\>bitsadmin /Wrap /Info myDownloadJob /verbose
```

#### additional references

[Command-Line Syntax Key](command-line-syntax-key.md)
