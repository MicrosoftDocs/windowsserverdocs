---
title: Remove computer from docking station
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7b7f0e85-3860-40a4-8119-c36d50270b46
---
# Remove computer from docking station
This security policy reference topic for the IT professional describes the best practices, location, values, policy management, and security considerations for this policy setting.  
  
## Reference  
This security setting determines whether a user can undock a portable computer from its docking station without logging on. This policy setting only affects scenarios that involve a portable computer and its docking station.  
  
If this user right is assigned to the user’s account \(or if the user is a member of the assigned group\), the user must log on before removing the portable computer from its docking station. Otherwise, as a security measure, the user will not be able to log on after the computer is removed from the docking station. If this policy is not assigned, the user may remove the portable computer from its docking station without logging on, and then have the ability to start and log on to the computer afterwards in its undocked state.  
  
This policy setting is supported on versions of Windows that are designated in the **Applies To** list at the beginning of this topic.  
  
Constant: SeUndockPrivilege  
  
### Possible values  
  
-   User\-defined list of accounts  
  
-   Not Defined  
  
### Best practices  
  
1.  Assign this user right to only those accounts that are permitted to use the portable computer.  
  
### Location  
*GPO\_name*\\Computer Configuration\\Windows Settings\\Security Settings\\Local Policies\\User Rights Assignment  
  
### Default values  
Although this portable computer scenario does not normally apply to servers, by default this setting is Administrators on domain controllers and on stand\-alone servers.  
  
The following table lists the actual and effective default policy values for the most recent supported versions of Windows. Default values are also listed on the policy’s property page.  
  
|Server type or GPO|Default value|  
|----------------------|-----------------|  
|Default Domain Policy|Not defined|  
|Default Domain Controller Policy|Administrators|  
|Stand\-Alone Server Default Settings|Administrators|  
|Domain Controller Effective Default Settings|Administrators|  
|Member Server Effective Default Settings|Administrators|  
|Client Computer Effective Default Settings|Administrators|  
  
### Operating system version differences  
There are no differences in the way this policy setting works between the supported versions of Windows that are designated in the **Applies To** list at the beginning of this topic. However, the groups Users and Power Users were added as defaults for backwards compatibility to Windows Vista.  
  
## Policy management  
This section describes features, tools, and guidance to help you manage this policy.  
  
A restart of the computer is not required for this policy setting to be effective.  
  
Any change to the user rights assignment for an account becomes effective the next time the owner of the account logs on.  
  
### Group Policy  
Settings are applied in the following order through a Group Policy Object \(GPO\), which will overwrite settings on the local computer at the next Group Policy update:  
  
1.  Local policy settings  
  
2.  Site policy settings  
  
3.  Domain policy settings  
  
4.  OU policy settings  
  
When a local setting is greyed out, it indicates that a GPO currently controls that setting.  
  
## Security considerations  
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.  
  
### Vulnerability  
Anyone who has the **Remove computer from docking station** user right can log on and then remove a portable computer from its docking station. If this setting is not defined, it has the same effect as if everyone was granted this right. However, the value of implementing this countermeasure is reduced by the following factors:  
  
-   If attackers can restart the computer, they could remove it from the docking station after the BIOS starts but before the operating system starts.  
  
-   This setting does not affect servers because they typically are not installed in docking stations.  
  
-   An attacker could steal the computer and the docking station together.  
  
-   Computers that can be mechanically undocked can be physically removed by the user whether or not they use the Windows undocking functionality.  
  
### Countermeasure  
Ensure that only the local Administrators group and the user account to which the computer is allocated are assigned the **Remove computer from docking station** user right.  
  
### Potential impact  
By default, only members of the local Administrators group are granted this right. Other user accounts must be explicitly granted this user right as necessary. If your organization's users are not members of the local Administrators groups on their portable computers, they cannot remove their portable computers from their docking stations if they do not first shut  down the computer. Therefore, you may want to assign the **Remove computer from docking station** privilege to the local Users group for portable computers.  
  
## See Also  
[User Rights Assignment](User-Rights-Assignment.md)  
  

