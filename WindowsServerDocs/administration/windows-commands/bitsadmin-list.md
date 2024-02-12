---
title: bitsadmin list
description: Reference article for the bitsadmin list command, which lists the transfer jobs owned by the current user.
ms.topic: reference
ms.assetid: 1416965e-e0e6-49cf-b1d4-b286d3cf8716
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin list

Lists the transfer jobs owned by the current user.

## Syntax

```
bitsadmin /list [/allusers][/verbose]
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| /allusers | Optional. Lists jobs for all users. You must have administrator privileges to use this parameter. |
| /verbose | Optional. Provides detailed information about each job. |

## Examples

To retrieve information about jobs owned by the current user.

```
bitsadmin /list
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
