---
title: bitsadmin wrap
description: Windows Commands topic for bitsadmin wrap, which wraps any line of output text extending beyond the rightmost edge of the command window to the next line.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: 14e57522-539d-4621-ad15-09f7a44ccab7
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# bitsadmin wrap

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Wraps any line of output text extending beyond the rightmost edge of the command window to the next line.

## Syntax

```
bitsadmin /Wrap Job
```

### Parameters

|Parameter|Description|
|-------|--------|
|Job|The job's display name or GUID|

## Remarks

Specify before other switches. By default, all switches, except the [bitsadmin monitor](bitsadmin-monitor.md) switch, wrap the output.

## <a name=BKMK_examples></a>Examples

The following example retrieves information for the job named *myDownloadJob* and wraps the output.

```
C:\>bitsadmin /Wrap /Info myDownloadJob /verbose
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)
