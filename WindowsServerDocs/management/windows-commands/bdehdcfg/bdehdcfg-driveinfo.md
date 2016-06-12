---
title: bdehdcfg: driveinfo
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f2d065e7-eced-4509-a1a0-ee2521a7f02e
---
# bdehdcfg: driveinfo
Displays the drive letter, the total size, the maximum free space, and the partition characteristics. Only valid partitions are listed. Unallocated space is not listed if four primary or extended partitions already exist. for examples of how this command can be used, see [Examples](#BKMK_Examples).

## Syntax

```
bdehdcfg -driveinfo <DriveLetter>
```

### Parameters

|Parameter|Description|
|-------------|---------------|
|<DriveLetter>|Specifies a drive letter followed by a colon.|

## remarks
The command is informational only and makes no modifications to the drive.

## <a name="BKMK_Examples"></a>Example
The following example will display the drive information for drive C.

```
bdehdcfg –driveinfo C:
```

## additional references

-   [Command-Line Syntax Key](../commandline-syntax-key.md)

-   [bdehdcfg](../bdehdcfg.md)


