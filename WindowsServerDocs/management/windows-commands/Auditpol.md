---
title: Auditpol
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - management
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a02cfb9d-732f-4e77-aeba-f18265daa3af

author: coreyp
ms.author: coreyp-at-msft
ms.date: 09/14/2016
---
# Auditpol
Displays information about and performs functions to manipulate audit policies.  
For examples of how this command can be used, see the Examples section in each topic.  
## Syntax  
```  
Auditpol command [<sub-command><options>]  
```  
## Parameters  
|Sub-command|Description|  
|----------------|---------------|  
|/get|Displays the current audit policy.<br /><br />See [Auditpol get](Auditpol-get.md) for syntax and options.|  
|/set|Sets the audit policy.<br /><br />See [Auditpol set](Auditpol-set.md) for syntax and options.|  
|/list|Displays selectable policy elements.<br /><br />See [Auditpol list](Auditpol-list.md) for syntax and options.|  
|/backup|Saves the audit policy to a file.<br /><br />See [Auditpol backup](Auditpol-backup.md) for syntax and options.|  
|/restore|Restores the audit policy from a file that was previously created by using auditpol /backup.<br /><br />See [Auditpol restore](Auditpol-restore.md) for syntax and options.|  
|/clear|Clears the audit policy.<br /><br />See [Auditpol clear](Auditpol-clear.md) for syntax and options.|  
|/remove|Removes all per-user audit policy settings and disables all system audit policy settings.<br /><br />See [Auditpol remove](Auditpol-remove.md) for syntax and options.|  
|/resourceSACL|Configures global resource system access control lists (SACLs). **Note:** Applies only to  Windows 7  and  Windows Server 2008 R2 .<br /><br />See [Auditpol resourceSACL](Auditpol-resourceSACL.md).|  
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
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
