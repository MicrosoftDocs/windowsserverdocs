---
title: Audit Filtering Platform Policy Change
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 470e2f66-75d6-4276-ba3a-51d25a7512b7
---
# Audit Filtering Platform Policy Change
This topic for the IT professional describes the Advanced Security Audit policy setting, **Audit Filtering Platform Policy Change**, which determines whether the operating system generates audit events for certain IPsec and Windows Filtering Platform actions.  
  
Windows Filtering Platform \(WFP\) enables independent software vendors \(ISVs\) to filter and modify TCP\/IP packets, monitor or authorize connections, filter Internet Protocol security \(IPsec\)\-protected traffic, and filter remote procedure calls \(RPCs\).  
  
This security policy setting determines whether the operating system generates audit events for:  
  
-   IPsec services status.  
  
-   Changes to IPsec settings.  
  
-   Status and changes to the Windows Filtering Platform engine and providers.  
  
-   IPsec Policy Agent service activities.  
  
Event volume: Low  
  
Default: Not configured  
  
If this policy setting is configured, the following events appear on computers running the supported versions of the Windows operating system as designated in the **Applies to** list at the beginning of this topic, in addition to Windows Server 2008 and Windows Vista.  
  
|Event ID|Event message|  
|------------|-----------------|  
|4709|IPsec Services was started.|  
|4710|IPsec Services was disabled.|  
|4711|May contain any one of the following:<br /><br />-   PAStore Engine applied locally cached copy of Active Directory storage IPsec policy on the computer.<br />-   PAStore Engine applied Active Directory storage IPsec policy on the computer.<br />-   PAStore Engine applied local registry storage IPsec policy on the computer.<br />-   PAStore Engine failed to apply locally cached copy of Active Directory storage IPsec policy on the computer.<br />-   PAStore Engine failed to apply Active Directory storage IPsec policy on the computer.<br />-   PAStore Engine failed to apply local registry storage IPsec policy on the computer.<br />-   PAStore Engine failed to apply some rules of the active IPsec policy on the computer.<br />-   PAStore Engine failed to load directory storage IPsec policy on the computer.<br />-   PAStore Engine loaded directory storage IPsec policy on the computer.<br />-   PAStore Engine failed to load local storage IPsec policy on the computer.<br />-   PAStore Engine loaded local storage IPsec policy on the computer.<br />-   PAStore Engine polled for changes to the active IPsec policy and detected no changes.|  
|4712|IPsec Services encountered a potentially serious failure.|  
|5040|A change has been made to IPsec settings. An Authentication Set was added.|  
|5041|A change has been made to IPsec settings. An Authentication Set was modified.|  
|5042|A change has been made to IPsec settings. An Authentication Set was deleted.|  
|5043|A change has been made to IPsec settings. A Connection Security Rule was added.|  
|5044|A change has been made to IPsec settings. A Connection Security Rule was modified.|  
|5045|A change has been made to IPsec settings. A Connection Security Rule was deleted.|  
|5046|A change has been made to IPsec settings. A Crypto Set was added.|  
|5047|A change has been made to IPsec settings. A Crypto Set was modified.|  
|5048|A change has been made to IPsec settings. A Crypto Set was deleted.|  
|5440|The following callout was present when the Windows Filtering Platform Base Filtering Engine started.|  
|5441|The following filter was present when the Windows Filtering Platform Base Filtering Engine started.|  
|5442|The following provider was present when the Windows Filtering Platform Base Filtering Engine started.|  
|5443|The following provider context was present when the Windows Filtering Platform Base Filtering Engine started.|  
|5444|The following sub\-layer was present when the Windows Filtering Platform Base Filtering Engine started.|  
|5446|A Windows Filtering Platform callout has been changed.|  
|5448|A Windows Filtering Platform provider has been changed.|  
|5449|A Windows Filtering Platform provider context has been changed.|  
|5450|A Windows Filtering Platform sub\-layer has been changed.|  
|5456|PAStore Engine applied Active Directory storage IPsec policy on the computer.|  
|5457|PAStore Engine failed to apply Active Directory storage IPsec policy on the computer.|  
|5458|PAStore Engine applied locally cached copy of Active Directory storage IPsec policy on the computer.|  
|5459|PAStore Engine failed to apply locally cached copy of Active Directory storage IPsec policy on the computer.|  
|5460|PAStore Engine applied local registry storage IPsec policy on the computer.|  
|5461|PAStore Engine failed to apply local registry storage IPsec policy on the computer.|  
|5462|PAStore Engine failed to apply some rules of the active IPsec policy on the computer. Use the IP Security Monitor snap\-in to diagnose the problem.|  
|5463|PAStore Engine polled for changes to the active IPsec policy and detected no changes.|  
|5464|PAStore Engine polled for changes to the active IPsec policy, detected changes, and applied them to IPsec Services.|  
|5465|PAStore Engine received a control for forced reloading of IPsec policy and processed the control successfully.|  
|5466|PAStore Engine polled for changes to the Active Directory IPsec policy, determined that Active Directory cannot be reached, and will use the cached copy of the Active Directory IPsec policy instead. Any changes made to the Active Directory IPsec policy since the last poll could not be applied.|  
|5467|PAStore Engine polled for changes to the Active Directory IPsec policy, determined that Active Directory can be reached, and found no changes to the policy. The cached copy of the Active Directory IPsec policy is no longer being used.|  
|5468|PAStore Engine polled for changes to the Active Directory IPsec policy, determined that Active Directory can be reached, found changes to the policy, and applied those changes. The cached copy of the Active Directory IPsec policy is no longer being used.|  
|5471|PAStore Engine loaded local storage IPsec policy on the computer.|  
|5472|PAStore Engine failed to load local storage IPsec policy on the computer.|  
|5473|PAStore Engine loaded directory storage IPsec policy on the computer.|  
|5474|PAStore Engine failed to load directory storage IPsec policy on the computer.|  
|5477|PAStore Engine failed to add quick mode filter.|  
  
## Related resource  
[Advanced Security Audit Policy Settings](../Topic/Advanced-Security-Audit-Policy-Settings.md)  
  
