---
title: auditpol resourceSACL
description: Reference article for the auditpol resourceSACL command, which configures global resource system access control lists (SAcls).
ms.topic: reference
ms.assetid: 28771ba7-967a-45e9-9bf0-b2a2673070f0
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# auditpol resourceSACL

>Applies to: Windows Server 2022, Windows Server 2019, Windows 7 and Windows Server 2008 R2

Configures global resource system access control lists (SACLs).

To perform *resourceSACL* operations, you must have **Write** or **Full Control** permissions for that object set in the security descriptor. You can also perform *resourceSACL* operations if you have the **Manage auditing and security log** (SeSecurityPrivilege) user right.

## Syntax

```
auditpol /resourceSACL
[/set /type:<resource> [/success] [/failure] /user:<user> [/access:<access flags>]]
[/remove /type:<resource> /user:<user> [/type:<resource>]]
[/clear [/type:<resource>]]
[/view [/user:<user>] [/type:<resource>]]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| /set | Adds a new entry to or updates an existing entry in the resource SACL for the resource type specified. |
| /remove | Removes all entries for the given user in the global object access auditing  list. |
| /clear | Removes all entries from the global object access auditing list.|
| /view | Lists the global object access auditing entries in a resource SACL. The user and resource types are optional. |
| /? | Displays help at the command prompt. |

### Arguments

| Argument | Description |
| -------- | ----------- |
| /type | The resource for which object access auditing is being configured. The supported, case-sensitive, argument values are *File* (for directories and files) and *Key* (for registry keys). |
| /success | Specifies success auditing. |
| /failure | Specifies failure auditing. |
| /user | Specifies a user in one of the following forms:<ul><li> DomainName\Account (such as DOM\Administrators)</li><li>StandaloneServer\Group Account (see [LookupAccountName function](/windows/win32/api/winbase/nf-winbase-lookupaccountnamea))</li><li>{S-1-x-x-x-x} (x is expressed in decimal, and the entire SID must be enclosed in curly braces). For example: {S-1-5-21-5624481-130208933-164394174-1001}<p>**Note:** If the SID form is used, no check is done to verify the existence of this account.</li></ul> |
| /access | Specifies a permission mask that can be specified through:<p>Generic access rights, including:<ul><li>GA - GENERIC ALL</li><li>GR - GENERIC READ</li><li>GW - GENERIC WRITE</li><li>GX - GENERIC EXECUTE</li></ul><p>Access rights for files, including:<ul><li>FA - FILE ALL ACCESS</li><li>FR - FILE GENERIC READ</li><li>FW - FILE GENERIC WRITE</li><li>FX - FILE GENERIC EXECUTE</li></ul><p>Access rights for registry keys, including:<ul><li>KA - KEY ALL ACCESS</li><li>KR - KEY READ</li><li>KW - KEY WRITE</li><li>KX - KEY EXECUTE</li></ul><p>For example: `/access:FRFW` enables audit events for read and write operations.<p>A hexadecimal value representing the access mask (such as 0x1200a9)<p>This is useful when using resource-specific bit masks that are not part of the security descriptor definition language (SDDL) standard. If omitted, Full access is used. |

## Examples

To set a global resource SACL to audit successful access attempts by a user on a registry key:

```
auditpol /resourceSACL /set /type:Key /user:MYDOMAIN\myuser /success
```

To set a global resource SACL to audit successful and failed attempts by a user to perform generic read and write functions on files or folders:

```
auditpol /resourceSACL /set /type:File /user:MYDOMAIN\myuser /success /failure /access:FRFW
```

To remove all global resource SACL entries for files or folders:

```
auditpol /resourceSACL /type:File /clear
```

To remove all global resource SACL entries for a particular user from files or folders:

```
auditpol /resourceSACL /remove /type:File /user:{S-1-5-21-56248481-1302087933-1644394174-1001}
```

To list the global object access auditing entries set on files or folders:

```
auditpol /resourceSACL /type:File /view
```

To list the global object access auditing entries for a particular user that are set on files or folders:

```
auditpol /resourceSACL /type:File /view /user:MYDOMAIN\myuser
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [auditpol commands](auditpol.md)
