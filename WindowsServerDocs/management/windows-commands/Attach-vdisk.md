---
title: Attach vdisk
description: "Windows Commands"
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
ms.date: 10/12/2016
---
# Attach vdisk
Attaches (sometimes called mounts or surfaces) a virtual hard disk (VHD) so that it appears on the host computer as a local hard disk drive. If the VHD already has a disk partition and file system volume when you attach it, the volume inside the VHD is assigned a drive letter.
> [!NOTE]
> This command is only applicable to Windows 7 and Windows Server 2008 R2.
For an example of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).
## Syntax
```
attach vdisk [readonly] { [sd=<SDDL>] | [usefilesd] } [noerr]
```
### Parameters
|Parameter|Description|
|-------------|---------------|
|readonly|Attaches the VHD as read-only. Any write operation returns an error.|
|sd=<SDDL string>|Sets the user filter on the VHD. The filter string must be in the Security Descriptor Definition Language (SDDL) format. By default the user filter allows access like on a physical disk.<br /><br />SDDL strings can be complex, but in its simplest form, a security descriptor that protects access is known as a discretionary access control list (DACL). It is of the form: D:<dacl_flags><string_ace1><string_ace2>... <string_acen><br /><br />Common DACL flags are:<br /><br />-   **A** â€“ Allow access<br />-   **D** â€“ Deny access<br /><br />Common rights are:<br /><br />-   **GA** â€“ All access<br />-   **GR** â€“ Read access<br />-   **GW** â€“ Write access<br /><br />Common user accounts are:<br /><br />-   **BA** â€“ Built in administrators<br />-   **AU** â€“ Authenticated users<br />-   **CO** â€“ Creator owner<br />-   **WD** - Everyone<br /><br />Examples:<br /><br />**D:P:(A;;GR;;;AU** gives read-access to all authenticated users<br /><br />**D:P:(A;;GA;;;WD** gives everyone full acces|
|usefilesd|Specifies that the security descriptor on the .vhd file should be used on the VHD. If the **Usefilesd** parameter is not specified, the VHD will not have an explicit security descriptor unless it is specified with the **Sd** parameter.|
|noerr|Used for scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code.|
## Remarks
-   A VHD must be selected and detached for this operation to succeed. Use the **select vdisk** command to select a VHD and shift the focus to it.
## <a name="BKMK_Examples"></a>Examples
To attach the selected VHD as read-only, type:
```
attach vdisk readonly
```
## Additional references
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)
-   [Compact vdisk](Compact-vdisk.md)
-   [Create vdisk](assetId:///72df30b1-8902-487b-98f6-bcb693610e29)
-   [Detail vdisk](Detail-vdisk.md)
-   [Detach vdisk](Detach-vdisk.md)
-   [Expand vdisk](Expand-vdisk.md)
-   [Merge vdisk](Merge-vdisk.md)
-   [Select vdisk](Select-vdisk.md)
-   [List_1](List_1.md)
