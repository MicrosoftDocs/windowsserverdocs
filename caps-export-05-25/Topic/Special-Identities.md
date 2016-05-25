---
title: Special Identities
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2c52050e-61c8-4803-b615-f2756ed36e37
---
# Special Identities
This reference topic for the IT professional describes the special identity groups \(which are sometimes referred to as security groups\) that are used in Windows access control.  
  
Special identity groups are similar to Active Directory security groups as listed in the users and built\-in containers. Special identity groups can provide an efficient way to assign access to resources in your network. By using special identity groups, you can:  
  
-   Assign user rights to security groups in Active Directory.  
  
-   Assign permissions to security groups for the purpose of accessing resources.  
  
Servers that are running the supported Windows Server operating systems designated in the **Applies To** list at the beginning of this topic include several special identity groups. These special identity groups do not have specific memberships that can be modified, but they can represent different users at different times, depending on the circumstances.  
  
Although the special identity groups can be assigned rights and permissions to resources, the memberships cannot be modified or viewed. Group scopes do not apply to special identity groups. Users are automatically assigned to these special identity groups whenever they sign in or access a particular resource.  
  
For information about security groups and group scope, see [Active Directory Security Groups](../Topic/Active-Directory-Security-Groups.md).  
  
The special identity groups are described in the following tables.  
  
