---
title: auditpol restore
description: Reference article for the auditpol restore command, which restores system audit policy settings, per-user audit policy settings for all users, and all auditing options from a file that is syntactically consistent with the comma-separated value (CSV) file format used by the /backup option.
ms.topic: reference
ms.assetid: ad73e520-484f-4cf1-a7f9-ae7488e9edf6
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---
# auditpol restore

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Restores system audit policy settings, per-user audit policy settings for all users, and all auditing options from a file that is syntactically consistent with the comma-separated value (CSV) file format used by the /backup option.

To perform *restore* operations on the *per-user* and *system* policies, you must have **Write** or **Full Control** permission for that object set in the security descriptor. You can also perform *restore* operations if you have the **Manage auditing and security log** (SeSecurityPrivilege) user right, which is useful when restoring the security descriptor in the event of an error or malicious attack.

## Syntax

```
auditpol /restore /file:<filename>
```

### Parameters

| Parameter | Description |
| ------- | -------- |
| /file | Specifies the file from which the audit policy should be restored. The file must have been created by using the /backup option or must be syntactically consistent with the CSV file format used by the /backup option. |
| /? |Displays help at the command prompt. |

## Examples

To restore system audit policy settings, per-user audit policy settings for all users, and all auditing options from a file named auditpolicy.csv that was created by using the /backup command, type:

```
auditpol /restore /file:c:\auditpolicy.csv
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [auditpol backup](auditpol-backup.md)

- [auditpol commands](auditpol.md)
