---
title: Enable Strict Replication Consistency
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: fd89082d-1f41-4807-8211-2507b3cf14ea
author: Femila
---
# Enable Strict Replication Consistency
  You can use this procedure to ensure that strict replication consistency is enabled in the forest. This setting prohibits replication of outdated Active Directory objects. If you disconnect a domain controller from the replication topology for an extended period and then reconnect it, this setting ensures that no outdated objects are reintroduced into Active Directory Domain Services \(AD DS\).  
  
 To determine whether strict replication consistency is enabled, use the **regedit** command to view the registry on a domain controller. The setting for replication consistency is stored in the registry in the **Strict Replication Consistency** entry in **HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\NTDS\\Parameters**.  
  
 Values for this entry are as follows:  
  
-   Value: **1** \(**0** to disable\)  
  
-   Default: **1** \(enabled\) in a new Windows Server 2003 or Windows Server 2008 forest; otherwise **0**.  
  
-   Data type: **REG\_DWORD**  
  
 If the value is **0**, use the following procedure to change the value to **1** on a specific domain controller or on all domain controllers.  
  
 Membership in the **Domain Admins** group in the domain, or equivalent, is the minimum required to complete this procedure on a single domain controller.   
Membership in the **Enterprise Admins** group in the forest, or equivalent, is the minimum required to complete this procedure on all domain controllers. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To enable strict replication consistency  
  
1.  Open a command prompt, type the following command, and then press ENTER:  
  
     `repadmin /regkey <DC_LIST> {+|-}<key>`  
  
    |Value|Description|  
    |-----------|-----------------|  
    |**repadmin \/regkey**|Enables and disables the values for the following two registry entries under **HKEY\_LOCAL\_MACHINE\\SYSTEM\\Current Control Set\\Services\\NTDS\\Parameters**:<br /><br /> -   **Strict replication consistency**<br />-   **Allow replication with divergent and corrupt partner**|  
    |\<DC\_LIST\>|The name of a single domain controller. Or, use **\*** to apply the change to all domain controllers in the forest. For the domain controller name, you can use the Domain Name System \(DNS\) name, the distinguished name of the domain controller computer object, or the distinguished name of the domain controller server object.|  
    |{\+&#124;\-}\<key\>|**\+** to enable and **\-** to disable, and *key* is strict. For example, **\+strict** enables strict replication consistency; **\-strict** disables it.|  
  
2.  Repeat step 1 for every domain controller on which you want to enable strict replication consistency.  
  
> [!NOTE]  
>  For more naming options and information about the syntax of the `<DC_LIST>` parameter, at the command prompt, type `repadmin /listhelp`.  
  
  