---
title: Bdehdcfg: driveinfo
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f2d065e7-eced-4509-a1a0-ee2521a7f02e
---
# Bdehdcfg: driveinfo
Displays the drive letter, the total size, the maximum free space, and the partition characteristics. Only valid partitions are listed. Unallocated space is not listed if four primary or extended partitions already exist. For examples of how this command can be used, see [Examples](#BKMK_Examples).

## Syntax

```
bdehdcfg -driveinfo <DriveLetter>
```

### Parameters

|Parameter|Description|
|-------------|---------------|
|<DriveLetter>|Specifies a drive letter followed by a colon.|

## Remarks
The command is informational only and makes no modifications to the drive.

## <a name="BKMK_Examples"></a>Example
The following example will display the drive information for drive C.

```
bdehdcfg –driveinfo C:
```

## Additional references

-   [Command-Line Syntax Key](../Command-Line-Syntax-Key.md)

-   [Bdehdcfg](../Bdehdcfg.md)


