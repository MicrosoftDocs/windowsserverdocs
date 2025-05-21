---
title: Advanced Security Audit Policy Settings
TOCTitle: Advanced Security Audit Policy Settings
ms.topic: concept-article
ms.author: alalve
author: xelu86
ms.date: 05/20/2025
---





## Advanced Security Audit policy settings

The security audit policy settings found under **Security Settings\\Advanced Audit Policy Configuration** enable organizations to monitor compliance with key business and security requirements by tracking specific activities, such as:

- Modifications made by group administrators to settings or data on servers containing sensitive information (for example, finance servers).

- Access to critical files by employees within designated groups.

- Application of the correct system access control list (SACL) to all files, folders, or registry keys on a computer or file share, providing a verifiable safeguard against unauthorized access.

You can access these audit policy settings through the Local Security Policy snap-in (secpol.msc) on the local computer or by using Group Policy.

Advanced Audit Policy settings provide granular control over which activities are monitored, allowing you to focus on events that are most relevant to your organization. You can exclude auditing for actions that aren't important or that generate unnecessary log volume. Additionally, because these policies can be managed through domain Group Policy Objects, you can easily modify, test, and deploy audit configurations to specific users and groups as needed.

The advanced Audit Policy configurations are as follows:

- **Account Logon**

  Configuring policy settings in this category can help you document attempts to authenticate account data on a domain controller or on a local Security Accounts Manager (SAM). Unlike Logon and Logoff policy settings and events, which track attempts to access a particular computer, settings and events in this category focus on the account database that is used. This category includes the following subcategories:

  <details>
  <summary> Expand Audit Credential Validation policy

  The **Audit Credential Validation** policy determines whether the operating system generates audit events on credentials that are submitted for a user account logon request. These events occur on the computer that is authoritative for the credentials as follows:

  - For domain accounts, the domain controller is authoritative.
  - For local accounts, the local computer is authoritative.

  Because domain accounts are used much more frequently than local accounts in enterprise environments, most of the Account Logon events in a domain environment occur on the domain controllers that are authoritative for the domain accounts. However, these events can occur on any computer, and they might occur with or on separate computers from Logon and Logoff events.

  | Event ID | Event message |
  |--|--|
  | 4774 | An account was mapped for logon. |
  | 4775 | An account couldn't be mapped for logon. |
  | 4776 | The domain controller attempted to validate the credentials for an account. |
  | 4777 | The domain controller failed to validate the credentials for an account. |

  - Event volume: **High** on domain controllers.
  - Default on Client editions: **No Auditing**.
  - Default on Server editions: **Success**.

  </details>

  <details>
  <summary> Expand Audit Credential Validation policy

  The **Audit Kerberos Authentication Service** policy controls whether audit events are generated when a Kerberos authentication ticket-granting ticket (TGT) is requested. With this setting enabled, it helps administrators monitor Kerberos sign-in activity and detect potential security issues related to authentication requests.

  If you configure this policy setting, an audit event is generated after a Kerberos authentication TGT request. Success audits record successful attempts and failure audits record unsuccessful attempts.

  | Event ID | Event message |
  |--|--|--|
  |  4768  | A Kerberos authentication ticket (TGT) was requested. |
  |  4771  | Kerberos preauthentication failed. |
  |  4772  | A Kerberos authentication ticket request failed. |

  - Event volume: **High** on Kerberos Key Distribution Center servers.
  - Default on Client editions: **No Auditing**.
  - Default on Server editions: **Success**.

  </details>

  <details>
  <summary> Expand Audit Kerberos Service Ticket Operations policy

  The **Audit Kerberos Service Ticket Operations** policy controls whether the operating system logs security audit events when Kerberos service tickets are requested or renewed. Enabling this setting helps administrators monitor and track Kerberos authentication activity within the environment.

  Events are generated every time Kerberos is used to authenticate a user who wants to access a protected network resource. Kerberos service ticket operation audit events can be used to track user activity.

  | Event ID | Event message |
  |--|--|
  | 4769 | A Kerberos service ticket was requested. |
  | 4770 | A Kerberos service ticket was renewed. |

  - Event volume: **High** on a domain controller that is in a Key Distribution Center (KDC).
                  **Low** on domain members.
  - Default: **Not configured**.

  </details>

  <details>
  <summary> Expand Audit Other Account Logon Events

  The **Audit Other Account Logon Events** policy audits events triggered by responses to credential requests for user account logons that aren't standard credential validation or Kerberos ticket requests. Examples can include:

  - When you start a new Remote Desktop sessions and session disconnections.

  - When you lock and unlock a workstation.

  - When you invoke or dismiss a screen saver.

  - When a Kerberos replay attack is detected, in which a Kerberos request with identical information was received twice.

    > [!NOTE]
    > This situation might result from a network configuration issue.

  - When you access a wireless network or a wired 802.1x network granted to a user or computer account

  | Event ID | Event message |
  |--|--|
  | 4649 | A replay attack was detected. |
  | 4778 | A session was reconnected to a Window Station. |
  | 4779 | A session was disconnected from a Window Station. |
  | 4800 | The workstation was locked. |
  | 4801 | The workstation was unlocked. |
  | 4802 | The screen saver was invoked. |
  | 4803 | The screen saver was dismissed. |
  | 5378 | The requested credentials delegation wasn't allowed by policy. |
  | 5632 | A request was made to authenticate to a wireless network. |
  | 5633 | A request was made to authenticate to a wired network. |

  - Event volume: *Varies* depending on system use.
  - Default: **Not configured**.

  </details>

