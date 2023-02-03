---
title: bitsadmin setvalidationstate
description: Reference article for the bitsadmin setvalidationstate command, which sets the content validation state of the given file within the job.
ms.topic: reference
ms.assetid: e8fc8e8c-171c-4681-8057-6986b018e576
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin setvalidationstate

Sets the content validation state of the given file within the job.

## Syntax

```
bitsadmin /setvalidationstate <job> <file_index> <TRUE|FALSE>
```

### Parameters

| Parameter | Description |
| --------- | ---------- |
| Job | The job's display name or GUID. |
| file_index | Starts at 0. |
| TRUE or FALSE | **TRUE** turns on content validation for the specified file, while **FALSE** turns it off. |

## Examples

To set the content validation state of file 2 to TRUE for the job named *myDownloadJob*:

```
bitsadmin /setvalidationstate myDownloadJob 2 TRUE
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
