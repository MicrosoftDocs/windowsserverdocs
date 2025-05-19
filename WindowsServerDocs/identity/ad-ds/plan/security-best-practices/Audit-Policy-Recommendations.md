---
title: Audit Policy recommendations
description: This article provides guidance on Windows audit policy settings, including default configurations, baseline recommendations, and advanced options for both workstations and Windows servers.
ms.topic: best-practice
author: xelu86
ms.author: alalve
ms.date: 05/20/2025
ms.assetid: 0abe0976-4b49-45d6-a7b3-81d28bdb8210
---

# Audit Policy recommendations

This article covers the default Windows audit policy settings and Microsoft's baseline and advanced recommendations for both workstations and servers. It provides guidance to help administrators choose appropriate audit policies based on their organization's needs.

The SCM baseline recommendations shown here, along with the recommended settings to help detect system compromise, are intended only to be a starting baseline guide to administrators. Each organization must make its own decisions regarding the threats they face, their acceptable risk tolerances, and what audit policy categories or subcategories they should enable. For more information about threats, see [Threats and Countermeasures Guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/hh125921(v=ws.10)). Administrators without a thoughtful audit policy in place are encouraged to start with the settings recommended here, and then to modify and test before implementing in their production environment.

The recommendations are for enterprise-class computers, which Microsoft defines as computers that have average security requirements and require a high level of operational functionality. Entities needing higher security requirements should consider more aggressive audit policies.

> [!NOTE]
> Microsoft Windows defaults and baseline recommendations were taken from the [Microsoft Security Compliance Manager tool](/previous-versions/tn-archive/cc677002(v=technet.10)).

The following baseline audit policy settings are recommended for normal security computers that aren't known to be under active, successful attack by determined adversaries or malware.

## Recommended Audit Policies by Operating System

This section contains tables that list the audit setting recommendations that apply to the following operating systems:

- Windows Server 2022
- Windows Server 2019
- Windows Server 2016
- Windows Server 2012
- Windows Server 2012 R2
- Windows Server 2008
- Windows 10
- Windows 8.1
- Windows 7

These tables contain the Windows default setting, the baseline recommendations, and the stronger recommendations for these operating systems.

**Audit Policy table legend**

| **Notation** | **Recommendation** |
| --- | --- |
| Yes | Enable in general scenarios |
| No | Don't enable in general scenarios |
| If | Enable if needed for a specific scenario, or if a role or feature for which auditing is desired is installed on the machine |
| DC | Enable on domain controllers |
| [Blank] | No recommendation |

**Windows 10, Windows 8, and Windows 7 Audit Settings recommendations**

| Audit Policy Category or Subcategory | Windows Default<br>`Success | Failure` | Baseline Recommendation<br>`Success | Failure` | Stronger Recommendation<br>`Success | Failure` |
| --- | :---: | :---: | :---: |
| **Account Logon** |  |  |  |
| Audit Credential Validation | `No | No` | `Yes | No` | `Yes | Yes` |
| Audit Kerberos Authentication Service |  |  | `Yes | Yes` |
| Audit Kerberos Service Ticket Operations |  |  | `Yes | Yes` |
| Audit Other Account Logon Events |  |  | `Yes | Yes` |

| Audit Policy Category or Subcategory | Windows Default<br>`Success | Failure` | Baseline Recommendation<br>`Success | Failure` | Stronger Recommendation<br>`Success | Failure` |
| --- | :---: | :---: | :---: |
| **Account Management** |  |  |  |
| Audit Application Group Management |  |  |  |
| Audit Computer Account Management |  | `Yes | No` | `Yes | Yes` |
| Audit Distribution Group Management |  |  |  |
| Audit Other Account Management Events |  | `Yes | No` | `Yes | Yes` |
| Audit Security Group Management |  | `Yes | No` | `Yes | Yes` |
| Audit User Account Management | `Yes | No` | `Yes | No` | `Yes | Yes` |

| Audit Policy Category or Subcategory | Windows Default<br>`Success | Failure` | Baseline Recommendation<br>`Success | Failure` | Stronger Recommendation<br>`Success | Failure` |
| --- | :---: | :---: | :---: |
| **Detailed Tracking** |  |  |  |
| Audit DPAPI Activity |  |  | `Yes | Yes` |
| Audit Process Creation |  | `Yes | No` | `Yes | Yes` |
| Audit Process Termination |  |  |  |
| Audit RPC Events |  |  |  |

