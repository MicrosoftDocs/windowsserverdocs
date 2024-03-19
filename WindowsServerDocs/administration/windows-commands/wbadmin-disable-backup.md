---
title: wbadmin disable backup
description: Reference article for the wbadmin disable backup command, which stops running the existing scheduled daily backups.
ms.topic: reference
ms.assetid: 5176cbd9-0696-4b3f-9c35-272dd84f7898
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wbadmin disable backup

Stops running the existing scheduled daily backups.

To disable a scheduled daily backup using this command, you must be a member of the **Administrators** group, or you must have been delegated the appropriate permissions. In addition, you must run **wbadmin** from an elevated command prompt, by right-clicking **Command Prompt**, and then selecting **Run as administrator**.

## Syntax

```
wbadmin disable backup [-quiet]
```

### Parameters

| Parameter | Description |
|--|--|
| -quiet | Runs the command without prompts to the user. |

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [wbadmin command](wbadmin.md)

- [wbadmin enable backup command](wbadmin-enable-backup.md)