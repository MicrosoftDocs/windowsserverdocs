---
ms.assetid: 385a2a7c-d6bd-4f11-9c18-fca0413f9e97
title: Fsutil dirty
ms.prod: windows-server-threshold
manager: dmoss
ms.author: toklima
author: toklima
ms.technology: storage
audience: "IT Pro"
ms.topic: article
ms.date: 10/16/2017
---
# Fsutil dirty
>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows 10, Windows Server 2012 R2, Windows 8.1, Windows Server 2012, Windows 8, Windows Server 2008 R2, Windows 7

Queries or sets a volume's dirty bit. When a volume's dirty bit is set, **autochk** automatically checks the volume for errors the next time the computer is restarted.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
fsutil dirty {query | set} <VolumePath>
```

## Parameters

|   Parameter   |                                                 Description                                                  |
|---------------|--------------------------------------------------------------------------------------------------------------|
|     query     |                                  Queries the specified volume's dirty bit.                                   |
|      set      |                                    Sets the specified volume's dirty bit.                                    |
| \<VolumePath> | Specifies the drive name followed by a colon or GUID in the following format: **Volume{**<em>GUID</em>**}**. |

## Remarks

-   A volume's dirty bit indicates that the file system may be in an inconsistent state. The dirty bit can be set because:

    -   The volume is online and it has outstanding changes.

    -   Changes were made to the volume and the computer was shut down before the changes were committed to the disk.

    -   Corruption was detected on the volume.

-   If the dirty bit is set when the computer restarts, **chkdsk** runs to verify the file system integrity and to attempt to fix any issues with the volume.

## <a name="BKMK_examples"></a>Examples
To query the dirty bit on drive C, type:

```
fsutil dirty query c:
```

-   If the volume is dirty, the following output displays:

    `Volume C: is dirty`

-   If the volume is not dirty, the following output displays:

    `Volume C: is not dirty`

To set the dirty bit on drive C, type:

```
fsutil dirty set C:
```

#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)

[Fsutil](Fsutil.md)


