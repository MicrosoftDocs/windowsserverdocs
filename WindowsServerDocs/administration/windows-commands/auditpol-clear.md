---
title: auditpol clear
description: Reference article for the auditpol clear command, which deletes the per-user audit policy for all users, resets (disables) the system audit policy for all subcategories, and sets all the auditing options to disabled.
ms.topic: reference
ms.assetid: 05bfa218-2434-4ad1-b33c-e6fcfb2b4f67
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---
# auditpol clear

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Deletes the per-user audit policy for all users, resets (disables) the system audit policy for all subcategories, and sets all the auditing options to disabled.

To perform *clear* operations on the *per-user* and *system* policies, you must have **Write** or **Full Control** permission for that object set in the security descriptor. You can also perform *clear* operations if you have the **Manage auditing and security log** (SeSecurityPrivilege) user right. However, this right allows additional access that is not necessary to perform the overall *clear* operations.

## Syntax

```
auditpol /clear [/y]
```

### Parameters

| Parameter | Description |
| ----------- | --------------- |
| /y | Suppresses the prompt to confirm if all audit policy settings should be cleared. |
| /? | Displays help at the command prompt. |

## Examples

To delete the per-user audit policy for all users, reset (disable) the system audit policy for all subcategories, and set all the audit policy settings to disabled, at a confirmation prompt, type:

```
auditpol /clear
```

To delete the per-user audit policy for all users, reset the system audit policy settings for all subcategories, and set all the audit policy settings to disabled, without a confirmation prompt, type:

```
auditpol /clear /y
```

> [!NOTE]
> The preceding example is useful when using a script to perform this operation.

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [auditpol commands](auditpol.md)
