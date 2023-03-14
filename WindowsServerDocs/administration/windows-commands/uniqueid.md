---
title: uniqueid
description: Reference article for uniqueid, which displays or sets the GUID partition table (GPT) identifier or master boot record (MBR) signature for the disk with focus.
ms.topic: reference
ms.assetid: 64235a4a-b91c-46da-b9b0-68ee90571c2a
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# uniqueid

Displays or sets the GUID partition table (GPT) identifier or master boot record (MBR) signature for the basic or dynamic disk with focus. A basic or dynamic disk must be selected for this operation to succeed. Use the [select disk command](select-disk.md) to select a disk and shift the focus to it.

## Syntax

```
uniqueid disk [id={<dword> | <GUID>}] [noerr]
```

### Parameters

| Parameter | Description |
|--|--|
| id=`{<dword> | <GUID>}` | For MBR disks, this parameter specifies a 4-byte (DWORD) value in hexadecimal form for the signature. For GPT disks, this parameter specifies a GUID for the identifier. |
| noerr | For scripting only. When an error occurs, DiskPart continues to process commands as if the error didn't occur. Without this parameter, an error causes DiskPart to exit with an error code. |

## Examples

To display the signature of the MBR disk with focus, type:

```
uniqueid disk
```

To set the signature of the MBR disk with focus to the DWORD value *5f1b2c36*, type:

```
uniqueid disk id=5f1b2c36
```

To set the identifier of the GPT disk with focus to the GUID value baf784e7-6bbd-4cfb-aaac-e86c96e166ee, type:

```
uniqueid disk id=baf784e7-6bbd-4cfb-aaac-e86c96e166ee
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [select disk command](select-disk.md)
