---
title: bitsadmin cache and info
description: Reference article for the bitsadmin cache and info command, which dumps a specific cache entry.
ms.topic: reference
ms.assetid: 15975cbf-dba6-49ca-a725-d15ce1952de5
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin cache and info

Dumps a specific cache entry.

## Syntax

```
bitsadmin /cache /info recordID [/verbose]
```

### Parameters

| Paramreter | Description |
| -------------- | -------------- |
| recordID | The GUID associated with the cache entry. |

## Examples

To dump the cache entry with the recordID value of {6511FB02-E195-40A2-B595-E8E2F8F47702}:

```
bitsadmin /cache /info {6511FB02-E195-40A2-B595-E8E2F8F47702}
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin cache command](bitsadmin-cache.md)
