---
title: Deny access to this computer from the network
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-policy-settings
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 215c296b-cf02-4554-9244-5c0962300340
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Deny access to this computer from the network

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This security policy reference topic for the IT professional describes the best practices, location, values, policy management, and security considerations for this policy setting.  
  
## Reference  
This security setting determines which users are prevented from accessing a computer over the network.  
  
This policy setting is supported on versions of Windows that are designated in the **Applies To** list at the beginning of this topic.  
  
Constant: SeDenyNetworkLogonRight  
  
### Possible values  
  
-   User-defined list of accounts  
  
-   Guest  
  
### Best practices  
  
1.  Because all Active Directory Domain Services programs use a network logon for access, use caution when you assign this user right on domain controllers.  
  
### Location  
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\User Rights Assignment  
  
### Default values  
By default, this setting is Guest on domain controllers and on stand-alone servers.  
  
The following table lists the actual and effective default policy values for the most recent supported versions of Windows. Default values are also listed on the policy’s property page.  
  
|Server type or GPO|Default value|  
|----------------------|-----------------|  
|Default Domain Policy|Not defined|  
|Default Domain Controller Policy|Guest|  
|Stand-Alone Server Default Settings|Guest|  
|Domain Controller Effective Default Settings|Guest|  
|Member Server Effective Default Settings|Guest|  
|Client Computer Effective Default Settings|Guest|  
  
### Operating system version differences  
There are no differences in the way this policy setting works between the supported versions of Windows that are designated in the **Applies To** list at the beginning of this topic.  
  
## Policy management  
This section describes features and tools available to help you manage this policy.  
  
A restart of the computer is not required for this policy setting to be effective.  
  
This policy setting supersedes the **Access this computer from the network** policy setting if a user account is subject to both policies.  
  
Any change to the user rights assignment for an account becomes effective the next time the owner of the account logs on.  
  
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
Users who can log on to the computer over the network can enumerate lists of account names, group names, and shared resources. Users with permission to access shared folders and files can connect over the network and possibly view or modify data.  
  
### Countermeasure  
Assign the **Deny access to this computer from the network** user right to the following accounts:  
  
-   Anonymous logon  
  
-   Built-in local Administrator account  
  
-   Local Guest account  
  
-   All service accounts  
  
An important exception to this list is any service accounts that are used to start services that must connect to the computer over the network. For example, let’s say you have configured a shared folder for web servers to access, and you present content within that folder through a website. You may need to allow the account that runs IIS to log on to the server with the shared folder from the network. This user right is particularly effective when you must configure servers and workstations on which sensitive information is handled because of regulatory compliance concerns.  
  
### Potential impact  
If you configure the **Deny access to this computer from the network** user right for other accounts, you could limit the abilities of users who are assigned to specific administrative roles in your environment. You should verify that delegated tasks are not negatively affected.  
  
## See Also  
[User Rights Assignment](User-Rights-Assignment.md)  
  

