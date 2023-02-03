---
title: vssadmin resize shadowstorage
description: A description of the vssadmin resize shadowstorage command, which resizes the maximum amount of storage space that can be used for shadow copy storage.
ms.topic: reference
author: JasonGerend
ms.author: jgerend
ms.date: 03/05/2020
---

# vssadmin resize shadowstorage

>Applies to: Windows Server 2022, Windows Server 2019, Windows 10, Windows 8.1, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, Windows Server 2008

Resizes the maximum amount of storage space that can be used for shadow copy storage.

The minimum amount of storage space that can be used for shadow copy storage can be specified by using the **MinDiffAreaFileSize** registry value. For more information, see [MinDiffAreaFileSize](/windows/win32/backup/registry-keys-for-backup-and-restore#mindiffareafilesize).

> [!WARNING]
> Resizing the storage association may cause shadow copies to disappear.

## Syntax

```
vssadmin resize shadowstorage /for=<ForVolumeSpec> /on=<OnVolumeSpec> [/maxsize=<MaxSizeSpec>]
```

### Parameters

| Parameter | Description |
|--|--|
| /for=`<ForVolumeSpec>` | Specifies the volume for which the maximum amount of storage space is to be resized. |
| /on=`<OnVolumeSpec>` | Specifies the storage volume. |
| [/maxsize=`<MaxSizeSpec>`] | Specifies the maximum amount of space that can be used for storing shadow copies. If no value is specified for **/maxsize**, there's no limit placed on the amount of storage space that can be used.<p>The **MaxSizeSpec** value must be 1 MB or greater and must be expressed in one of the following units: KB, MB, GB, TB, PB, or EB. If no unit is specified, **MaxSizeSpec** uses bytes by default. |

## Examples

To resize shadow copy of volume C on volume D, with a maximum size of 900MB, type:

```
vssadmin resize shadowstorage /For=C: /On=D: /MaxSize=900MB
```

To resize shadow copy of volume C on volume D, with no maximum size, type:

```
vssadmin resize shadowstorage /For=C: /On=D: /MaxSize=UNBOUNDED
```

To resize shadow copy of volume C by 20%, type:

```
vssadmin resize shadowstorage /For=C: /On=C: /MaxSize=20%
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [vssadmin command](vssadmin.md)
