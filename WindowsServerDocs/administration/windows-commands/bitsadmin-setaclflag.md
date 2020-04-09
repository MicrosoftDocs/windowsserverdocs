---
title: bitsadmin setaclflag
description: Windows Commands topic for **bitsadmin setaclflag**, which sets the access control list (ACL) propagations flags.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: 6e3bcda0-827d-4dfd-8384-d1da018f3e10
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
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
| flags | Specify one or more of the values, including:<ul><li>**o** - Copy owner information with file.</li><li>**g** - Copy group information with file.</li><li>Copy discretionary access control list (DACL) information with file.</li><li>Copy system access control list (SACL) information with file.</li></ul>|

## Remarks

The /setaclflag switch is used to maintain owner and access control list information when a job is downloading data from a Windows (SMB) share.

## Examples

The following example sets the access control list propagation flags for the job named *myDownloadJob* to maintain the owner and group information with the downloaded files.

```
C:\>bitsadmin /setaclflags myDownloadJob og
```

## Additional References

[Command-Line Syntax Key](command-line-syntax-key.md)&reg;'    