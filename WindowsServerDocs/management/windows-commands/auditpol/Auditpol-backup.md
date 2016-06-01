---
title: Auditpol backup
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: dc84e581-aa0f-4c91-b13b-1d970bad5517
---
# Auditpol backup
Backs up system audit policy settings, per\-user audit policy settings for all users, and all auditing options to a comma\-separated value \(CSV\) text file.

For examples of how this command can be used, see [Examples](#BKMK_examples).

## Syntax

```
Auditpol /backup /file:<filename>
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|\/file|Specifies the name of the file to which the audit policy will be backed up.|
|\/?|Displays help at the command prompt.|

## Remarks
For backup operations for the per\-user policy and system policy, you must have Write or Full Control permission on that object set in the security descriptor. You can also perform backup operations by possessing the **Manage auditing and security log** \(SeSecurityPrivilege\) user right. However, this right allows additional access that is not necessary to perform the list operation.

## <a name="BKMK_examples"></a>Examples
To back up per\-user audit policy settings for all users, system audit policy settings, and all auditing options into a CSV\-formatted text file named auditpolicy.csv, type:

```
Auditpol /backup /file:C\auditpolicy.csv 
```

> [!NOTE]
> If no drive is specified, the current directory is used.

#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)

[Auditpol restore](Auditpol-restore.md)


