---
title: Special identity groups
description: Learn about Windows Server special identity groups that are used for Windows access control.
author: dansimp
ms.author: dansimp
ms.topic: article
ms.date: 08/02/2022
---

# Special identity groups

> Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

Learn about Windows Server special identity groups (sometimes called *security groups*) that are used for Windows access control.

## What is a special identity group?

Special identity groups are similar to the Active Directory security groups that are listed in the Active Directory Users and BuiltIn containers. Special identity groups can provide an efficient way to assign access to resources in your network. By using special identity groups, you can:

- Assign user rights to security groups in Active Directory.

- Assign permissions to security groups to access resources.

## How special identity groups work in Windows Server

If a server is running one of the versions of the Windows Server operating system shown in **Applies to** at the beginning of this article, the server has several special identity groups. These special identity groups don't have specific memberships that you can modify, but they can represent different users at different times depending on the circumstances.

Although you can assign rights and permissions for specific resources to a special identity group, you can't view or modify the membership of a special identity group. Group scopes don't apply to special identity groups. Users are automatically assigned to special identity groups when they sign in or access a specific resource.

For information about Active Directory security groups and group scopes, see [Active Directory security groups](understand-security-groups.md).

## Default special identity groups

Default special identity groups in Windows Server are described in the following list:

- [Anonymous Logon](#anonymous-logon)
- [Attested key property](#attested-key-property)
- [Authenticated Users](#authenticated-users)
- [Authentication authority asserted identity](#authentication-authority-asserted-identity)
- [Batch](#batch)
- [Console logon](#console-logon)
- [Creator Group](#creator-group)
- [Creator Owner](#creator-owner)
- [Dialup](#dialup)
- [Digest Authentication](#digest-authentication)
- [Enterprise Domain Controllers](#enterprise-domain-controllers)
- [Enterprise Read-only Domain Controllers](#enterprise-read-only-domain-controllers)
- [Everyone](#everyone)
- [Fresh Public Key identity](#fresh-public-key-identity)
- [Interactive](#interactive)
- [IUSR](#iusr)
- [Key trust](#key-trust)
- [Local Service](#local-service)
- [LocalSystem](#localsystem)
- [MFA key property](#mfa-key-property)
- [Network](#network)
- [Network Service](#network-service)
- [NTLM Authentication](#ntlm-authentication)
- [Other Organization](#other-organization)
- [Owner Rights](#owner-rights)
- [Principal Self](#principal-self)
- [Proxy](#proxy)
- [Read-only Domain Controller](#read-only-domain-controller)
- [Remote Interactive Logon](#remote-interactive-logon)
- [Restricted](#restricted)
- [SChannel Authentication](#schannel-authentication)
- [Service](#service)
- [Service asserted identity](#service-asserted-identity)
- [Terminal Server User](#terminal-server-user)
- [This Organization](#this-organization)
- [Window Manager\\Window Manager Group](#window-managerwindow-manager-group)

### Anonymous Logon

Any user who accesses the system through an anonymous logon has the Anonymous Logon identity. This identity allows anonymous access to resources, like to a webpage that's published on a corporate server. The Anonymous Logon group isn't a member of the Everyone group by default.

|Attribute|Value|
| --- | --- |
|Well-known SID/RID|S-1-5-7|
|Object class|Foreign Security Principal|
|Default location in Active Directory |CN=WellKnown Security Principals, CN=Configuration, DC=\<forestRootDomain\>|
|Default user rights|None|

### Attested key property

A security identifier (SID) that means the key trust object had the attestation property.

|Attribute|Value|
| --- | --- |
|Well-known SID/RID|S-1-18-6|
|Object class|Foreign Security Principal|
|Default location in Active Directory |CN=WellKnown Security Principals, CN=Configuration, DC=\<forestRootDomain\>|
|Default user rights|None|

### Authenticated Users

Any user who accesses the system through a sign-in process has the Authenticated Users identity. This identity allows access to shared resources within the domain, such as files in a shared folder that should be accessible to all the workers in the organization. Membership is controlled by the operating system.

|Attribute|Value|
| --- | --- |
|Well-known SID/RID|S-1-5-11|
|Object class|Foreign Security Principal|
|Default location in Active Directory |CN=WellKnown Security Principals, CN=Configuration, DC=\<forestRootDomain\>|
|Default user rights| [Access this computer from the network](/windows/device-security/security-policy-settings/access-this-computer-from-the-network): SeNetworkLogonRight<p>[Add workstations to domain](/windows/device-security/security-policy-settings/add-workstations-to-domain): SeMachineAccountPrivilege<p>[Bypass traverse checking](/windows/device-security/security-policy-settings/bypass-traverse-checking): SeChangeNotifyPrivilege|

### Authentication authority asserted identity

An SID that means the client's identity is asserted by an authentication authority based on proof of possession of client credentials.

|Attribute|Value|
| --- | --- |
|Well-known SID/RID|S-1-18-1|
|Object class|Foreign Security Principal|
|Default location in Active Directory |CN=WellKnown Security Principals, CN=Configuration, DC=\<forestRootDomain\>|
|Default user rights|None|

### Batch

Any user or process that accesses the system as a batch job or through the batch queue has the Batch identity. This identity allows batch jobs to run scheduled tasks, such as a nightly cleanup job that deletes temporary files. Membership is controlled by the operating system.

|Attribute|Value|
| --- | --- |
|Well-known SID/RID|S-1-5-3|
|Object class|Foreign Security Principal|
|Default location in Active Directory |CN=WellKnown Security Principals, CN=Configuration, DC=\<forestRootDomain\>|
|Default user rights| none|

### Console logon

A group that includes users who are logged on to the physical console. This SID can be used to implement security policies that grant different rights based on whether a user has been granted physical access to the console.

|Attribute|Value|
| --- | --- |
|Well-known SID/RID|S-1-2-1|
|Object class|Foreign Security Principal|
|Default location in Active Directory |CN=WellKnown Security Principals, CN=Configuration, DC=\<forestRootDomain\>|
|Default user rights|None|

### Creator Group

The person who created a file or directory is a member of this special identity group. The Windows Server operating system uses this identity to automatically grant access permissions to the creator of a file or directory.

A placeholder SID is created in an inheritable access control entry (ACE). When the ACE is inherited, the system replaces this SID with the SID for the primary group of the object’s current owner. The primary group is used only by the POSIX subsystem.

|Attribute|Value|
| --- | --- |
|Well-known SID/RID|S-1-3-1|
|Object class|Foreign Security Principal|
|Default location in Active Directory |CN=WellKnown Security Principals, CN=Configuration, DC=\<forestRootDomain\>|
|Default user rights| none|

### Creator Owner

The person who created a file or directory is a member of this special identity group. The Windows Server operating system uses this identity to automatically grant access permissions to the creator of a file or directory. A placeholder SID is created in an inheritable ACE. When the ACE is inherited, the system replaces this SID with the SID for the object’s current owner.

|Attribute|Value|
| --- | --- |
|Well-known SID/RID|S-1-3-0 |
|Object class|Foreign Security Principal|
|Default location in Active Directory |CN=WellKnown Security Principals, CN=Configuration, DC=\<forestRootDomain\>|
|Default user rights| none|

### Dialup

Any user who accesses the system through a dial-up connection has the Dialup identity. This identity distinguishes dial-up users from other types of authenticated users.

|Attribute|Value|
| --- | --- |
|Well-known SID/RID|S-1-5-1|
|Object class|Foreign Security Principal|
|Default location in Active Directory |CN=WellKnown Security Principals, CN=Configuration, DC=\<forestRootDomain\>|
|Default user rights| none|

### Digest Authentication

|Attribute|Value|
| --- | --- |
|Well-known SID/RID|S-1-5-64-21|
|Object class|Foreign Security Principal|
|Default location in Active Directory |CN=WellKnown Security Principals, CN=Configuration, DC=\<forestRootDomain\>|
|Default user rights| none|

### Enterprise Domain Controllers

This group includes all domain controllers in an Active Directory forest. Domain controllers with enterprise-wide roles and responsibilities have the Enterprise Domain Controllers identity. This identity allows domain controllers to perform certain tasks in the enterprise by using transitive trusts. Membership is controlled by the operating system.

|Attribute|Value|
| --- | --- |
|Well-known SID/RID|S-1-5-9|
|Object class|Foreign Security Principal|
|Default location in Active Directory |CN=WellKnown Security Principals, CN=Configuration, DC=\<forestRootDomain\>|
|Default user rights| [Access this computer from the network](/windows/device-security/security-policy-settings/access-this-computer-from-the-network): SeNetworkLogonRight<p>[Allow log on locally](/windows/device-security/security-policy-settings/allow-log-on-locally): SeInteractiveLogonRight|

### Enterprise Read-only Domain Controllers

This group includes all domain controllers in an Active Directory forest. Domain controllers with enterprise-wide roles and responsibilities have the Enterprise Domain Controllers identity. Except for account passwords, a read-only domain controller (RODC) holds all the Active Directory objects and attributes that a writable domain controller holds. Membership is controlled by the operating system.

|Attribute|Value|
| --- | --- |
|Well-known SID/RID|S-1-5-21-\<RootDomain>|
|Object class|Foreign Security Principal|
|Default location in Active Directory |CN=WellKnown Security Principals, CN=Configuration, DC=\<forestRootDomain\>|
|Default user rights|None|

### Everyone

All interactive, network, dial-up, and authenticated users are members of the Everyone group. This special identity group gives wide access to system resources. When a user logs on to the network, the user is automatically added to the Everyone group. Membership is controlled by the operating system.

On computers running Windows 2000 and earlier, the Everyone group included the Anonymous Logon group as a default member. Beginning in Windows Server 2003, the Everyone group contains only Authenticated Users and Guest. The group no longer includes Anonymous Logon by default. To change the Everyone group setting to include the Anonymous Logon group, in Registry Editor, go to the **Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa** key and set the value of the **everyoneincludesanonymous** DWORD to **1**.

|Attribute|Value|
| --- | --- |
|Well-known SID/RID|S-1-1-0 |
|Object class|Foreign Security Principal|
|Default location in Active Directory |CN=WellKnown Security Principals, CN=Configuration, DC=\<forestRootDomain\>|
|Default user rights| [Access this computer from the network](/windows/device-security/security-policy-settings/access-this-computer-from-the-network): SeNetworkLogonRight<p> [Bypass traverse checking](/windows/device-security/security-policy-settings/bypass-traverse-checking): SeChangeNotifyPrivilege|

### Fresh Public Key identity

An SID that means the client's identity is asserted by an authentication authority based on proof of current possession of client public key credentials.

|Attribute|Value|
| --- | --- |
|Well-known SID/RID|S-1-18-3|
|Object class|Foreign Security Principal|
|Default location in Active Directory |CN=WellKnown Security Principals, CN=Configuration, DC=\<forestRootDomain\>|
|Default user rights|None|

### Interactive

Any user who is logged on to the local system has the Interactive identity. This identity allows only local users to access a resource. When a user accesses a specific resource on the computer to which they're currently logged on, the user is automatically added to the Interactive group. Membership is controlled by the operating system.

|Attribute|Value|
| --- | --- |
|Well-known SID/RID|S-1-5-4|
|Object class|Foreign Security Principal|
|Default location in Active Directory |CN=WellKnown Security Principals, CN=Configuration, DC=\<forestRootDomain\>|
|Default user rights| None|

### IUSR

Internet Information Services (IIS) uses this account by default when anonymous authentication is enabled.

|Attribute|Value|
| --- | --- |
|Well-known SID/RID|S-1-5-17|
|Object class|Foreign Security Principal|
|Default location in Active Directory |CN=WellKnown Security Principals, CN=Configuration, DC=\<forestRootDomain\>|
|Default user rights|None|

### Key trust

An SID that means the client's identity is based on proof of possession of public key credentials by using the key trust object.

|Attribute|Value|
| --- | --- |
|Well-known SID/RID|S-1-18-4|
|Object class|Foreign Security Principal|
|Default location in Active Directory |CN=WellKnown Security Principals, CN=Configuration, DC=\<forestRootDomain\>|
|Default user rights|None|

### Local Service

The Local Service account is similar to the Authenticated User account. Members of the Local Service account have the same level of access to resources and objects as members of the Users group. This limited access helps safeguard your system if individual services or processes are compromised. Services that run as the Local Service account access network resources as a null session with anonymous credentials. The name of the account is NT AUTHORITY\\LocalService. This account doesn't have a password.

|Attribute|Value|
| --- | --- |
|Well-known SID/RID|S-1-5-19|
|Object class|Foreign Security Principal|
|Default location in Active Directory |CN=WellKnown Security Principals, CN=Configuration, DC=\<forestRootDomain\>|
|Default user rights|  [Adjust memory quotas for a process](/windows/device-security/security-policy-settings/adjust-memory-quotas-for-a-process): SeIncreaseQuotaPrivilege <p>[Bypass traverse checking](/windows/device-security/security-policy-settings/bypass-traverse-checking): SeChangeNotifyPrivilege<p> [Change the system time](/windows/device-security/security-policy-settings/change-the-system-time): SeSystemtimePrivilege<p> [Change the time zone](/windows/device-security/security-policy-settings/change-the-time-zone): SeTimeZonePrivilege<p> [Create global objects](/windows/device-security/security-policy-settings/create-global-objects): SeCreateGlobalPrivilege<p> [Generate security audits](/windows/device-security/security-policy-settings/generate-security-audits): SeAuditPrivilege<p>[Impersonate a client after authentication](/windows/device-security/security-policy-settings/impersonate-a-client-after-authentication): SeImpersonatePrivilege<p> [Replace a process level token](/windows/device-security/security-policy-settings/replace-a-process-level-token): SeAssignPrimaryTokenPrivilege<p>|

### LocalSystem

The LocalSystem account is a service account that's used by the operating system. The LocalSystem account is a powerful account that has full access to the system and acts as the computer on the network. If a service logs on to the LocalSystem account on a domain controller, that service has access to the entire domain. Some services are configured by default to log on to the LocalSystem account. Don't change the default service setting. The name of the account is LocalSystem. This account doesn't have a password.

|Attribute|Value|
| --- | --- |
|Well-known SID/RID|S-1-5-18|
|Object class|Foreign Security Principal|
|Default location in Active Directory |CN=WellKnown Security Principals, CN=Configuration, DC=\<forestRootDomain\>|
|Default user rights|None|

### MFA key property

An SID that means the key trust object had the multifactor authentication (MFA) property.

|Attribute|Value|
| --- | --- |
|Well-known SID/RID|S-1-18-5|
|Object class|Foreign Security Principal|
|Default location in Active Directory |CN=WellKnown Security Principals, CN=Configuration, DC=\<forestRootDomain\>|
|Default user rights|None|

### Network

This group implicitly includes all users who are logged on through a network connection. Any user who accesses the system through a network has the Network identity. This identity allows only remote users to access a resource. When a user accesses a specific resource over the network, the user is automatically added to the Network group. Membership is controlled by the operating system.

|Attribute|Value|
| --- | --- |
|Well-known SID/RID|S-1-5-2|
|Object class|Foreign Security Principal|
|Default location in Active Directory |CN=WellKnown Security Principals, CN=Configuration, DC=\<forestRootDomain\>|
|Default user rights|None|

### Network Service

The Network Service account is similar to the Authenticated User account. Members of the Network Service account have the same level of access to resources and objects as members of the Users group. This limited access helps safeguard your system if individual services or processes are compromised. Services that run as the Network Service account access network resources by using the credentials of the computer account. The name of the account is NT AUTHORITY\\NetworkService. This account doesn't have a password.

|Attribute|Value|
| --- | --- |
|Well-known SID/RID|S-1-5-20 |
|Object class|Foreign Security Principal|
|Default location in Active Directory |CN=WellKnown Security Principals, CN=Configuration, DC=\<forestRootDomain\>|
|Default user rights| [Adjust memory quotas for a process](/windows/device-security/security-policy-settings/adjust-memory-quotas-for-a-process): SeIncreaseQuotaPrivilege<p> [Bypass traverse checking](/windows/device-security/security-policy-settings/bypass-traverse-checking): SeChangeNotifyPrivilege<p>[Create global objects](/windows/device-security/security-policy-settings/create-global-objects): SeCreateGlobalPrivilege<p>[Generate security audits](/windows/device-security/security-policy-settings/generate-security-audits): SeAuditPrivilege<p>[Impersonate a client after authentication](/windows/device-security/security-policy-settings/impersonate-a-client-after-authentication): SeImpersonatePrivilege<p>[Replace a process level token](/windows/device-security/security-policy-settings/replace-a-process-level-token): SeAssignPrimaryTokenPrivilege<p>|

### NTLM Authentication

|Attribute|Value|
| --- | --- |
|Well-known SID/RID|S-1-5-64-10 |
|Object class|Foreign Security Principal|
|Default location in Active Directory |CN=WellKnown Security Principals, CN=Configuration, DC=\<forestRootDomain\>|
|Default user rights| None|

### Other Organization

This group implicitly includes all users who are logged on to the system through a dial-up connection. Membership is controlled by the operating system.

|Attribute|Value|
| --- | --- |
|Well-known SID/RID|S-1-5-1000 |
|Object class|Foreign Security Principal|
|Default location in Active Directory |CN=WellKnown Security Principals, CN=Configuration, DC=\<forestRootDomain\>|
|Default user rights| None |

### Owner Rights

The Owner Rights group represents the current owner of the object. When an ACE that carries this SID is applied to an object, the system ignores the implicit READ_CONTROL and WRITE_DAC permissions for the object owner.

|Attribute|Value|
| --- | --- |
|Well-known SID/RID|S-1-3-4|
|Object class|Foreign Security Principal|
|Default location in Active Directory |CN=WellKnown Security Principals, CN=Configuration, DC=\<forestRootDomain\>|
|Default user rights|None|

### Principal Self

This identity is a placeholder in an ACE on a user, group, or computer object in Active Directory. When you grant permissions to Principal Self, you grant permissions to the security principal that's represented by the object. During an access check, the operating system replaces the SID for Principal Self with the SID for the security principal that's represented by the object.

|Attribute|Value|
| --- | --- |
|Well-known SID/RID|S-1-5-10 |
|Object class|Foreign Security Principal|
|Default location in Active Directory |CN=WellKnown Security Principals, CN=Configuration, DC=\<forestRootDomain\>|
|Default user rights| None |

### Proxy

Identifies a SECURITY_NT_AUTHORITY proxy.

|Attribute|Value|
| --- | --- |
|Well-known SID/RID|S-1-5-8|
|Object class|Foreign Security Principal|
|Default location in Active Directory |CN=WellKnown Security Principals, CN=Configuration, DC=\<forestRootDomain\>|
|Default user rights|None|

### Read-only Domain Controller

This group includes all RODCs in the forest with read-only rights to the Active Directory database. It allows domain controller deployment when physical security is scarce or not guaranteed. Membership is controlled by the operating system.

|Attribute|Value|
| --- | --- |
|Well-known SID/RID|S-1-5-21-\<domain>|
|Object class|Foreign Security Principal|
|Default location in Active Directory |CN=WellKnown Security Principals, CN=Configuration, DC=\<forestRootDomain\>|
|Default user rights|None|

> [!NOTE]
> The [Denied RODC Password Replication group](understand-security-groups.md#denied-rodc-password-replication) is created automatically when an RODC account is created in the forest. Passwords can't be replicated in the Denied RODC Password Replication group.

### Remote Interactive Logon

This identity represents all users who are currently logged on to a computer by using a Remote Desktop Protocol connection. This group is a subset of the Interactive group. Access tokens that contain the Remote Interactive Logon SID also contain the Interactive SID.

|Attribute|Value|
| --- | --- |
|Well-known SID/RID|S-1-5-14|
|Object class|Foreign Security Principal|
|Default location in Active Directory |CN=WellKnown Security Principals, CN=Configuration, DC=\<forestRootDomain\>|
|Default user rights| None |

### Restricted

Users and computers with restricted capabilities have the Restricted identity. This identity group is used by a process that's running in a restricted security context, such as running an application with the RunAs service. When code runs at the Restricted security level, the Restricted SID is added to the user’s access token.

|Attribute|Value|
| --- | --- |
|Well-known SID/RID|S-1-5-12|
|Object class|Foreign Security Principal|
|Default location in Active Directory |CN=WellKnown Security Principals, CN=Configuration, DC=\<forestRootDomain\>|
|Default user rights| None |

### SChannel Authentication

|Attribute|Value|
| --- | --- |
|Well-known SID/RID|S-1-5-64-14|
|Object class|Foreign Security Principal|
|Default location in Active Directory |CN=WellKnown Security Principals, CN=Configuration, DC=\<forestRootDomain\>|
|Default user rights| None |

### Service

Any service that accesses the system has the Service identity. This identity group includes all security principals that are signed in as a service. This identity grants access to processes that Windows Server services are running. Membership is controlled by the operating system.

|Attribute|Value|
| --- | --- |
|Well-known SID/RID|S-1-5-6|
|Object class|Foreign Security Principal|
|Default location in Active Directory |CN=WellKnown Security Principals, CN=Configuration, DC=\<forestRootDomain\>|
|Default user rights| [Create global objects](/windows/device-security/security-policy-settings/create-global-objects): SeCreateGlobalPrivilege<p>[Impersonate a client after authentication](/windows/device-security/security-policy-settings/impersonate-a-client-after-authentication): SeImpersonatePrivilege<p>|

### Service asserted identity

An SID that means the client's identity is asserted by a service.

|Attribute|Value|
| --- | --- |
|Well-known SID/RID|S-1-18-2|
|Object class|Foreign Security Principal|
|Default location in Active Directory |CN=WellKnown Security Principals, CN=Configuration, DC=\<forestRootDomain\>|
|Default user rights|None|

### Terminal Server User

Any user that's accessing the system through Terminal Services has the Terminal Server User identity. This identity allows users to access Terminal Server applications and to do other necessary tasks with Terminal Server services. Membership is controlled by the operating system.

|Attribute|Value|
| --- | --- |
|Well-known SID/RID|S-1-5-13|
|Object class|Foreign Security Principal|
|Default location in Active Directory |CN=WellKnown Security Principals, CN=Configuration, DC=\<forestRootDomain\>|
|Default user rights| None |

### This Organization

|Attribute|Value|
| --- | --- |
|Well-known SID/RID|S-1-5-15|
|Object class|Foreign Security Principal|
|Default location in Active Directory |CN=WellKnown Security Principals, CN=Configuration, DC=\<forestRootDomain\>|
|Default user rights| None |

### Window Manager\\Window Manager Group

|Attribute|Value|
| --- | --- |
|Well-known SID/RID|S-1-5-90 |
|Object class|Foreign Security Principal|
|Default location in Active Directory |CN=WellKnown Security Principals, CN=Configuration, DC=\<forestRootDomain\>|
|Default user rights| [Bypass traverse checking](/windows/device-security/security-policy-settings/bypass-traverse-checking): SeChangeNotifyPrivilege<p> [Increase a process working set](/windows/device-security/security-policy-settings/increase-a-process-working-set): SeIncreaseWorkingSetPrivilege<p>|

## See also

- [Active Directory security groups](understand-security-groups.md)

- [Security principals](understand-security-principals.md)

- [Access control overview](/windows/security/identity-protection/access-control/access-control)
