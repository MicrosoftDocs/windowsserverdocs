---
title: Audit Process Creation
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 570cccb6-e2fa-41a2-84cc-ba3334901fd5
---
# Audit Process Creation
This topic for the IT professional describes the Advanced Security Audit policy setting, **Audit Process Creation**, which determines whether the operating system generates audit events when a process is created \(starts\).  
  
These audit events can help you track user activity and understand how a computer is being used. Information includes the name of the program or the user that created the process.  
  
Event volume: Low to medium, depending on system usage  
  
Default: Not configured  
  
If this policy setting is configured, the following events appear on computers running the supported versions of the Windows operating system as designated in the **Applies To** list at the beginning of this topic, in addition to Windows Server 2008 and Windows Vista.  
  
|Event ID|Event message|  
|------------|-----------------|  
|4688|A new process has been created.|  
|4696|A primary token was assigned to a process.|  
  
## Related resource  
[Advanced Security Audit Policy Settings](../Topic/Advanced-Security-Audit-Policy-Settings.md)  
  
