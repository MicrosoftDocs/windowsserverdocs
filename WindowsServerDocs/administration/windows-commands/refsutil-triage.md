---
title: refsutil triage
description: Reference article for the refsutil triage tool, which ensures data integrity and consistency by scrubbing the directory contents or global tables on a ReFS (Resilient File System) volume in Windows.
author: dknappettmsft
ms.author: daknappe
ms.date: 04/02/2025
ms.topic: reference
---

# refsutil triage

The `refsutil triage` command is used to scrub directory contents or global tables on a ReFS (Resilient File System) volume, ensuring data integrity and consistency.

## Syntax

```
refsutil triage <drive> [/s <id>] [/g] [/v]
```

## Parameters

| Parameter | Description |
|-----------|-------------|
| `<drive>` | Specifies the target drive, either as a drive letter in the format `E:` or as a path to the volume's mount point. |
| `/s <id>` | Scrubs the directory specified by `<id>`, where `<id>` is the file identifier for the directory. This option scrubs all files within the specified directory. This parameter can't be used with the `/g` parameter. |
| `/g` | Scrubs the global tables of the volume. This parameter can't be used with the `/s <id>` parameter. |
| `/v` | Displays verbose output, providing detailed information during the scrubbing operation. |

## Examples

To perform a directory scrub on the directory with file ID `15100` on the D: drive, run the following command:

```
refsutil triage D: /s 15100
```

To perform a directory scrub on the directory with file ID `16040` on the D: drive with verbose output, run the following command:

```
refsutil triage D: /s 16040 /v
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
