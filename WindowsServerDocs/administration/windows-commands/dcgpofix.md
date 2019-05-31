---
title: dcgpofix
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 81d5fa65-2aea-49d3-b353-357441846c00
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# dcgpofix



Recreates the default Group Policy Objects (GPOs) for a domain. For examples of how this command can be used, see [Examples](#BKMK_Examples).

## Syntax

```
DCGPOFix [/ignoreschema] [/target: {Domain | DC | Both}] [/?]
```

### Parameters

|    Parameter    |                                                                                                 Description                                                                                                 |
|-----------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|  /ignoreschema  | Ignores the version of the Active Directory® schema mc</br>when you run this command. Otherwise, the command only works on the same schema version as the Windows version in which the command was shipped. |
| /target {Domain |                                                                                                     DC                                                                                                      |
|       /?        |                                                                                    Displays Help at the command prompt.                                                                                     |

## Remarks

-   The **dcgpofix** command is available in Windows Server 2008 R2 and Windows Server 2008, except on Server Core installations.
-   Although the Group Policy Management Console (GPMC) is distributed with Windows Server 2008 R2 and Windows Server 2008, you must install Group Policy Management as a feature through Server Manager.

## <a name="BKMK_Examples"></a>Examples

Restore the Default Domain Policy GPO to its original state. You will lose any changes that you have made to this GPO. As a best practice, you should configure the Default Domain Policy GPO only to manage the default Account Policies settings, Password Policy, Account Lockout Policy, and Kerberos Policy. In this example, you ignore the version of the Active Directory schema so that the **dcgpofix** command is not limited to same schema as the Windows version in which the command was shipped.
```
dcgpofix /ignoreschema /target:Domain
```
Restore the Default Domain Controllers Policy GPO to its original state. You will lose any changes that you have made to this GPO. As a best practice, you should configure the Default Domain Controllers Policy GPO only to set user rights and audit policies. In this example, you ignore the version of the Active Directory schema so that the **dcgpofix** command is not limited to same schema as the Windows version in which the command was shipped.
```
dcgpofix /ignoreschema /target:DC
```

#### Additional references

-   [Group Policy TechCenter](https://go.microsoft.com/fwlink/?LinkID=145531)
-   [Command-Line Syntax Key](command-line-syntax-key.md)