- **Account Management**

  The security audit policy settings in this category can be used to monitor changes to user and computer accounts and groups. This category includes the following subcategories:

  <details>
  <summary> Expand Audit Application Group Management policy

  The **Audit Application Group Management** policy controls whether the operating system logs audit events when certain actions are performed. These actions include creating, modifying, or deleting application groups, and changing their membership. Application group management tasks include:

  - An application group is created, changed, or deleted.
  - A member is added to or removed from an application group.

  | Event ID | Event message |
  |--|--|
  | 4783 | A basic application group was created. |
  | 4784 | A basic application group was changed. |
  | 4785 | A member was added to a basic application group. |
  | 4786 | A member was removed from a basic application group. |
  | 4787 | A non-member was added to a basic application group. |
  | 4788 | A non-member was removed from a basic application group. |
  | 4789 | A basic application group was deleted. |
  | 4790 | A Lightweight Directory Access Protocol (LDAP) query group was created. |

  - Event volume: **Low**.
  - Default: **No Auditing**.

  </details>

  <details>
  <summary> Expand Audit Computer Account Management policy

  The **Audit Computer Account Management** policy controls whether the operating system logs audit events when a computer account is created, modified, or deleted in Active Directory. When you enable this policy, it helps administrators monitor and track changes to computer accounts within a domain. Valuable information for security auditing, compliance, and troubleshooting account management activities is provided by monitoring these events.

  | Event ID | Event message |
  |--|--|
  | 4741 | A computer account was created. |
  | 4742 | A computer account was changed. |
  | 4743 | A computer account was deleted. |

  - Event volume: **Low**.
  - Default on Client editions: **No Auditing**.
  - Default on Server editions: **Success**.

- **Detailed Tracking**

    Detailed Tracking security policy settings and audit events can be used to monitor the activities of individual applications and users on that computer, and to understand how a computer is being used. This category includes the following subcategories:

  - [Audit DPAPI Activity](dn319104\(v=ws.11\).md)

  - [Audit Process Creation](dn319093\(v=ws.11\).md)

  - [Audit Process Termination](dn319122\(v=ws.11\).md)

  - [Audit RPC Events](dn319083\(v=ws.11\).md)

- **DS Access**

    DS Access security audit policy settings provide a detailed audit trail of attempts to access and modify objects in Active Directory Domain Services (AD DS). These audit events are logged only on domain controllers. This category includes the following subcategories:

  - [Audit Detailed Directory Service Replication](dn311482\(v=ws.11\).md)

  - [Audit Directory Service Access](dn311490\(v=ws.11\).md)

  - [Audit Directory Service Changes](dn319096\(v=ws.11\).md)

  - [Audit Directory Service Replication](dn319121\(v=ws.11\).md)

