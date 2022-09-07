---
title: Special Identities
description: Windows Server special identities groups usage in Windows access control 
author: dansimp
ms.author: dansimp
ms.topic: article
ms.date: 08/02/2022
---

# Special identities

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

This article describes the special identity groups (which are sometimes referred to as security groups) that are used in Windows access control.

Special identity groups are similar to Active Directory security groups as listed in the users and built-in containers. Special identity groups can provide an efficient way to assign access to resources in your network. By using special identity groups, you can:

- Assign user rights to security groups in Active Directory.

- Assign permissions to security groups for the purpose of accessing resources.

Servers that are running the supported Windows Server operating systems designated in the **Applies to** list at the beginning of this article include several special identity groups. These special identity groups do not have specific memberships that can be modified, but they can represent different users at different times, depending on the circumstances.

Although the special identity groups can be assigned rights and permissions to resources, the memberships cannot be modified or viewed. Group scopes do not apply to special identity groups. Users are automatically assigned to these special identity groups whenever they sign in or access a particular resource.

For information about security groups and group scope, see [Active Directory Security Groups](understand-security-groups.md).

The special identity groups are described in the following tables:

- [Anonymous Logon](#anonymous-logon)

- [Authenticated Users](#authenticated-users)

- [Batch](#batch)

- [Creator Group](#creator-group)

- [Creator Owner](#creator-owner)

- [Dialup](#dialup)

- [Digest Authentication](#digest-authentication)

- [Enterprise Domain Controllers](#enterprise-domain-controllers)

- [Enterprise Read-only Domain Controllers](#enterprise-read-only-domain-controllers)

- [Everyone](#everyone)

- [Interactive](#interactive)

- [Local Service](#local-service)

- [LocalSystem](#localsystem)

- [Network](#network)

- [Network Service](#network-service)

- [NTLM Authentication](#ntlm-authentication)

- [Other Organization](#other-organization)

- [Principal Self](#principal-self)

- [Read-only Domain Controller](#read-only-domain-controller)

- [Remote Interactive Logon](#remote-interactive-logon)

- [Restricted](#restricted)

- [SChannel Authentication](#schannel-authentication)

- [Service](#service)

- [Terminal Server User](#terminal-server-user)

- [This Organization](#this-organization)

- [Window Manager\\Window Manager Group](#window-managerwindow-manager-group)

## Anonymous Logon

Any user who accesses the system through an anonymous logon has the Anonymous Logon identity. This identity allows anonymous access to resources, such as a web page that is published on corporate servers. The Anonymous Logon group is not a member of the Everyone group by default.

| Attribute | Value |
|  :--: | :--: |
| Well-Known SID/RID | S-1-5-7 |
|Object Class|  Foreign Security Principal|
|Default Location in Active Directory |cn=WellKnown Security Principals, cn=Configuration, dc=\<forestRootDomain\>|
|Default User Rights|None|

## Attested key property

A SID that means the key trust object had the attestation property.

| Attribute | Value |
|  :--: | :--: |
| Well-Known SID/RID | S-1-18-6 |
|Object Class|  Foreign Security Principal|
|Default Location in Active Directory |cn=WellKnown Security Principals, cn=Configuration, dc=\<forestRootDomain\>|
|Default User Rights|None|

## Authenticated Users

Any user who accesses the system through a sign-in process has the Authenticated Users identity. This identity allows access to shared resources within the domain, such as files in a shared folder that should be accessible to all the workers in the organization. Membership is controlled by the operating system.

| Attribute | Value |
|  :--: | :--: |
| Well-Known SID/RID | S-1-5-11 |
|Object Class|  Foreign Security Principal|
|Default Location in Active Directory |cn=WellKnown Security Principals, cn=Configuration, dc=\<forestRootDomain\>|
|Default User Rights| [Access this computer from the network](/windows/device-security/security-policy-settings/access-this-computer-from-the-network): SeNetworkLogonRight<p>[Add workstations to domain](/windows/device-security/security-policy-settings/add-workstations-to-domain): SeMachineAccountPrivilege<p>[Bypass traverse checking](/windows/device-security/security-policy-settings/bypass-traverse-checking): SeChangeNotifyPrivilege|

## Authentication authority asserted identity

A SID that means the client's identity is asserted by an authentication authority based on proof of possession of client credentials.

| Attribute | Value |
|  :--: | :--: |
| Well-Known SID/RID | S-1-18-1 |
|Object Class|  Foreign Security Principal|
|Default Location in Active Directory |cn=WellKnown Security Principals, cn=Configuration, dc=\<forestRootDomain\>|
|Default User Rights|None|

## Batch

Any user or process that accesses the system as a batch job (or through the batch queue) has the Batch identity. This identity allows batch jobs to run scheduled tasks, such as a nightly cleanup job that deletes temporary files. Membership is controlled by the operating system.

| Attribute | Value |
|  :--: | :--: |
| Well-Known SID/RID | S-1-5-3 |
|Object Class|  Foreign Security Principal|
|Default Location in Active Directory |cn=WellKnown Security Principals, cn=Configuration, dc=\<forestRootDomain\>|
|Default User Rights| none|

## Console logon

A group that includes users who are logged on to the physical console. This SID can be used to implement security policies that grant different rights based on whether a user has been granted physical access to the console.

| Attribute | Value |
|  :--: | :--: |
| Well-Known SID/RID | S-1-2-1 |
|Object Class|  Foreign Security Principal|
|Default Location in Active Directory |cn=WellKnown Security Principals, cn=Configuration, dc=\<forestRootDomain\>|
|Default User Rights|None|

## Creator Group

The person who created the file or the directory is a member of this special identity group. Windows Server operating systems use this identity to automatically grant access permissions to the creator of a file or directory.

A placeholder security identifier (SID) is created in an inheritable access control entry (ACE). When the ACE is inherited, the system replaces this SID with the SID for the primary group of the object’s current owner. The primary group is used only by the Portable Operating System Interface for UNIX (POSIX) subsystem.

| Attribute | Value |
|  :--: | :--: |
| Well-Known SID/RID | S-1-3-1 |
|Object Class|  Foreign Security Principal|
|Default Location in Active Directory |cn=WellKnown Security Principals, cn=Configuration, dc=\<forestRootDomain\>|
|Default User Rights| none|

## Creator Owner

The person who created the file or the directory is a member of this special identity group. Windows Server operating systems use this identity to automatically grant access permissions to the creator of a file or directory. A placeholder SID is created in an inheritable ACE. When the ACE is inherited, the system replaces this SID with the SID for the object’s current owner.

| Attribute | Value |
|  :--: | :--: |
| Well-Known SID/RID | S-1-3-0 |
|Object Class|  Foreign Security Principal|
|Default Location in Active Directory |cn=WellKnown Security Principals, cn=Configuration, dc=\<forestRootDomain\>|
|Default User Rights| none|

## Dialup

Any user who accesses the system through a dial-up connection has the Dial-Up identity. This identity distinguishes dial-up users from other types of authenticated users.

| Attribute | Value |
|  :--: | :--: |
| Well-Known SID/RID | S-1-5-1 |
|Object Class|  Foreign Security Principal|
|Default Location in Active Directory |cn=WellKnown Security Principals, cn=Configuration, dc=\<forestRootDomain\>|
|Default User Rights| none|

## Digest authentication

| Attribute | Value |
|  :--: | :--: |
| Well-Known SID/RID | S-1-5-64-21 |
|Object Class|  Foreign Security Principal|
|Default Location in Active Directory |cn=WellKnown Security Principals, cn=Configuration, dc=\<forestRootDomain\>|
|Default User Rights| none|

## Enterprise Domain Controllers

This group includes all domain controllers in an Active Directory forest. Domain controllers with enterprise-wide roles and responsibilities have the Enterprise Domain Controllers identity. This identity allows them to perform certain tasks in the enterprise by using transitive trusts. Membership is controlled by the operating system.

| Attribute | Value |
|  :--: | :--: |
| Well-Known SID/RID | S-1-5-9 |
|Object Class|  Foreign Security Principal|
|Default Location in Active Directory |cn=WellKnown Security Principals, cn=Configuration, dc=\<forestRootDomain\>|
|Default User Rights| [Access this computer from the network](/windows/device-security/security-policy-settings/access-this-computer-from-the-network): SeNetworkLogonRight<p>[Allow log on locally](/windows/device-security/security-policy-settings/allow-log-on-locally): SeInteractiveLogonRight|

## Enterprise Read-only Domain Controllers

This group includes all domain controllers in an Active Directory forest. Domain controllers with enterprise-wide roles and responsibilities have the Enterprise Domain Controllers identity. Except for account passwords, a Read-only domain controller holds all the Active Directory objects and attributes that a writable domain controller holds. Membership is controlled by the operating system.

| Attribute | Value |
|  :--: | :--: |
| Well-Known SID/RID | S-1-5-21-\<RootDomain>|
|Object Class|  Foreign Security Principal|
|Default Location in Active Directory |cn=WellKnown Security Principals, cn=Configuration, dc=\<forestRootDomain\>|
|Default User Rights|None|

## Everyone

All interactive, network, dial-up, and authenticated users are members of the Everyone group. This special identity group gives wide access to system resources. Whenever a user logs on to the network, the user is automatically added to the Everyone group.

On computers running Windows 2000 and earlier, the Everyone group included the Anonymous Logon group as a default member, but as of Windows Server 2003, the Everyone group contains only Authenticated Users and Guest; and it no longer includes Anonymous Logon by default (although this can be changed, using Registry Editor, by going to the **Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa** key and setting the value of **everyoneincludesanonymous** DWORD to 1).

Membership is controlled by the operating system.

| Attribute | Value |
|  :--: | :--: |
| Well-Known SID/RID | S-1-1-0 |
|Object Class|  Foreign Security Principal|
|Default Location in Active Directory |cn=WellKnown Security Principals, cn=Configuration, dc=\<forestRootDomain\>|
|Default User Rights| [Access this computer from the network](/windows/device-security/security-policy-settings/access-this-computer-from-the-network): SeNetworkLogonRight</br> [Act as part of the operating system](/windows/device-security/security-policy-settings/act-as-part-of-the-operating-system): SeTcbPrivilege</br> [Bypass traverse checking](/windows/device-security/security-policy-settings/bypass-traverse-checking): SeChangeNotifyPrivilege|

## Fresh Public Key identity

A SID that means the client's identity is asserted by an authentication authority based on proof of current possession of client public key credentials.

| Attribute | Value |
|  :--: | :--: |
| Well-Known SID/RID | S-1-18-3 |
|Object Class|  Foreign Security Principal|
|Default Location in Active Directory |cn=WellKnown Security Principals, cn=Configuration, dc=\<forestRootDomain\>|
|Default User Rights|None|

## Interactive

Any user who is logged on to the local system has the Interactive identity. This identity allows only local users to access a resource. Whenever a user accesses a given resource on the computer to which they are currently logged on, the user is automatically added to the Interactive group. Membership is controlled by the operating system.

| Attribute | Value |
|  :--: | :--: |
| Well-Known SID/RID | S-1-5-4 |
|Object Class|  Foreign Security Principal|
|Default Location in Active Directory |cn=WellKnown Security Principals, cn=Configuration, dc=\<forestRootDomain\>|
|Default User Rights| None|

## IUSR

Internet Information Services (IIS) uses this account by default whenever anonymous authentication is enabled.

| Attribute | Value |
|  :--: | :--: |
| Well-Known SID/RID | S-1-5-17 |
|Object Class|  Foreign Security Principal|
|Default Location in Active Directory |cn=WellKnown Security Principals, cn=Configuration, dc=\<forestRootDomain\>|
|Default User Rights|None|

## Key trust

A SID that means the client's identity is based on proof of possession of public key credentials using the key trust object.

| Attribute | Value |
|  :--: | :--: |
| Well-Known SID/RID | S-1-18-4 |
|Object Class|  Foreign Security Principal|
|Default Location in Active Directory |cn=WellKnown Security Principals, cn=Configuration, dc=\<forestRootDomain\>|
|Default User Rights|None|

## Local Service

The Local Service account is similar to an Authenticated User account. The Local Service account has the same level of access to resources and objects as members of the Users group. This limited access helps safeguard your system if individual services or processes are compromised. Services that run as the Local Service account access network resources as a null session with anonymous credentials. The name of the account is NT AUTHORITY\\LocalService. This account does not have a password.

| Attribute | Value |
|  :--: | :--: |
| Well-Known SID/RID | S-1-5-19 |
|Object Class|  Foreign Security Principal|
|Default Location in Active Directory |cn=WellKnown Security Principals, cn=Configuration, dc=\<forestRootDomain\>|
|Default User Rights|  [Adjust memory quotas for a process](/windows/device-security/security-policy-settings/adjust-memory-quotas-for-a-process): SeIncreaseQuotaPrivilege <p>[Bypass traverse checking](/windows/device-security/security-policy-settings/bypass-traverse-checking): SeChangeNotifyPrivilege<p> [Change the system time](/windows/device-security/security-policy-settings/change-the-system-time): SeSystemtimePrivilege<p> [Change the time zone](/windows/device-security/security-policy-settings/change-the-time-zone): SeTimeZonePrivilege<p> [Create global objects](/windows/device-security/security-policy-settings/create-global-objects): SeCreateGlobalPrivilege<p> [Generate security audits](/windows/device-security/security-policy-settings/generate-security-audits): SeAuditPrivilege<p>[Impersonate a client after authentication](/windows/device-security/security-policy-settings/impersonate-a-client-after-authentication): SeImpersonatePrivilege<p> [Replace a process level token](/windows/device-security/security-policy-settings/replace-a-process-level-token): SeAssignPrimaryTokenPrivilege<p>|

## LocalSystem

This is a service account that is used by the operating system. The LocalSystem account is a powerful account that has full access to the system and acts as the computer on the network. If a service logs on to the LocalSystem account on a domain controller, that service has access to the entire domain. Some services are configured by default to log on to the LocalSystem account. Do not change the default service setting. The name of the account is LocalSystem. This account does not have a password.

| Attribute | Value |
|  :--: | :--: |
| Well-Known SID/RID | S-1-5-18 |
|Object Class|  Foreign Security Principal|
|Default Location in Active Directory |cn=WellKnown Security Principals, cn=Configuration, dc=\<forestRootDomain\>|
|Default User Rights|None|

## MFA key property

A SID that means the key trust object had the multifactor authentication (MFA) property.

| Attribute | Value |
|  :--: | :--: |
| Well-Known SID/RID | S-1-18-5 |
|Object Class|  Foreign Security Principal|
|Default Location in Active Directory |cn=WellKnown Security Principals, cn=Configuration, dc=\<forestRootDomain\>|
|Default User Rights|None|

## Network

This group implicitly includes all users who are logged on through a network connection. Any user who accesses the system through a network has the Network identity. This identity allows only remote users to access a resource. Whenever a user accesses a given resource over the network, the user is automatically added to the Network group. Membership is controlled by the operating system.

| Attribute | Value |
|  :--: | :--: |
| Well-Known SID/RID | S-1-5-2 |
|Object Class|  Foreign Security Principal|
|Default Location in Active Directory |cn=WellKnown Security Principals, cn=Configuration, dc=\<forestRootDomain\>|
|Default User Rights|None|

## Network Service

The Network Service account is similar to an Authenticated User account. The Network Service account has the same level of access to resources and objects as members of the Users group. This limited access helps safeguard your system if individual services or processes are compromised. Services that run as the Network Service account access network resources by using the credentials of the computer account. The name of the account is NT AUTHORITY\\NetworkService. This account does not have a password.

| Attribute | Value |
|  :--: | :--: |
| Well-Known SID/RID | S-1-5-20 |
|Object Class|  Foreign Security Principal|
|Default Location in Active Directory |cn=WellKnown Security Principals, cn=Configuration, dc=\<forestRootDomain\>|
|Default User Rights| [Adjust memory quotas for a process](/windows/device-security/security-policy-settings/adjust-memory-quotas-for-a-process): SeIncreaseQuotaPrivilege<p> [Bypass traverse checking](/windows/device-security/security-policy-settings/bypass-traverse-checking): SeChangeNotifyPrivilege<p>[Create global objects](/windows/device-security/security-policy-settings/create-global-objects): SeCreateGlobalPrivilege<p>[Generate security audits](/windows/device-security/security-policy-settings/generate-security-audits): SeAuditPrivilege<p>[Impersonate a client after authentication](/windows/device-security/security-policy-settings/impersonate-a-client-after-authentication): SeImpersonatePrivilege<p>[Replace a process level token](/windows/device-security/security-policy-settings/replace-a-process-level-token): SeAssignPrimaryTokenPrivilege<p>|

## NTLM authentication

| Attribute | Value |
|  :--: | :--: |
| Well-Known SID/RID | S-1-5-64-10 |
|Object Class|  Foreign Security Principal|
|Default Location in Active Directory |cn=WellKnown Security Principals, cn=Configuration, dc=\<forestRootDomain\>|
|Default User Rights| None|

## Other Organization

This group implicitly includes all users who are logged on to the system through a dial-up connection. Membership is controlled by the operating system.

| Attribute | Value |
|  :--: | :--: |
| Well-Known SID/RID | S-1-5-1000 |
|Object Class|  Foreign Security Principal|
|Default Location in Active Directory |cn=WellKnown Security Principals, cn=Configuration, dc=\<forestRootDomain\>|
|Default User Rights| None |

## Owner Rights

A group that represents the current owner of the object. When an ACE that carries this SID is applied to an object, the system ignores the implicit READ_CONTROL and WRITE_DAC permissions for the object owner.

| Attribute | Value |
|  :--: | :--: |
| Well-Known SID/RID | S-1-3-4 |
|Object Class|  Foreign Security Principal|
|Default Location in Active Directory |cn=WellKnown Security Principals, cn=Configuration, dc=\<forestRootDomain\>|
|Default User Rights|None|

## Principal Self

This identity is a placeholder in an ACE on a user, group, or computer object in Active Directory. When you grant permissions to Principal Self, you grant them to the security principal that is represented by the object. During an access check, the operating system replaces the SID for Principal Self with the SID for the security principal that is represented by the object.

| Attribute | Value |
|  :--: | :--: |
| Well-Known SID/RID | S-1-5-10 |
|Object Class|  Foreign Security Principal|
|Default Location in Active Directory |cn=WellKnown Security Principals, cn=Configuration, dc=\<forestRootDomain\>|
|Default User Rights| None |

## Proxy

Identifies a SECURITY_NT_AUTHORITY Proxy.

| Attribute | Value |
|  :--: | :--: |
| Well-Known SID/RID | S-1-5-8 |
|Object Class|  Foreign Security Principal|
|Default Location in Active Directory |cn=WellKnown Security Principals, cn=Configuration, dc=\<forestRootDomain\>|
|Default User Rights|None|

## Read-only Domain Controller

This group includes all read-only domain controllers in the forest with read-only rights within the Active Directory database. It allows for domain controller deployment in situations where physical security is scare or not guaranteed. Membership is controlled by the operating system.

| Attribute | Value |
|  :--: | :--: |
| Well-Known SID/RID | S-1-5-21-\<domain>|
|Object Class|  Foreign Security Principal|
|Default Location in Active Directory |cn=WellKnown Security Principals, cn=Configuration, dc=\<forestRootDomain\>|
|Default User Rights|None|

> [!NOTE]
> The Denied RODC (Read-only Domain Controller) Replication group is created automatically when a RODC account is created in the forest. Passwords cannot be replicated in the Denied Read-only domain controller group.

## Remote Interactive Logon

This identity represents all users who are currently logged on to a computer by using a Remote Desktop connection. This group is a subset of the Interactive group. Access tokens that contain the Remote Interactive Logon SID also contain the Interactive SID.

| Attribute | Value |
|  :--: | :--: |
| Well-Known SID/RID | S-1-5-14|
|Object Class|  Foreign Security Principal|
|Default Location in Active Directory |cn=WellKnown Security Principals, cn=Configuration, dc=\<forestRootDomain\>|
|Default User Rights| None |

## Restricted

Users and computers with restricted capabilities have the Restricted identity. This identity group is used by a process that is running in a restricted security context, such as running an application with the RunAs service. When code runs at the Restricted security level, the Restricted SID is added to the user’s access token.

| Attribute | Value |
|  :--: | :--: |
| Well-Known SID/RID | S-1-5-12 |
|Object Class|  Foreign Security Principal|
|Default Location in Active Directory |cn=WellKnown Security Principals, cn=Configuration, dc=\<forestRootDomain\>|
|Default User Rights| None |

## SChannel authentication

| Attribute | Value |
|  :--: | :--: |
| Well-Known SID/RID | S-1-5-64-14 |
|Object Class|  Foreign Security Principal|
|Default Location in Active Directory |cn=WellKnown Security Principals, cn=Configuration, dc=\<forestRootDomain\>|
|Default User Rights| None |

## Service

Any service that accesses the system has the Service identity. This identity group includes all security principals that are signed in as a service. This identity grants access to processes that are being run by Windows Server services. Membership is controlled by the operating system.

| Attribute | Value |
|  :--: | :--: |
| Well-Known SID/RID | S-1-5-6 |
|Object Class|  Foreign Security Principal|
|Default Location in Active Directory |cn=WellKnown Security Principals, cn=Configuration, dc=\<forestRootDomain\>|
|Default User Rights| [Create global objects](/windows/device-security/security-policy-settings/create-global-objects): SeCreateGlobalPrivilege<p>[Impersonate a client after authentication](/windows/device-security/security-policy-settings/impersonate-a-client-after-authentication): SeImpersonatePrivilege<p>|

## Service asserted identity

A SID that means the client's identity is asserted by a service.

| Attribute | Value |
|  :--: | :--: |
| Well-Known SID/RID | S-1-18-2 |
|Object Class|  Foreign Security Principal|
|Default Location in Active Directory |cn=WellKnown Security Principals, cn=Configuration, dc=\<forestRootDomain\>|
|Default User Rights|None|

## Terminal Server User

Any user accessing the system through Terminal Services has the Terminal Server User identity. This identity allows users to access Terminal Server applications and to perform other necessary tasks with Terminal Server services. Membership is controlled by the operating system.

| Attribute | Value |
|  :--: | :--: |
| Well-Known SID/RID | S-1-5-13 |
|Object Class|  Foreign Security Principal|
|Default Location in Active Directory |cn=WellKnown Security Principals, cn=Configuration, dc=\<forestRootDomain\>|
|Default User Rights| None |

## This Organization

| Attribute | Value |
|  :--: | :--: |
| Well-Known SID/RID | S-1-5-15 |
|Object Class|  Foreign Security Principal|
|Default Location in Active Directory |cn=WellKnown Security Principals, cn=Configuration, dc=\<forestRootDomain\>|
|Default User Rights| None |

## Window Manager\\Window Manager Group

| Attribute | Value |
|  :--: | :--: |
| Well-Known SID/RID | S-1-5-90 |
|Object Class|  Foreign Security Principal|
|Default Location in Active Directory |cn=WellKnown Security Principals, cn=Configuration, dc=\<forestRootDomain\>|
|Default User Rights| [Bypass traverse checking](/windows/device-security/security-policy-settings/bypass-traverse-checking): SeChangeNotifyPrivilege<p> [Increase a process working set](/windows/device-security/security-policy-settings/increase-a-process-working-set): SeIncreaseWorkingSetPrivilege<p>|

## See also

- [Active Directory Security Groups](understand-security-groups.md)

- [Security Principals](understand-security-principals.md)

- [Access Control Overview](/windows/security/identity-protection/access-control/access-control)
