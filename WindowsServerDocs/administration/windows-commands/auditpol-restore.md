---
title: auditpol restore
description: "Windows Commands topic for **auditpol restore** - 
Restores system audit policy settings, per-user audit policy settings for all users, and all auditing options from a file that is syntactically consistent with the comma-separated value (CSV) file format used by the /backup option."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ad73e520-484f-4cf1-a7f9-ae7488e9edf6
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# auditpol restore

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Restores system audit policy settings, per-user audit policy settings for all users, and all auditing options from a file that is syntactically consistent with the comma-separated value (CSV) file format used by the /backup option.

## Syntax
```
auditpol /restore /file:<filename>
```
## Parameters
|Parameter|Description|
|-------|--------|
|/file|Specifies the file from which the audit policy should be restored. The file must have been created by using the /backup option or must be syntactically consistent with the CSV file format used by the /backup option.|
|/?|Displays help at the command prompt.|
## Remarks
for restore operations for the per-user policy and system policy, you must have Write or Full Control permission on that object set in the security descriptor. You can also perform the restore operation by possessing the **Manage auditing and security log** (SeSecurityPrivilege) user right. SeSecurityPrivilege is useful when restoring the security descriptor in the event of an inadvertent error or malicious attack.
## <a name="BKMK_examples"></a>Examples
To restore system audit policy settings, per-user audit policy settings for all users, and all auditing options from a file named auditpolicy.csv that was created by using the /backup command, type:
```
auditpol /restore /file:c:\auditpolicy.csv
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
[auditpol backup](auditpol-backup.md)
