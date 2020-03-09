---
title: Vssadmin resize shadowstorage
description: A description of the vssadmin resize shadowstorage command.
ms.prod: windows-server 
ms.topic: article 
author: JasonGerend 
ms.author: jgerend 
ms.technology: storage 
ms.date: 03/05/2020
ms.localizationpriority: medium
---
# Vssadmin resize shadowstorage

>Applies to: Windows 10, Windows 8.1, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, Windows Server 2008

Resizes the maximum amount of storage space that can be used for shadow copy storage.

The minimum amount of storage space that can be used for shadow copy storage can be specified by using the **MinDiffAreaFileSize** registry value. For more information, see [MinDiffAreaFileSize](https://docs.microsoft.com/windows/win32/backup/registry-keys-for-backup-and-restore#mindiffareafilesize).

> [!WARNING]
> Resizing the storage association may cause shadow copies to disappear.

## Syntax

```cmd
vssadmin resize shadowstorage /for=<ForVolumeSpec> /on=<OnVolumeSpec> [/maxsize=<MaxSizeSpec>]
```

## Parameters

|Parameter|Description|
|---|---|
`/for=<ForVolumeSpec>`  | Specifies the volume for which the maximum amount of storage space is to be resized.
`/on=<OnVolumeSpec>` | Specifies the storage volume.
`[/maxsize=<MaxSizeSpec>]` |  Specifies the maximum amount of space that can be used for storing shadow copies. If no value is specified for /maxsize, there is no limit placed on the amount of storage space that can be used.  <br> <br> The MaxSizeSpec value must be 1 MB or greater and must be expressed in one of the following units: KB, MB, GB, TB, PB, or EB. If no unit is specified, MaxSizeSpec uses bytes by default.

## Examples

```cmd
vssadmin Resize ShadowStorage /For=C: /On=D: /MaxSize=900MB
vssadmin Resize ShadowStorage /For=C: /On=D: /MaxSize=UNBOUNDED
vssadmin Resize ShadowStorage /For=C: /On=C: /MaxSize=20%
```

## Additional references

* [Command-line syntax key](https://docs.microsoft.com/windows-server/administration/windows-commands/command-line-syntax-key)
* [Vssadmin](vssadmin.md)
