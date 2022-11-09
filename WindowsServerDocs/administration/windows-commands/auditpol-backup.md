---
title: auditpol backup
description: Reference article for the auditpol backup command, which backs up system audit policy settings, per-user audit policy settings for all users, and all auditing options to a comma-separated value (CSV) text file.
ms.topic: reference
ms.assetid: dc84e581-aa0f-4c91-b13b-1d970bad5517
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---
# auditpol backup

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Backs up system audit policy settings, per-user audit policy settings for all users, and all auditing options to a comma-separated value (CSV) text file.

To perform *backup* operations on the *per-user* and *system* policies, you must have **Write** or **Full Control** permission for that object set in the security descriptor. You can also perform *backup* operations if you have the **Manage auditing and security log** (SeSecurityPrivilege) user right. However, this right allows additional access that is not necessary to perform the overall *backup* operations.

## Syntax

```
auditpol /backup /file:<filename>
```

### Parameters

| Parameter | Description |
|-----------|------------- |
| /file | Specifies the name of the file to which the audit policy will be backed up. |
| /? | Displays help at the command prompt. |

## Examples

To back up per-user audit policy settings for all users, system audit policy settings, and all auditing options into a CSV-formatted text file named auditpolicy.csv, type:

```
auditpol /backup /file:C:\auditpolicy.csv
```

> [!NOTE]
> If no drive is specified, the current directory is used.

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [auditpol restore](auditpol-restore.md)

- [auditpol commands](auditpol.md)
