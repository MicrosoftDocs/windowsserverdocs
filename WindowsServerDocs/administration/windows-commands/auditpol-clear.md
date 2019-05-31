---
title: auditpol clear
description: "Windows Commands topic for **auditpol clear** - deletes the per-user audit policy for all users, resets (disables) the system audit policy for all subcategories, and sets all the auditing options to disabled."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 05bfa218-2434-4ad1-b33c-e6fcfb2b4f67
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# auditpol clear

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

deletes the per-user audit policy for all users, resets (disables) the system audit policy for all subcategories, and sets all the auditing options to disabled.

## Syntax
```
auditpol /clear [/y]
```
## Parameters

| Parameter |                                   Description                                    |
|-----------|----------------------------------------------------------------------------------|
|    /y     | Suppresses the prompt to confirm if all audit policy settings should be cleared. |
|    /?     |                       Displays help at the command prompt.                       |

## Remarks
for clear operations for the per-user policy and system policy, you must have Write or Full Control permission on that object set in the security descriptor. You can also perform the clear operation by possessing the **Manage auditing and security log** (SeSecurityPrivilege) user right. However, this right allows additional access that is not necessary to perform the clear operation.
## <a name="BKMK_examples"></a>Examples
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
> #### additional references
> [Command-Line Syntax Key](command-line-syntax-key.md)
