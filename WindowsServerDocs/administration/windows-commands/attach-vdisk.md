---
title: attach vdisk
description: "Windows Commands topic for **attach vdisk** - attaches (sometimes called mounts or surfaces) a virtual hard disk (VHD) so that it appears on the host computer as a local hard disk drive."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 882ab875-0c14-4eb3-98ef-fd0e8fa40d9c
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# attach vdisk

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

attaches (sometimes called mounts or surfaces) a virtual hard disk (VHD) so that it appears on the host computer as a local hard disk drive. If the VHD already has a disk partition and file system volume when you attach it, the volume inside the VHD is assigned a drive letter.
> [!NOTE]
> This command is only applicable to Windows 7 and Windows Server 2008 R2.

## Syntax
```
attach vdisk [readonly] { [sd=<SDDL>] | [usefilesd] } [noerr]
```
### Parameters

|    Parameter     |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|     readonly     |                                                                                                                                                                                                                                                                                                                                                                                                                                                                             attaches the VHD as read-only. Any write operation returns an error.                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| sd=<SDDL string> | Sets the user filter on the VHD. The filter string must be in the Security Descriptor Definition Language (SDDL) format. By default the user filter allows access like on a physical disk.<br /><br />SDDL strings can be complex, but in its simplest form, a security descriptor that protects access is known as a discretionary access control list (DACL). It is of the form: D:<dacl_flags><string_ace1><string_ace2>... <string_acen><br /><br />Common DACL flags are:<br /><br />-   **A**   Allow access<br />-   **D**   Deny access<br /><br />Common rights are:<br /><br />-   **GA**   All access<br />-   **GR**   Read access<br />-   **GW**   Write access<br /><br />Common user accounts are:<br /><br />-   **BA**   Built in administrators<br />-   **AU**   Authenticated users<br />-   **CO**   Creator owner<br />-   **WD** - Everyone<br /><br />Examples:<br /><br />**D:P:(A;;GR;;;AU** gives read-access to all authenticated users<br /><br />**D:P:(A;;GA;;;WD** gives everyone full acces |
|    usefilesd     |                                                                                                                                                                                                                                                                                                                                                                                          Specifies that the security descriptor on the .vhd file should be used on the VHD. If the **Usefilesd** parameter is not specified, the VHD will not have an explicit security descriptor unless it is specified with the **Sd** parameter.                                                                                                                                                                                                                                                                                                                                                                                          |
|      noerr       |                                                                                                                                                                                                                                                                                                                                                                                                           Used for scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code.                                                                                                                                                                                                                                                                                                                                                                                                           |

## Remarks
- A VHD must be selected and detached for this operation to succeed. Use the **select vdisk** command to select a VHD and shift the focus to it.
  ## <a name="BKMK_Examples"></a>Examples
  To attach the selected VHD as read-only, type:
  ```
  attach vdisk readonly
  ```
  ## additional references
- [Command-Line Syntax Key](command-line-syntax-key.md)
- [compact vdisk](compact-vdisk.md)

- [detail vdisk](detail-vdisk.md)
- [Detach vdisk](detach-vdisk.md)
- [expand vdisk](expand-vdisk.md)
- [Merge vdisk](merge-vdisk.md)
- [select vdisk](select-vdisk.md)
- [list_1](list_1.md)
