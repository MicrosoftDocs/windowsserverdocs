---
title: auditpol get
description: Reference article for the auditpol get command, which retrieves the system policy, per-user policy, auditing options, and audit security descriptor object.
ms.topic: reference
ms.assetid: fe13de4e-836c-4207-b47c-64b6272d6c41
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---
# auditpol get

> Applies to: Windows Server (Semi-Annual Channel), Windows Server, 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Retrieves the system policy, per-user policy, auditing options, and audit security descriptor object.

To perform *get* operations on the *per-user* and *system* policies, you must have **Read** permission for that object set in the security descriptor. You can also perform *get* operations if you have the **Manage auditing and security log** (SeSecurityPrivilege) user right. However, this right allows additional access that is not necessary to perform the overall *get* operations.

## Syntax

```
auditpol /get
[/user[:<username>|<{sid}>]]
[/category:*|<name>|<{guid}>[,:<name|<{guid}> ]]
[/subcategory:*|<name>|<{guid}>[,:<name|<{guid}> ]]
[/option:<option name>]
[/sd]
[/r]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| /user | Displays the security principal for whom the per-user audit policy is queried. Either the /category or /subcategory parameter must be specified. The user may be specified as a security identifier (SID) or name. If no user account is specified, then the system audit policy is queried. |
| /category | One or more audit categories specified by globally unique identifier (GUID) or name. An asterisk (*) may be used to indicate that all audit categories should be queried. |
| /subcategory | One or more audit subcategories specified by GUID or name. |
| /sd | Retrieves the security descriptor used to delegate access to the audit policy. |
| /option | Retrieves the existing policy for the CrashOnAuditFail, FullprivilegeAuditing, AuditBaseObjects, or AuditBasedirectories options. |
| /r | Displays the output in report format, comma-separated value (CSV). |
| /? | Displays help at the command prompt. |

### Remarks

All categories and subcategories can be specified by the GUID or name enclosed by quotation marks ("). Users can be specified by SID or name.

## Examples

To retrieve the per-user audit policy for the Guest account and display the output for the System, detailed Tracking, and Object Access categories, type:

```
auditpol /get /user:{S-1-5-21-1443922412-3030960370-963420232-51} /category:System,detailed Tracking,Object Access
```

> [!NOTE]
> This command is useful in two scenarios. 1) When monitoring a specific user account for suspicious activity, you can use the `/get` command to retrieve the results in specific categories by using an inclusion policy to enable additional auditing. 2) if audit settings on an account are logging numerous but superfluous events, you can use the `/get` command to filter out extraneous events for that account with an exclusion policy. For a list of all categories, use the `auditpol /list /category` command.

To retrieve the per-user audit policy for a category and a particular subcategory, which reports the inclusive and exclusive settings for that subcategory under the System category for the Guest account, type:

```
auditpol /get /user:guest /category:System /subcategory:{0ccee921a-69ae-11d9-bed3-505054503030}
```

To display the output in report format and include the computer name, policy target, subcategory, subcategory GUID, inclusion settings, and exclusion settings, type:

```
auditpol /get /user:guest /category:detailed Tracking /r
```

To retrieve the policy for the System category and subcategories, which reports the category and subcategory policy settings for the system audit policy, type:

```
auditpol /get /category:System /subcategory:{0ccee921a-69ae-11d9-bed3-505054503030}
```

To retrieve the policy for the detailed Tracking category and subcategories in report format and include the computer name, policy target, subcategory, subcategory GUID, inclusion settings, and exclusion settings, type:

```
auditpol /get /category:detailed Tracking /r
```

To retrieve the policy for two categories with the categories specified as GUIDs, which reports all the audit policy settings of all the subcategories under two categories, type:

```
auditpol /get /category:{69979849-797a-11d9-bed3-505054503030},{69997984a-797a-11d9-bed3-505054503030} subcategory:{0ccee921a-69ae-11d9-bed3-505054503030}
```

To retrieve the state, either enabled or disabled, of the AuditBaseObjects option, type:

```
auditpol /get /option:AuditBaseObjects
```

Where the available options are AuditBaseObjects, AuditBaseOperations, and FullprivilegeAuditing. To retrieve the state enabled, disabled, or 2 of the CrashOnAuditFail option, type:

```
auditpol /get /option:CrashOnAuditFail /r
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [auditpol commands](auditpol.md)
