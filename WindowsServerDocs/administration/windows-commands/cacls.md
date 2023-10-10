---
title: cacls
description: Reference article for the cacls command. This command has been deprecated and isn't guaranteed to be supported in future releases of Windows.
ms.topic: reference
ms.assetid: b5bdbaaa-4557-48b8-80df-e75ee0d2f27d
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# cacls

>[!IMPORTANT]
> This command has been deprecated. Please use [icacls](icacls.md) instead.

Displays or modifies discretionary access control lists (DACL) on specified files.

## Syntax

```
cacls <filename> [/t] [/m] [/l] [/s[:sddl]] [/e] [/c] [/g user:<perm>] [/r user [...]] [/p user:<perm> [...]] [/d user [...]]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<filename>` | Required. Displays ACLs of specified files. |
| /t | Changes ACLs of specified files in the current directory and all subdirectories. |
| /m | Changes ACLs of volumes mounted to a directory. |
| /l | Works on the Symbolic Link itself instead of the target. |
| /s:sddl | Replaces the ACLs with those specified in the SDDL string. This parameter is not valid for use with the **/e**, **/g**, **/r**, **/p**, or **/d** parameters. |
| /e | Edit an ACL instead of replacing it. |
| /c | Continue after access denied errors. |
| `/g user:<perm>` | Grants specified user access rights, including these valid values for permission:<ul><li>**n** - None</li><li>**r** - Read</li><li>**w** - Write</li><li>**c** - Change (write)</li><li>**f** - Full control</li></ul> |
| /r user [...] | Revoke specified user's access rights. Only valid when used with the **/e** parameter. |
| `[/p user:<perm> [...]` | Replace specified user's access rights, including these valid values for permission:<ul><li>**n** - None</li><li>**r** - Read</li><li>**w** - Write</li><li>**c** - Change (write)</li><li>**f** - Full control</li></ul> |
| [/d user [...] | Deny specified user access. |
| /? | Displays help at the command prompt. |

#### Sample output

| Output | Access control entry (ACE) applies to |
-------- | ------------------------------------- |
| OI | Object inherit. This folder and files. |
| CI | Container inherit. This folder and subfolders. |
| IO | Inherit only. The ACE does not apply to the current file/directory. |
| No output message | This folder only. |
| (OI)(CI) | This folder, subfolders, and files. |
| (OI)(CI)(IO) | Subfolders and files only. |
| (CI)(IO) | Subfolders only. |
| (OI)(IO) | Files only. |

#### Remarks

- You can use wildcards (**?** and **&#42;**) to specify multiple files.

- You can specify more than one user.

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [icacls](icacls.md)
