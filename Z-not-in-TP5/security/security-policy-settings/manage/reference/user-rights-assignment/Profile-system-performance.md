---
title: Profile system performance
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0e2a1769-d38a-4fb5-a580-428654343499
---
# Profile system performance
This security policy reference topic for the IT professional describes the best practices, location, values, policy management, and security considerations for this policy setting.  
  
## Reference  
This security setting determines which users can use Windows performance monitoring tools to monitor the performance of system processes.  
  
This policy setting is supported on versions of Windows that are designated in the **Applies To** list at the beginning of this topic.  
  
Constant: SeSystemProfilePrivilege  
  
### Possible values  
  
-   User-defined list of accounts  
  
-   Administrators  
  
-   Not defined  
  
### Best practices  
  
1.  Ensure that only the local Administrators group is assigned the **Profile system performance** user right.  
  
### Location  
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\User Rights Assignment  
  
### Default values  
By default this setting is Administrators on domain controllers and on stand-alone servers.  
  
The following table lists the actual and effective default policy values for the most recent supported versions of Windows. Default values are also listed on the policy’s property page.  
  
|Server type or GPO|Default value|  
|----------------------|-----------------|  
|Default Domain Policy|Not defined|  
|Default Domain Controller Policy|Administrators|  
|Stand-Alone Server Default Settings|Administrators|  
|Domain Controller Effective Default Settings|Administrators|  
|Member Server Effective Default Settings|Administrators|  
|Client Computer Effective Default Settings|Administrators|  
  
### Operating system version differences  
There are no differences in the way this policy setting works between the supported versions of Windows that are designated in the **Applies To** list at the beginning of this topic.  
  
## Policy management  
This section describes features, tools, and guidance to help you manage this policy.  
  
A restart of the computer is not required for this policy setting to be effective.  
  
Any change to the user rights assignment for an account becomes effective the next time the owner of the account logs on.  
  
Depending on your version of Windows and your environment, you might need to add this user right to the Local System account or the Local Service account if you encounter access errors when you use the Administrators account.  
  
### Group Policy  
Settings are applied in the following order through a Group Policy Object (GPO), which will overwrite settings on the local computer at the next Group Policy update:  
  
1.  Local policy settings  
  
2.  Site policy settings  
  
3.  Domain policy settings  
  
4.  OU policy settings  
  
When a local setting is greyed out, it indicates that a GPO currently controls that setting.  
  
## Security considerations  
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.  
  
### Vulnerability  
The **Profile system performance** user right poses a moderate vulnerability. Attackers with this user right could monitor a computer's performance to help identify critical processes that they might want to attack directly. Attackers might also be able to determine what processes are active on the computer so that they could identify countermeasures to avoid, such as antivirus software or an intrusion detection system.  
  
### Countermeasure  
Ensure that only the local Administrators group is assigned the **Profile system performance** user right.  
  
### Potential impact  
None. Restricting the **Profile system performance** user right to the local Administrators group is the default configuration.  
  
## See Also  
[User Rights Assignment](User-Rights-Assignment.md)  
  

