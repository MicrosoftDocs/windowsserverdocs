---
title: auditpol set
description: "Windows Commands topic for **auditpol set** - 
Sets the per-user audit policy, system audit policy, or auditing options."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f4947486-87bd-48cb-ba81-7230c8e70895
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# auditpol set

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Sets the per-user audit policy, system audit policy, or auditing options.

## Syntax
```
auditpol /set
[/user[:<username>|<{sid}>][/include][/exclude]]
[/category:<name>|<{guid}>[,:<name|<{guid}> ]]
[/success:<enable>|<disable>][/failure:<enable>|<disable>]
[/subcategory:<name>|<{guid}>[,:<name|<{guid}> ]]
[/success:<enable>|<disable>][/failure:<enable>|<disable>]
[/option:<option name> /value: <enable>|<disable>]
```
## Parameters

|  Parameter   |                                                                                                                                          Description                                                                                                                                           |
|--------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|    /user     |                                        The security principal for whom the per-user audit policy specified by the category or subcategory is set. Either the category or subcategory option must be specified, as a security identifier (SID) or name.                                         |
|   /include   | Specified with /user; indicates that the user's per-user policy will cause an audit to be generated even if it is not specified by the system audit policy. This setting is the default and is automatically applied if neither the /include nor /exclude parameters are explicitly specified. |
|   /exclude   |                                Specified with /user; indicates that the user's per-user policy will cause an audit to be suppressed regardless of the system audit policy. This setting is ignored for users who are members of the local Administrators group.                                |
|  /category   |                                                                            One or more audit categories specified by globally unique identifier (GUID) or name. If no user is specified, the system policy is set.                                                                             |
| /subcategory |                                                                                         One or more audit subcategories specified by GUID or name. If no user is specified, the system policy is set.                                                                                          |
|   /success   |                 Specifies success auditing. This setting is the default and is automatically applied if neither the /success nor /failure parameters are explicitly specified. This setting must be used with a parameter indicating whether to enable or disable the setting.                 |
|   /failure   |                                                                                  Specifies failure auditing. This setting must be used with a parameter indicating whether to enable or disable the setting.                                                                                   |
|   /option    |                                                                                   Sets the audit policy for the CrashOnAuditFail, FullprivilegeAuditing, AuditBaseObjects, or AuditBasedirectories options.                                                                                    |
|     /sd      |                 Sets the security descriptor used to delegate access to the audit policy. The security descriptor must be specified by using the Security Descriptor Definition Language (SDDL). The security descriptor must have a discretionary access control list (DACL).                 |
|      /?      |                                                                                                                              Displays help at the command prompt.                                                                                                                              |

## Remarks
for all set operations for the per-user policy and system policy, you must have Write or Full Control permission on that object set in the security descriptor. You can also perform set operations by possessing the **Manage auditing and security log** (SeSecurityPrivilege) user right. However, this right allows additional access that is not necessary to perform the set operation.
## <a name="BKMK_examples"></a>Examples
### Examples for the per-user audit policy
To set the per-user audit policy for all subcategories under the detailed Tracking category for the user mikedan so that all the user's successful attempts will be audited, type:
```
auditpol /set /user:mikedan /category:"detailed Tracking" /include /success:enable
```
To set the per-user audit policy for categories specified by name and GUID, and subcategories specified by GUID to suppress auditing for any successful or failed attempts, type:
```
auditpol /set /user:mikedan /exclude /category:"Object Access","System",{6997984b-797a-11d9-bed3-505054503030} 
/subcategory:{0ccee9210-69ae-11d9-bed3-505054503030},:{0ccee9211-69ae-11d9-bed3-505054503030}, /success:enable /failure:enable
```
To set the per-user audit policy for the specified user for all the categories for the suppression of auditing of all but successful attempts, type:
```
auditpol /set /user:mikedan /exclude /category:* /success:enable
```
### Examples for the system audit policy
To set the system audit policy for all subcategories under the detailed Tracking category to include auditing for only successful attempts, type:
```
auditpol /set /category:"detailed Tracking" /success:enable
```
> [!NOTE]
> The failure setting is not altered.
> To set the system audit policy for the Object Access and System categories (which is implied because subcategories are listed) and subcategories specified by GUIDs for the suppression of failed attempts and the auditing of successful attempts, type:
> ```
> auditpol /set /subcategory:{0ccee9210-69ae-11d9-bed3-505054503030},{0ccee9211-69ae-11d9-bed3-505054503030}, /failure:disable /success:enable
> ```
> ### Example for auditing options
> To set the auditing options to the enabled state for the CrashOnAuditFail option, type:
> ```
> auditpol /set /option:CrashOnAuditFail /value:enable
> ```
> #### additional references
> [Command-Line Syntax Key](command-line-syntax-key.md)
