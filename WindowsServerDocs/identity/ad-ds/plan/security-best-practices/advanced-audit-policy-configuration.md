---
title: Advanced Audit Policy Configuration settings
description: The Advanced Audit Policy Configuration settings in Group Policy allows admins to specify which security events are audited on Windows systems for tracking activities, security monitoring, and incident detection.
ms.topic: concept-article
ms.author: daknappe
author: dknappettmsft
ms.date: 05/29/2025
---

# Advanced Audit Policy Configuration

The Advanced Audit Policy Configuration settings are found under **Computer Configuration\Windows Settings\Security Settings\Advanced Audit Policy Configuration\System Audit Policies** in Group Policy. These settings enable organizations to monitor compliance with key business and security requirements by tracking specific activities, such as:

- Modifications made by group administrators to settings or data on servers containing sensitive information (for example, finance servers).

- Access to critical files by employees within designated groups.

- Application of the correct system access control list (SACL) to all files, folders, or registry keys on a computer or file share, providing a verifiable safeguard against unauthorized access.

You can access these audit policy settings through the Local Security Policy snap-in (`secpol.msc`) on the local computer or by using Group Policy.

These advanced audit policy settings provide granular control over which activities are monitored, allowing you to focus on events that are most relevant to your organization. You can exclude auditing for actions that aren't important or that generate unnecessary log volume. Additionally, because these policies can be managed through domain Group Policy Objects, you can easily modify, test, and deploy audit configurations to specific users and groups as needed.

The advanced Audit Policy configurations are as follows:

- **Account Logon**

  Configuring policy settings in this category can help you document attempts to authenticate account data on a domain controller or on a local Security Accounts Manager (SAM). Unlike **Logon** and **Logoff** policy settings and events, which track attempts to access a particular computer, settings and events in this category focus on the account database that is used. This category includes the following subcategories:

  <br>
  <details>
  <summary> Expand Audit Credential Validation policy </summary>

  The **Audit Credential Validation** policy determines whether the OS (OS) generates audit events on credentials that are submitted for a user account logon request. These events occur on the computer that is authoritative for the credentials as follows:

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
  <summary> Expand Audit Kerberos Authentication Service policy </summary>

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
  <summary> Expand Audit Kerberos Service Ticket Operations policy </summary>

  The **Audit Kerberos Service Ticket Operations** policy controls whether the OS logs security audit events when Kerberos service tickets are requested or renewed. Enabling this setting helps administrators monitor and track Kerberos authentication activity within the environment.

  Events are generated every time Kerberos is used to authenticate a user who wants to access a protected network resource. Kerberos service ticket operation audit events can be used to track user activity.

  | Event ID | Event message |
  |--|--|
  | 4769 | A Kerberos service ticket was requested. |
  | 4770 | A Kerberos service ticket was renewed. |

  - Event volume: **High** on a domain controller that is in a Key Distribution Center (KDC). **Low** on domain members.

  - Default: **Not configured**.

  </details>

  <details>
  <summary> Expand Audit Other Account Logon Events </summary>

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

  - Default: **No Auditing**.

  </details>

- **Account Management**

  The security audit policy settings in this category can be used to monitor changes to user and computer accounts and groups. This category includes the following subcategories:

  <br>
  <details>
  <summary> Expand Audit Application Group Management policy </summary>

  The **Audit Application Group Management** policy controls whether the OS logs audit events when certain actions are performed. These actions include creating, modifying, or deleting application groups, and changing their membership. Application group management tasks include:

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
  <summary> Expand Audit Computer Account Management policy </summary>

  The **Audit Computer Account Management** policy controls whether the OS logs audit events when a computer account is created, modified, or deleted in Active Directory. When you enable this policy, it helps administrators monitor and track changes to computer accounts within a domain. Valuable information for security auditing, compliance, and troubleshooting account management activities is provided by monitoring these events.

  | Event ID | Event message |
  |--|--|
  | 4741 | A computer account was created. |
  | 4742 | A computer account was changed. |
  | 4743 | A computer account was deleted. |

  - Event volume: **Low**.

  - Default on Client editions: **No Auditing**.

  - Default on Server editions: **Success**.

  <details>
  <summary> Expand Audit Distribution Group Management policy </summary>

  The **Audit Distribution Group Management** policy determines whether the OS generates audit events for specific distribution-group management tasks. This subcategory to which this policy belongs is logged only on domain controllers. Tasks for distribution-group management that can be audited include:

  - A distribution group is created, changed, or deleted.

  - A member is added to or removed from a distribution group.

  > [!NOTE]
  > Distribution groups can't be used to manage access control permissions.

  | Event ID | Event message |
  |--|--|
  | 4744 | A security-disabled local group was created. |
  | 4745 | A security-disabled local group was changed. |
  | 4746 | A member was added to a security-disabled local group. |
  | 4747 | A member was removed from a security-disabled local group. |
  | 4748 | A security-disabled local group was deleted. |
  | 4749 | A security-disabled global group was created. |
  | 4750 | A security-disabled global group was changed. |
  | 4751 | A member was added to a security-disabled global group. |
  | 4752 | A member was removed from a security-disabled global group. |
  | 4753 | A security-disabled global group was deleted. |
  | 4759 | A security-disabled universal group was created. |
  | 4760 | A security-disabled universal group was changed. |
  | 4761 | A member was added to a security-disabled universal group. |
  | 4762 | A member was removed from a security-disabled universal group. |

  - Event volume: **Low**.

  - Default: **No Auditing**.

  </details>

  <details>
  <summary> Expand Audit Other Account Management Events policy </summary>

  The **Audit Other Account Management Events** policy determines whether the OS generates user account management audit events. Events can be generated for user account management auditing when:

  - The password hash of an account is accessed. This typically happens when the Active Directory Migration Tool (ADMT) is moving password data.

  - The Password Policy Checking application programming interface (API) is called. Calls to this function could be part of an attack from a malicious application that is testing whether password complexity policy settings are being applied.

  > [!NOTE]
  > These events are logged when the domain policy is applied (on refresh or restart), not when settings are modified by an administrator.
  >
  > Changes made to the domain policy are under **Computer Configuration\Windows Settings\Security Settings\Account Policies\Password Policy** or **Computer Configuration\Windows Settings\Security Settings\Account Policies\Account Lockout Policy**.

  | Event ID | Event message |
  |--|--|
  | 4782 | The password hash for an account was accessed. |
  | 4793 | The Password Policy Checking API was called. |

  - Event volume: **Low**.

  - Default: **No Auditing**.

  </details>

  <details>
  <summary> Expand Audit Security Group Management policy </summary>

  The **Audit Security Group Management** policy determines whether the OS generates audit events when specific security group management tasks are performed. Tasks for security group management include:

  - A security group is created, changed, or deleted.

  - A member is added to or removed from a security group.

  - A group's type is changed.

  Security groups can be used for access control permissions and also as distribution lists.

  | Event ID | Event message |
  |--|--|
  | 4727 | A security-enabled global group was created. |
  | 4728 | A member was added to a security-enabled global group. |
  | 4729 | A member was removed from a security-enabled global group. |
  | 4730 | A security-enabled global group was deleted. |
  | 4731 | A security-enabled local group was created. |
  | 4732 | A member was added to a security-enabled local group. |
  | 4733 | A member was removed from a security-enabled local group. |
  | 4734 | A security-enabled local group was deleted. |
  | 4735 | A security-enabled local group was changed. |
  | 4737 | A security-enabled global group was changed. |
  | 4754 | A security-enabled universal group was created. |
  | 4755 | A security-enabled universal group was changed. |
  | 4756 | A member was added to a security-enabled universal group. |
  | 4757 | A member was removed from a security-enabled universal group. |
  | 4758 | A security-enabled universal group was deleted. |
  | 4764 | A group's type was changed. |

  - Event volume: **Low**.

  - Default: **Success**.

  </details>

  <details>
  <summary> Expand Audit User Account Management </summary>

  The **Audit User Account Management** determines whether the OS generates audit events when specific user account management tasks are performed. Tasks that are audited for user account management include:

  - A user account is created, changed, deleted, renamed, disabled, enabled, locked out, or unlocked.

  - A user account password is set or changed.

  - A Security identifier (SID) history is added to a user account.

  - A Directory Services Restore Mode password is set.

  - Permissions are changed on accounts that are members of administrator groups.

  - Credential Manager credentials are backed up or restored.

  This policy setting is essential for tracking events that involve provisioning and managing user accounts.

  | Event ID | Event message |
  |--|--|
  | 4720 | A user account was created. |
  | 4722 | A user account was enabled. |
  | 4723 | An attempt was made to change an account's password. |
  | 4724 | An attempt was made to reset an account's password. |
  | 4725 | A user account was disabled. |
  | 4726 | A user account was deleted. |
  | 4738 | A user account was changed. |
  | 4740 | A user account was locked out. |
  | 4765 | SID History was added to an account. |
  | 4766 | An attempt to add SID History to an account failed. |
  | 4767 | A user account was unlocked. |
  | 4780 | The ACL was set on accounts which are members of administrators groups. |
  | 4781 | The name of an account was changed. |
  | 4794 | An attempt was made to set the Directory Services Restore Mode. |
  | 5376 | Credential Manager credentials were backed up. |
  | 5377 | Credential Manager credentials were restored from a backup. |

  - Event volume: **Low**.

  - Default: **Success**.

  </details>

