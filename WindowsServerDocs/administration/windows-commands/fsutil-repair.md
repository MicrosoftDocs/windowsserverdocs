---
title: fsutil repair
description: Reference article for the fsutil repair command, which administers and monitors NTFS self-healing repair operations.
manager: dmoss
ms.author: toklima
author: toklima
ms.assetid: 62d77150-1d9e-4069-ab4a-299f33024912
ms.topic: reference
ms.date: 10/16/2017
---

# fsutil repair

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows 10, Windows Server 2012 R2, Windows 8.1, Windows Server 2012, Windows 8

Administers and monitors NTFS self-healing repair operations. Self-healing NTFS attempts to correct corruptions of the NTFS file system online, without requiring **Chkdsk.exe** to be run. For more information, see [Self-healing NTFS](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc771388(v=ws.10)).

## Syntax

```
fsutil repair [enumerate] <volumepath> [<logname>]
fsutil repair [initiate] <volumepath> <filereference>
fsutil repair [query] <volumepath>
fsutil repair [set] <volumepath> <flags>
fsutil repair [wait][<waittype>] <volumepath>

```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| enumerate | Enumerates the entires of a volume's corruption log. |
| `<logname>` | Can be `$corrupt`, the set of confirmed corruptions in the volume or `$verify`, a set of potential, unverified corruptions in the volume. |
| initiate | Initiates NTFS self-healing. |
| `<filereference>` | Specifies the NTFS volume-specific file ID (file reference number). The file reference includes the segment number of the file. |
| query | Queries the self-healing state of the NTFS volume. |
| set | Sets the self-healing state of the volume. |
| `<flags>` | Specifies the repair method to be used when setting the self-healing state of the volume.<p>This parameter can be set to three values:<ul><li>**0x01** - Enables general repair.</li><li>**0x09** - Warns about potential data loss without repair.</li><li>**0x00** - Disables NTFS self-healing repair operations.</li></ul> |
| state | Queries the corruption state of the system or for a given volume. |
| wait | Waits for repair(s) to complete. If NTFS has detected a problem on a volume on which it is performing repairs, this option allows the system to wait until the repair is complete before it runs any pending scripts. |
| `[waittype {0|1}]` | Indicates whether to wait for the current repair to complete or to wait for all repairs to complete. The *waittype* parameter can be set to the following values:<ul><li>**0** - Waits for all repairs to complete. (default value)</li><li>**1** - Waits for the current repair to complete.</li></ul> |

### Examples

To enumerate the confirmed corruptions of a volume, type:

```
fsutil repair enumerate C: $Corrupt
```

To enable self-healing repair on drive C, type:

```
fsutil repair set c: 1
```

To disable self-healing repair on drive C, type:

```
fsutil repair set c: 0
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [fsutil](fsutil.md)

- [Self-healing NTFS](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc771388(v=ws.10))
