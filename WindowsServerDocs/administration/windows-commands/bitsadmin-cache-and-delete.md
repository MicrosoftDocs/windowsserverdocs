---
title: bitsadmin cache and delete
description: Reference article for the bitsadmin cache and delete command, which deletes a specific cache entry.
ms.topic: reference
ms.assetid: 22540273-55a5-46ea-869b-6df2aa6808a1
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin cache and delete

Deletes a specific cache entry.

## Syntax

```
bitsadmin /cache /delete recordID
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| recordID | The GUID associated with the cache entry. |

## Examples

To delete the cache entry with the RecordID of {6511FB02-E195-40A2-B595-E8E2F8F47702}:

```
bitsadmin /cache /delete {6511FB02-E195-40A2-B595-E8E2F8F47702}
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin cache command](bitsadmin-cache.md)
