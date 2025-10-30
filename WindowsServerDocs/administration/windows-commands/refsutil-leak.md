---
title: refsutil leak
description: Reference article for the refsutil leak tool, which detects and diagnoses storage leaks, revealing their location and size to optimize storage usage on a specified Resilient File System (ReFS) volume in Windows.
author: dknappettmsft
ms.author: daknappe
ms.date: 04/03/2025
ms.topic: reference
---

# refsutil leak

The `refsutil leak` command assists administrators in detecting and diagnosing storage leaks, which occur when storage space is consumed inefficiently or unnecessarily. When the specified Resilient File System (ReFS) volume is scanned, this command identifies the location and size of leaks, helping to optimize storage usage and maintain system performance.

## Syntax

```
refsutil leak <drive> [/a] [/x] [/v] [/d] [/q] [/t <count>] [/s <file>]
```

## Parameters

| Parameter | Description |
|--|--|
| `<drive>` | Specifies the drive letter in the format `E:` or the path to the volume mount point. |
| `/a` | If leak detection discovers corruption, this parameter attempts to fix it and rerun the leak detection. With this parameter enabled, leak detection restarts once for each corrupted directory found on the volume. |
| `/x` | Operates with an exclusive lock on the volume. Without this parameter, leak detection creates a snapshot of the volume for processing. |
| `/v` | Enables verbose output, providing more detailed information. |
| `/d` | Only performs a diagnosis. Leaks are reported to standard output (stdout) but isn't fixed. |
| `/q` | Queries the required space for the leak analysis operation. |
| `/t <count>` | Specifies how many CPU threads to use for leak detection. Utilizing more threads speeds up the process on a multi-core CPU. If set to `0`, it runs the detection in a single thread (not recommended). The default is `4` threads. |
| `/s <file>` | Uses the specified `<file>` as a scratch buffer for the operation. The `<file>` must be able to grow to the size reported by the `/q` parameter. If this parameter is omitted, a scratch buffer is created in the TEMP directory. |

> [!NOTE]
> Using the `/d` and `/a` parameters together will triage all found directory and file corruptions, but doesn't fix leaks.

## Examples

To perform a leak analysis and generate a detailed report using F:\Scratch.tmp as the temporary file using `6` CPU threads, run this command:

```
refsutil leak D: /a /t 6 /s F:\Scratch.tmp
```

To perform a leak analysis and display detailed output using `5` CPU threads, run this command:

```
refsutil leak D: /a /d /v /t 5
```

To check the amount of space needed for a leak analysis on the D: drive, run this command:

```
refsutil leak D: /q
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
