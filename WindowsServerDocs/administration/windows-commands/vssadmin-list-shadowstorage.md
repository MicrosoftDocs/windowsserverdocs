---
title: vssadmin list shadowstorage
titleSuffix: in Windows and Windows Server
description: Learn how to use the vssadmin list shadowstorage command to list all shadow copy storage associations on a system or a specified volume.
ms.topic: reference
author: robinharwood
ms.author: roharwoo
ms.date: 09/07/2026
ai-usage: ai-assisted
---

# vssadmin list shadowstorage

Lists the shadow copy storage associations on the system. A shadow copy storage association links a volume that has shadow copies to the volume that stores those copies, and reports the disk space that storage uses.

Run this command to find out where shadow copy storage resides and how much space it consumes, such as before you change its size.

## Syntax

```
vssadmin list shadowstorage [/for=<ForVolumeSpec>|/on=<OnVolumeSpec>]
```

### Parameters

| Parameter | Description |
|--|--|
| /for=`<ForVolumeSpec>` | Lists the shadow copy storage associations for the specified volume. Don't use this parameter together with **/on**. |
| /on=`<OnVolumeSpec>` | Lists the shadow copy storage associations on the specified volume. Don't use this parameter together with **/for**. |

## Examples

To list all shadow copy storage associations located on volume C, type:

```
vssadmin list shadowstorage /on=C:
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [vssadmin command](vssadmin.md)
