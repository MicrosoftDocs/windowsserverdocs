---
title: bitsadmin getaclflags
description: Reference topic for the bitsadmin getaclflags command, which retrieves the access control list (ACL) propagations flags.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: 99266def-7479-4430-a61c-98ec433fa88b
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin getaclflags

Retrieves the access control list (ACL) propagations flags, reflecting whether items are inherited by child objects.

## Syntax

```
bitsadmin /getaclflags <job>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| job | The job's display name or GUID. |

### Remarks

Returns one or more of the following flag values:

- **o** - Copy owner information with file.

- **g** - Copy group information with file.

- **d** - Copy discretionary access control list (DACL) information with file.

- **s** - Copy system access control list (SACL) information with file.

## Examples

To retrieve the access control list propagation flags for the job named *myDownloadJob*:

```
bitsadmin /getaclflags myDownloadJob
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
