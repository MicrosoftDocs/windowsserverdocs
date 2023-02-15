---
title: bitsadmin setdescription
description: Reference article for the bitsadmin setdescription command, which sets the description of the specified job.
ms.topic: reference
ms.assetid: 1e46a5dd-4637-4a2e-b88f-d3f85b177db8
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin setdescription

Sets the description for the specified job.

## Syntax

```
bitsadmin /setdescription <job> <description>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| job | The job's display name or GUID. |
| description | Text used to describe the job. |

## Examples

To retrieve the description for the job named *myDownloadJob*:

```
bitsadmin /setdescription myDownloadJob music_downloads
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