- **Detailed Tracking**

  Detailed Tracking security policy settings and audit events can be used to monitor the activities of individual applications and users on that computer, and to understand how a computer is being used. This category includes the following subcategories:

  <br>
  <details>
  <summary> Expand Audit DPAPI Activity policy </summary>

  The **Audit DPAPI Activity** policy determines whether the OS generates audit events when encryption or decryption calls are made into the data protection application interface (DPAPI).

  DPAPI is used to protect secret information such as stored passwords and key information. To learn more, see [Windows Data Protection](/previous-versions/ms995355(v=msdn.10)).

  | Event ID | Event message |
  |--|--|
  | 4692 | Backup of data protection master key was attempted. |
  | 4693 | Recovery of data protection master key was attempted. |
  | 4694 | Protection of auditable protected data was attempted. |
  | 4695 | Unprotection of auditable protected data was attempted. |

  - Event volume: **Low**.

  </details>

  <details>
  <summary> Expand Audit PNP Activity policy </summary>

  The **Audit PNP Activity** policy audits when an an external plug and play (PnP) device is detected.

  | Event ID | Event message |
  |--|--|
  | 6416 | A new device is connected or an existing device is removed. |

  - Event volume: **Low**.

  </details>

  <details>
  <summary> Expand Audit Process Creation policy </summary>

  The **Audit Process Creation** policy determines whether the OS generates audit events when a process is created or starts.

  These audit events can help you track user activity and understand how a computer is being used. Information includes the name of the program or the user that created the process.

  | Event ID | Event message |
  |--|--|
  | 4688 | A new process has been created. |
  | 4696 | A primary token was assigned to a process. |

  - Event volume: *Varies* depending on system usage.

  </details>

  <details>
  <summary> Expand Audit Process Termination policy </summary>

  The **Audit Process Termination** policy determines whether the OS generates audit events when an attempt is made to end a process.

  | Event ID | Event message |
  |--|--|
  | 4689 | A process has exited. |

  - Event volume: *Varies* depending on system usage.

  </details>

  <details>
  <summary> Expand Audit RPC Events policy </summary>

  The **Audit RPC Events** policy determines whether the OS generates audit events when inbound remote procedure call (RPC) connections are made.

  RPC is a technology for creating distributed client/server programs. RPC is an interprocess communication technique that enables client and server software to communicate. To learn more, see [Remote procedure call (RPC)](/windows/win32/rpc/rpc-start-page).

  | Event ID | Event message |
  |--|--|
  | 5712 | An RPC was attempted. |

  - Event volume: **High** on RPC servers.

  - Default: **No Auditing**.

  </details>

  <details>
  <summary> Expand Audit Token Right Adjustment policy </summary>

  The **Audit Token Right Adjustment** policy audits events generated by adjusting the privileges of a token.

  | Event ID | Event message |
  |--|--|
  | 4703 | A user right was adjusted. |

  - Event volume: **High**.

  - Default: **No Auditing**.

  </details>

- **DS Access**

  DS Access security audit policy settings provide a detailed audit trail of attempts to access and modify objects in Active Directory Domain Services (AD DS). These audit events are logged only on domain controllers. This category includes the following subcategories:

  <br>
  <details>
  <summary> Expand Audit Detailed Directory Service Replication policy </summary>

  The **Audit Detailed Directory Service Replication** policy determines whether the OS generates audit events that contain detailed tracking information about data that is replicated between domain controllers. This audit subcategory can be useful to diagnose replication issues.

  | Event ID | Event message |
  |--|--|
  | 4928 | An Active Directory replica source naming context was established. |
  | 4929 | An Active Directory replica source naming context was removed. |
  | 4930 | An Active Directory replica source naming context was modified. |
  | 4931 | An Active Directory replica destination naming context was modified. |
  | 4934 | Attributes of an Active Directory object were replicated. |
  | 4935 | Replication failure begins. |
  | 4936 | Replication failure ends. |
  | 4937 | A lingering object was removed from a replica. |

  - Event volume: **High**.

  - Default: **No Auditing**.

  </details>

  <details>
  <summary> Expand Audit Directory Service Access policy </summary>

  The **Audit Directory Service Access** policy determines whether the OS generates audit events when an Active Directory Domain Services (AD DS) object is accessed. These events are similar to the Directory Service Access events in previous versions of Windows Server OSs.

  > [!NOTE]
  > Audit events are generated only on objects with configured SACLs, and only when they're accessed in a manner that matches the SACL settings.

  | Event ID | Event message |
  |--|--|
  | 4662 | An operation was performed on an object. |

  - Event volume: **High** on domain controllers. **None** on client computers.

  - Default on Client editions: **No Auditing**.

  - Default on Server editions: **Success**.

  </details>

  <details>
  <summary> Expand Audit Directory Service Changes policy </summary>

  The **Audit Directory Service Changes** policy determines whether the OS generates audit events when changes are made to objects in AD DS. This policy, where appropriate, indicates the old and new values of the changed properties of the objects that were changed. The types of changes that are reported are:

  - Create

  - Delete

  - Modify

  - Move

  - Undelete

  > [!NOTE]
  > Audit events are generated only for objects with configured SACLs, and only when they're accessed in a manner that matches their SACL settings. Some objects and properties don't cause audit events to be generated due to settings on the object class in the schema.
  >
  > This subcategory only logs events on domain controllers. Changes to Active Directory objects are important events to track in order to understand the state of the network policy.

  | Event ID | Event message |
  |--|--|
  | 5136 | A directory service object was modified. |
  | 5137 | A directory service object was created. |
  | 5138 | A directory service object was undeleted. |
  | 5139 | A directory service object was moved. |
  | 5141 | A directory service object was deleted. |

  - Event volume: **High** on domain controllers only.

  - Default: **No Auditing**.

  </details>

  <details>
  <summary> Expand Audit Directory Service Replication policy </summary>

  The **Audit Directory Service Replication** policy determines whether the OS generates audit events when replication between two domain controllers begins and ends. Events in this subcategory are logged only on domain controllers.

  | Event ID | Event message |
  |--|--|
  | 4932 | Synchronization of a replica of an Active Directory naming context has begun. |
  | 4933 | Synchronization of a replica of an Active Directory naming context has ended. |

  - Event volume: **Medium** on domain controllers. **None** on client computers.

  - Default: **No Auditing**.

  </details>

