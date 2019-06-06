---
title: bitsadmin addfilewithranges
description: "Windows Commands topic for **bitsadmin addfilewithranges** - adds a file to the specified job. BITS downloads the specified ranges from the remote file."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: df0ce0bf-dff1-4a48-a16f-fd2f4d5f7189
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin addfilewithranges

Adds a file to the specified job. BITS downloads the specified ranges from the remote file. This switch is valid only for download jobs.

## Syntax

```
bitsadmin /AddFileWithRanges <Job> <RemoteURL> <LocalName> <RangeList>
```

## Parameters

|Parameter|Description|
|---------|-----------|
|Job|The job's display name or GUID|
|RemoteURL|*RemoteURL* is the URL of the file on the server.|
|LocalName|*LocalName* is the name of the file on the local computer. *LocalName* must contain an absolute path to the file.|
|RangeList|*RangeList* is a comma-delimited list of offset:length pairs. Use a colon to separate the offset value from the length value. For example, a value of `0:100,2000:100,5000:eof` tells BITS to transfer 100 bytes from offset 0, 100 bytes from offset 2000, and the remaining bytes from offset 5000 to the end of the file.|

## More Information

-   The token **eof** is a valid length value within the offset and length pairs in the *\<RangeList>*. It instructs the service to read to the end of the specified file.
-   Note that AddFileWithRanges will fail with error code 0x8020002c when a zero-length range is specified along with another range with same offset, such as: C:\bits>bitsadmin /addfilewithranges j2 http://bitsdc/dload/1k.zip c:\1k.zip 100:0,100:5

    Error message: Unable to add file to job - 0x8020002c. The list of byte ranges contains some overlapping ranges, which are not supported.

    Workaround: do not specify the zero-length range first. For example: bitsadmin /addfilewithranges j2 http://bitsdc/dload/1k.zip c:\1k.zip 100:5,100:0.

## Examples

The following example tells BITS to transfer 100 bytes from offset 0, 100 bytes from offset 2000, and the remaining bytes from offset 5000 to the end of the file.

```
C:\>bitsadmin /addfilewithranges http://downloadsrv/10mb.zip c:\10mb.zip "0:100,2000:100,5000:eof"
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)