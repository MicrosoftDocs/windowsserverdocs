---
title: Audit Audit Policy Change
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 91c8dd86-118a-4e0f-8cc6-89685a158f06
---
# Audit Audit Policy Change
This topic for the IT professional describes the Advanced Security Audit policy setting, **Audit Audit Policy Change**, which determines whether the operating system generates audit events when changes are made to audit policy.  
  
Changes to audit policy that are audited include:  
  
-   Changing permissions and audit settings on the audit policy object \(by using **auditpol \/set \/sd**\).  
  
-   Changing the system audit policy.  
  
-   Registering and unregistering security event sources.  
  
-   Changing per\-user audit settings.  
  
-   Changing the value of **CrashOnAuditFail**.  
  
-   Changing audit settings on an object \(for example, modifying the system access control list \(SACL\) for a file or registry key\).  
  
    > [!NOTE]  
    > SACL change auditing is performed when a SACL for an object has changed and the Policy Change category is configured. Discretionary access control list \(DACL\) and owner change auditing are performed when Object Access auditing is configured and the object's SACL is set for auditing of the DACL or owner change.  
  
-   Changing anything in the Special Groups list.  
  
> [!IMPORTANT]  
> Changes to the audit policy are critical security events.  
  
Event volume: Low  
  
Default: Success  
  
If this policy setting is configured, the following events appear on computers running the supported versions of the Windows operating system as designated in the **Applies to** list at the beginning of this topic, in addition to Windows Server 2008 and Windows Vista, unless otherwise noted.  
  
|Event ID|Event message|  
|------------|-----------------|  
|4715|The audit policy \(SACL\) on an object was changed.|  
|4719|System audit policy was changed.|  
|4817|Auditing settings on an object were changed. **Note:** This event is logged only on computers running the supported versions of the Windows operating system.|  
|4902|The Per\-user audit policy table was created.|  
|4904|An attempt was made to register a security event source.|  
|4905|An attempt was made to unregister a security event source.|  
|4906|The CrashOnAuditFail value has changed.|  
|4907|Auditing settings on object were changed.|  
|4908|Special Groups Logon table modified.|  
|4912|Per User Audit Policy was changed.|  
  
## Related resource  
[Advanced Security Audit Policy Settings](../Topic/Advanced-Security-Audit-Policy-Settings.md)  
  
