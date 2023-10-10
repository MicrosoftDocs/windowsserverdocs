---
title: bitsadmin addfileset
description: Reference article for the bitsadmin addfileset command, which adds one or more files to the specified job.
ms.topic: reference
ms.assetid: 75466994-262f-4724-b14d-f813c5397675
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin addfileset

Adds one or more files to the specified job.

## Syntax

```
bitsadmin /addfileset <job> <textfile>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| job | The job's display name or GUID. |
| textfile | A text file, each line of which contains a remote and a local file name. **Note:** Names must space-delimited. Lines starting with a `#` character are treated as a comment. |

## Examples

```
bitsadmin /addfileset files.txt
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
