---
title: wbadmin stop job
description: Reference article for the wbadmin stop job command, which cancels the backup or recovery operation that is currently running.
ms.topic: reference
ms.assetid: 3b83b398-39c7-4410-bf17-5c1fb1a4f46d
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wbadmin stop job

Cancels the backup or recovery operation that is currently running.

> [!IMPORTANT]
> Canceled operations can't be restarted. You must run a canceled backup or a recovery operation from the beginning again.

To stop a backup or recovery operation using this command, you must be a member of the **Backup Operators** group or the **Administrators** group, or you must have been delegated the appropriate permissions. In addition, you must run **wbadmin** from an elevated command prompt, by right-clicking **Command Prompt**, and then selecting **Run as administrator**.

## Syntax

```
wbadmin stop job [-quiet]
```

### Parameters

| Parameter | Description |
|--|--|
| -quiet | Runs the command without prompts to the user. |

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [wbadmin command](wbadmin.md)
