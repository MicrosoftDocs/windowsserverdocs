---
title: bitsadmin setdisplayname
description: Reference article for the bitsadmin setdisplayname command, which sets the display name of the specified job.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: 13706c53-fb5f-4879-b5ca-82531361d6e1
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin setdisplayname

Sets the display name for the specified job.

## Syntax

```
bitsadmin /setdisplayname <job> <display_name>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| job | The job's display name or GUID. |
| display_name | Text used as the displayed name for the specific job. |

## Examples

To set the display name for the job to *myDownloadJob*:

```
bitsadmin /setdisplayname myDownloadJob
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
