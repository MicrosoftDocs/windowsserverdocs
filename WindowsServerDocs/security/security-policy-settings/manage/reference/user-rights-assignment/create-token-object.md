---
title: Create a token object
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 14cc4310-4aa8-4458-9805-27cac8b3fb94
---
# Create a token object
This security policy reference topic for the IT professional describes the best practices, location, values, policy management, and security considerations for this policy setting.  
  
## Reference  
This policy setting determines which accounts a process can use to create a token, and which accounts it can then use to gain access to local resources when the process uses NtCreateToken\(\) or other token\-creation APIs.  
  
When a user logs on to the local computer or connects to a remote computer through a network, Windows builds the user’s access token. Then the system examines the token to determine the level of the user's privileges. When you revoke a privilege, the change is immediately recorded, but the change is not reflected in the user's access token until the next time the user logs on or connects.  
  
This policy setting is supported on versions of Windows that are designated in the **Applies To** list at the beginning of this topic.  
  
Constant: SeCreateTokenPrivilege  
  
### Possible values  
  
-   User\-defined list of accounts  
  
-   Not Defined  
  
### Best practices  
  
1.  This user right is used internally by the operating system. Unless it is necessary, do not assign this user right to a user, group, or process other than Local System.  
  
### Location  
*GPO\_name*\\Computer Configuration\\Windows Settings\\Security Settings\\Local Policies\\User Rights Assignment  
  
### Default values  
This user right is used internally by the operating system. By default, it is not assigned to any user groups.  
  
The following table lists the actual and effective default policy values for the most recent supported versions of Windows. Default values are also listed on the policy’s property page.  
  
|Server type or GPO|Default value|  
|----------------------|-----------------|  
|Default Domain Policy|Not Defined|  
|Default Domain Controller Policy|Not Defined|  
|Stand\-Alone Server Default Settings|Not Defined|  
|Domain Controller Effective Default Settings|Local System|  
|Member Server Effective Default Settings|Local System|  
|Client Computer Effective Default Settings|Local System|  
  
### Operating system version differences  
There are no differences in the way this policy setting works between the supported versions of Windows that are designated in the **Applies To** list at the beginning of this topic.  
  
## Policy management  
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
  
> [!CAUTION]  
> A user account that is given this user right has complete control over the system, and it can lead to the system being compromised. We highly recommend that you do not assign this right to any user accounts.  
  
The operating system examines a user's access token to determine the level of the user's privileges. Access tokens are built when users log on to the local computer or connect to a remote computer over a network. When you revoke a privilege, the change is immediately recorded, but the change is not reflected in the user's access token until the next time the user logs on or connects. Users with the ability to create or modify tokens can change the level of access for any account on a computer if they are currently logged on. They could escalate their privileges or create a DoS condition.  
  
### Countermeasure  
Do not assign the **Create a token object** user right to any users. Processes that require this user right should use the Local System account, which already includes it, instead of a separate user account that has this user right assigned.  
  
### Potential impact  
None. Not Defined is the default configuration.  
  
## See Also  
[User Rights Assignment](user-rights-assignment.md)  
  

