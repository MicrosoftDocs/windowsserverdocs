---
title: auditpol
description: Reference article for the auditpol command, which displays information about and performs functions to manipulate audit policies.
ms.topic: reference
ms.assetid: a02cfb9d-732f-4e77-aeba-f18265daa3af
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# auditpol

Displays information about and performs functions to manipulate audit policies, including:

- Setting and querying a system audit policy.

- Setting and querying a per-user audit policy.

- Setting and querying auditing options.

- Setting and querying the security descriptor used to delegate access to an audit policy.

- Reporting or backing up an audit policy to a comma-separated value (CSV) text file.

- Loading an audit policy from a CSV text file.

- Configuring global resource SACLs.

## Syntax

```
auditpol command [<sub-command><options>]
```

### Parameters

| Sub-command | Description |
| ----------- | ----------- |
| /get | Displays the current audit policy. For more information, see [auditpol get](auditpol-get.md) for syntax and options. |
| /set | Sets the audit policy. For more information, see [auditpol set](auditpol-set.md) for syntax and options. |
| /list | Displays selectable policy elements. For more information, see [auditpol list](auditpol-list.md) for syntax and options. |
| /backup | Saves the audit policy to a file. For more information, see [auditpol backup](auditpol-backup.md) for syntax and options. |
| /restore | Restores the audit policy from a file that was previously created by using auditpol /backup. For more information, see [auditpol restore](auditpol-restore.md) for syntax and options. |
| /clear | Clears the audit policy. For more information, see [auditpol clear](auditpol-clear.md) for syntax and options. |
| /remove | Removes all per-user audit policy settings and disables all system audit policy settings. For more information, see [auditpol remove](auditpol-remove.md) for syntax and options. |
| /resourceSACL | Configures global resource system access control lists (SACLs). **Note:** Applies only to Windows 7 and Windows Server 2008 R2. For more information, see [auditpol resourceSACL](auditpol-resourcesacl.md). |
| /?| Displays help at the command prompt. |

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
