---
title: Allow log on locally
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b73acb60-0dc8-4c71-85b5-1906892eee19
---
# Allow log on locally
This security policy reference topic for the IT professional describes the best practices, location, values, policy management, and security considerations for this policy setting.  
  
## Reference  
This policy setting determines which users can start an interactive session on the computer. Users must have this user right to log on over a Remote Desktop Services or Terminal Services session that is running on a Windows\-based member computer or domain controller.  
  
> [!NOTE]  
> Users who do not have this right are still able to start a remote interactive session on the computer if they have the **Allow logon through Remote Desktop Services** right.  
  
This policy setting is supported on versions of Windows that are designated in the **Applies To** list at the beginning of this topic.  
  
Constant: SeInteractiveLogonRight  
  
### Possible values  
  
-   User\-defined list of accounts  
  
-   Not Defined  
  
By default, the members of the following groups have this right on workstations and servers:  
  
-   Administrators  
  
-   Backup Operators  
  
-   Users  
  
By default, the members of the following groups have this right on domain controllers:  
  
-   Account Operators  
  
-   Administrators  
  
-   Backup Operators  
  
-   Print Operators  
  
-   Server Operators  
  
### Best practices  
  
1.  Restrict this user right to legitimate users who must log on to the console of the computer.  
  
2.  If you selectively remove default groups, you can limit the abilities of users who are assigned to specific administrative roles in your organization.  
  
### Location  
*GPO\_name*\\Computer Configuration\\Windows Settings\\Security Settings\\Local Policies\\User Rights Assignment  
  
### Default values  
The following table lists the actual and effective default policy values for the most recent supported versions of Windows. Default values are also listed on the policy’s property page.  
  
|Server type or GPO|Default value|  
|----------------------|-----------------|  
|Default Domain Policy|Not Defined|  
|Default Domain Controller Policy|Account Operators<br /><br />Administrators<br /><br />Backup Operators<br /><br />Print Operators<br /><br />Server Operators|  
|Stand\-Alone Server Default Settings|Administrators<br /><br />Backup Operators<br /><br />Users|  
|Domain Controller Effective Default Settings|Account Operators<br /><br />Administrators<br /><br />Backup Operators<br /><br />Print Operators<br /><br />Server Operators|  
|Member Server Effective Default Settings|Administrators<br /><br />Backup Operators<br /><br />Users|  
|Client Computer Effective Default Settings|Administrators<br /><br />Backup Operators<br /><br />Users|  
  
### Operating system version differences  
There are no differences in the way this policy setting works between the supported on versions of Windows that are designated in the **Applies To** list at the beginning of this topic. Remote Desktop Services was formerly known as Terminal Services.  
  
## Policy management  
Restarting the computer is not required to implement this change.  
  
Any change to the user rights assignment for an account becomes effective the next time the owner of the account logs on.  
  
Modifying this setting might affect compatibility with clients, services, and applications. Use caution when removing service accounts that are used by components and by programs on member computers and on domain controllers in the domain from the default domain controller's policy. Also use caution when removing users or security groups that log on to the console of member computers in the domain, or removing service accounts that are defined in the local Security Accounts Manager \(SAM\) database of member computers or of workgroup computers.  
  
If you want to grant a user account the ability to log on locally to a domain controller, you must make that user a member of a group that already has the **Allowed logon locally** system right or grant the right to that user account.  
  
The domain controllers in the domain share the Default Domain Controllers Group Policy Object \(GPO\). When you grant an account the **Allow logon locally** right, you are allowing that account to log on locally to all domain controllers in the domain.  
  
If the Users group is listed in the **Allow log on locally** setting for a GPO, all domain users can log on locally. The Users built\-in group contains Domain Users as a member.  
  
### Group Policy  
Group Policy settings are applied through GPOs in the following order, which will overwrite settings on the local computer at the next Group Policy update:  
  
1.  Local policy settings  
  
2.  Site policy settings  
  
3.  Domain policy settings  
  
4.  OU policy settings  
  
## Security considerations  
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.  
  
### Vulnerability  
Any account with the **Allow log on locally** user right can log on to the console of the computer. If you do not restrict this user right to legitimate users who must log on to the console of the computer, unauthorized users could download and run malicious software to elevate their privileges.  
  
### Countermeasure  
For domain controllers, assign the **Allow log on locally** user right only to the Administrators group. For other server roles, you may choose to add Backup Operators in addition to Administrators. For end\-user computers, you should also assign this right to the Users group.  
  
Alternatively, you can assign groups such as Account Operators, Server Operators, and Guests to the **Deny log on locally** user right.  
  
### Potential impact  
If you remove these default groups, you could limit the abilities of users who are assigned to specific administrative roles in your environment. If you have installed optional components such as ASP.NET or IIS, you may need to assign the **Allow log on locally** user right to additional accounts that are required by those components. IIS requires that this user right be assigned to the IUSR\_*<ComputerName>* account. You should confirm that delegated activities are not adversely affected by any changes that you make to the **Allow log on locally** user rights assignments.  
  
## See Also  
[User Rights Assignment](User-Rights-Assignment.md)  
  

