---
title: Auditpol
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a02cfb9d-732f-4e77-aeba-f18265daa3af
---
# Auditpol
Displays information about and performs functions to manipulate audit policies.  
  
For examples of how this command can be used, see the Examples section in each topic.  
  
## Syntax  
  
```  
Auditpol command [<sub-command><options>]  
```  
  
## Parameters  
  
|Sub\-command|Description|  
|----------------|---------------|  
|\/get|Displays the current audit policy.<br /><br />See [Auditpol get](../Topic/Auditpol-get.md) for syntax and options.|  
|\/set|Sets the audit policy.<br /><br />See [Auditpol set](../Topic/Auditpol-set.md) for syntax and options.|  
|\/list|Displays selectable policy elements.<br /><br />See [Auditpol list](../Topic/Auditpol-list.md) for syntax and options.|  
|\/backup|Saves the audit policy to a file.<br /><br />See [Auditpol backup](../Topic/Auditpol-backup.md) for syntax and options.|  
|\/restore|Restores the audit policy from a file that was previously created by using auditpol \/backup.<br /><br />See [Auditpol restore](../Topic/Auditpol-restore.md) for syntax and options.|  
|\/clear|Clears the audit policy.<br /><br />See [Auditpol clear](../Topic/Auditpol-clear.md) for syntax and options.|  
|\/remove|Removes all per\-user audit policy settings and disables all system audit policy settings.<br /><br />See [Auditpol remove](../Topic/Auditpol-remove.md) for syntax and options.|  
|\/resourceSACL|Configures global resource system access control lists \(SACLs\). **Note:** Applies only to [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].<br /><br />See [Auditpol resourceSACL](../Topic/Auditpol-resourceSACL.md).|  
|\/?|Displays help at the command prompt.|  
  
## Remarks  
The audit policy command\-line tool can be used to:  
  
-   Set and query a system audit policy.  
  
-   Set and query a per\-user audit policy.  
  
-   Set and query auditing options.  
  
-   Set and query the security descriptor used to delegate access to an audit policy.  
  
-   Report or back up an audit policy to a comma\-separated value \(CSV\) text file.  
  
-   Load an audit policy from a CSV text file.  
  
-   Configure global resource SACLs.  
  
#### Additional references  
[Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
