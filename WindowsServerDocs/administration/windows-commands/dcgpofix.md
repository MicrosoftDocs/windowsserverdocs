---
title: dcgpofix
description: Reference article for the dcgpofix command, which recreates the default Group Policy Objects (GPOs) for a domain.
ms.topic: reference
ms.assetid: 81d5fa65-2aea-49d3-b353-357441846c00
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# dcgpofix

Recreates the default Group Policy Objects (GPOs) for a domain. To get to the Group Policy Management Console (GPMC), you must install Group Policy Management as a feature through Server Manager.

>[!IMPORTANT]
> As a best practice, you should configure the Default Domain Policy GPO only to manage the default **Account Policies** settings, Password Policy, Account Lockout Policy, and Kerberos Policy. Additionally, you should configure the Default Domain Controllers Policy GPO only to set user rights and audit policies.

## Syntax

```
dcgpofix [/ignoreschema] [/target: {domain | dc | both}] [/?]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| /ignoreschema | Ignores the version of the Active Directory schema when you run this command. Otherwise, the command only works on the same schema version as the Windows version in which the command was shipped. |
| `/target {domain | dc | both` | Specifies whether to target the Default Domain policy, the Default Domain Controllers policy, or both types of policies. |
| /? | Displays Help at the command prompt. |

## Examples

To manage the default **Account Policies** settings, Password Policy, Account Lockout Policy, and Kerberos Policy, while ignoring the Active Directory schema version, type:

```
dcgpofix /ignoreschema /target:domain
```

To configure the Default Domain Controllers Policy GPO only to set user rights and audit policies, while ignoring the Active Directory schema version, type:

```
dcgpofix /ignoreschema /target:dc
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)