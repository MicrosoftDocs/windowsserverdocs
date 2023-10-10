---
title: auditpol backup
description: Reference article for the auditpol backup command that backs up system audit policy settings, per-user audit policy settings for all users, and all auditing options to a comma-separated value (CSV) text file.
ms.topic: reference
author: JasonGerend
ms.author: jgerend
ms.date: 04/01/2023
---
# auditpol backup

Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

The auditpol backup command backs up system audit policy settings, per-user audit policy settings for all users, and all auditing options to a comma-separated value (CSV) text file.

To perform *backup* operations on the *per-user* and *system* policies, you need **Write** or **Full Control** permissions for that object set in the security descriptor. You can also perform *backup* operations if you have the **Manage auditing and security log** (SeSecurityPrivilege) user right. However, this right allows access that isn't necessary to perform the overall *backup* operations.

## Syntax

```
auditpol /backup /file:<filename>
```

### Parameters

| Parameter | Description |
|-----------|------------- |
| /file | Specifies the file name of the for the back up. |
| /? | Displays help at the command prompt. |

## Examples

You can back up the following settings to a CSV-formatted text file:

- Per-user audit policy settings for all users
- System audit policy settings
- All auditing options

To back up these settings to a file named auditpolicy.csv, type the following command:

```
auditpol /backup /file:C:\auditpolicy.csv
```

> [!NOTE]
> If no drive is specified, the current directory is used.

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [auditpol restore](auditpol-restore.md)

- [auditpol commands](auditpol.md)
