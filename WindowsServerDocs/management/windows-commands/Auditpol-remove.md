---
title: Auditpol remove
description: "Windows Commands topic for **Auditpol remove** - Removes the per-user audit policy for a specified account or all accounts."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: be42ec55-235c-44f7-9abd-ed1cf3f5b1f5
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Auditpol remove

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Removes the per-user audit policy for a specified account or all accounts.

## Syntax
```
Auditpol /remove [/user[:<username>|<{SID}>]]
[/allusers]
```
## Parameters
|Parameter|Description|
|-------|--------|
|/user|Specifies the security identifier (SID) or user name for the user for whom the per-user audit policy is to be deleted.|
|/allusers|Removes the per-user audit policy for all users.|
|/?|Displays help at the command prompt.|
## Remarks
For remove operations for the per-user policy, you must have Write or Full Control permission on that object set in the security descriptor. You can also perform remove operations by possessing the **Manage auditing and security log** (SeSecurityPrivilege) user right. However, this right allows additional access that is not necessary to perform the remove operation.
## <a name="BKMK_examples"></a>Examples
To remove the per-user audit policy for user mikedan by name, type:
```
Auditpol /remove /user:mikedan
```
To remove the per-user audit policy for user mikedan by SID, type:
```
Auditpol /remove /user:{S-1-5-21-397123471-12346959}
```
To remove the per-user audit policy for all users, type:
```
Auditpol /remove /allusers
```
#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
