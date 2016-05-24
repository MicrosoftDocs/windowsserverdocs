---
title: Audit Kernel Object
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 13ffa070-cb57-4de9-a97e-5900d9a35099
---
# Audit Kernel Object
This topic for the IT professional describes the Advanced Security Audit policy setting, **Audit Kernel Object**, which determines whether the operating system generates audit events when users attempt to access the system kernel, which includes mutexes and semaphores.  
  
Only kernel objects with a matching system access control list \(SACL\) generate security audit events. The audits generated are usually useful only to developers.  
  
Typically, kernel objects are given SACLs only if the **AuditBaseObjects** or **AuditBaseDirectories** auditing options are enabled.  
  
> [!NOTE]  
> The **Audit: Audit the access of global system objects** policy setting controls the default SACL of kernel objects.  
  
Event volume: High if you have enabled one of the Global Object Access Auditing settings  
  
Default setting: Not configured  
  
If this policy setting is configured, the following events appear on computers running the supported versions of the Windows operating system as designated in the **Applies to** list at the beginning of this topic, in addition to Windows Server 2008 and Windows Vista.  
  
|Event ID|Event message|  
|------------|-----------------|  
|4659|A handle to an object was requested with intent to delete.|  
|4660|An object was deleted.|  
|4661|A handle to an object was requested.|  
|4663|An attempt was made to access an object.|  
  
## Related resource  
[Advanced Security Audit Policy Settings](../Topic/Advanced-Security-Audit-Policy-Settings.md)  
  
