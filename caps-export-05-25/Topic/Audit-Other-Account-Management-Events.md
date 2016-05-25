---
title: Audit Other Account Management Events
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a94acae6-29a5-4110-b3bb-ff6e1bc0f75d
---
# Audit Other Account Management Events
This topic for the IT professional describes the Advanced Security Audit policy setting, **Audit Other Account Management Events**, which determines whether the operating system generates user account management audit events.  
  
Events can be generated for user account management auditing when:  
  
-   The password hash of an account is accessed. This typically happens when the Active Directory Migration Tool \(ADMT\) is moving password data.  
  
-   The Password Policy Checking application programming interface \(API\) is called. Calls to this function could be part of an attack from a malicious application that is testing whether password complexity policy settings are being applied.  
  
-   Changes are made to domain policy under **Computer Configuration\\Windows Settings\\Security Settings\\Account Policies\\Password Policy** or **Computer Configuration\\Windows Settings\\Security Settings\\Account Policies\\Account Lockout Policy**.  
  
> [!NOTE]  
> These events are logged when the domain policy is applied \(on refresh or restart\), not when settings are modified by an administrator.  
  
Event volume: Low  
  
Default: Not configured  
  
If this policy setting is configured, the following events appear on computers running the supported versions of the Windows operating system as designated in the **Applies To** list at the beginning of this topic, in addition to Windows Server 2008 and Windows Vista.  
  
|Event ID|Event Message Summary|  
|------------|-------------------------|  
|4782|The password hash for an account was accessed.|  
|4793|The Password Policy Checking API was called.|  
  
## Related resource  
[Advanced Security Audit Policy Settings](../Topic/Advanced-Security-Audit-Policy-Settings.md)  
  
