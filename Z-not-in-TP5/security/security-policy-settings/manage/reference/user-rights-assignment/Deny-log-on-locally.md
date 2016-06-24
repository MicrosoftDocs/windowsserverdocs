---
title: Deny log on locally
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0f525bb8-7d05-4748-b12e-b7e83763d941
---
# Deny log on locally
This security policy reference topic for the IT professional describes the best practices, location, values, policy management, and security considerations for this policy setting.  
  
## Reference  
This policy setting determines which users are prevented from logging on directly at the computer's console.  
  
This policy setting is supported on versions of Windows that are designated in the **Applies To** list at the beginning of this topic.  
  
Constant: SeDenyInteractiveLogonRight  
  
### Possible values  
  
-   User-defined list of accounts  
  
-   Not defined  
  
### Best practices  
  
1.  Assign the **Deny log on locally** user right to the local guest account to restrict access by potentially unauthorized users.  
  
2.  Test your modifications to this policy setting in conjunction with the **Allow log on locally** policy setting to determine if the user account is subject to both policies.  
  
### Location  
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\User Rights Assignment  
  
### Default values  
The following table lists the actual and effective default policy values for the most recent supported versions of Windows. Default values are also listed on the policy’s property page.  
  
|Server type or GPO|Default value|  
|----------------------|-----------------|  
|Default Domain Policy|Not defined|  
|Default Domain Controller Policy|Not defined|  
|Stand-Alone Server Default Settings|Not defined|  
|Domain Controller Effective Default Settings|Not defined|  
|Member Server Effective Default Settings|Not defined|  
|Client Computer Effective Default Settings|Not defined|  
  
### Operating system version differences  
There are no differences in the way this policy setting works between the supported versions of Windows that are designated in the **Applies To** list at the beginning of this topic.  
  
> [!NOTE]  
> This setting is not compatible with computers running Windows 2000 Server with Service Pack 1 or earlier.  
  
## Policy management  
This section describes features, tools, and guidance to help you manage this policy.  
  
A restart of the computer is not required for this policy setting to be effective.  
  
Any change to the user rights assignment for an account becomes effective the next time the owner of the account logs on.  
  
If you apply this policy setting to the Everyone group, no one will be able to log on locally.  
  
### Group Policy  
This policy setting supersedes the **Allow log on locally** policy setting if a user account is subject to both policies.  
  
Settings are applied in the following order through a Group Policy Object (GPO), which will overwrite settings on the local computer at the next Group Policy update:  
  
1.  Local policy settings  
  
2.  Site policy settings  
  
3.  Domain policy settings  
  
4.  OU policy settings  
  
When a local setting is greyed out, it indicates that a GPO currently controls that setting.  
  
## Security considerations  
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.  
  
### Vulnerability  
Any account with the ability to log on locally could be used to log on at the console of the computer. If this user right is not restricted to legitimate users who must log on to the console of the computer, unauthorized users might download and run malicious software that elevates their user rights.  
  
### Countermeasure  
Assign the **Deny log on locally** user right to the local Guest account. If you have installed optional components such as ASP.NET, you may want to assign this user right to additional accounts that are required by those components.  
  
### Potential impact  
If you assign the **Deny log on locally** user right to additional accounts, you could limit the abilities of users who are assigned to specific roles in your environment. However, this user right should explicitly be assigned to the ASPNET account on computers that are configured with the Web Server role. You should confirm that delegated activities are not adversely affected.  
  
## See Also  
[User Rights Assignment](User-Rights-Assignment.md)  
  

