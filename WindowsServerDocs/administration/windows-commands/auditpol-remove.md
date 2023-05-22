---
title: auditpol remove
description: Reference article for the auditpol remove command; auditpol removes the per-user audit policy for a specified account or all accounts.
ms.topic: reference
author: JasonGerend
ms.author: jgerend
ms.date: 04/01/2023
---
# auditpol remove

Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

The auditpol remove command removes the per-user audit policy for a specified account or all accounts.

To perform *remove* operations on the *per-user* policy, you must have **Write** or **Full Control** permissions for that object set in the security descriptor. You can also perform *remove* operations if you have the **Manage auditing and security log** (`SeSecurityPrivilege`) user right. However, this right allows access that isn't necessary to perform the overall *remove* operations.

## Syntax

```
auditpol /remove [/user[:<username>|<{SID}>]]
[/allusers]
```

### Parameters

| Parameter | Description |
| ------- | -------- |
| /user | Specifies the security identifier (SID) or user name for the user for whom the per-user audit policy is to be deleted. |
| /allusers | Removes the per-user audit policy for all users. |
| /? | Displays help at the command prompt. |

## Examples

To remove the per-user audit policy for user `mikedan` by name, type:

```
auditpol /remove /user:mikedan
```

To remove the per-user audit policy for user `mikedan` by SID, type:

```
auditpol /remove /user:{S-1-5-21-397123471-12346959}
```

To remove the per-user audit policy for all users, type:

```
auditpol /remove /allusers
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [auditpol commands](auditpol.md)
