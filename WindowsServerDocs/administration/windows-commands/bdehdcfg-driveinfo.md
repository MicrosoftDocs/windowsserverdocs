---
title: bdehdcfg driveinfo
description: "Windows Commands topic for ** bdehdcfg: driveinfo** - Displays the drive letter, the total size, the maximum free space, and the partition characteristics."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f2d065e7-eced-4509-a1a0-ee2521a7f02e
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# bdehdcfg: driveinfo

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays the drive letter, the total size, the maximum free space, and the partition characteristics. Only valid partitions are listed. Unallocated space is not listed if four primary or extended partitions already exist. For examples of how this command can be used, see [Examples](#BKMK_Examples).
## Syntax
```
bdehdcfg -driveinfo <DriveLetter>
```
### Parameters

|   Parameter   |                  Description                  |
|---------------|-----------------------------------------------|
| <DriveLetter> | Specifies a drive letter followed by a colon. |

## Remarks
The command is informational only and makes no modifications to the drive.
## <a name="BKMK_Examples"></a>Example
The following example will display the drive information for drive C.
```
bdehdcfg  driveinfo C:
```
## additional references
-   [Command-Line Syntax Key](command-line-syntax-key.md)
-   [bdehdcfg](bdehdcfg.md)
