---
title: Deny log on as a service
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8c30c92a-592f-4562-a12f-c42749135bff
---
# Deny log on as a service
This security policy reference topic for the IT professional describes the best practices, location, values, policy management, and security considerations for this policy setting.  
  
## Reference  
This policy setting determines which users are prevented from logging on to the service applications on a computer.  
  
A service is an application type that runs in the system background without a user interface. It provides core operating system features, such as web serving, event logging, file serving, printing, cryptography, and error reporting.  
  
This policy setting is supported on versions of Windows that are designated in the **Applies To** list at the beginning of this topic.  
  
Constant: SeDenyServiceLogonRight  
  
### Possible values  
  
-   User-defined list of accounts  
  
-   Not defined  
  
### Best practices  
  
1.  When you assign this user right, thoroughly test that the effect is what you intended.  
  
2.  Within a domain, modify this setting on the applicable Group Policy Object (GPO).  
  
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
  
## Policy management  
This section describes features and tools available to help you manage this policy.  
  
A restart of the computer is not required for this policy setting to be effective.  
  
Any change to the user rights assignment for an account becomes effective the next time the owner of the account logs on.  
  
For information about configuring a service, see [Configure How a Service Is Started](http://technet.microsoft.com/library/cc755249.aspx).  
  
### Group Policy  
On a domain-joined computer, including the domain controller, this policy can be overwritten by a domain policy, which will prevent you from modifying the local policy setting.  
  
This policy setting might conflict with and negate the **Log on as a service** setting.  
  
Settings are applied in the following order through a Group Policy Object (GPO), which will overwrite settings on the local computer at the next Group Policy update:  
  
1.  Local policy settings  
  
2.  Site policy settings  
  
3.  Domain policy settings  
  
4.  OU policy settings  
  
When a local setting is greyed out, it indicates that a GPO currently controls that setting.  
  
## Security considerations  
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.  
  
### Vulnerability  
Accounts that can log on to a service application could be used to configure and start new unauthorized services, such as a keylogger or other malicious software. The benefit of the specified countermeasure is somewhat reduced by the fact that only users with administrative rights can install and configure services, and an attacker who has already attained that level of access could configure the service to run by using the System account.  
  
### Countermeasure  
We recommend that you not assign the **Deny log on as a service** user right to any accounts. This is the default configuration. Organizations that are extremely concerned about security might assign this user right to groups and accounts when they are certain that they will never need to log on to a service application.  
  
### Potential impact  
If you assign the **Deny log on as a service** user right to specific accounts, services may not start and a denial-of-service condition could result.  
  
## See Also  
[User Rights Assignment](User-Rights-Assignment.md)  
  