| Audit Policy Category or Subcategory | Windows Default<br>`Success | Failure` | Baseline Recommendation<br>`Success | Failure` | Stronger Recommendation<br>`Success | Failure` |
| --- | :---: | :---: | :---: |
| **DS Access** |  |  |  |
| Audit Detailed Directory Service Replication |  |  |  |
| Audit Directory Service Access |  |  |  |
| Audit Directory Service Changes |  |  |  |
| Audit Directory Service Replication |  |  |  |

| Audit Policy Category or Subcategory | Windows Default<br>`Success | Failure` | Baseline Recommendation<br>`Success | Failure` | Stronger Recommendation<br>`Success | Failure` |
| --- | :---: | :---: | :---: |
| **Logon and Logoff** |  |  |  |
| Audit Account Lockout | `Yes | No` |  | `Yes | No` |
| Audit User/Device Claims |  |  |  |
| Audit IPsec Extended Mode |  |  |  |
| Audit IPsec Main Mode |  |  | `IF | IF` |
| Audit IPsec Quick Mode |  |  |  |
| Audit Logoff | `Yes | No` | `Yes | No` | `Yes | No` |
| Audit Logon <sup>1</sup> | `Yes | Yes` | `Yes | Yes` | `Yes | Yes` |
| Audit Network Policy Server | `Yes | Yes` |  |  |
| Audit Other Logon/Logoff Events |  |  |  |
| Audit Special Logon | `Yes | No` | `Yes | No` | `Yes | Yes` |

| Audit Policy Category or Subcategory | Windows Default<br>`Success | Failure` | Baseline Recommendation<br>`Success | Failure` | Stronger Recommendation<br>`Success | Failure` |
| --- | :---: | :---: | :---: |
| **Object Access** |  |  |  |
| Audit Application Generated |  |  |  |
| Audit Certification Services |  |  |  |
| Audit Detailed File Share |  |  |  |
| Audit File Share |  |  |  |
| Audit File System |  |  |  |
| Audit Filtering Platform Connection |  |  |  |
| Audit Filtering Platform Packet Drop |  |  |  |
| Audit Handle Manipulation |  |  |  |
| Audit Kernel Object |  |  |  |
| Audit Other Object Access Events |  |  |  |
| Audit Registry |  |  |  |
| Audit Removable Storage |  |  |  |
| Audit SAM |  |  |  |
| Audit Central Access Policy Staging |  |  |  |

| Audit Policy Category or Subcategory | Windows Default<br>`Success | Failure` | Baseline Recommendation<br>`Success | Failure` | Stronger Recommendation<br>`Success | Failure` |
| --- | :---: | :---: | :---: |
| **Policy Change** |  |  |  |
| Audit Audit Policy Change | `Yes | No` | `Yes | Yes` | `Yes | Yes` |
| Audit Authentication Policy Change | `Yes | No` | `Yes | No` | `Yes | Yes` |
| Audit Authorization Policy Change |  |  |  |
| Audit Filtering Platform Policy Change |  |  |  |
| Audit MPSSVC Rule-Level Policy Change |  |  | `Yes` |
| Audit Other Policy Change Events |  |  |  |

| Audit Policy Category or Subcategory | Windows Default<br>`Success | Failure` | Baseline Recommendation<br>`Success | Failure` | Stronger Recommendation<br>`Success | Failure` |
| --- | :---: | :---: | :---: |
| **Privilege Use** |  |  |  |
| Audit Non Sensitive Privilege Use |  |  |  |
| Audit Other Privilege Use Events |  |  |  |
| Audit Sensitive Privilege Use |  |  |  |

| Audit Policy Category or Subcategory | Windows Default<br>`Success | Failure` | Baseline Recommendation<br>`Success | Failure` | Stronger Recommendation<br>`Success | Failure` |
| --- | :---: | :---: | :---: |
| **System** |  |  |  |
| Audit IPsec Driver |  | `Yes | Yes` | `Yes | Yes` |
| Audit Other System Events | `Yes | Yes` |  |  |
| Audit Security State Change | `Yes | No` | `Yes | Yes` | `Yes | Yes` |
| Audit Security System Extension |  | `Yes | Yes` | `Yes | Yes` |
| Audit System Integrity | `Yes | Yes` | `Yes | Yes` | `Yes | Yes` |

