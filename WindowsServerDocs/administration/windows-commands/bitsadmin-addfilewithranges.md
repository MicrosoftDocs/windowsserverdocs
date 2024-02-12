---
title: bitsadmin addfilewithranges
description: Reference article for the bitsadmin addfilewithranges command, which adds a file to the specified job. BITS downloads the specified ranges from the remote file.
ms.topic: reference
ms.assetid: df0ce0bf-dff1-4a48-a16f-fd2f4d5f7189
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin addfilewithranges

Adds a file to the specified job. BITS downloads the specified ranges from the remote file. This switch is valid only for download jobs.

## Syntax

```
bitsadmin /addfilewithranges <job> <remoteURL> <localname> <rangelist>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| job | The job's display name or GUID. |
| remoteURL | URL of the file on the server. |
| localname | Name of the file on the local computer. Must contain an absolute path to the file. |
| rangelist | Comma-delimited list of offset:length pairs. Use a colon to separate the offset value from the length value. For example, a value of `0:100,2000:100,5000:eof` tells BITS to transfer 100 bytes from offset 0, 100 bytes from offset 2000, and the remaining bytes from offset 5000 to the end of the file. |

## Remarks

- The token **eof** is a valid length value within the offset and length pairs in the `<rangelist>`. It instructs the service to read to the end of the specified file.

- The `addfilewithranges` command will fail with error code 0x8020002c, if a zero-length range is specified along with another range using same offset, such as:

    `c:\bits>bitsadmin /addfilewithranges j2 http://bitsdc/dload/1k.zip c:\1k.zip 100:0,100:5`

    **Error message:** Unable to add file to job - 0x8020002c. The list of byte ranges contains some overlapping ranges, which are not supported.

    **Workaround:** Don't specify the zero-length range first. For example, use `bitsadmin /addfilewithranges j2 http://bitsdc/dload/1k.zip c:\1k.zip 100:5,100:0`

## Examples

To transfer 100 bytes from offset 0, 100 bytes from offset 2000, and the remaining bytes from offset 5000 to the end of the file:

```
bitsadmin /addfilewithranges http://downloadsrv/10mb.zip c:\10mb.zip 0:100,2000:100,5000:eof
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
