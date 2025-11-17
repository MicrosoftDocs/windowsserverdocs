---
title: refsutil dedup
description: Reference article for the refsutil dedup tool, which deduplicates a Resilient File System (ReFS) volume in Windows.
author: dknappettmsft
ms.author: daknappe
ms.date: 04/02/2025
ms.topic: reference
---

# refsutil dedup

The `refsutil compression` command manages data deduplication on a specified Resilient File System (ReFS) volume. You can either deduplicate the volume or scan it to see how much space can be saved by deduplicating equivalent clusters. You can also control CPU usage and choose between memory-mapped file I/O or asynchronous reads.

## Syntax

```
refsutil dedup <drive> [/d] [/s] [/cpu <percentage>] [/mm]
```

## Parameters

| Parameter | Description |
|--|--|
| `drive` | Specifies the volume path in the `E:` format or a mount point. |
| `/d` | Deduplicates the volume. <br><br>This parameter can't be used with the `/s` parameter. |
| `/s` | Scans the volume to determine how much space can be saved by deduplicating equivalent clusters. <br><br>This parameter can't be used with the `/d` parameter. |
| `/cpu percentage` | Specifies the maximum percentage of CPU to use. Acceptable values are between 1-100. |
| `/mm` | Uses memory-mapped file I/O to read files for deduplication. <br><br>This parameter must be used with either the `/d` or `/s` parameters. |

## Examples

To scan the D: volume and see how much space you can save by deduplicating equivalent clusters, run the command:

```
refsutil dedup D: /s
```

To deduplicate the D: volume using 50% of CPU resources, run the command:

```
refsutil dedup D: /d /cpu 50
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
