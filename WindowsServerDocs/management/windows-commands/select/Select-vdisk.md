---
title: Select vdisk
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8808872a-3523-4205-a6c6-83fa738ee37a
---
# Select vdisk
Selects the specified virtual hard disk \(VHD\) and shifts the focus to it.

> [!NOTE]
> This command is only applicable to Windows 7 and Windows Server 2008 R2.

## Syntax

```
select vdisk file=<full path> [noerr]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|file\=<full path>|Specifies the full path and file name of an existing VHD file.|
|noerr|Used for scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code.|

## <a name="BKMK_examples"></a>Examples
To shift the focus to the VHD named Test.vhd, type:

```
select vdisk file="c:\test\test.vhd"
```

#### Additional references

-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)

-   [Attach vdisk](Attach-vdisk.md)

-   [Compact vdisk](Compact-vdisk.md)

-   [Create vdisk](assetId:///72df30b1-8902-487b-98f6-bcb693610e29)

-   [Detach vdisk](Detach-vdisk.md)

-   [Detail vdisk](Detail-vdisk.md)

-   [Expand vdisk](Expand-vdisk.md)

-   [Merge vdisk](Merge-vdisk.md)

-   [List_1](List_1.md)


