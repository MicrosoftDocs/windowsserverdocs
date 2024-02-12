---
title: attach vdisk
description: Reference article for the attach vdisk command, which attaches (sometimes called mounts or surfaces) a virtual hard disk (VHD) so that it appears on the host computer as a local hard disk drive.
ms.topic: reference
ms.assetid: 882ab875-0c14-4eb3-98ef-fd0e8fa40d9c
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---
# attach vdisk

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Attaches (sometimes called mounts or surfaces) a virtual hard disk (VHD) so that it appears on the host computer as a local hard disk drive. If the VHD already has a disk partition and file system volume when you attach it, the volume inside the VHD is assigned a drive letter.

> [!IMPORTANT]
> You must choose and detach a VHD for this operation to succeed. Use the **select vdisk** command to select a VHD and shift the focus to it.

## Syntax

```
attach vdisk [readonly] { [sd=<SDDL>] | [usefilesd] } [noerr]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| readonly | Attaches the VHD as read-only. Any write operation returns an error. |
| `sd=<SDDL string>` | Sets the user filter on the VHD. The filter string must be in the Security Descriptor Definition Language (SDDL) format. By default the user filter allows access like on a physical disk. SDDL strings can be complex, but in its simplest form, a security descriptor that protects access is known as a discretionary access control list (DACL). It uses the form: `D:<dacl_flags><string_ace1><string_ace2>`... `<string_acen>`<p>Common DACL flags are:<ul><li>**A**. Allow access</li><li>**D**. Deny access</li></ul>Common rights are:<ul><li>**GA**. All access</li><li>**GR**. Read access</li><li> **GW**. Write access</li></ul>Common user accounts are:<ul><li>**BA**. Built in administrators</li><li>**AU**. Authenticated users</li><li>**CO**. Creator owner</li><li>**WD**. Everyone</li></ul>Examples:<ul><li>**D:P:(A;;GR;;;AU**. Gives read-access to all authenticated users.</li><li>**D:P:(A;;GA;;;WD**. Gives everyone full access.</li></ul> |
| usefilesd | Specifies that the security descriptor on the .vhd file should be used on the VHD. If the **Usefilesd** parameter is not specified, the VHD will not have an explicit security descriptor unless it is specified with the **Sd** parameter. |
| noerr | Used for scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code. |

## Examples

To attach the selected VHD as read-only, type:

```
attach vdisk readonly
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [select vdisk](select-vdisk.md)

- [compact vdisk](compact-vdisk.md)

- [detail vdisk](detail-vdisk.md)

- [detach vdisk](detach-vdisk.md)

- [expand vdisk](expand-vdisk.md)

- [merge vdisk](merge-vdisk.md)

- [list](./list.md)