| Audit Policy Category or Subcategory | Windows Default<br>`Success | Failure` | Baseline Recommendation<br>`Success | Failure` | Stronger Recommendation<br>`Success | Failure` |
| --- | :---: | :---: | :---: |
| **Global Object Access Auditing** |  |  |  |
| Audit IPsec Driver |  |  |  |
| Audit Other System Events |  |  |  |
| Audit Security State Change |  |  |  |
| Audit Security System Extension |  |  |  |
| Audit System Integrity |  |  |  |

<sup>1</sup> Beginning with Windows 10 version 1809, Audit Logon is enabled by default for both Success and Failure. In previous versions of Windows, only Success is enabled by default.

**Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, and Windows Server 2008 Audit Settings recommendations**

| Audit Policy Category or Subcategory | Windows Default<br>`Success | Failure` | Baseline Recommendation<br>`Success | Failure` | Stronger Recommendation<br>`Success | Failure` |
| --- | :---: | :---: | :---: |
| **Account Logon** |  |  |  |
| Audit Credential Validation | `No | No` | `Yes | Yes` | `Yes | Yes` |
| Audit Kerberos Authentication Service |  |  | `Yes | Yes` |
| Audit Kerberos Service Ticket Operations |  |  | `Yes | Yes` |
| Audit Other Account Logon Events |  |  | `Yes | Yes` |

| Audit Policy Category or Subcategory | Windows Default<br>`Success | Failure` | Baseline Recommendation<br>`Success | Failure` | Stronger Recommendation<br>`Success | Failure` |
| --- | :---: | :---: | :---: |
| **Account Management** |  |  |  |
| Audit Application Group Management |  |  |  |
| Audit Computer Account Management |  | `Yes | DC` | `Yes | Yes` |
| Audit Distribution Group Management |  |  |  |
| Audit Other Account Management Events |  | `Yes | Yes` | `Yes | Yes` |
| Audit Security Group Management |  | `Yes | Yes` | `Yes | Yes` |
| Audit User Account Management | `Yes | No` | `Yes | Yes` | `Yes | Yes` |

| Audit Policy Category or Subcategory | Windows Default<br>`Success | Failure` | Baseline Recommendation<br>`Success | Failure` | Stronger Recommendation<br>`Success | Failure` |
| --- | :---: | :---: | :---: |
| **Detailed Tracking** |  |  |  |
| Audit DPAPI Activity |  |  | `Yes | Yes` |
| Audit Process Creation |  | `Yes | No` | `Yes | Yes` |
| Audit Process Termination |  |  |  |
| Audit RPC Events |  |  |  |

| Audit Policy Category or Subcategory | Windows Default<br>`Success | Failure` | Baseline Recommendation<br>`Success | Failure` | Stronger Recommendation<br>`Success | Failure` |
| --- | :---: | :---: | :---: |
| **DS Access** |  |  |  |
| Audit Detailed Directory Service Replication |  |  |  |
| Audit Directory Service Access |  | `DC | DC` | `DC | DC` |
| Audit Directory Service Changes |  | `DC | DC` | `DC | DC` |
| Audit Directory Service Replication |  |  |  |

| Audit Policy Category or Subcategory | Windows Default<br>`Success | Failure` | Baseline Recommendation<br>`Success | Failure` | Stronger Recommendation<br>`Success | Failure` |
| --- | :---: | :---: | :---: |
| **Logon and Logoff** |  |  |  |
| Audit Account Lockout | `Yes | No` |  | `Yes | No` |
| Audit User/Device Claims |  |  |  |
| Audit IPsec Extended Mode |  |  |  |
| Audit IPsec Main Mode |  |  | `IF | IF` |
| Audit IPsec Quick Mode |  |  |  |
| Audit Logoff | `Yes | No` | `Yes | No` | `Yes | No` |
| Audit Logon | `Yes | Yes` | `Yes | Yes` | `Yes | Yes` |
| Audit Network Policy Server | `Yes | Yes` |  |  |
| Audit Other Logon/Logoff Events |  |  | `Yes | Yes` |
| Audit Special Logon | `Yes | No` | `Yes | No` | `Yes | Yes` |

