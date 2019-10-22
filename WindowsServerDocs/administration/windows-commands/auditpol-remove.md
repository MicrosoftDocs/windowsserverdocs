---
title: auditpol remove
description: "Windows Commands topic for **auditpol remove** - removes the per-user audit policy for a specified account or all accounts."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: be42ec55-235c-44f7-9abd-ed1cf3f5b1f5
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# auditpol remove

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

removes the per-user audit policy for a specified account or all accounts.

## Syntax
```
auditpol /remove [/user[:<username>|<{SID}>]]
[/allusers]
```
## Parameters
|Parameter|Description|
|-------|--------|
|/user|Specifies the security identifier (SID) or user name for the user for whom the per-user audit policy is to be deleted.|
|/allusers|removes the per-user audit policy for all users.|
|/?|Displays help at the command prompt.|
## Remarks
for remove operations for the per-user policy, you must have Write or Full Control permission on that object set in the security descriptor. You can also perform remove operations by possessing the **Manage auditing and security log** (SeSecurityPrivilege) user right. However, this right allows additional access that is not necessary to perform the remove operation.
## <a name="BKMK_examples"></a>Examples
To remove the per-user audit policy for user mikedan by name, type:
```
auditpol /remove /user:mikedan
```
To remove the per-user audit policy for user mikedan by SID, type:
```
auditpol /remove /user:{S-1-5-21-397123471-12346959}
```
To remove the per-user audit policy for all users, type:
```
auditpol /remove /allusers
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
