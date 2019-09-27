---
title: convert
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 96e437c0-1aa3-46ab-9078-a7b8cdaf3792
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# convert



Converts file allocation table (FAT) and FAT32 volumes to the NTFS file system, leaving existing files and directories intact. Volumes converted to the NTFS file system cannot be converted back to FAT or FAT32.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
convert [<Volume>] /fs:ntfs [/v] [/cvtarea:<FileName>] [/nosecurity] [/x]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|\<Volume>|Specifies the drive letter (followed by a colon), mount point, or volume name to convert to NTFS.|
|/fs:ntfs|Required. Converts the volume to NTFS.|
|/v|Runs **convert** in verbose mode, which displays all messages during the conversion process.|
|/cvtarea:\<FileName>|Specifies that the Master File Table (MFT) and other NTFS metadata files are written to an existing, contiguous placeholder file. This file must be in the root directory of the file system to be converted. Use of the **/cvtarea** parameter can result in a less fragmented file system after conversion. For best results, the size of this file should be 1 KB multiplied by the number of files and directories in the file system, although the **convert** utility accepts files of any size.</br>Important: You must create the placeholder file by using the **fsutil file createnew** command prior to running **convert**. **Convert** does not create this file for you. **Convert** overwrites this file with NTFS metadata. After conversion, any unused space in this file is freed.|
|/nosecurity|Specifies that the security settings on the converted files and directories allow access by all users.|
|/x|Dismounts the volume, if necessary, before it is converted. Any open handles to the volume will no longer be valid.|
|/?|Displays help at the command prompt.|

## Remarks

-   If **convert** cannot lock the drive (for example, the drive is the system volume or the current drive), you are given the option to convert the drive the next time you restart the computer. If you cannot restart the computer immediately to complete the conversion, plan a time to restart the computer and allow extra time for the conversion process to complete.
-   For volumes converted from FAT or FAT32 to NTFS:

    Due to existing disk usage, the MFT is created in a different location than on a volume originally formatted with NTFS, so volume performance might not be as good as on volumes originally formatted with NTFS. For optimal performance, consider recreating these volumes and formatting them with the NTFS file system.

    Volume conversion from FAT or FAT32 to NTFS leaves the files intact, but the volume might lack some performance benefits compared to volumes initially formatted with NTFS. For example, the MFT might become fragmented on converted volumes. In addition, on converted boot volumes, **convert** applies the same default security that is applied during Windows Setup.

## <a name="BKMK_examples"></a>Examples

To convert the volume on drive E to NTFS and display all messages during the conversion process, type:
```
convert e: /fs:ntfs /v
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)