- **Logon/Logoff**

    Logon/Logoff security policy settings and audit events allow you to track attempts to log on to a computer interactively or over a network. These events are particularly useful for tracking user activity and identifying potential attacks on network resources. This category includes the following subcategories:

  - [Audit Account Lockout](dn319074\(v=ws.11\).md)

  - [Audit IPsec Extended Mode](dn319077\(v=ws.11\).md)

  - [Audit IPsec Main Mode](dn319106\(v=ws.11\).md)

  - [Audit IPsec Quick Mode](dn319107\(v=ws.11\).md)

  - [Audit Logoff](dn319085\(v=ws.11\).md)

  - [Audit Logon](dn319080\(v=ws.11\).md)

  - [Audit Network Policy Server](dn311469\(v=ws.11\).md)

  - [Audit Other Logon-Logoff Events](dn311470\(v=ws.11\).md)

  - [Audit Special Logon](dn319088\(v=ws.11\).md)

- **Object Access**

    Object Access policy settings and audit events allow you to track attempts to access specific objects or types of objects on a network or computer. To audit attempts to access a file, directory, registry key, or any other object, you must enable the appropriate Object Access auditing subcategory for success and/or failure events. For example, the File System subcategory needs to be enabled to audit file operations, and the Registry subcategory needs to be enabled to audit registry accesses.

    This category includes the following subcategories:

  - [Audit Application Generated](dn319094\(v=ws.11\).md)

  - [Audit Certification Services](dn319076\(v=ws.11\).md)

  - [Audit Detailed File Share](dn319118\(v=ws.11\).md)

  - [Audit File Share](dn311489\(v=ws.11\).md)

  - [Audit File System](dn319068\(v=ws.11\).md)

  - [Audit Filtering Platform Connection](dn311466\(v=ws.11\).md)

  - [Audit Filtering Platform Packet Drop](dn311496\(v=ws.11\).md)

  - [Audit Handle Manipulation](dn319090\(v=ws.11\).md)

  - [Audit Kernel Object](dn319064\(v=ws.11\).md)

  - [Audit Other Object Access Events](dn319119\(v=ws.11\).md)

  - [Audit Registry](dn311473\(v=ws.11\).md)

  - [Audit SAM](dn319052\(v=ws.11\).md)

- **Policy Change**

    Policy Change audit events allow you to track changes to important security policies on a local system or network. Because policies are typically established by administrators to help secure network resources, monitoring changes or attempts to change these policies can be an important aspect of security management for a network. This category includes the following subcategories:

  - [Audit Audit Policy Change](dn319116\(v=ws.11\).md)

  - [Audit Authentication Policy Change](dn319066\(v=ws.11\).md)

  - [Audit Authorization Policy Change](dn319089\(v=ws.11\).md)

  - [Audit Filtering Platform Policy Change](dn319087\(v=ws.11\).md)

  - [Audit MPSSVC Rule-Level Policy Change](dn319069\(v=ws.11\).md)

  - [Audit Other Policy Change Events](dn311459\(v=ws.11\).md)

- **Privilege Use**

    Permissions on a network are granted for users or computers to complete defined tasks. Privilege Use security policy settings and audit events allow you to track the use of certain permissions on one or more systems. This category includes the following subcategories:

  - [Audit Non-Sensitive Privilege Use](dn311481\(v=ws.11\).md)

  - [Audit Sensitive Privilege Use](dn319113\(v=ws.11\).md)

  - [Audit Other Privilege Use Events](dn319092\(v=ws.11\).md)

- **System**

    System security policy settings and audit events allow you to track system-level changes to a computer that are not included in other categories and that have potential security implications. This category includes the following subcategories:

  - [Audit IPsec Driver](dn319103\(v=ws.11\).md)

  - [Audit Other System Events](dn319050\(v=ws.11\).md)

  - [Audit Security State Change](dn311493\(v=ws.11\).md)

  - [Audit Security System Extension](dn311491\(v=ws.11\).md)

  - [Audit System Integrity](dn319081\(v=ws.11\).md)

- **Global Object Access**

> [!NOTE]
> When both a file or folder SACL and a Global Object Access Auditing policy are configured on a computer (or both a registry SACL and a Global Object Access Auditing policy), the effective SACL is a combination of the two. An audit event is triggered if an action matches either the file or folder SACL or the Global Object Access Auditing policy.
