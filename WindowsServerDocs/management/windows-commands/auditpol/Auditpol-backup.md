---
title: auditpol backup
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: dc84e581-aa0f-4c91-b13b-1d970bad5517
---
# auditpol backup
Backs up system audit policy settings, per\-user audit policy settings for all users, and all auditing options to a comma\-separated value \(CSV\) text file.

for examples of how this command can be used, see [Examples](#BKMK_examples).

## Syntax

```
auditpol /backup /file:<filename>
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|\/file|Specifies the name of the file to which the audit policy will be backed up.|
|\/?|Displays help at the command prompt.|

## remarks
for backup operations for the per\-user policy and system policy, you must have Write or Full Control permission on that object set in the security descriptor. You can also perform backup operations by possessing the **manage auditing and security log** \(SeSecurityPrivilege\) user right. However, this right allows additional access that is not necessary to perform the list operation.

## <a name="BKMK_examples"></a>Examples
To back up per\-user audit policy settings for all users, system audit policy settings, and all auditing options into a CSV\-formatted text file named auditpolicy.csv, type:

```
auditpol /backup /file:C\auditpolicy.csv 
```

> [!NOTE]
> if no drive is specified, the current directory is used.

#### additional references
[Command-Line Syntax Key](../commandline-syntax-key.md)

[auditpol restore](auditpol-restore.md)


