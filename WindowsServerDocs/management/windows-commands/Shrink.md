---
title: Shrink
description: "Windows Commands"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ec87cc7c-9846-465e-a10d-4ee10db4f4e6
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Shrink

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

The Diskpart Shrink command reduces the size of the selected volume by the amount you specify. This command makes free disk space available from the unused space at the end of the volume.
For examples of how this command can be used, see [Examples](#BKMK_examples).
## Syntax
```
shrink [desired=<n>] [minimum=<n>] [nowait] [noerr]
shrink querymax [noerr]
```
## Parameters
|Parameter|Description|
|-------------|---------------|
|desired=<n>|Specifies the desired amount of space in megabytes (MB) to reduce the size of the volume by.|
|minimum=<n>|Specifies the minimum amount of space in MB to reduce the size of the volume by.|
|querymax|Returns the maximum amount of space in MB by which the volume can be reduced. This value may change if applications are currently accessing the volume.|
|nowait|Forces the command to return immediately while the shrink process is still in progress.|
|noerr|For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code.|
## Remarks
-   You can reduce the size of a volume only if it is formatted using the NTFS file system or if it does not have a file system.
-   This command works on basic volumes, and on simple or spanned dynamic volumes.
-   If a desired amount is not specified, the volume will be reduced by the minimum amount (if specified).
-   If a minimum amount is not specified, the volume will be reduced by the desired amount (if specified).
-   If neither a minimum amount nor a desired amount is specified, the volume will be reduced by as much as possible.
-   If a minimum amount is specified but not enough free space is available, the command will fail.
-   A volume must be selected for this operation to succeed. Use the **select volume** command to select a volume and shift the focus to it.
-   This command does not operate on original equipment manufacturer (OEM) partitions, Extensible Firmware Interface (EFI) system partitions, or recovery partitions.
## <a name="BKMK_examples"></a>Examples
To reduce the size of the selected volume by the largest possible amount between 250 and 500 megabytes, type:
```
shrink desired=500 minimum=250
```
To display the maximum number of MB that the volume can be reduced by, type:
```
shrink querymax
```
#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
[Diskpart \[LH\]](assetId:///26a4a166-95fa-4faf-95bc-2d5345f4a57a)
[Resize-Partition](http://technet.microsoft.com/library/hh848680.aspx)
