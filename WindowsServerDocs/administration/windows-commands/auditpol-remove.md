---
title: auditpol remove
description: Reference article for the auditpol remove command, which removes the per-user audit policy for a specified account or all accounts.
ms.topic: reference
ms.assetid: be42ec55-235c-44f7-9abd-ed1cf3f5b1f5
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---
# auditpol remove

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Removes the per-user audit policy for a specified account or all accounts.

To perform *remove* operations on the *per-user* policy, you must have **Write** or **Full Control** permissions for that object set in the security descriptor. You can also perform *remove* operations if you have the **Manage auditing and security log** (SeSecurityPrivilege) user right. However, this right allows additional access that is not necessary to perform the overall *remove* operations.

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

To remove the per-user audit policy for user mikedan by name, type:

```
auditpol /remove /user:mikedan
```

To remove the per-user audit policy for user mikedan by SID, type:

```
auditpol /remove /user:{S-1-5-21-397123471-12346959}
```

To remove the per-user audit policy for all users, type:

```
auditpol /remove /allusers
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [auditpol commands](auditpol.md)
