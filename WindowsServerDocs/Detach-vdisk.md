---
title: Detach vdisk
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5f01dcb8-9237-4564-ad94-8a8dd0fd0cca
---
# Detach vdisk
Stops the selected virtual hard disk \(VHD\) from appearing as a local hard disk drive on the host computer. When a VHD is detached, you can copy it to other locations.

> [!NOTE]
> This command is only applicable to Windows 7 and Windows Server 2008 R2.

## Syntax

```
detach vdisk [noerr]
```

### Parameters

|Parameter|Description|
|-------------|---------------|
|noerr|Used for scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code.|

## Remarks

-   A VHD must be selected and detached for this operation to succeed. Use the **select vdisk** command to select a VHD and shift the focus to it.

## <a name="BKMK_Examples"></a>Examples
To detach the selected VHD, type:

```
detach vdisk
```

## Additional references

-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)

-   [Attach vdisk](Attach-vdisk.md)

-   [Compact vdisk](Compact-vdisk.md)

-   [Create vdisk](assetId:///72df30b1-8902-487b-98f6-bcb693610e29)

-   [Detail vdisk](Detail-vdisk.md)

-   [Expand vdisk](Expand-vdisk.md)

-   [Merge vdisk](Merge-vdisk.md)

-   [Select vdisk](Select-vdisk.md)

-   [List_1](List_1.md)


