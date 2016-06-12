---
title: Create global objects
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 99da7a91-5a18-4e5f-9dba-ce0e3c2e25a2
---
# Create global objects
This security policy reference topic for the IT professional describes the best practices, location, values, policy management, and security considerations for this policy setting.  
  
## Reference  
This policy setting determines which users can create global objects that are available to all sessions. Users can still create objects that are specific to their own session if they do not have this user right.  
  
A global object is an object that is created to be used by any number of processes or threads, even those not started within the user’s session. Remote Desktop Services uses global objects in its processes to facilitate connections and access.  
  
This policy setting is supported on versions of Windows that are designated in the **Applies To** list at the beginning of this topic.  
  
Constant: SeCreateGlobalPrivilege  
  
### Possible values  
  
-   User\-defined list of accounts  
  
-   Default accounts listed below  
  
### Best practices  
  
1.  Do not assign any user accounts this right.  
  
### Location  
*GPO\_name*\\Computer Configuration\\Windows Settings\\Security SettingsLocal Policies\\User Rights Assignment  
  
### Default values  
By default, members of the Administrators group have this right, as do Local Service and Network Service accounts on the supported versions of Windows. Service is included for backwards compatibility with earlier versions of Windows.  
  
The following table lists the actual and effective default policy values for the most recent supported versions of Windows. Default values are also listed on the policy’s property page.  
  
|Server type or GPO|Default value|  
|----------------------|-----------------|  
|Default Domain Policy|Not Defined|  
|Default Domain Controller Policy|Administrators<br /><br />Local Service<br /><br />Network Service<br /><br />Service|  
|Stand\-Alone Server Default Settings|Administrators<br /><br />Local Service<br /><br />Network Service<br /><br />Service|  
|Domain Controller Effective Default Settings|Administrators<br /><br />Local Service<br /><br />Network Service<br /><br />Service|  
|Member Server Effective Default Settings|Administrators<br /><br />Local Service<br /><br />Network Service<br /><br />Service|  
|Client Computer Effective Default Settings|Administrators<br /><br />Local Service<br /><br />Network Service<br /><br />Service|  
  
### Operating system version differences  
Prior to Windows Server 2008 and Windows Vista, the default values of this security policy setting included Administrators, Service, and Local System. There are no differences in the way this policy setting works between the supported versions of Windows that are designated in the **Applies To** list at the beginning of this topic.  
  
## Policy management  
A restart of the computer is not required for this policy setting to take effect.  
  
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
  
The operating system examines a user's access token to determine the level of the user's privileges. Access tokens are built when users log on to the local computer or connect to a remote computer over a network. When you revoke a privilege, the change is immediately recorded, but the change is not reflected in the user's access token until the next time the user logs on or connects. Users with the ability to create or modify tokens can change the level of access for any currently logged on account. They could escalate their privileges or create a denial\-of\-service \(DoS\) condition.  
  
### Countermeasure  
Do not assign the **Create a token object** user right to any users. Processes that require this user right should use the Local System account, which already includes it, instead of a separate user account with this user right assigned.  
  
### Potential impact  
None. Not Defined is the default domain policy configuration.  
  
## See Also  
[User Rights Assignment](user-rights-assignment.md)  
  

