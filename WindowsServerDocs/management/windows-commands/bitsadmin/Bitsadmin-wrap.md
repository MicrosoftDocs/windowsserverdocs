---
title: bitsadmin wrap
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 14e57522-539d-4621-ad15-09f7a44ccab7
---
# bitsadmin wrap
Wraps any line of output text extending beyond the rightmost edge of the command window to the next line.

## Syntax

```
bitsadmin /Wrap Job
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|Job|The job's display name or GUID|

## remarks
Specify before other commands. By default, all commands, except the [bitsadmin monitor](bitsadmin-monitor.md) command, wrap the output.

## <a name="BKMK_examples"></a>Examples
The following example retrieves information for the job named *myDownloadJob* and wraps the output.

```
C:\>bitsadmin /Wrap /Info myDownloadJob /verbose
```

## additional references
[Command-Line Syntax Key](../commandline-syntax-key.md)


