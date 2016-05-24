---
title: Audit Directory Service Changes
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 58edb26b-8442-4684-b015-c105d15e9aa1
---
# Audit Directory Service Changes
This topic for the IT professional describes the Advanced Security Audit policy setting, **Audit Directory Service Changes**, which determines whether the operating system generates audit events when changes are made to objects in Active Directory Domain Services \(AD DS\).  
  
The types of changes that are reported are:  
  
-   Create  
  
-   Delete  
  
-   Modify  
  
-   Move  
  
-   Undelete  
  
Directory Service Changes auditing, where appropriate, indicates the old and new values of the changed properties of the objects that were changed.  
  
> [!IMPORTANT]  
> Audit events are generated only for objects with configured system access control lists \(SACLs\), and only when they are accessed in a manner that matches their SACL settings. Some objects and properties do not cause audit events to be generated due to settings on the object class in the schema.  
  
This subcategory only logs events on domain controllers. Changes to Active Directory objects are important events to track in order to understand the state of the network policy.  
  
Event volume: High on domain controllers; none on client computers  
  
Default: Not configured  
  
If this policy setting is configured, the following events appear on computers running the supported versions of the Windows operating system as designated in the **Applies To** list at the beginning of this topic, in addition to Windows Server 2008.  
  
|Event ID|Event message|  
|------------|-----------------|  
|5136|A directory service object was modified.|  
|5137|A directory service object was created.|  
|5138|A directory service object was undeleted.|  
|5139|A directory service object was moved.|  
|5141|A directory service object was deleted.|  
  
## Related resource  
[Advanced Security Audit Policy Settings](../Topic/Advanced-Security-Audit-Policy-Settings.md)  
  
