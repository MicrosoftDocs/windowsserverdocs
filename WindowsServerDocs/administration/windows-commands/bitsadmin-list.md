---
title: bitsadmin list
description: Reference article for the bitsadmin list command, which lists the transfer jobs owned by the current user.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
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
