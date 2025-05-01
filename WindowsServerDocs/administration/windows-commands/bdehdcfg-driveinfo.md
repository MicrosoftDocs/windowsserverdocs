---
title: bdehdcfg driveinfo
description: Reference article for the bdehdcfg driveinfo command, which displays the drive letter, the total size, the maximum free space, and the partition characteristics.
ms.topic: reference
ms.assetid: f2d065e7-eced-4509-a1a0-ee2521a7f02e
ms.author: mosagie
author: meaghanlewis
manager: mtillman
ms.date: 10/16/2017
---
# bdehdcfg: driveinfo



Displays the drive letter, the total size, the maximum free space, and the partition characteristics. Only valid partitions are listed. Unallocated space is not listed if four primary or extended partitions already exist.

>[!NOTE]
> This command is informational only and makes no changes to the drive.

## Syntax

```
bdehdcfg -driveinfo <drive_letter>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| <drive_letter> | Specifies a drive letter followed by a colon. |

## Example

To display the drive information for the C: drive:

```
bdehdcfg  driveinfo C:
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bdehdcfg](bdehdcfg.md)
