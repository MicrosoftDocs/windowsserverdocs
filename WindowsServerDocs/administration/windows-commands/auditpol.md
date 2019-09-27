---
title: auditpol
description: "Windows Commands topic for **auditpol** - Displays information about and performs functions to manipulate audit policies."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a02cfb9d-732f-4e77-aeba-f18265daa3af
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# auditpol



Displays information about and performs functions to manipulate audit policies.

For examples of how this command can be used, see the Examples section in each topic.

## Syntax

```
Auditpol command [<sub-command><options>]
```

## Parameters

|Sub-command|Description|
|-----------|-----------|
|/get|Displays the current audit policy.</br>See [Auditpol get](auditpol-get.md) for syntax and options.|
|/set|Sets the audit policy.</br>See [Auditpol set](auditpol-set.md) for syntax and options.|
|/list|Displays selectable policy elements.</br>See [Auditpol list](auditpol-list.md) for syntax and options.|
|/backup|Saves the audit policy to a file.</br>See [Auditpol backup](auditpol-backup.md) for syntax and options.|
|/restore|Restores the audit policy from a file that was previously created by using auditpol /backup.</br>See [Auditpol restore](auditpol-restore.md) for syntax and options.|
|/clear|Clears the audit policy.</br>See [Auditpol clear](auditpol-clear.md) for syntax and options.|
|/remove|Removes all per-user audit policy settings and disables all system audit policy settings.</br>See [Auditpol remove](auditpol-remove.md) for syntax and options.|
|/resourceSACL|Configures global resource system access control lists (SACLs).</br>Note: Applies only to Windows 7 and Windows Server 2008 R2.</br>See [Auditpol resourceSACL](auditpol-resourcesacl.md).|
|/?|Displays help at the command prompt.|

## Remarks

The audit policy command-line tool can be used to:
-   Set and query a system audit policy.
-   Set and query a per-user audit policy.
-   Set and query auditing options.
-   Set and query the security descriptor used to delegate access to an audit policy.
-   Report or back up an audit policy to a comma-separated value (CSV) text file.
-   Load an audit policy from a CSV text file.
-   Configure global resource SACLs.

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)