| Audit Policy Category or Subcategory | Windows Default<br>`Success | Failure` | Baseline Recommendation<br>`Success | Failure` | Stronger Recommendation<br>`Success | Failure` |
| --- | :---: | :---: | :---: |
| **Object Access** |  |  |  |
| Audit Application Generated |  |  |  |
| Audit Certification Services |  |  |  |
| Audit Detailed File Share |  |  |  |
| Audit File Share |  |  |  |
| Audit File System |  |  |  |
| Audit Filtering Platform Connection |  |  |  |
| Audit Filtering Platform Packet Drop |  |  |  |
| Audit Handle Manipulation |  |  |  |
| Audit Kernel Object |  |  |  |
| Audit Other Object Access Events |  |  |  |
| Audit Registry |  |  |  |
| Audit Removable Storage |  |  |  |
| Audit SAM |  |  |  |
| Audit Central Access Policy Staging |  |  |  |

| Audit Policy Category or Subcategory | Windows Default<br>`Success | Failure` | Baseline Recommendation<br>`Success | Failure` | Stronger Recommendation<br>`Success | Failure` |
| --- | :---: | :---: | :---: |
| **Policy Change** |  |  |  |
| Audit Audit Policy Change | `Yes | No` | `Yes | Yes` | `Yes | Yes` |
| Audit Authentication Policy Change | `Yes | No` | `Yes | No` | `Yes | Yes` |
| Audit Authorization Policy Change |  |  |  |
| Audit Filtering Platform Policy Change |  |  |  |
| Audit MPSSVC Rule-Level Policy Change |  |  | `Yes` |
| Audit Other Policy Change Events |  |  |  |

| Audit Policy Category or Subcategory | Windows Default<br>`Success | Failure` | Baseline Recommendation<br>`Success | Failure` | Stronger Recommendation<br>`Success | Failure` |
| --- | :---: | :---: | :---: |
| **Privilege Use** |  |  |  |
| Audit Non Sensitive Privilege Use |  |  |  |
| Audit Other Privilege Use Events |  |  |  |
| Audit Sensitive Privilege Use |  |  |  |

| Audit Policy Category or Subcategory | Windows Default<br>`Success | Failure` | Baseline Recommendation<br>`Success | Failure` | Stronger Recommendation<br>`Success | Failure` |
| --- | :---: | :---: | :---: |
| **System** |  |  |  |
| Audit IPsec Driver |  | `Yes | Yes` | `Yes | Yes` |
| Audit Other System Events | `Yes | Yes` |  |  |
| Audit Security State Change | `Yes | No` | `Yes | Yes` | `Yes | Yes` |
| Audit Security System Extension |  | `Yes | Yes` | `Yes | Yes` |
| Audit System Integrity | `Yes | Yes` | `Yes | Yes` | `Yes | Yes` |

| Audit Policy Category or Subcategory | Windows Default<br>`Success | Failure` | Baseline Recommendation<br>`Success | Failure` | Stronger Recommendation<br>`Success | Failure` |
| --- | :---: | :---: | :---: |
| **Global Object Access Auditing** |  |  |  |
| Audit IPsec Driver |  |  |  |
| Audit Other System Events |  |  |  |
| Audit Security State Change |  |  |  |
| Audit Security System Extension |  |  |  |
| Audit System Integrity |  |  |  |

## Set Audit Policy on workstations and servers

All event log management plans should monitor workstations and servers. A common mistake is to only monitor servers or domain controllers. Because malicious hacking often initially occurs on workstations, not monitoring workstations is ignoring the best and earliest source of information.

Administrators should thoughtfully review and test any audit policy before implementation in their production environment.

## Events to monitor

A perfect event ID to generate a security alert should contain the following attributes:

- High likelihood that occurrence indicates unauthorized activity

- Low number of false positives

- Occurrence should result in an investigative/forensics response

Two types of events should be monitored and alerted:

1. Events where an occurrence is a strong indicator of unauthorized or suspicious activity.

2. An accumulation of events above an expected and accepted baseline.

An example of the first event is:

If Domain Admins are forbidden from logging on to computers that aren't domain controllers, a single occurrence of a Domain Admin member logging on to an end-user workstation should generate an alert and be investigated. This type of alert is easy to generate by using the Audit Special Logon event 4964 (Special groups were assigned to a new logon). Other examples of single instance alerts include:

