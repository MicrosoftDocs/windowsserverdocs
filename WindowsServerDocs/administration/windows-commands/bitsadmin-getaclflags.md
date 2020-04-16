---
title: bitsadmin getaclflags
description: Windows Commands topic for **bitsadmin getaclflags**, which retrieves the access control list (ACL) propagations flags.
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

## Remarks

Displays one or more of the following flag values:

- **o** - Copy owner information with file.

- **g** - Copy group information with file.

- **d** - Copy discretionary access control list (DACL) information with file.

- **s** - Copy system access control list (SACL) information with file.

## <a name=BKMK_examples></a>Examples

The following example retrieves the access control list propagation flags for the job named *myDownloadJob*.

```
C:\>bitsadmin /getaclflags myDownloadJob
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)