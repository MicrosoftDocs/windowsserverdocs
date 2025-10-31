---
title: fsutil dirty
description: Reference article for the fsutil dirty command, which queries or sets a volume's dirty bit.
ms.author: roharwoo
author: robinharwood
ms.topic: reference
ms.date: 10/16/2017
---

# fsutil dirty



Queries or sets a volume's dirty bit. When a volume's dirty bit is set, **autochk** automatically checks the volume for errors the next time the computer is restarted.

## Syntax

```
fsutil dirty {query | set} <volumepath>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| query | Queries the specified volume's dirty bit. |
| set | Sets the specified volume's dirty bit. |
| `<volumepath>` | Specifies the drive name followed by a colon or GUID in the following format: `volume{GUID}`. |

#### Remarks

- A volume's dirty bit indicates that the file system may be in an inconsistent state. The dirty bit can be set because:

    - The volume is online and it has outstanding changes.

    - Changes were made to the volume and the computer was shut down before the changes were committed to the disk.

    - Corruption was detected on the volume.

- If the dirty bit is set when the computer restarts, **chkdsk** runs to verify the file system integrity and to attempt to fix any issues with the volume.

### Examples

To query the dirty bit on drive C, type:

```
fsutil dirty query c:
```

- If the volume is dirty, the following output displays: `Volume C: is dirty`

- If the volume isn't dirty, the following output displays: `Volume C: is not dirty`

To set the dirty bit on drive C, type:

```
fsutil dirty set C:
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [fsutil](fsutil.md)
