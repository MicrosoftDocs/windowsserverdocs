---
title: Audit Detailed File Share
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9f296f91-d236-4afd-bbed-1d0de2ca3393
---
# Audit Detailed File Share
This topic for the IT professional describes the Advanced Security Audit policy setting, **Audit Detailed File Share**, which allows you to audit attempts to access files and folders on a shared folder.  
  
The Detailed File Share setting logs an event every time a file or folder is accessed, whereas the File Share setting only records one event for any connection established between a client computer and file share. Detailed File Share audit events include detailed information about the permissions or other criteria used to grant or deny access.  
  
> [!NOTE]  
> There are no system access control lists \(SACLs\) for shared folders. If this policy setting is enabled, access to all shared files and folders on the system is audited.  
  
Event volume: High on a file server or domain controller because of SYSVOL network access required by Group Policy  
  
Default: Not configured  
  
If this policy setting is configured, the following event appears on computers running the supported versions of the Windows operating system as designated in the **Applies to** list at the beginning of this topic, in addition to Windows Server 2008 and Windows Vista.  
  
|Event ID|Event message|  
|------------|-----------------|  
|5145|A network share object was checked to see whether the client can be granted desired access.|  
  
## See Also  
[Advanced Security Audit Policy Settings](../Topic/Advanced-Security-Audit-Policy-Settings.md)  
  