-   [Anonymous Logon](#BKMK_AnonymousLogon)  
  
-   [Authenticated User](#BKMK_AuthenticatedUser)  
  
-   [Batch](#BKMK_Batch)  
  
-   [Creator Group](#BKMK_CreatorGroup)  
  
-   [Creator Owner](#BKMK_CreatorOwner)  
  
-   [Dialup](#BKMK_Dialup)  
  
-   [Digest Authentication](#BKMK_DigestAuth)  
  
-   [Enterprise Domain Controllers](#BKMK_EntDCs)  
  
-   [Everyone](#BKMK_Everyone)  
  
-   [Interactive](#BKMK_Interactive)  
  
-   [Local Service](#BKMK_LocalService)  
  
-   [LocalSystem](#BKMK_LocalSystem)  
  
-   [Network](#BKMK_Network)  
  
-   [Network Service](#BKMK_NetworkService)  
  
-   [NTLM Authentication](#BKMK_NTLMAuth)  
  
-   [Other Organization](#BKMK_OtherOrganization)  
  
-   [Principal Self](#BKMK_PrincipalSelf)  
  
-   [Remote Interactive Logon](#BKMK_RemoteInteractiveLogon)  
  
-   [Restricted](#BKMK_RestrictedCode)  
  
-   [SChannel Authentication](#BKMK_SChannelAuth)  
  
-   [Service](#BKMK_Service)  
  
-   [Terminal Server User](#BKMK_TerminalServerUser)  
  
-   [This Organization](#BKMK_ThisOrg)  
  
-   [Window Manager\\Window Manager Group](#BKMK_WindowManager)  
  
## <a name="BKMK_AnonymousLogon"></a>Anonymous Logon  
Any user who accesses the system through an anonymous logon has the Anonymous Logon identity. This identity allows anonymous access to resources, such as a web page that is published on corporate servers. The Anonymous Logon group is not a member of the Everyone group by default.  
  
|Attribute|Value|  
|-------------|---------|  
|Well\-Known SID\/RID|S\-1\-5\-7|  
|Object Class|Foreign Security Principal|  
|Default Location in Active Directory|cn\=WellKnown Security Principals, cn\=Configuration, dc\=<forestRootDomain>|  
|Default User Rights|None|  
  
## <a name="BKMK_AuthenticatedUser"></a>Authenticated Users  
Any user who accesses the system through a sign\-in process has the Authenticated Users identity. This identity allows access to shared resources within the domain, such as files in a shared folder that should be accessible to all the workers in the organization. Membership is controlled by the operating system.  
  
|Attribute|Value|  
|-------------|---------|  
|Well\-Known SID\/RID|S\-1\-5\-11|  
|Object Class|Foreign Security Principal|  
|Default Location in Active Directory|cn\=WellKnown Security Principals, cn\=Configuration, dc\=<forestRootDomain>|  
|Default User Rights|[Access this computer from the network](../Topic/Access-this-computer-from-the-network.md):  SeNetworkLogonRight<br /><br />[Add workstations to domain](../Topic/Add-workstations-to-domain.md):  SeMachineAccountPrivilege<br /><br />[Bypass traverse checking](../Topic/Bypass-traverse-checking.md):  SeChangeNotifyPrivilege|  
  
## <a name="BKMK_Batch"></a>Batch  
Any user or process that accesses the system as a batch job \(or through the batch queue\) has the Batch identity. This identity allows batch jobs to run scheduled tasks, such as a nightly cleanup job that deletes temporary files. Membership is controlled by the operating system.  
  
|Attribute|Value|  
|-------------|---------|  
|Well\-Known SID\/RID|S\-1\-5\-3|  
|Object Class|Foreign Security Principal|  
|Default Location in Active Directory|cn\=WellKnown Security Principals, cn\=Configuration, dc\=<forestRootDomain>|  
|Default User Rights|None|  
  
## <a name="BKMK_CreatorGroup"></a>Creator Group  
The person who created the file or the directory is a member of this special identity group. Windows Server operating systems use this identity to automatically grant access permissions to the creator of a file or directory.  
  
A placeholder security identifier \(SID\) is created in an inheritable access control entry \(ACE\). When the ACE is inherited, the system replaces this SID with the SID for the primary group of the object’s current owner. The primary group is used only by the Portable Operating System Interface for UNIX \(POSIX\) subsystem.  
  
|Attribute|Value|  
|-------------|---------|  
|Well\-Known SID\/RID|S\-1\-3\-1|  
|Object Class|Foreign Security Principal|  
|Default Location in Active Directory|cn\=WellKnown Security Principals, cn\=Configuration, dc\=<forestRootDomain>|  
|Default User Rights|None|  
  
## <a name="BKMK_CreatorOwner"></a>Creator Owner  
The person who created the file or the directory is a member of this special identity group. Windows Server operating systems use this identity to automatically grant access permissions to the creator of a file or directory. A placeholder SID is created in an inheritable ACE. When the ACE is inherited, the system replaces this SID with the SID for the object’s current owner.  
  
|Attribute|Value|  
|-------------|---------|  
|Well\-Known SID\/RID|S\-1\-3\-0|  
|Object Class|Foreign Security Principal|  
|Default Location in Active Directory|cn\=WellKnown Security Principals, cn\=Configuration, dc\=<forestRootDomain>|  
|Default User Rights|None|  
  
## <a name="BKMK_Dialup"></a>Dialup  
Any user who accesses the system through a dial\-up connection has the Dial\-Up identity. This identity distinguishes dial\-up users from other types of authenticated users.  
  
|Attribute|Value|  
|-------------|---------|  
|Well\-Known SID\/RID|S\-1\-5\-1|  
|Object Class|Foreign Security Principal|  
|Default Location in Active Directory|cn\=WellKnown Security Principals, cn\=Configuration, dc\=<forestRootDomain>|  
|Default User Rights|None|  
  
## <a name="BKMK_DigestAuth"></a>Digest Authentication  
  
|Attribute|Value|  
|-------------|---------|  
|Well\-Known SID\/RID|S\-1\-5\-64\-21|  
|Object Class|Foreign Security Principal|  
|Default Location in Active Directory|cn\=WellKnown Security Principals, cn\=Configuration, dc\=<forestRootDomain>|  
|Default User Rights|None|  
  
## <a name="BKMK_EntDCs"></a>Enterprise Domain Controllers  
This group includes all domain controllers in an Active Directory forest. Domain controllers with enterprise\-wide roles and responsibilities have the Enterprise Domain Controllers identity. This identity allows them to perform certain tasks in the enterprise by using transitive trusts. Membership is controlled by the operating system.  
  
|Attribute|Value|  
|-------------|---------|  
|Well\-Known SID\/RID|S\-1\-5\-9|  
|Object Class|Foreign Security Principal|  
|Default Location in Active Directory|cn\=WellKnown Security Principals, cn\=Configuration, dc\=<forestRootDomain>|  
|Default User Rights Assignment|[Access this computer from the network](../Topic/Access-this-computer-from-the-network.md):  SeNetworkLogonRight<br /><br />[Allow log on locally](../Topic/Allow-log-on-locally.md):  SeInteractiveLogonRight|  
  
## <a name="BKMK_Everyone"></a>Everyone  
All interactive, network, dial\-up, and authenticated users are members of the Everyone group. This special identity group gives wide access to system resources. Whenever a user logs on to the network, the user is automatically added to the Everyone group.  
  
On computers running Windows 2000 and earlier, the Everyone group included the Anonymous Logon group as a default member, but as of Windows Server 2003, the Everyone group contains only Authenticated Users and Guest; and it no longer includes Anonymous Logon by default \(although this can be changed\).  
  
Membership is controlled by the operating system.  
  
|Attribute|Value|  
|-------------|---------|  
|Well\-Known SID\/RID|S\-1\-1\-0|  
|Object Class|Foreign Security Principal|  
|Default Location in Active Directory|cn\=WellKnown Security Principals, cn\=Configuration, dc\=<forestRootDomain>|  
|Default User Rights|[Access this computer from the network](../Topic/Access-this-computer-from-the-network.md):  SeNetworkLogonRight<br /><br />[Act as part of the operating system](../Topic/Act-as-part-of-the-operating-system.md):  SeTcbPrivilege<br /><br />[Bypass traverse checking](../Topic/Bypass-traverse-checking.md):  SeChangeNotifyPrivilege|  
  
## <a name="BKMK_Interactive"></a>Interactive  
Any user who is logged on to the local system has the Interactive identity. This identity allows only local users to access a resource. Whenever a user accesses a given resource on the computer to which they are currently logged on, the user is automatically added to the Interactive group. Membership is controlled by the operating system.  
  
|Attribute|Value|  
|-------------|---------|  
|Well\-Known SID\/RID|S\-1\-5\-4|  
|Object Class|Foreign Security Principal|  
|Default Location in Active Directory|cn\=WellKnown Security Principals, cn\=Configuration, dc\=<forestRootDomain>|  
|Default User Rights|None|  
  
## <a name="BKMK_LocalService"></a>Local Service  
The Local Service account is similar to an Authenticated User account. The Local Service account has the same level of access to resources and objects as members of the Users group. This limited access helps safeguard your system if individual services or processes are compromised. Services that run as the Local Service account access network resources as a null session with anonymous credentials. The name of the account is NT AUTHORITY\\LocalService. This account does not have a password.  
  
|Attribute|Value|  
|-------------|---------|  
|Well\-Known SID\/RID|S\-1\-5\-19|  
|Object Class|Foreign Security Principal|  
|Default Location in Active Directory|cn\=WellKnown Security Principals, cn\=Configuration, dc\=<forestRootDomain>|  
|Default user rights|[Adjust memory quotas for a process](../Topic/Adjust-memory-quotas-for-a-process.md):  SeIncreaseQuotaPrivilege<br /><br />[Bypass traverse checking](../Topic/Bypass-traverse-checking.md):  SeChangeNotifyPrivilege<br /><br />[Change the system time](../Topic/Change-the-system-time.md):  SeSystemtimePrivilege<br /><br />[Change the time zone](../Topic/Change-the-time-zone.md):  SeTimeZonePrivilege<br /><br />[Create global objects](../Topic/Create-global-objects.md):  SeCreateGlobalPrivilege<br /><br />[Generate security audits](../Topic/Generate-security-audits.md):  SeAuditPrivilege<br /><br />[Impersonate a client after authentication](../Topic/Impersonate-a-client-after-authentication.md):  SeImpersonatePrivilege<br /><br />[Replace a process level token](../Topic/Replace-a-process-level-token.md):  SeAssignPrimaryTokenPrivilege|  
  
## <a name="BKMK_LocalSystem"></a>LocalSystem  
This is a service account that is used by the operating system. The LocalSystem account is a powerful account that has full access to the system and acts as the computer on the network. If a service logs on to the LocalSystem account on a domain controller, that service has access to the entire domain. Some services are configured by default to log on to the LocalSystem account. Do not change the default service setting. The name of the account is LocalSystem. This account does not have a password.  
  
|Attribute|Value|  
|-------------|---------|  
|Well\-Known SID\/RID|S\-1\-5\-18|  
|Object Class|Foreign Security Principal|  
|Default Location in Active Directory|cn\=WellKnown Security Principals, cn\=Configuration, dc\=<forestRootDomain>|  
|Default User Rights|None|  
  
## <a name="BKMK_Network"></a>Network  
This group implicitly includes all users who are logged on through a network connection. Any user who accesses the system through a network has the Network identity. This identity allows only remote users to access a resource. Whenever a user accesses a given resource over the network, the user is automatically added to the Network group. Membership is controlled by the operating system.  
  
|Attribute|Value|  
|-------------|---------|  
|Well\-Known SID\/RID|S\-1\-5\-2|  
|Object Class|Foreign Security Principal|  
|Default Location in Active Directory|cn\=WellKnown Security Principals, cn\=Configuration, dc\=<forestRootDomain>|  
|Default User Rights|None|  
  
## <a name="BKMK_NetworkService"></a>Network Service  
The Network Service account is similar to an Authenticated User account. The Network Service account has the same level of access to resources and objects as members of the Users group. This limited access helps safeguard your system if individual services or processes are compromised. Services that run as the Network Service account access network resources by using the credentials of the computer account. The name of the account is NT AUTHORITY\\NetworkService. This account does not have a password.  
  
|Attribute|Value|  
|-------------|---------|  
|Well\-Known SID\/RID|S\-1\-5\-20|  
|Object Class|Foreign Security Principal|  
|Default Location in Active Directory|cn\=WellKnown Security Principals, cn\=Configuration, dc\=<forestRootDomain>|  
|Default User Rights|[Adjust memory quotas for a process](../Topic/Adjust-memory-quotas-for-a-process.md):   SeIncreaseQuotaPrivilege<br /><br />[Bypass traverse checking](../Topic/Bypass-traverse-checking.md):  SeChangeNotifyPrivilege<br /><br />[Create global objects](../Topic/Create-global-objects.md):  SeCreateGlobalPrivilege<br /><br />[Generate security audits](../Topic/Generate-security-audits.md):  SeAuditPrivilege<br /><br />[Impersonate a client after authentication](../Topic/Impersonate-a-client-after-authentication.md):  SeImpersonatePrivilege<br /><br />[Restore files and directories](../Topic/Restore-files-and-directories.md):  SeAssignPrimaryTokenPrivilege<br /><br />[Replace a process level token](../Topic/Replace-a-process-level-token.md):  SeAssignPrimaryTokenPrivilege|  
  
## <a name="BKMK_NTLMAuth"></a>NTLM Authentication  
  
|Attribute|Value|  
|-------------|---------|  
|Well\-Known SID\/RID|S\-1\-5\-64\-10|  
|Object Class|Foreign Security Principal|  
|Default Location in Active Directory|cn\=WellKnown Security Principals, cn\=Configuration, dc\=<forestRootDomain>|  
|Default User Rights|None|  
  
## <a name="BKMK_OtherOrganization"></a>Other Organization  
This group implicitly includes all users who are logged on to the system through a dial\-up connection. Membership is controlled by the operating system.  
  
|Attribute|Value|  
|-------------|---------|  
|Well\-Known SID\/RID|S\-1\-5\-1000|  
|Object Class|Foreign Security Principal|  
|Default Location in Active Directory|cn\=WellKnown Security Principals, cn\=Configuration, dc\=<forestRootDomain>|  
|Default User Rights|None|  
  
## <a name="BKMK_PrincipalSelf"></a>Principal Self  
This identify is a placeholder in an ACE on a user, group, or computer object in Active Directory. When you grant permissions to Principal Self, you grant them to the security principal that is represented by the object. During an access check, the operating system replaces the SID for Principal Self with the SID for the security principal that is represented by the object.  
  
|Attribute|Value|  
|-------------|---------|  
|Well\-Known SID\/RID|S\-1\-5\-10|  
|Object Class|Foreign Security Principal|  
|Default Location in Active Directory|cn\=WellKnown Security Principals, cn\=Configuration, dc\=<forestRootDomain>|  
|Default User Rights|None|  
  
## <a name="BKMK_RemoteInteractiveLogon"></a>Remote Interactive Logon  
This identity represents all users who are currently logged on to a computer by using a Remote Desktop connection. This group is a subset of the Interactive group. Access tokens that contain the Remote Interactive Logon SID also contain the Interactive SID.  
  
|Attribute|Value|  
|-------------|---------|  
|Well\-Known SID\/RID|S\-1\-5\-14|  
|Object Class|Foreign Security Principal|  
|Default Location in Active Directory|cn\=WellKnown Security Principals, cn\=Configuration, dc\=<forestRootDomain>|  
|Default User Rights|None|  
  
## <a name="BKMK_RestrictedCode"></a>Restricted  
Users and computers with restricted capabilities have the Restricted identity. This identity group is used by a process that is running in a restricted security context, such as running an application with the RunAs service. When code runs at the Restricted security level, the Restricted SID is added to the user’s access token.  
  
|Attribute|Value|  
|-------------|---------|  
|Well\-Known SID\/RID|S\-1\-5\-12|  
|Object Class|Foreign Security Principal|  
|Default Location in Active Directory|cn\=WellKnown Security Principals, cn\=Configuration, dc\=<forestRootDomain>|  
|Default User Rights|None|  
  
## <a name="BKMK_SChannelAuth"></a>SChannel Authentication  
  
|Attribute|Value|  
|-------------|---------|  
|Well\-Known SID\/RID|S\-1\-5\-64\-14|  
|Object Class|Foreign Security Principal|  
|Default Location in Active Directory|cn\=WellKnown Security Principals, cn\=Configuration, dc\=<forestRootDomain>|  
|Default User Rights|None|  
  
## <a name="BKMK_Service"></a>Service  
Any service that accesses the system has the Service identity. This identity group includes all security principals that are signed in as a service. This identity grants access to processes that are being run by Windows Server services. Membership is controlled by the operating system.  
  
|Attribute|Value|  
|-------------|---------|  
|Well\-Known SID\/RID|S\-1\-5\-6|  
|Object Class|Foreign Security Principal|  
|Default Location in Active Directory|cn\=WellKnown Security Principals, cn\=Configuration, dc\=<forestRootDomain>|  
|Default User Rights|[Create global objects](../Topic/Create-global-objects.md):  SeCreateGlobalPrivilege<br /><br />[Impersonate a client after authentication](../Topic/Impersonate-a-client-after-authentication.md):  SeImpersonatePrivilege|  
  
## <a name="BKMK_TerminalServerUser"></a>Terminal Server User  
Any user accessing the system through Terminal Services has the Terminal Server User identity. This identity allows users to access Terminal Server applications and to perform other necessary tasks with Terminal Server services. Membership is controlled by the operating system.  
  
|Attribute|Value|  
|-------------|---------|  
|Well\-Known SID\/RID|S\-1\-5\-13|  
|Object Class|Foreign Security Principal|  
|Default Location in Active Directory|cn\=WellKnown Security Principals, cn\=Configuration, dc\=<forestRootDomain>|  
|Default User Rights|None|  
  
## <a name="BKMK_ThisOrg"></a>This Organization  
  
|Attribute|Value|  
|-------------|---------|  
|Well\-Known SID\/RID|S\-1\-5\-15|  
|Object Class|Foreign Security Principal|  
|Default Location in Active Directory|cn\=WellKnown Security Principals, cn\=Configuration, dc\=<forestRootDomain>|  
|Default User Rights|None|  
  
## <a name="BKMK_WindowManager"></a>Window Manager\\Window Manager Group  
  
|Attribute|Value|  
|-------------|---------|  
|Well\-Known SID\/RID||  
|Object Class||  
|Default Location in Active Directory|cn\=WellKnown Security Principals, cn\=Configuration, dc\=<forestRootDomain>|  
|Default User Rights|[Bypass traverse checking](../Topic/Bypass-traverse-checking.md):  SeChangeNotifyPrivilege<br /><br />[Increase a process working set](../Topic/Increase-a-process-working-set.md):  SeIncreaseWorkingSetPrivilege|  
  
## See also  
[Active Directory Security Groups](../Topic/Active-Directory-Security-Groups.md)  
  
[Security Principals Technical Overview](../Topic/Security-Principals-Technical-Overview.md)  
  
