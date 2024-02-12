---
title: auditpol list
description: Reference article for the auditpol list command, which lists audit policy categories and subcategories, or lists users for whom a per-user audit policy is defined.
ms.topic: reference
ms.assetid: 45502abe-3d6e-4e13-94f0-8e6fcb6db860
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---
# auditpol list

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Lists audit policy categories and subcategories, or lists users for whom a per-user audit policy is defined.

To perform *list* operations on the *per-user* policy, you must have **Read** permission for that object set in the security descriptor. You can also perform *list* operations if you have the **Manage auditing and security log** (SeSecurityPrivilege) user right. However, this right allows additional access that is not necessary to perform the overall *list* operations.

## Syntax

```
auditpol /list
[/user|/category|subcategory[:<categoryname>|<{guid}>|*]]
[/v] [/r]
```

### Parameters

| Parameter | Description |
| ------- | -------- |
| /user | Retrieves all users for whom the per-user audit policy has been defined. If used with the /v parameter, the security identifier (SID) of the user is also displayed. |
| /category | Displays the names of categories understood by the system. If used with the /v parameter, the category globally unique identifier (GUID) is also displayed. |
| /subcategory | Displays the names of subcategories and their associated GUID. |
| /v | Displays the GUID with the category or subcategory, or when used with /user, displays the SID of each user. |
| /r | Displays the output as a report in comma-separated value (CSV) format. |
| /? | Displays help at the command prompt. |

## Examples

To list all users who have a defined audit policy, type:

```
auditpol /list /user
```

To list all users who have a defined audit policy and their associated SID, type:

```
auditpol /list /user /v
```

To list all categories and subcategories in report format, type:

```
auditpol /list /subcategory:* /r
```

To list the subcategories of the detailed Tracking and DS Access categories, type:

```
auditpol /list /subcategory:detailed Tracking,DS Access
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [auditpol commands](auditpol.md)
