---
title: bitsadmin reset
description: Reference article for the bitsadmin reset command, which cancels all jobs in the transfer queue owned by the current user.
ms.topic: reference
ms.assetid: 0e4f9d1d-072c-493f-8d7a-f6d713c3ef29
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin reset

Cancels all jobs in the transfer queue owned by the current user. You can't reset jobs created by Local System. Instead, you must be an administrator and use the task scheduler to schedule this command as a task using the Local System credentials.

> [!NOTE]
> If you have administrator privileges in BITSAdmin 1.5 and earlier, the /reset switch will cancel all the jobs in the queue. Additionally, the /allusers option isn't supported.

## Syntax

```
bitsadmin /reset [/allusers]
```

### Parameters

| Parameter | Description |
| -------------- | -------------- |
| /allusers | Optional. Cancels all jobs in the queue owned by the current user. You must have administrator privileges to use this parameter. |

## Examples

To cancel all the jobs in the transfer queue for the current user.

```
bitsadmin /reset
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
