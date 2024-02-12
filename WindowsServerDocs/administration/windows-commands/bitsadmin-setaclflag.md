---
title: bitsadmin setaclflag
description: Reference article for the bitsadmin setaclflag command, which sets the access control list (ACL) propagations flags.
ms.topic: reference
ms.assetid: 6e3bcda0-827d-4dfd-8384-d1da018f3e10
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin setaclflag

Sets the access control list (ACL) propagations flags for the job. The flags indicate that you want to maintain the owner and ACL information with the file being downloaded. For example, to maintain the owner and group with the file, set the **flags** parameter to `og`.

## Syntax

```
bitsadmin /setaclflag <job> <flags>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| job | The job's display name or GUID. |
| flags | Specify one or more of the values, including:<ul><li>**o** - Copy owner information with file.</li><li>**g** - Copy group information with file.</li><li>**d** - Copy discretionary access control list (DACL) information with file.</li><li>**s** - Copy system access control list (SACL) information with file.</li></ul> |

## Examples

To set the access control list propagation flags for the job named *myDownloadJob*, so it maintains the owner and group information with the downloaded files.

```
bitsadmin /setaclflags myDownloadJob og
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