- If *Server A* should never connect to *Server B*, alert when they connect to each other.

- Alert if a standard user account is unexpectedly added to a privileged or sensitive security group.

- If employees in factory location A never work at night, alert when a user logs on at midnight.

- Alert if an unauthorized service is installed on a domain controller.

- Investigate if a regular end-user attempts to directly sign in a SQL Server for which they have no clear reason for doing so.

- If you have no members in your Domain Admin group, and someone adds themselves there, check it immediately.

An example of the second event is:

An aberrant number of failed logons could indicate a password guessing attack. For an enterprise to provide an alert for an unusually high number of failed logons, they must first understand the normal levels of failed logons within their environment before a malicious security event.

For a comprehensive list of events that you should include when you monitor for signs of compromise, see [Appendix L: Events to Monitor](../../../ad-ds/plan/Appendix-L--Events-to-Monitor.md).

## Active Directory objects and attributes to monitor

The following are the accounts, groups, and attributes that you should monitor to help you detect attempts to compromise your Active Directory Domain Services installation.

- Systems for disabling or removal of antivirus and anti-malware software (automatically restart protection when it's manually disabled)

- Administrator accounts for unauthorized changes

- Activities that are performed by using privileged accounts (automatically remove account when suspicious activities are completed or the allotted time expired)

- Privileged and VIP accounts in AD DS. Monitor for changes to attributes on the Account tab, such as: cn, name, sAMAccountName, userPrincipalName, or userAccountControl. In addition to monitoring the accounts, restrict who can modify the accounts to as small a set of administrative users as possible.

Refer to [Appendix L: Events to Monitor](../../../ad-ds/plan/Appendix-L--Events-to-Monitor.md) for a list of recommended events to monitor, their criticality ratings, and an event message summary.

- Group servers by the classification of their workloads, which allows you to quickly identify the servers that should be the most closely monitored and most stringently configured

- Changes to the properties and membership of following AD DS groups: Enterprise Admins, Domain Admins, Administrators, and Schema Admins

- Disabled privileged accounts (such as built-in Administrator accounts in Active Directory and on member systems) for enabling the accounts

- Management accounts to log all writes to the account

- Built-in Security Configuration Wizard to configure service, registry, audit, and firewall settings to reduce the server's attack surface. Use this wizard if you implement jump servers as part of your administrative host strategy.

## Additional information for monitoring AD DS

Review the following links for additional information about monitoring AD DS:

- [Global Object Access Auditing is Magic](/archive/blogs/askds/global-object-access-auditing-is-magic)

- [Introducing Auditing Changes in Windows 2008](/archive/blogs/askds/introducing-auditing-changes-in-windows-2008)

- [Cool Auditing Tricks in Vista and 2008](/archive/blogs/askds/cool-auditing-tricks-in-vista-and-2008)

- [One-Stop Shop for Auditing in Windows Server 2008 and Windows Vista](/archive/blogs/askds/one-stop-shop-for-auditing-in-windows-server-2008-and-windows-vista)

- [AD DS Auditing Step-by-Step Guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc731607(v=ws.10))

## Security event ID recommendation criticalities

All Event ID recommendations are accompanied by a criticality rating as follows:

**High:** Event IDs with a high criticality rating should always and immediately be alerted and investigated.

**Medium:** An Event ID with a medium criticality rating could indicate malicious activity, but it must be accompanied by some other abnormality. For example, this could include an unusual number occurring in a particular time period, unexpected occurrences, or occurrences on a computer that normally wouldn't be expected to log the event. A medium-criticality event might also be collected as a metric and then compared over time.

**Low:** And Event ID with a low criticality events shouldn't garner attention or cause alerts, unless correlated with medium or high criticality events.

These recommendations are meant to provide a baseline guide for the administrator. All recommendations should be thoroughly reviewed before implementing in a production environment.

Refer to [Appendix L: Events to Monitor](../../../ad-ds/plan/Appendix-L--Events-to-Monitor.md) for a list of the recommended events to monitor, their criticality ratings, and an event message summary.

## Advanced Security Audit policy settings

The security audit policy settings found under **Security Settings\\Advanced Audit Policy Configuration** enable organizations to monitor compliance with key business and security requirements by tracking specific activities, such as:

- Modifications made by group administrators to settings or data on servers containing sensitive information (for example, finance servers).

- Access to critical files by employees within designated groups.

- Application of the correct system access control list (SACL) to all files, folders, or registry keys on a computer or file share, providing a verifiable safeguard against unauthorized access.

You can access these audit policy settings through the Local Security Policy snap-in (secpol.msc) on the local computer or by using Group Policy.

Advanced Audit Policy settings provide granular control over which activities are monitored, allowing you to focus on events that are most relevant to your organization. You can exclude auditing for actions that aren't important or that generate unnecessary log volume. Additionally, because these policies can be managed through domain Group Policy Objects, you can easily modify, test, and deploy audit configurations to specific users and groups as needed.

The advanced Audit Policy configurations are as follows:

| **Policy** | **Description** | **Subcategory** |
|---|---|---|
| Account Logon | Configuring policy settings in this category can help you document attempts to authenticate account data on a domain controller or on a local Security Accounts Manager (SAM). Unlike Logon and Logoff policy settings and events, which track attempts to access a particular computer, settings and events in this category focus on the account database that is used.| [Audit Credential Validation](dn319049\(v=ws.11\).md)<br><br>[Audit Kerberos Authentication Service](dn319109\(v=ws.11\).md)<br><br>[Audit Kerberos Service Ticket Operations](dn319105\(v=ws.11\).md)<br><br>[Audit Other Logon-Logoff Events](dn311470\(v=ws.11\).md)<br><br> |
| Account Management | The security audit policy settings in this category can be used to monitor changes to user and computer accounts and groups.| [Audit Application Group Management](dn311463\(v=ws.11\).md)<br><br>[Audit Computer Account Management](dn319065\(v=ws.11\).md)<br><br>[Audit Distribution Group Management](dn319059\(v=ws.11\).md)<br><br>[Audit Other Account Management Events](dn311462\(v=ws.11\).md)<br><br>[Audit Security Group Management](dn311500\(v=ws.11\).md)<br><br>[Audit User Account Management](dn319091\(v=ws.11\).md)<br><br> |
| Detailed Tracking | Detailed Tracking security policy settings and audit events help monitor the activities of individual applications and users on a computer. These settings provide insight into how the computer is being used. | [Audit DPAPI Activity](dn319104\(v=ws.11\).md)<br><br>[Audit Process Creation](dn319093\(v=ws.11\).md)<br><br>[Audit Process Termination](dn319122\(v=ws.11\).md)<br><br>[Audit RPC Events](dn319083\(v=ws.11\).md)<br><br> |
| DS Access | DS Access security audit policy settings provide a detailed audit trail of attempts to access and modify objects in Active Directory Domain Services (AD DS). These audit events are logged only on domain controllers.<br> | [Audit Detailed Directory Service Replication](dn311482\(v=ws.11\).md)<br><br>[Audit Directory Service Access](dn311490\(v=ws.11\).md)<br><br>[Audit Directory Service Changes](dn319096\(v=ws.11\).md)<br><br>[Audit Directory Service Replication](dn319121\(v=ws.11\).md)<br> |
| Logon/Logoff | Logon/Logoff security policy settings and audit events allow you to track sign in attempts on a computer interactively or over a network. These events are useful for tracking user activity and identifying potential attacks on network resources.<br> | [Audit Account Lockout](dn319074\(v=ws.11\).md)<br><br>[Audit IPsec Extended Mode](dn319077\(v=ws.11\).md)<br><br>[Audit IPsec Main Mode](dn319106\(v=ws.11\).md)<br><br>[Audit IPsec Quick Mode](dn319107\(v=ws.11\).md)<br><br>[Audit Logoff](dn319085\(v=ws.11\).md)<br><br>[Audit Logon](dn319080\(v=ws.11\).md)<br><br>[Audit Network Policy Server](dn311469\(v=ws.11\).md)<br><br>[Audit Other Logon-Logoff Events](dn311470\(v=ws.11\).md)<br><br>[Audit Special Logon](dn319088\(v=ws.11\).md)<br> |
| Object Access | Object Access policy settings and audit events allow you to track attempts to access specific objects or types of objects on a network or computer.<br><br>To audit attempts to access a file, directory, registry key, or any other object, you must enable the appropriate Object Access auditing subcategory for success and/or failure events.<br><br>For example, the File System subcategory needs to be enabled to audit file operations, and the Registry subcategory needs to be enabled to audit registry accesses.<br><br>Proving that these audit policies are in effect to an external auditor is more difficult. There's no easy way to verify that the proper SACLs are set on all inherited objects. To address this issue, see the **Global Object Access** policy. | [Audit Application Generated](dn319094\(v=ws.11\).md)<br><br>[Audit Certification Services](dn319076\(v=ws.11\).md)<br><br>[Audit Detailed File Share](dn319118\(v=ws.11\).md)<br><br>[Audit File Share](dn311489\(v=ws.11\).md)<br><br>[Audit File System](dn319068\(v=ws.11\).md)<br><br>[Audit Filtering Platform Connection](dn311466\(v=ws.11\).md)<br><br>[Audit Filtering Platform Packet Drop](dn311496\(v=ws.11\).md)<br><br>[Audit Handle Manipulation](dn319090\(v=ws.11\).md)<br><br>[Audit Kernel Object](dn319064\(v=ws.11\).md)<br><br>[Audit Other Object Access Events](dn319119\(v=ws.11\).md)<br><br>[Audit Registry](dn311473\(v=ws.11\).md)<br><br>[Audit SAM](dn319052\(v=ws.11\).md)<br> |
| Policy Change | Policy Change audit events allow you to track changes to important security policies on a local system or network.<br><br>Because policies are typically established by administrators to help secure network resources, monitoring changes or attempts to change these policies can be an important aspect of security management for a network. | [Audit Audit Policy Change](dn319116\(v=ws.11\).md)<br><br>[Audit Authentication Policy Change](dn319066\(v=ws.11\).md)<br><br>[Audit Authorization Policy Change](dn319089\(v=ws.11\).md)<br><br>[Audit Filtering Platform Policy Change](dn319087\(v=ws.11\).md)<br><br>[Audit MPSSVC Rule-Level Policy Change](dn319069\(v=ws.11\).md)<br><br>[Audit Other Policy Change Events](dn311459\(v=ws.11\).md) |
| Privilege Use | Permissions on a network are granted for users or computers to complete defined tasks. Privilege Use security policy settings and audit events allow you to track the use of certain permissions on one or more systems. | [Audit Non-Sensitive Privilege Use](dn311481\(v=ws.11\).md)<br>[Audit Sensitive Privilege Use](dn319113\(v=ws.11\).md)<br>[Audit Other Privilege Use Events](dn319092\(v=ws.11\).md)<br> |
| System | System security policy settings and audit events allow you to track system-level changes to a computer that aren't included in other categories. These changes might have potential security implications. | [Audit IPsec Driver](dn319103\(v=ws.11\).md)<br>[Audit Other System Events](dn319050\(v=ws.11\).md)<br><br>[Audit Security State Change](dn311493\(v=ws.11\).md)<br><br>[Audit Security System Extension](dn311491\(v=ws.11\).md)<br>[Audit System Integrity](dn319081\(v=ws.11\).md)<br> |
| Global Object Access | Global Object Access Auditing policy settings allow administrators to define computer SACLs per object type for the file system or for the registry. The specified SACL is then automatically applied to every object of that type.<br><br>Auditors are able to prove that every resource in the system is protected by an audit policy by viewing the contents of the Global Object Access Auditing policy settings. For example, if auditors see a policy setting called "Track all changes made by group administrators," they know that this policy is in effect.<br><br>Resource SACLs are also useful for diagnostic scenarios. For example, setting the Global Object Access Auditing policy to log all the activity for a specific user can help administrators quickly identify which object in a system is denying a user access. Enabling the policy to track "Access denied" events for the file system or registry aids in pinpointing the source of denied access. | [File System (Global Object Access Auditing)](dn319112\(v=ws.11\).md)<br><br>[Registry (Global Object Access Auditing)](dn311461\(v=ws.11\).md) |

> [!NOTE]
> When both a file or folder SACL and a Global Object Access Auditing policy are configured on a computer (or both a registry SACL and a Global Object Access Auditing policy), the effective SACL is a combination of the two. An audit event is triggered if an action matches either the file or folder SACL or the Global Object Access Auditing policy.
