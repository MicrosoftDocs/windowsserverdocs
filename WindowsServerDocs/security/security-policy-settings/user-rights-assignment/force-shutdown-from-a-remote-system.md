---
title: Force shutdown from a remote system
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-policy-settings
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 20826f77-ffd5-44c4-afc5-b6d38c7583b3
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Force shutdown from a remote system

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This security policy reference topic for the IT professional describes the best practices, location, values, policy management, and security considerations for this policy setting.  
  
## Reference  
This security setting determines which users are allowed to shut down a computer from a remote location on the network. This allows members of the Administrators group or specific users to manage computers (for tasks such as a restart) from a remote location.  
  
This policy setting is supported on versions of Windows that are designated in the **Applies To** list at the beginning of this topic.  
  
Constant: SeRemoteShutdownPrivilege  
  
### Possible values  
  
-   User-defined list of accounts  
  
-   Administrators  
  
### Best practices  
  
1.  Explicitly restrict this user right to members of the Administrators group or other specifically assigned roles that require this capability, such as nonadministrative operations staff.  
  
### Location  
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\User Rights Assignment  
  
### Default values  
By default this setting is Administrators and Server Operators on domain controllers and Administrators on stand-alone servers.  
  
The following table lists the actual and effective default policy values for the most recent supported versions of Windows. Default values are also listed on the policy???s property page.  
  
|Server type or GPO|Default value|  
|-----------|---------|  
|Default Domain Policy|Not defined|  
|Default Domain Controller Policy|Administrators<br /><br />Server Operators|  
|Stand-Alone Server Default Settings|Administrators|  
|Domain Controller Effective Default Settings|Administrators<br /><br />Server Operators|  
|Member Server Effective Default Settings|Administrators|  
|Client Computer Effective Default Settings|Administrators|  
  
### Operating system version differences  
This setting was introduced with Windows Vista and Windows Server 2008. There are no differences in the way this policy setting works between the supported versions of Windows that are designated in the **Applies To** list at the beginning of this topic.  
  
## Policy management  
This section describes features, tools, and guidance to help you manage this policy.  
  
A restart of the computer is not required for this policy setting to be effective.  
  
Any change to the user rights assignment for an account becomes effective the next time the owner of the account logs on.  
  
This policy setting must be applied on the computer that is being accessed remotely.  
  
### Group Policy  
This user right is defined in the Default Domain Controller Group Policy Object (GPO) and in the local security policy of workstations and servers.  
  
Settings are applied in the following order through a Group Policy Object (GPO), which will overwrite settings on the local computer at the next Group Policy update:  
  
1.  Local policy settings  
  
2.  Site policy settings  
  
3.  Domain policy settings  
  
4.  OU policy settings  
  
When a local setting is greyed out, it indicates that a GPO currently controls that setting.  
  
## Security considerations  
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.  
  
### Vulnerability  
Any user who can shut down a computer could cause a denial-of-service condition to occur. Therefore, this user right should be tightly restricted.  
  
### Countermeasure  
Restrict the **Force shutdown from a remote system** user right to members of the Administrators group or other specifically assigned roles that require this capability, such as nonadministrative operations staff.  
  
### Potential impact  
On a domain controller, if you remove the **Force shutdown from a remote system** user right from the Server Operator group, you could limit the abilities of users who are assigned to specific administrative roles in your environment. You should confirm that delegated activities are not adversely affected.  
  
## See Also  
[User Rights Assignment](user-rights-assignment.md)  
  