- **Logon/Logoff**

  Logon/Logoff security policy settings and audit events allow you to track attempts to sign into a computer interactively or over a network. These events are useful for tracking user activity and identifying potential attacks on network resources. This category includes the following subcategories:

  <br>
  <details>
  <summary> Expand Audit Account Lockout policy </summary>

  The **Audit Account Lockout** policy allows you to audit security events that are generated by a failed attempt to sign into an account that is locked out. If you configure this policy setting, an audit event is generated when an account can't sign into a computer because the account is locked out. Success audits record successful attempts and failure audits record unsuccessful attempts.

  Account lockout events are essential for understanding user activity and detecting potential attacks.

  | Event ID | Event message |
  |--|--|
  | 4625 | An account failed to log on. |

  - Event volume: **Low**.

  - Default setting: **Success**.

  </details>

  <details>
  <summary> Expand Audit User / Device Claims </summary>

  The **Audit User / Device Claims** policy allows you to audit user and device claims information in the account’s logon token. Events in this subcategory are generated on the computer on which a logon session is created. For an interactive logon, the security audit event is generated on the computer that the user logged on to. You must enable the Audit Logon subcategory in order to get events from this subcategory.

  For a network logon, such as accessing a shared folder on the network, the security audit event is generated on the computer hosting the resource.

  | Event ID | Event message |
  |--|--|
  | 4626 | User/Device claims information. |

  - Event volume: **Low** on a client computer. **Medium** on a domain controller or a network server

  - Default: **No Auditing**.

  </details>

  <details>
  <summary> Expand Audit Group Membership policy </summary>

  The **Audit Group Membership** policy allows you to audit the group membership information in the user's logon token. Events in this subcategory are generated on the computer on which a logon session is created. You must also enable the Audit Logon subcategory.

  For an interactive logon, the security audit event is generated on the computer that the user logged on to. For a network logon, such as accessing a shared folder on the network, the security audit event is generated on the computer hosting the resource.

  | Event ID | Event message |
  |--|--|
  | 4627 | Group membership information. |

  - Event volume: **Low** on a client computer. **Medium** on a domain controller or a network server.

  - Default: **No Auditing**.

  </details>

  <details>
  <summary> Expand Audit IPsec Extended Mode policy </summary>

  The **Audit IPsec Extended Mode** policy determines whether the OS generates audit events for the results of the Internet Key Exchange (IKE) protocol and Authenticated Internet Protocol (AuthIP) during Extended Mode negotiations.

  IKE is an Internet standard, defined in [RFC 2409](https://www.rfc-editor.org/rfc/rfc2409), that defines a mechanism to establish IPsec security associations. A security association is a combination of a mutually agreeable policy and keys that define the security services and mechanisms that help protect communication between IPsec peers.

  AuthIP is an enhanced version of IKE that offers additional flexibility, including support for user-based authentication and authentication with multiple credentials. It also provides improved authentication method negotiation and supports asymmetric authentication. Like IKE, AuthIP supports main-mode and quick-mode negotiation. AuthIP also supports Extended Mode, a part of IPsec peer negotiation during which a second round of authentication can be performed. Extended Mode, which is optional, can be used for multiple authentications. For example, with extended mode you can perform separate computer-based and user-based authentications.

  | Event ID | Event message |
  |--|--|
  | 4978 | During Extended Mode negotiation, IPsec received an invalid negotiation packet. If this problem persists, it could indicate a network issue or an attempt to modify or replay this negotiation. |
  | 4979| IPsec Main Mode and Extended Mode security associations were established. <br><br> *This event provides event data in the following categories: Main Mode Local Endpoint, Main Mode Remote Endpoint, Main Mode Cryptographic Information, Main Mode Security Association, Main Mode Additional Information, and Extended Mode Information.* |
  | 4980 | IPsec Main Mode and Extended Mode security associations were established. <br><br> *This event provides event audit data in the following categories: Main Mode Local Endpoint, Main Mode Remote Endpoint. Main Mode Cryptographic Information, Main Mode Security Association, Main Mode Additional Information, Extended Mode Local Endpoint, Extended Mode Remote Endpoint, and Extended Mode Additional Information.* |
  | 4981 | IPsec Main Mode and Extended Mode security associations were established. <br><br> *This event provides event audit data in the following categories: Local Endpoint, Local Certificate, Remote Endpoint, Remote Certificate, Cryptographic Information, Security Association Information, Additional Information, and Extended Mode Information.* |
  | 4982 | IPsec Main Mode and Extended Mode security associations were established. <br><br> *This event provides event audit data in the following categories: Local Endpoint, Local Certificate, Remote Endpoint, Remote Certificate, Cryptographic Information, Security Association Information, Additional Information, Extended Mode Local Endpoint, Extended Mode Remote Endpoint, and Extended Mode Additional Information.* |
  | 4983 | An IPsec Extended Mode negotiation failed. The corresponding Main Mode security association has been deleted. <br><br> *This event provides event audit data in the following categories: Local Endpoint, Local Certificate, Remote Endpoint, Remote Certificate, and Failure Information.* |
  | 4984 | An IPsec Extended Mode negotiation failed. The corresponding Main Mode security association has been deleted. <br><br> *This event provides event audit data in the following categories: Local Endpoint, Remote Endpoint, Additional Information, and Failure Information.* |

  - Event volume: **High**.

  - Default: **No Auditing**.

  </details>

  <details>
  <summary> Expand Audit IPsec Main Mode policy </summary>

  The **Audit IPsec Main Mode** policy determines whether the OS generates audit events for the results of the IKE protocol and AuthIP during Quick Mode negotiations. Like IKE, AuthIP supports Main Mode and Quick Mode negotiation.

  Main Mode IKE negotiation establishes a secure channel, known as the Internet Security Association and Key Management Protocol (ISAKMP) security association, between two computers. To establish the secure channel, Main Mode negotiation determines a set of cryptographic protection suites, exchanges keying material to establish the shared secret key, and authenticates computer identities.

  | Event ID | Event message |
  |--|--|
  | 4646 | Security ID: %1. |
  | 4650 | An IPsec Main Mode security association was established. Extended Mode was not enabled. Certificate authentication was not used. |
  | 4651 | An IPsec Main Mode security association was established. Extended Mode was not enabled. A certificate was used for authentication. |
  | 4652 | An IPsec Main Mode negotiation failed. <br><br> *This audit event returns detailed audit data in the following categories: Local Endpoint, Local Certificate, Remote Endpoint, Remote Certificate, Additional Information, and Failure Information.* |
  | 4653 | An IPsec Main Mode negotiation failed. <br><br> *This audit event returns detailed audit data in the following categories: Local Endpoint, Remote Endpoint, Additional Information, and Failure Information.* |
  | 4655 | An IPsec Main Mode security association ended. |
  | 4976 | During Main Mode negotiation, IPsec received an invalid negotiation packet. If this problem persists, it could indicate a network issue or an attempt to modify or replay this negotiation. |
  | 5049 | An IPsec Security Association was deleted. |
  | 5453 | An IPsec negotiation with a remote computer failed because the IKE and AuthIP IPsec Keying Modules (IKEEXT) service is not started. |

  - Event volume: **High**.

  - Default: **No Auditing**.

  </details>

  <details>
  <summary> Expand Audit IPsec Quick Mode policy </summary>

  The **Audit IPsec Quick Mode** policy determines whether the OS generates audit events for the results of the IKE protocol and AuthIP during Quick Mode negotiations. Like IKE, AuthIP supports Main Mode and Quick Mode negotiation.

  Quick Mode (also known as Phase 2) IKE negotiation establishes a secure channel between two computers to protect data. Quick Mode creates IPsec security associations, which are agreements between computers about how to protect network traffic. These associations are negotiated by the IPsec service.

  During Quick Mode, keying material is refreshed or, if necessary, new keys are generated. A protection suite that protects specified IP traffic is also selected. A protection suite is a defined set of data integrity or data encryption settings. Quick Mode isn't considered a complete exchange because it's dependent on a Main Mode exchange.

  | Event ID | Event message |
  |--|--|
  | 4977 | During Quick Mode negotiation, IPsec received an invalid negotiation packet. If this problem persists, it could indicate a network issue or an attempt to modify or replay this negotiation. |
  | 5451 | An IPsec Quick Mode security association was established. |
  | 5452 | An IPsec Quick Mode security association ended. |

  - Event volume: **High**.

  - Default: **No Auditing**.

  </details>

  <details>
  <summary> Expand Audit Logoff policy </summary>

  The **Audit Logoff** policy determines whether the OS generates audit events when logon sessions are terminated. These events occur on the computer that was accessed. When an interactive logon occurs, these events are generated on the computer that was logged on to.

  > [!NOTE]
  > There's no failure event in this subcategory because failed logoffs (such as when a system abruptly shuts down) don't generate an audit record.

  Logon events are essential to understanding user activity and detecting potential attacks. Logoff events aren't 100 percent reliable. For example, the computer can be turned off without a proper logoff and shutdown; in this case, a logoff event isn't generated.

  | Event ID | Event message |
  |--|--|
  | 4634 | An account was logged off. |
  | 4647 | User initiated logoff. |

  - Event volume: **Low**.

  - Default: **Success**.

  </details>

  <details>
  <summary> Expand Audit Logon policy </summary>

  The **Audit Logon** policy determines whether the OS generates audit events when a user attempts to sign into a computer.

  These events are related to the creation of sign in sessions and occur on the computer that was accessed. For an interactive logon, events are generated on the computer that was logged on to. For a network logon, such as accessing a share, events are generated on the computer that hosts the resource that was accessed. Logon events are essential to tracking user activity and detecting potential attacks. The following events are recorded:

  - Logon success and failure.
  - Logon attempts by using explicit credentials. This event is generated when a process attempts to sign into an account by explicitly specifying that account's credentials. This most commonly occurs in batch configurations such as scheduled tasks, or when using the `runas` command.

  | Event ID | Event message |
  |--|--|
  | 4624 | An account was successfully logged on. |
  | 4625 | An account failed to log on. |
  | 4648 | A logon was attempted using explicit credentials. |
  | 4675 | SIDs were filtered. |

  - Event volume: **Low** on a client computer. **Medium** on a domain controller or network server.

  - Default: **Success** for client computers. **Success** and **Failure** for servers.

  </details>

  <details>
  <summary> Expand Audit Network Policy Server policy </summary>

  The **Audit Network Policy Server** policy determines whether the OS generates audit events for RADIUS (IAS) and Network Access Protection (NAP) activity on user access requests. These requests are:

  - Grant

  - Deny

  - Discard

  - Quarantine

  - Lock

  - Unlock

  NAP events can be used to help understand the overall health of the network.

  | Event ID | Event message |
  |--|--|
  | 6272 | Network Policy Server granted access to a user. |
  | 6273 | Network Policy Server denied access to a user. |
  | 6274 | Network Policy Server discarded the request for a user. |
  | 6275 | Network Policy Server discarded the accounting request for a user. |
  | 6276 | Network Policy Server quarantined a user. |
  | 6277 | Network Policy Server granted access to a user but put it on probation because the host didn't meet the defined health policy. |
  | 6278 | Network Policy Server granted full access to a user because the host met the defined health policy. |
  | 6279 | Network Policy Server locked the user account due to repeated failed authentication attempts. |
  | 6280 | Network Policy Server unlocked the user account. |

  - Event volume: **Medium** or **High** on NPS and IAS servers. **Moderate** on other servers or on client computers.

  - Default: **Success** and **Failure**.

  </details>

  <details>
  <summary> Expand Audit Other Logon/Logoff Events policy </summary>

  The **Audit Other Logon/Logoff Events** policy determines whether Windows generates audit events for other logon or logoff events. These other logon or logoff events include:

  - A Remote Desktop session connects or disconnects.

  - A workstation is locked or unlocked.

  - A screen saver is invoked or dismissed.

  - A replay attack is detected. This event indicates that a Kerberos request was received twice with identical information. A network misconfiguration can also cause this.

  - A user is granted access to a wireless network. It can either be a user account or the computer account.

  - A user is granted access to a wired 802.1x network. It can either be a user account or the computer account.

  | Event ID | Event message |
  |--|--|
  | 4649 | A replay attack was detected. |
  | 4778 | A session was reconnected to a Window Station. |
  | 4779 | A session was disconnected from a Window Station. |
  | 4800 | The workstation was locked. |
  | 4801 | The workstation was unlocked. |
  | 4802 | The screen saver was invoked. |
  | 4803 | The screen saver was dismissed. |
  | 5378 | The requested credentials delegation was disallowed by policy. |
  | 5632 | A request was made to authenticate to a wireless network. |
  | 5633 | A request was made to authenticate to a wired network. |

  - Event volume: **Low**.

  - Default: **No Auditing**.

  </details>

  <details>
  <summary> Expand Audit Special Logon policy </summary>

  The **Audit Special Logon** policy determines whether the OS generates audit events under special sign on (or log on) circumstances. This security policy setting determines whether the OS generates audit events when:

  - A special logon is used. A special logon is a logon that has administrator-equivalent privileges and can be used to elevate a process to a higher level.

  - A member of a special group logs on. Special Groups is a Windows feature that enables the administrator to find out when a member of a certain group has logged on. The administrator can set a list of group security identifiers (SIDs) in the registry. If any of these SIDs is added to a token during logon and this auditing subcategory is enabled, a security event is logged.

  Users holding special privileges can potentially make changes to the system. We recommend that you track their activity.

  | Event ID | Event message |
  |--|--|
  | 4964 | Special groups have been assigned to a new logon. |

  - Event volume: Low

  - Default: Success

  </details>

- **Object Access**

  Object Access policy settings and audit events allow you to track attempts to access specific objects or types of objects on a network or computer. To audit attempts to access a file, directory, registry key, or any other object, you must enable the appropriate Object Access auditing subcategory for success and/or failure events. For example, the File System subcategory needs to be enabled to audit file operations, and the Registry subcategory needs to be enabled to audit registry accesses. This category includes the following subcategories:

  <br>
  <details>
  <summary> Expand Audit Application Generated policy </summary>

  The **Audit Application Generated** policy determines whether the OS generates audit events when applications attempt to use the Windows Auditing application programming interfaces (APIs).

  The following events can generate audit activity:

  - Creation, deletion, or initialization of an application client context

  - Application operations

  Applications that are designed to use the Windows Auditing APIs can use this subcategory to log auditing events that are related to those APIs. The level, volume, relevance, and importance of these audit events depend on the application that generates them. The OS logs the events as they're generated by the application.

  | Event ID | Event message |
  |--|--|
  | 4665 | An attempt was made to create an application client context. |
  | 4666 | An application attempted an operation. |
  | 4667 | An application client context was deleted. |
  | 4668 | An application was initialized. |

  - Event volume: *Varies* based on the installed application's use of Windows Auditing

  </details>

  <details>
  <summary> Expand Audit Certification Services policy </summary>

  The **Audit Certification Services** policy determines whether the OS generates events when Active Directory Certificate Services (AD CS) operations are performed. Monitoring these operational events is important to ensure that AD CS role services are functioning properly. Examples of AD CS operations include:

  - AD CS starts, shuts down, is backed up, or is restored.

  - Certificate revocation list (CRL) related tasks are performed.

  - Certificates are requested, issued, or revoked.

  - Certificate manager settings for AD CS are changed.

  - The configuration and properties of the certification authority (CA) are changed.

  - AD CS templates are modified.

  - Certificates are imported.

  - A CA certificate is published to Active Directory Domain Services.

  - Security permissions for AD CS role services are modified.

  - Keys are archived, imported, or retrieved.

  - The OCSP Responder Service is started or stopped.

  | Event ID | Event message |
  |--|--|
  | 4868 | The certificate manager denied a pending certificate request. |
  | 4869 | Certificate Services received a resubmitted certificate request. |
  | 4870 | Certificate Services revoked a certificate. |
  | 4871 | Certificate Services received a request to publish the certificate revocation list (CRL). |
  | 4872 | Certificate Services published the certificate revocation list (CRL). |
  | 4873 | A certificate request extension changed. |
  | 4874 | One or more certificate request attributes changed. |
  | 4875 | Certificate Services received a request to shut down. |
  | 4876 | Certificate Services backup started. |
  | 4877 | Certificate Services backup completed. |
  | 4878 | Certificate Services restore started. |
  | 4879 | Certificate Services restore completed. |
  | 4880 | Certificate Services started. |
  | 4881 | Certificate Services stopped. |
  | 4882 | The security permissions for Certificate Services changed. |
  | 4883 | Certificate Services retrieved an archived key. |
  | 4884 | Certificate Services imported a certificate into its database. |
  | 4885 | The audit filter for Certificate Services changed. |
  | 4886 | Certificate Services received a certificate request. |
  | 4887 | Certificate Services approved a certificate request and issued a certificate. |
  | 4888 | Certificate Services denied a certificate request. |
  | 4889 | Certificate Services set the status of a certificate request to pending. |
  | 4890 | The certificate manager settings for Certificate Services changed. |
  | 4891 | A configuration entry changed in Certificate Services. |
  | 4892 | A property of Certificate Services changed. |
  | 4893 | Certificate Services archived a key. |
  | 4894 | Certificate Services imported and archived a key. |
  | 4895 | Certificate Services published the CA certificate to Active Directory Domain Services. |
  | 4896 | One or more rows have been deleted from the certificate database. |
  | 4897 | Role separation enabled. |
  | 4898 | Certificate Services loaded a template. |

  - Event volume: **Medium** or **Low** on servers that host AD CS services

  </details>

  <details>
  <summary> Expand Audit Detailed File Share policy </summary>

  The **Audit Detailed File Share** policy allows you to audit attempts to access files and folders on a shared folder. The Detailed File Share setting logs an event every time a file or folder is accessed, whereas the File Share setting only records one event for any connection established between a client computer and file share. Detailed File Share audit events include detailed information about the permissions or other criteria used to grant or deny access.

  > [!NOTE]
  > Shared folders don't have SACLs. When you enable this policy setting, all access to shared files and folders on the system is audited.

  | Event ID | Event message |
  |--|--|
  | 5145 | A network share object was checked to see whether the client can be granted desired access. |

  - Event volume: **High** on a file server or domain controller because of SYSVOL network access required by Group Policy

  </details>

  <details>
  <summary> Expand Audit File Share policy </summary>

  The **Audit File Share** policy determines whether the OS generates audit events when a file share is accessed. Audit events aren't generated when shares are created, deleted, or when share permissions change. Combined with File System auditing, File Share auditing enables you to track what content was accessed, the source (IP address and port) of the request, and the user account that was used for the access.

  > [!NOTE]
  > There are no SACLs for shares; therefore, after this setting is enabled, access to all shares on the system will be audited.

  | Event ID | Event message |
  |--|--|
  | 5140 | A network share object was accessed. <br><br> *This event is logged on computers running Windows Server 2008 R2, Windows Server 2008, Windows 7, or Windows Vista.* |
  | 5142 | A network share object was added. |
  | 5143 | A network share object was modified. |
  | 5144 | A network share object was deleted. |
  | 5168 | SPN check for SMB/SMB2 failed. |

  - Event volume: **High** on a file server or domain controller because of SYSVOL network access required by Group Policy.

  </details>

  <details>
  <summary> Expand Audit File System policy </summary>

  The **Audit File System** policy determines whether the OS generates audit events when users attempt to access file system objects. Audit events are generated only for objects that have configured SACLs, and only if the type of access requested (such as Write, Read, or Modify) and the account making the request match the settings in the SACL.

  If success auditing is enabled, an audit entry is generated each time any account successfully accesses a file system object that has a matching SACL. If failure auditing is enabled, an audit entry is generated each time any user unsuccessfully attempts to access a file system object that has a matching SACL. These events are essential for tracking activity for file objects that are sensitive or valuable and require extra monitoring.

  | Event ID | Event message |
  |--|--|
  | 4664 | An attempt was made to create a hard link. |
  | 4985 | The state of a transaction has changed. |
  | 5051 | A file was virtualized. |

  - Event volume: *Varies* depending on how file system SACLs are configured.

  </details>

  <details>
  <summary> Expand Audit Filtering Platform Connection policy </summary>

  The **Audit Filtering Platform Connection** policy determines whether the OS generates audit events when connections are allowed or blocked by the Windows Filtering Platform. Windows Filtering Platform (WFP) was introduced in Windows Server 2008 and Windows Vista. It enables independent software vendors (ISVs) to filter and modify TCP/IP packets, monitor or authorize connections, filter Internet Protocol security (IPsec)-protected traffic, and filter RPCs. This security policy enables you to audit the following types of actions:

  - The Windows Firewall service blocks an application from accepting incoming connections on the network.

  - The Windows Filtering Platform allows or blocks a connection.

  - The Windows Filtering Platform permits or blocks a bind to a local port.

  - The Windows Filtering Platform permits or blocks an application or service from listening for incoming connections on a port.

  | Event ID | Event message |
  |--|--|
  | 5031 | The Windows Firewall Service blocked an application from accepting incoming connections on the network. |
  | 5140 | A network share object was accessed. <br><br> *This event is logged only on computers running the supported versions of the Windows OS as designated in the Applies To list.* |
  | 5150 | The Windows Filtering Platform blocked a packet. |
  | 5151 | A more restrictive Windows Filtering Platform filter has blocked a packet. |
  | 5154 | The Windows Filtering Platform has permitted an application or service to listen on a port for incoming connections. |
  | 5155 | The Windows Filtering Platform has blocked an application or service from listening on a port for incoming connections. |
  | 5156 | The Windows Filtering Platform has allowed a connection. |
  | 5157 | The Windows Filtering Platform has blocked a connection. |
  | 5158 | The Windows Filtering Platform has permitted a bind to a local port. |
  | 5159 | The Windows Filtering Platform has blocked a bind to a local port. |

  - Event volume: **High**.

  </details>

  <details>
  <summary> Expand Audit Filtering Platform Packet Drop policy </summary>

  The **Audit Filtering Platform Packet Drop** policy determines whether the OS generates audit events when packets are dropped by the Windows Filtering Platform. Windows Filtering Platform (WFP) was introduced in Windows Server 2008 and Windows Vista. WFP enables independent software vendors (ISVs) to filter and modify TCP/IP packets, monitor or authorize connections, filter Internet Protocol security (IPsec)-protected traffic, and filter RPCs. A high rate of dropped packets may indicate that there have been attempts to gain unauthorized access to computers on your network.

  | Event ID | Event message |
  |--|--|
  | 5152 | The Windows Filtering Platform blocked a packet. |
  | 5153 | A more restrictive Windows Filtering Platform filter has blocked a packet. |

  - Event volume: **High**.

  </details>

  <details>
  <summary> Expand Audit Handle Manipulation policy </summary>

  The **Audit Handle Manipulation** policy determines whether the OS generates audit events when a handle to an object is opened or closed. Only objects with configured SACLs generate these events, and only if the attempted handle operation matches the SACL.

  > [!NOTE]
  > Handle Manipulation events are generated only for object types where the corresponding File System or Registry Object Access subcategory is enabled. Refer to the **Audit File System** or **Audit Registry** policies.

  | Event ID | Event message |
  |--|--|
  | 4656 | A handle to an object was requested. |
  | 4658 | The handle to an object was closed. |
  | 4690 | An attempt was made to duplicate a handle to an object. |

  - Event volume: *Varies* on how SACLs are configured.

  </details>

  <details>
  <summary> Expand Audit Kernel Object policy </summary>

  The **Audit Kernel Object** policy determines whether the OS generates audit events when users attempt to access the system kernel, which includes mutexes and semaphores. Only kernel objects with a matching SACL generate security audit events. The audits generated are useful only to developers. Typically, kernel objects are given SACLs only if the **AuditBaseObjects** or **AuditBaseDirectories** auditing options are enabled.

  > [!NOTE]
  > The **Audit: Audit the access of global system objects** policy setting controls the default SACL of kernel objects.

  | Event ID | Event message |
  |--|--|
  | 4659 | A handle to an object was requested with intent to delete. |
  | 4660 | An object was deleted. |
  | 4661 | A handle to an object was requested. |
  | 4663 | An attempt was made to access an object. |

  - Event volume: **High** if auditing access of global system objects is enabled.

  </details>

  <details>
  <summary> Expand Audit Other Object Access Events policy </summary>

  The **Audit Other Object Access Events** policy determines whether the OS generates audit events for the management of Task Scheduler jobs or COM+ objects.

  For scheduler jobs, the following actions are audited:

  - A job is created, deleted, enabled, disabled, or updated.

  For COM+ objects, the following actions are audited:

  - A catalog object is added, deleted, or updated.

  | Event ID | Event message |
  |--|--|
  | 4671 | An application attempted to access a blocked ordinal through the TBS. |
  | 4691 | Indirect access to an object was requested. |
  | 4698 | A scheduled task was created. |
  | 4699 | A scheduled task was deleted. |
  | 4700 | A scheduled task was enabled. |
  | 4701 | A scheduled task was disabled. |
  | 4702 | A scheduled task was updated. |
  | 5148 | The Windows Filtering Platform has detected a DoS attack and entered a defensive mode; packets associated with this attack will be discarded. <br><br> *This event is logged only on computers running the supported versions of the Windows OS.* |
  | 5149 | The DoS attack has subsided and normal processing is being resumed. <br><br> *This event is logged only on computers running the supported versions of the Windows OS.* |
  | 5888 | An object in the COM+ Catalog was modified. |
  | 5889 | An object was deleted from the COM+ Catalog. |
  | 5890 | An object was added to the COM+ Catalog. |

  - Event volume: **Low**.

  </details>

  <details>
  <summary> Expand Audit Registry policy </summary>

  The **Audit Registry** policy determines whether the OS generates audit events when users attempt to access registry objects. Audit events are generated only for objects that have configured SACLs specified, and only if the type of access requested (such as Write, Read, or Modify) and the account making the request match the settings in the SACL.

  If success auditing is enabled, an audit entry is generated each time any account successfully accesses a registry object that has a matching SACL. If failure auditing is enabled, an audit entry is generated each time any user unsuccessfully attempts to access a registry object that has a matching SACL.

  | Event ID | Event message |
  |--|--|
  | 4657 | A registry value was modified. |
  | 5039 | A registry key was virtualized. |

  - Event volume: *Varies* on how registry SACLs are configured.

  </details>

  <details>
  <summary> Expand Audit Removable Storage policy </summary>

  The **Audit Removable Storage** policy determines whether the OS generates audit events when users attempt to access file system objects on removable storage devices. Audit events are generated for all types of access to any object on removable storage.

  When this policy is enabled, an audit event is logged each time an account accesses a file system object on a removable storage device. Success audits capture successful access attempts, while failure audits capture unsuccessful attempts. If this policy isn't configured, no audit events are generated for access to file system objects on removable storage devices.

  | Event ID | Event message |
  |--|--|
  | 4656 | A handle to an object was requested. |
  | 4658 | The handle to an object was closed. |
  | 4663 | An attempt was made to access an object. |

  </details>

  <details>
  <summary> Expand Audit SAM policy </summary>

  The Audit SAM, which enables you to audit events that are generated by attempts to access SAM objects. The SAM is a database that is present on computers running Windows OSs that stores user accounts and security descriptors for users on the local computer. SAM objects include:

  - SAM_ALIAS: A local group

  - SAM_GROUP: A group that isn't a local group

  - SAM_USER: A user account

  - SAM_DOMAIN: A domain

  - SAM_SERVER: A computer account

  If you configure this policy setting, an audit event is generated when a SAM object is accessed. Success audits record successful attempts, and failure audits record unsuccessful attempts. Only the SACL for **SAM_SERVER** can be modified.

  Changes to user and group objects are tracked by the Account Management audit category. However, user accounts with enough privileges could potentially alter the files in which the account and password information is stored in the system, bypassing any Account Management events.

  | Event ID | Event message |
  |--|--|
  | 4659 | A handle to an object was requested with intent to delete. |
  | 4660 | An object was deleted. |
  | 4661 | A handle to an object was requested. |
  | 4663 | An attempt was made to access an object. |

  - Event volume: **High** on domain controllers.

  </details>

  <details>
  <summary> Expand Audit Central Access Policy Staging policy </summary>

  The **Audit Central Access Policy Staging** policy enables auditing of access attempts where the permissions granted or denied by a proposed central access policy differ from those of the current policy on an object. When this policy is configured, an audit event is generated each time a user accesses an object and the permissions granted by the current central access policy differ from those granted by the proposed policy. Audit events are generated as follows:

  - **Success audits** (when enabled) log access attempts where the current policy grants access but the proposed policy would deny it.

  - **Failure audits** (when enabled) log access attempts in these scenarios:

    - The current policy doesn't grant access, but the proposed policy would grant it.

    - A principal requests their maximum allowed access rights, and the rights granted by the current policy differ from those granted by the proposed policy.

  | Event ID | Event message |
  |--|--|
  | 4818 | Proposed Central Access Policy does not grant the same access permissions as the current Central Access Policy. |

  - Event volume: Potentially **High** on a file server when the proposed policy differs significantly from the current central access policy.

  - Default: **No Auditing**.

  </details>

- **Policy Change**

  Policy Change audit events allow you to track changes to important security policies on a local system or network. Because policies are typically established by administrators to help secure network resources, monitoring changes or attempts to change these policies can be an important aspect of security management for a network. This category includes the following subcategories:

  <br>
  <details>
  <summary> Expand Audit Policy Change policy </summary>

  The **Audit Audit Policy Change** policy determines whether the OS generates audit events when changes are made to audit policy. Changes to the audit policy are critical security events. Changes to audit policy that are audited include:

  - Changing permissions and audit settings on the audit policy object (by using `auditpol /set /sd`).

  - Changing the system audit policy.

  - Registering and unregistering security event sources.

  - Changing per-user audit settings.

  - Changing the value of CrashOnAuditFail.

  - Changing anything in the Special Groups list.

  - Changing audit settings on an object (for example, modifying the SACL for a file or registry key).

  > [!NOTE]
  > SACL change auditing is performed when a SACL for an object has changed and the Policy Change category is configured. Discretionary access control list (DACL) and owner change auditing are performed when Object Access auditing is configured and the object's SACL is set for auditing of the DACL or owner change.

  | Event ID | Event message |
  |--|--|
  | 4715 | The audit policy (SACL) on an object was changed. |
  | 4719 | System audit policy was changed. |
  | 4817 | Auditing settings on an object were changed. <br><br> *This event is logged only on computers running the supported versions of the Windows OS.* |
  | 4902 | The Per-user audit policy table was created. |
  | 4904 | An attempt was made to register a security event source. |
  | 4905 | An attempt was made to unregister a security event source. |
  | 4906 | The CrashOnAuditFail value has changed. |
  | 4907 | Auditing settings on object were changed. |
  | 4908 | Special Groups Logon table modified. |
  | 4912 | Per User Audit Policy was changed. |

  - Event volume: **Low**.

  - Default: **Success**.

  </details>

  <details>
  <summary> Expand Audit Authentication Policy Change policy </summary>

  The **Audit Authentication Policy Change** policy determines whether the OS generates audit events when changes are made to authentication policy. This setting is useful for tracking changes in domain-level and forest-level trust and privileges that are granted to user accounts or groups. Changes made to authentication policy include:

  - Creation, modification, and removal of forest and domain trusts.

  - Changes to Kerberos policy under **Computer Configuration\Windows Settings\Security Settings\Account Policies\Kerberos Policy**.

  > [!NOTE]
  > The audit event is logged when the policy is applied, not when settings are modified by the administrator.

  When any of the following user rights is granted to a user or group:

  - Access this computer from the network.

  - Allow logon locally.

  - Allow logon through Remote Desktop.

  - Logon as a batch job.

  - Logon as a service.

  Namespace collision, such as when an added trust collides with an existing namespace name.

  | Event ID | Event message |
  |--|--|
  | 4713 | Kerberos policy was changed. |
  | 4716 | Trusted domain information was modified. |
  | 4717 | System security access was granted to an account. |
  | 4718 | System security access was removed from an account. |
  | 4739 | Domain Policy was changed. |
  | 4864 | A namespace collision was detected. |
  | 4865 | A trusted forest information entry was added. |
  | 4866 | A trusted forest information entry was removed. |
  | 4867 | A trusted forest information entry was modified. |

  - Event volume: **Low**.

  - Default: **Success**.

  </details>

  <details>
  <summary> Expand Audit Authorization Policy Change policy </summary>

  The **Audit Authorization Policy Change** policy determines whether the OS generates audit events when specific changes are made to the authorization policy. Authorization policy changes that can be audited include:

  - Assigning or removing user rights (privileges) such as **SeCreateTokenPrivilege**, except for the system access rights that are audited by using the **Audit Authentication Policy Change** subcategory.

  - Changing the Encrypting File System (EFS) policy.

  | Event ID | Event message |
  |--|--|
  | 4704 | A user right was assigned. |
  | 4705 | A user right was removed. |
  | 4706 | A new trust was created to a domain. |
  | 4707 | A trust to a domain was removed. |
  | 4714 | Encrypted data recovery policy was changed. |

  - Event volume: **Low**.

  - Default: **No Auditing**.

  </details>

  <details>
  <summary> Expand Audit Filtering Platform Policy Change policy </summary>

  The **Audit Filtering Platform Policy Change** policy determines whether the OS generates audit events for certain IPsec and Windows Filtering Platform actions. Windows Filtering Platform (WFP) enables independent software vendors (ISVs) to filter and modify TCP/IP packets, monitor or authorize connections, filter Internet Protocol security (IPsec)-protected traffic, and filter RPCs. This security policy setting determines whether the OS generates audit events for:

  - IPsec services status.

  - Changes to IPsec settings.

  - Status and changes to the Windows Filtering Platform engine and providers.

  - IPsec Policy Agent service activities.

  | Event ID | Event message |
  |--|--|
  | 4709 | IPsec Services was started. |
  | 4710 | IPsec Services was disabled. |
  | 4711 | May contain any one of the following messages:<br><br> <li>PAStore Engine applied locally cached copy of Active Directory storage IPsec policy on the computer. <li>PAStore Engine applied Active Directory storage IPsec policy on the computer. <li>PAStore Engine applied local registry storage IPsec policy on the computer. <li>PAStore Engine failed to apply locally cached copy of Active Directory storage IPsec policy on the computer. <li>PAStore Engine failed to apply Active Directory storage IPsec policy on the computer. <li>PAStore Engine failed to apply local registry storage IPsec policy on the computer. <li>PAStore Engine failed to apply some rules of the active IPsec policy on the computer. <li>PAStore Engine failed to load directory storage IPsec policy on the computer. <li>PAStore Engine loaded directory storage IPsec policy on the computer. <li>PAStore Engine failed to load local storage IPsec policy on the computer. <li>PAStore Engine loaded local storage IPsec policy on the computer. <li>PAStore Engine polled for changes to the active IPsec policy and detected no changes. </li> |
  | 4712 | IPsec Services encountered a potentially serious failure. |
  | 5040 | A change has been made to IPsec settings. An Authentication Set was added. |
  | 5041 | A change has been made to IPsec settings. An Authentication Set was modified. |
  | 5042 | A change has been made to IPsec settings. An Authentication Set was deleted. |
  | 5043 | A change has been made to IPsec settings. A Connection Security Rule was added. |
  | 5044 | A change has been made to IPsec settings. A Connection Security Rule was modified. |
  | 5045 | A change has been made to IPsec settings. A Connection Security Rule was deleted. |
  | 5046 | A change has been made to IPsec settings. A Crypto Set was added. |
  | 5047 | A change has been made to IPsec settings. A Crypto Set was modified. |
  | 5048 | A change has been made to IPsec settings. A Crypto Set was deleted. |
  | 5440 | The following callout was present when the Windows Filtering Platform Base Filtering Engine started. |
  | 5441 | The following filter was present when the Windows Filtering Platform Base Filtering Engine started. |
  | 5442 | The following provider was present when the Windows Filtering Platform Base Filtering Engine started. |
  | 5443 | The following provider context was present when the Windows Filtering Platform Base Filtering Engine started. |
  | 5444 | The following sub-layer was present when the Windows Filtering Platform Base Filtering Engine started. |
  | 5446 | A Windows Filtering Platform callout has been changed. |
  | 5448 | A Windows Filtering Platform provider has been changed. |
  | 5449 | A Windows Filtering Platform provider context has been changed. |
  | 5450 | A Windows Filtering Platform sub-layer has been changed. |
  | 5456 | PAStore Engine applied Active Directory storage IPsec policy on the computer. |
  | 5457 | PAStore Engine failed to apply Active Directory storage IPsec policy on the computer. |
  | 5458 | PAStore Engine applied locally cached copy of Active Directory storage IPsec policy on the computer. |
  | 5459 | PAStore Engine failed to apply locally cached copy of Active Directory storage IPsec policy on the computer. |
  | 5460 | PAStore Engine applied local registry storage IPsec policy on the computer. |
  | 5461 | PAStore Engine failed to apply local registry storage IPsec policy on the computer. |
  | 5462 | PAStore Engine failed to apply some rules of the active IPsec policy on the computer. Use the IP Security Monitor snap-in to diagnose the problem. |
  | 5463 | PAStore Engine polled for changes to the active IPsec policy and detected no changes. |
  | 5464 | PAStore Engine polled for changes to the active IPsec policy, detected changes, and applied them to IPsec Services. |
  | 5465 | PAStore Engine received a control for forced reloading of IPsec policy and processed the control successfully. |
  | 5466 | PAStore Engine polled for changes to the Active Directory IPsec policy, determined that Active Directory cannot be reached, and will use the cached copy of the Active Directory IPsec policy instead. Any changes made to the Active Directory IPsec policy since the last poll could not be applied. |
  | 5467 | PAStore Engine polled for changes to the Active Directory IPsec policy, determined that Active Directory can be reached, and found no changes to the policy. The cached copy of the Active Directory IPsec policy is no longer being used. |
  | 5468 | PAStore Engine polled for changes to the Active Directory IPsec policy, determined that Active Directory can be reached, found changes to the policy, and applied those changes. The cached copy of the Active Directory IPsec policy is no longer being used. |
  | 5471 | PAStore Engine loaded local storage IPsec policy on the computer. |
  | 5472 | PAStore Engine failed to load local storage IPsec policy on the computer. |
  | 5473 | PAStore Engine loaded directory storage IPsec policy on the computer. |
  | 5474 | PAStore Engine failed to load directory storage IPsec policy on the computer. |
  | 5477 | PAStore Engine failed to add quick mode filter. |

  - Event volume: **Low**.

  - Default: **No Auditing**.

  </details>

  <details>
  <summary> Expand Audit MPSSVC Rule-Level Policy Change policy </summary>

  The **Audit MPSSVC Rule-Level Policy Change** policy determines whether the OS generates audit events when changes are made to policy rules for the Microsoft Protection Service (MPSSVC.exe).

  The Microsoft Protection Service, which is used by Windows Firewall, is an integral part of the computer’s threat protection against Internet-bound threats such as Trojans and spyware. The tracked activities include:

  - Active policies when the Windows Firewall service starts.

  - Changes to Windows Firewall rules.

  - Changes to the Windows Firewall exception list.

  - Changes to Windows Firewall settings.

  - Rules ignored or not applied by the Windows Firewall service.

  - Changes to Windows Firewall Group Policy settings.

  Changes to firewall rules are important for understanding the security state of the computer and how well it's protected against network attacks.

  | Event ID | Event message |
  |--|--|
  | 4944 | The following policy was active when the Windows Firewall started. |
  | 4945 | A rule was listed when the Windows Firewall started. |
  | 4946 | A change has been made to Windows Firewall exception list. A rule was added. |
  | 4947 | A change has been made to Windows Firewall exception list. A rule was modified. |
  | 4948 | A change has been made to Windows Firewall exception list. A rule was deleted. |
  | 4949 | Windows Firewall settings were restored to the default values. |
  | 4950 | A Windows Firewall setting has changed. |
  | 4951 | A rule has been ignored because its major version number was not recognized by Windows Firewall. |
  | 4952 | Parts of a rule have been ignored because its minor version number was not recognized by Windows Firewall. The other parts of the rule will be enforced. |
  | 4953 | A rule has been ignored by Windows Firewall because it could not parse the rule. |
  | 4954 | Windows Firewall Group Policy settings have changed. The new settings have been applied. |
  | 4956 | Windows Firewall has changed the active profile. |
  | 4957 | Windows Firewall did not apply the following rule. |
  | 4958 | Windows Firewall did not apply the following rule because the rule referred to items not configured on this computer. |

  - Event volume: **Low**.

  - Default: **No Auditing**.

  </details>

  <details>
  <summary> Expand Audit Other Policy Change Events policy </summary>

  The **Audit Other Policy Change Events** policy determines whether the OS generates audit events for security policy changes that aren't otherwise audited in the Policy Change category. These other activities in the Policy Change category that can be audited include:

  - Trusted Platform Module (TPM) configuration changes.

  - Kernel-mode cryptographic self tests.

  - Cryptographic provider operations.

  - Cryptographic context operations or modifications.

  | Event ID | Event message |
  |--|--|
  | 4670 | Permissions on an object were changed. |
  | 4909 | The local policy settings for the TBS were changed. |
  | 4910 | The group policy settings for the TBS were changed. |
  | 5063 | A cryptographic provider operation was attempted. |
  | 5064 | A cryptographic context operation was attempted. |
  | 5065 | A cryptographic context modification was attempted. |
  | 5066 | A cryptographic function operation was attempted. |
  | 5067 | A cryptographic function modification was attempted. |
  | 5068 | A cryptographic function provider operation was attempted. |
  | 5069 | A cryptographic function property operation was attempted. |
  | 5070 | A cryptographic function property modification was attempted. |
  | 5447 | A Windows Filtering Platform filter has been changed. |
  | 6144 | Security policy in the group policy objects has been applied successfully. |
  | 6145 | One or more errors occurred while processing security policy in the group policy objects. |

  - Event volume: **Low**.

  - Default: **No Auditing**.

  </details>

- **Privilege Use**

  Permissions on a network are granted for users or computers to complete defined tasks. Privilege Use security policy settings and audit events allow you to track the use of certain permissions on one or more systems. This category includes the following subcategories:

  <br>
  <details>
  <summary> Expand Audit Non-Sensitive Privilege Use policy  </summary>

  The **Audit Non-Sensitive Privilege Use** policy determines whether the OS generates audit events when non-sensitive privileges (user rights) are used. The following privileges are non-sensitive:

  - Add workstations to domain

  - Adjust memory quotas for a process

  - Allow log on locally

  - Allow log on through Terminal Services

  - Bypass traverse checking

  - Change the system time

  - Create a page file

  - Create global objects

  - Create permanent shared objects

  - Create symbolic links

  - Deny access to this computer from the network

  - Deny log on as a batch job

  - Deny log on as a service

  - Deny log on locally

  - Deny log on through Terminal Services

  - Force shutdown from a remote system

  - Increase a process working set

  - Increase scheduling priority

  - Lock pages in memory

  - Log on as a batch job

  - Log on as a service

  - Modify an object label

  - Perform volume maintenance tasks

  - Profile single process

  - Profile system performance

  - Remove computer from docking station

  - Shut down the system

  - Synchronize directory service data

  If you configure this policy setting, an audit event is generated when a non-sensitive privilege is called. Success audits record successful attempts, and failure audits record unsuccessful attempts.

  | Event ID | Event message |
  |--|--|
  | 4672 | Special privileges assigned to new logon. |
  | 4673 | A privileged service was called. |
  | 4674 | An operation was attempted on a privileged object. |

  - Event volume: **Very High**.

  </details>

  <details>
  <summary> Expand Audit Other Privilege Use Events policy </summary>

  The **Audit Other Privilege Use Events** policy isn't used.

  </details>

  <details>
  <summary> Expand Audit Sensitive Privilege Use policy </summary>

  The **Audit Sensitive Privilege Use** policy determines whether the OS generates audit events when sensitive privileges (user rights) are used. Actions that can be audited include:

  - A privileged service is called.

  - One of the following privileges is called:

    - Act as part of the OS

    - Back up files and directories

    - Create a token object

    - Debug programs

    - Enable computer and user accounts to be trusted for delegation

    - Generate security audits

    - Impersonate a client after authentication

    - Load and unload device drivers

    - Manage auditing and security log

    - Modify firmware environment values

    - Replace a process-level token

    - Restore files and directories

    - Take ownership of files or other objects

  If you configure this policy setting, an audit event is generated when sensitive privilege requests are made. Success audits record successful attempts, and failure audits record unsuccessful attempts.

  | Event ID | Event message |
  |--|--|
  | 4672 | Special privileges assigned to new logon. |
  | 4673 | A privileged service was called. |
  | 4674 | An operation was attempted on a privileged object. |

  - Event volume: **High**.

  </details>

- **System**

  System security policy settings and audit events allow you to track system-level changes to a computer that aren't included in other categories and that have potential security implications. This category includes the following subcategories:

  <br>
  <details>
  <summary> Expand Audit IPsec Driver policy </summary>

  The **Audit IPsec Driver** policy determines whether the OS generates audit events for the activities of the IPsec driver. The IPsec driver, using the IP Filter List from the active IPsec policy, watches for outbound IP packets that must be secured and inbound IP packets that must be verified and decrypted. This security policy setting reports on the following activities of the IPsec driver:

  - Startup and shutdown of IPsec services.

  - Packets dropped due to integrity-check failure.

  - Packets dropped due to replay-check failure.

  - Packets dropped due to being in plaintext.

  - Packets received with an incorrect Security Parameter Index (SPI). This can indicate malfunctioning hardware or interoperability problems.

  - Failure to process IPsec filters.

  A high rate of packet drops by the IPsec filter driver may indicate attempts to gain access to the network by unauthorized systems. Failure to process IPsec filters poses a potential security risk because some network interfaces may not get the protection that is provided by the IPsec filter.

  | Event ID | Event message |
  |--|--|
  | 4960 | IPsec dropped an inbound packet that failed an integrity check. If this problem persists, it could indicate a network issue, or that packets are being modified in transit to this computer. Verify that the packets sent from the remote computer are the same as those received by this computer. This error might also indicate interoperability problems with other IPsec implementations. |
  | 4961 | IPsec dropped an inbound packet that failed a replay check. If this problem persists, it could indicate a replay attack against this computer. |
  | 4962 | IPsec dropped an inbound packet that failed a replay check. The inbound packet had too low a sequence number to ensure it was not a replay. |
  | 4963 | IPsec dropped an inbound clear text packet that should have been secured. This is usually due to the remote computer changing its IPsec policy without informing this computer. This could also be a spoofing attack attempt. |
  | 4965 | IPsec received a packet from a remote computer with an incorrect Security Parameter Index (SPI). This is usually caused by malfunctioning hardware that is corrupting packets. If these errors persist, verify that the packets sent from the remote computer are the same as those received by this computer. This error may also indicate interoperability problems with other IPsec implementations. In that case, if connectivity is not impeded, then these events can be ignored. |
  | 5478 | IPsec Services has started successfully. |
  | 5479 | IPsec Services has been shut down successfully. The shutdown of IPsec Services can put the computer at greater risk of network attack or expose the computer to potential security risks. |
  | 5480 | IPsec Services failed to get the complete list of network interfaces on the computer. This poses a potential security risk because some of the network interfaces may not get the protection provided by the applied IPsec filters. Use the IP Security Monitor snap-in to diagnose the problem. |
  | 5483 | IPsec Services failed to initialize RPC server. IPsec Services couldn't be started. |
  | 5484 | IPsec Services has experienced a critical failure and has been shut down. The shutdown of IPsec Services can put the computer at greater risk of network attack or expose the computer to potential security risks. |
  | 5485 | IPsec Services failed to process some IPsec filters on a plug-and-play event for network interfaces. This poses a potential security risk because some of the network interfaces may not get the protection provided by the applied IPsec filters. Use the IP Security Monitor snap-in to diagnose the problem. |

  - Event volume: **Low**.

  - Default: **No Auditing**.

  </details>

  <details>
  <summary> Expand Audit Other System Events policy </summary>

  The **Audit Other System Events** policy determines whether the OS audits various system events. The system events in this category include:

  - Startup and shutdown of the Windows Firewall service and driver.

  - Security policy processing by the Windows Firewall service.

  - Cryptography key file and migration operations.

  > [!IMPORTANT]
  > Failure to start the Windows Firewall service may result in a computer that isn't fully protected against network threats.

  | Event ID | Event message |
  |--|--|
  | 5024 | The Windows Firewall Service has started successfully. |
  | 5025 | The Windows Firewall Service has been stopped. |
  | 5027 | The Windows Firewall Service was unable to retrieve the security policy from the local storage. The service will continue enforcing the current policy. |
  | 5028 | The Windows Firewall Service was unable to parse the new security policy. The service will continue with currently enforced policy. |
  | 5029 | The Windows Firewall Service failed to initialize the driver. The service will continue to enforce the current policy. |
  | 5030 | The Windows Firewall Service failed to start. |
  | 5032 | Windows Firewall was unable to notify the user that it blocked an application from accepting incoming connections on the network. |
  | 5033 | The Windows Firewall Driver has started successfully. |
  | 5034 | The Windows Firewall Driver has been stopped. |
  | 5035 | The Windows Firewall Driver failed to start. |
  | 5037 | The Windows Firewall Driver detected critical runtime error. Terminating. |
  | 5058 | Key file operation. |
  | 5059 | Key migration operation. |
  | 6400 | BranchCache: Received an incorrectly formatted response while discovering availability of content. <br><br> *This event is logged only on computers running supported versions of the Windows OS.* |
  | 6401 | BranchCache: Received invalid data from a peer. Data discarded. <sup>1</sup> |
  | 6402 | BranchCache: The message to the hosted cache offering it data is incorrectly formatted. <sup>1</sup> |
  | 6403 | BranchCache: The hosted cache sent an incorrectly formatted response to the client. <sup>1</sup> |
  | 6404 | BranchCache: Hosted cache could not be authenticated using the provisioned SSL certificate. <sup>1</sup> |
  | 6405 | BranchCache: %2 instance(s) of event ID %1 occurred. <sup>1</sup> |
  | 6406 | %1 registered to Windows Firewall to control filtering for the following: %2 <sup>1</sup> |
  | 6407 | 1% <sup>1</sup> |
  | 6408 | Registered product %1 failed and Windows Firewall is now controlling the filtering for %2 <sup>1</sup> |

  > [!NOTE]
  > <sup>1</sup> This event is logged only on computers running supported versions of the Windows OS.

  - Event volume: **Low**.

  - Default: **Success** and **Failure**.

  </details>

  <details>
  <summary> Expand Audit Security State Change policy </summary>

  The **Audit Security State Change** policy determines whether Windows generates audit events for changes in the security state of a system. Changes in the security state of the OS include:

  - System startup and shutdown.

  - Change of system time.

  - System recovery from **CrashOnAuditFail**. This event is logged after a system reboots following **CrashOnAuditFail**. Some auditable activity might not be recorded when a system reboots due to **CrashOnAuditFail**.

  | Event ID | Event message |
  |--|--|
  | 4608 | Windows is starting up. |
  | 4609 | Windows is shutting down. |
  | 4616 | The system time was changed. |
  | 4621 | Administrator recovered system from CrashOnAuditFail. Users who are not administrators will now be allowed to log on. Some auditable activity might not have been recorded. |

  - Event volume: **Low**.

  - Default: **Success**.

  </details>

  <details>
  <summary> Expand Audit Security System Extension policy </summary>

  The **Audit Security System Extension** policy determines whether the OS generates audit events related to security system extensions. Changes to security system extensions in the OS include the following activities:

  - A security extension code is loaded (such as an authentication, notification, or security package). A security extension code registers with the Local Security Authority and will be used and trusted to authenticate logon attempts, submit logon requests, and be notified of any account or password changes. Examples of this extension code are Security Support Providers, such as Kerberos and NTLM.

  - A service is installed. An audit log is generated when a service is registered with the Service Control Manager. The audit log contains information about the service name, binary, type, start type, and service account.

  > [!IMPORTANT]
  > Attempts to install or load security system extensions or services are critical system events that could indicate a security breach.

  | Event ID | Event message |
  |--|--|
  | 4610 | An authentication package has been loaded by the Local Security Authority. |
  | 4611 | A trusted logon process has been registered with the Local Security Authority. |
  | 4614 | A notification package has been loaded by the Security Account Manager. |
  | 4622 | A security package has been loaded by the Local Security Authority. |
  | 4697 | A service was installed in the system. |

  - Event volume: **Low**. Security system extension events are generated more often on a domain controller than on client computers or member servers.

  - Default: **No Auditing**.

  </details>

  <details>
  <summary> Expand Audit System Integrity policy </summary>

  The **Audit System Integrity** policy determines whether the OS audits events that violate the integrity of the security subsystem. Activities that violate the integrity of the security subsystem include:

  - Audited events are lost due to a failure of the auditing system.

  - A process uses an invalid local procedure call (LPC) port in an attempt to impersonate a client, reply to a client address space, read to a client address space, or write from a client address space.

  - An RPC integrity violation is detected.

  - A code integrity violation with an invalid hash value of an executable file is detected.

  - Cryptographic tasks are performed.

  > [!IMPORTANT]
  > Violations of security subsystem integrity are critical and could indicate a potential security attack.

  | Event ID | Event message |
  |--|--|
  | 4612 | Internal resources allocated for the queuing of audit messages have been exhausted, leading to the loss of some audits. |
  | 4615 | Invalid use of LPC port. |
  | 4618 | A monitored security event pattern has occurred. |
  | 4816 | RPC detected an integrity violation while decrypting an incoming message. |
  | 5038 | Code integrity determined that the image hash of a file is not valid. The file could be corrupt due to unauthorized modification or the invalid hash could indicate a potential disk device error. |
  | 5056 | A cryptographic self-test was performed. |
  | 5057 | A cryptographic primitive operation failed. |
  | 5060 | Verification operation failed. |
  | 5061 | Cryptographic operation. |
  | 5062 | A kernel-mode cryptographic self-test was performed. |
  | 6281 | Code Integrity determined that the page hashes of an image file are not valid. The file could be improperly signed without page hashes or corrupt due to unauthorized modification. The invalid hashes could indicate a potential disk device error. <br><br> *This event is logged only on computers running the supported versions of the Windows OS.* |

  - Event volume: **Low**.

  - Default: **Success** and **Failure**.

  </details>

- **Global Object Access**

  Global Object Access Auditing policy settings allow administrators to define computer SACLs per object type for the file system or for the registry. The specified SACL is then automatically applied to every object of that type.

  Auditors are able to prove that every resource in the system is protected by an audit policy by viewing the contents of the Global Object Access Auditing policy settings. For example, if auditors see a policy setting called "Track all changes made by group administrators," they know that this policy is in effect.

  Resource SACLs are also useful for diagnostic scenarios. For example, setting the Global Object Access Auditing policy to log all the activity for a specific user and enabling the policy to track "Access denied" events for the file system or registry can help administrators quickly identify which object in a system is denying a user access.

  If you select the **Define this policy setting** check box on the policy’s property page, then select **Configure**, you can add a user or group to the global SACL. This enables you to define computer SACLs per object type for the file system. The specified SACL is then automatically applied to every file system object type.

  <br>
  <details>
  <summary> Expand File System (Global Object Access Auditing) policy </summary>

  The **File System (Global Object Access Auditing)** policy enables you to configure a global SACL on the file system for an entire computer.

  If both a file or folder SACL and a global SACL are configured on a computer, the effective SACL is derived by combining the file or folder SACL and the global SACL. This means that an audit event is generated if an activity matches either the file or folder SACL or the global SACL.

  - Event volume: *Varies* on the effective SACL and the level of user activity.

  </details>

  <details>
  <summary> Expand Registry (Global Object Access Auditing) policy </summary>

  The **Registry (Global Object Access Auditing)** policy enables you to configure a global SACL on the registry of a computer.

  If both a registry SACL and a global SACL are configured on a computer, the effective SACL is derived by combining the registry SACL and the global SACL. This means that an audit event is generated when an activity matches either the registry key SACL or the global SACL.

  - Event volume: *Varies* on the effective SACL and the level of user activity.

  </details>

