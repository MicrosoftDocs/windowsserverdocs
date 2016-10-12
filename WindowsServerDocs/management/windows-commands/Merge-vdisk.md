---
title: Merge vdisk
description: "Windows Commands"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5865bb08-89a3-406c-8328-0ef8868d03e8
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Merge vdisk

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Merges a differencing virtual hard disk (VHD) with its corresponding parent VHD. The parent VHD will be modified to include the modifications from the differencing VHD.
> [!NOTE]
> This command is only applicable to Windows 7 and Windows Server 2008 R2.
## Syntax
```
merge vdisk depth=<n>
```
### Parameters
|Parameter|Description|
|-------------|---------------|
|depth=<n>|Indicates the number of parent VHD files to merge together. For example, **depth=1** indicates that the differencing VHD will be merged with one level of the differencing chain.|
## Remarks
-   A VHD must be selected and detached for this operation to succeed. Use the **select vdisk** command to select a VHD and shift the focus to it.
-   This parameter modifies the parent VHD. As a result, other differencing VHDs that are dependent on the parent will no longer be valid.
## <a name="BKMK_Examples"></a>Examples
To merge a differencing VHD with its parent VHD, type:
```
merge vdisk depth=1
```
## Additional references
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)
-   [Attach vdisk](Attach-vdisk.md)
-   [Compact vdisk](Compact-vdisk.md)

-   [Detail vdisk](Detail-vdisk.md)
-   [Detach vdisk](Detach-vdisk.md)
-   [Expand vdisk](Expand-vdisk.md)
-   [Select vdisk](Select-vdisk.md)
-   [List_1](List_1.md)
