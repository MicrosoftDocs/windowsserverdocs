---
title: auditpol
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a02cfb9d-732f-4e77-aeba-f18265daa3af
---
# auditpol
Displays information about and performs functions to manipulate audit policies.  
  
for examples of how this command can be used, see the Examples section in each topic.  
  
## Syntax  
  
```  
auditpol command [<sub-command><options>]  
```  
  
## Parameters  
  
|Sub\-command|Description|  
|----------------|---------------|  
|\/get|Displays the current audit policy.<br /><br />See [auditpol get]() for syntax and options.|  
|\/set|Sets the audit policy.<br /><br />See [auditpol set]() for syntax and options.|  
|\/list|Displays selectable policy elements.<br /><br />See [auditpol list]() for syntax and options.|  
|\/backup|Saves the audit policy to a file.<br /><br />See [auditpol backup]() for syntax and options.|  
|\/restore|Restores the audit policy from a file that was previously created by using auditpol \/backup.<br /><br />See [auditpol restore]() for syntax and options.|  
|\/clear|Clears the audit policy.<br /><br />See [auditpol clear]() for syntax and options.|  
|\/remove|removes all per\-user audit policy settings and disables all system audit policy settings.<br /><br />See [auditpol remove]() for syntax and options.|  
|\/resourceSACL|Configures global resource system access control lists \(SAcls\). **Note:** Applies only to  Windows 7  and  Windows Server 2008 R2 .<br /><br />See [auditpol resourceSACL]().|  
|\/?|Displays help at the command prompt.|  
  
## remarks  
The audit policy command\-line tool can be used to:  
  
-   Set and query a system audit policy.  
  
-   Set and query a per\-user audit policy.  
  
-   Set and query auditing options.  
  
-   Set and query the security descriptor used to delegate access to an audit policy.  
  
-   Report or back up an audit policy to a comma\-separated value \(CSV\) text file.  
  
-   Load an audit policy from a CSV text file.  
  
-   Configure global resource SAcls.  
  
#### additional references  
[Command-Line Syntax Key](commandline-syntax-key.md)  
  

