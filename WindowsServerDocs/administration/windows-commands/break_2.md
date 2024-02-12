---
title: break (diskshadow)
description: Reference article for the break command, which disassociates a shadow copy volume from VSS and makes it accessible as a regular volume.
ms.topic: reference
ms.assetid: de2b6c95-1c2e-4a43-bec5-341a9014371b
ms.author: wscontent
author: xelu86
ms.date: 10/12/2023
---

# break (diskshadow)

Disassociates a shadow copy volume from VSS and makes it accessible as a regular volume. The volume can then be accessed using a drive letter (if assigned) or volume name. If used without parameters, **break** displays help at the command prompt.

> [!NOTE]
> This command is relevant only for hardware shadow copies after import.
>
> Exposed volumes, like the shadow copies they originate from, are read-only by default. Access to the volume is made directly to the hardware provider without record of the volume having been a shadow copy.

## Syntax

```
break [writable] <setid>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| writable | Enables read/write access on the volume. |
| `<setid>` | Specifies the ID of the shadow copy set. The alias of the shadow copy ID, which is stored as an environment variable by the **load metadata** command, can be used in the *SetID* parameter. |

## Examples

To make a shadow copy using the alias name Alias1 accessible as a writable volume in the operating system:

```
break writable %Alias1%
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
