---
title: ntfrsutl
description: Reference article for the ntfrsutl command, which dumps the internal tables, thread, and memory information for the NT File Replication Service (NTFRS).
ms.topic: reference
ms.assetid: d7721a19-5a87-4ab6-b816-65d2da2c811f
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# ntfrsutl

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Dumps the internal tables, thread, and memory information for the NT File Replication Service (NTFRS) from both the local and remote servers. The recovery setting for NTFRS in Service Control Manager (SCM) can be critical to locating and keeping important log events on the computer. This tool provides a convenient method of reviewing those settings.

## Syntax

```
ntfrsutl[idtable|configtable|inlog|outlog][<computer>]
ntfrsutl[memory|threads|stage][<computer>]
ntfrsutl ds[<computer>]
ntfrsutl [sets][<computer>]
ntfrsutl [version][<computer>]
ntfrsutl poll[/quickly[=[<n>]]][/slowly[=[<n>]]][/now][<computer>]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| idtable | Specifies the ID table. |
| configtable | Specifies the FRS configuration table. |
| inlog | Specifies the inbound log. |
| outlog | Specifies the outbound log. |
| `<computer>` | Specifies the computer. |
| memory | Specifies the memory usage. |
| threads | Specifies the memory usage. |
| stage | Specifies the memory usage. |
| ds | Lists the NTFRS service's view of the DS. |
| sets | Specifies the active replica sets. |
| version | Specifies the API and NTFRS service versions. |
| poll | Specifies the current polling intervals.<ul><li>`/quickly` - Polls quickly until it retrieves a stable configuration.</li><li>`/quickly=` - Polls quickly every default number of minutes.</li><li>`/quickly=<n>` - Polls quickly every *n* minutes.</li><li>`/slowly` - Polls slowly until it retrieves a stable configuration.</li><li>`/slowly=` - Polls slowly every default number of minutes.</li><li>`/slowly=<n>` - Polls slowly every *n* minutes.</li><li>`/now` - Polls now.</li></ul>|
| /? | Displays help at the command prompt. |

### Examples

To determine the polling interval for file replication, type:

```
C:\Program Files\SupportTools>ntfrsutl poll wrkstn-1
```

To determine the current NTFRS application program interface (API) version, type:

```
C:\Program Files\SupportTools>ntfrsutl version
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
