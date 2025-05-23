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

  <details>
  <summary> Expand Audit Distribution Group Management policy

  The **Audit Distribution Group Management** policy determines whether the operating system generates audit events for specific distribution-group management tasks. This subcategory to which this policy belongs is logged only on domain controllers. Tasks for distribution-group management that can be audited include:

  - A distribution group is created, changed, or deleted.
  - A member is added to or removed from a distribution group.

  > [!NOTE]
  > Distribution groups cannot be used to manage access control permissions.

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
  <summary> Expand Audit Other Account Management Events policy

  The **Audit Other Account Management Events** policy determines whether the operating system generates user account management audit events. Events can be generated for user account management auditing when:

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
  <summary> Expand Audit Security Group Management policy

  The **Audit Security Group Management** policy determines whether the operating system generates audit events when specific security group management tasks are performed. Tasks for security group management include:

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
  <summary> Expand Audit User Account Management

  The **Audit User Account Management** determines whether the operating system generates audit events when specific user account management tasks are performed. Tasks that are audited for user account management include:

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

  <details>
  <summary> Expand Audit DPAPI Activity policy

  The **Audit DPAPI Activity** policy determines whether the operating system generates audit events when encryption or decryption calls are made into the data protection application interface (DPAPI).

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
  <summary> Expand Audit PNP Activity policy

  The **Audit PNP Activity** policy audits when an an external plug and play (PnP) device is detected.

  | Event ID | Event message |
  |--|--|
  | 6416 | A new device is connected or an existing device is removed. |

  - Event volume: **Low**.

  </details>

  <details>
  <summary> Expand Audit Process Creation policy

  The **Audit Process Creation** policy determines whether the operating system generates audit events when a process is created or starts.

  These audit events can help you track user activity and understand how a computer is being used. Information includes the name of the program or the user that created the process.

  | Event ID | Event message |
  |--|--|
  | 4688 | A new process has been created. |
  | 4696 | A primary token was assigned to a process. |

  - Event volume: *Varies* depending on system usage.

  </details>

  <details>
  <summary> Expand Audit Process Termination policy

  The **Audit Process Termination** policy determines whether the operating system generates audit events when an attempt is made to end a process.

  | Event ID | Event message |
  |--|--|
  | 4689 | A process has exited. |

  - Event volume: *Varies* depending on system usage.

  </details>

  <details>
  <summary> Expand Audit RPC Events policy

  The **Audit RPC Events** policy determines whether the operating system generates audit events when inbound remote procedure call (RPC) connections are made.

  RPC is a technology for creating distributed client/server programs. RPC is an interprocess communication technique that enables client and server software to communicate. To learn more, see [What Is RPC?](/previous-versions/windows/it-pro/windows-server-2003/cc787851(v=ws.10)).

  | Event ID | Event message |
  |--|--|
  | 5712 | An RPC was attempted. |

  - Event volume: **High** on RPC servers.
  - Default: **No Auditing**.

  </details>

  <details>
  <summary> Expand Audit Token Right Adjustment policy

  The **Audit Token Right Adjustment** policy audits events generated by adjusting the privileges of a token.

  | Event ID | Event message |
  |--|--|
  | 4703 | A user right was adjusted. |

  - Event volume: **High**.
  - Default: **No Auditing**.

  </details>

- **DS Access**

  DS Access security audit policy settings provide a detailed audit trail of attempts to access and modify objects in Active Directory Domain Services (AD DS). These audit events are logged only on domain controllers. This category includes the following subcategories:

  <details>
  <summary> Expand Audit Detailed Directory Service Replication policy

  The **Audit Detailed Directory Service Replication** policy determines whether the operating system generates audit events that contain detailed tracking information about data that is replicated between domain controllers. This audit subcategory can be useful to diagnose replication issues.

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
  <summary> Expand Audit Directory Service Access policy

  The **Audit Directory Service Access** policy determines whether the operating system generates audit events when an Active Directory Domain Services (AD DS) object is accessed. These events are similar to the Directory Service Access events in previous versions of Windows Server operating systems.

  > [!NOTE]
  > Audit events are generated only on objects with configured system access control lists (SACLs), and only when they are accessed in a manner that matches the SACL settings.

  | Event ID | Event message |
  |--|--|
  | 4662 | An operation was performed on an object. |

  - Event volume: **High** on domain controllers. **None** on client computers.
  - Default on Client editions: **No Auditing**.
  - Default on Server editions: **Success**.

  </details>

  <details>
  <summary> Expand Audit Directory Service Changes policy

  The **Audit Directory Service Changes** policy determines whether the operating system generates audit events when changes are made to objects in Active Directory Domain Services (AD DS). This policy, where appropriate, indicates the old and new values of the changed properties of the objects that were changed. The types of changes that are reported are:

  - Create
  - Delete
  - Modify
  - Move
  - Undelete

  > [!NOTE]
  > Audit events are generated only for objects with configured system access control lists (SACLs), and only when they are accessed in a manner that matches their SACL settings. Some objects and properties do not cause audit events to be generated due to settings on the object class in the schema.
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
  <summary> Expand Audit Directory Service Replication policy

  The **Audit Directory Service Replication** policy determines whether the operating system generates audit events when replication between two domain controllers begins and ends. Events in this subcategory are logged only on domain controllers.

  | Event ID | Event message |
  |--|--|
  | 4932 | Synchronization of a replica of an Active Directory naming context has begun. |
  | 4933 | Synchronization of a replica of an Active Directory naming context has ended. |

  - Event volume: **Medium** on domain controllers. **None** on client computers.
  - Default: **No Auditing**.

  </details>

- **Logon/Logoff**

  Logon/Logoff security policy settings and audit events allow you to track attempts to log on to a computer interactively or over a network. These events are particularly useful for tracking user activity and identifying potential attacks on network resources. This category includes the following subcategories:

  <details>
  <summary> Expand Audit Audit Account Lockout policy

  The **Audit Account Lockout** policy allows you to audit security events that are generated by a failed attempt to log on to an account that is locked out. If you configure this policy setting, an audit event is generated when an account cannot log on to a computer because the account is locked out. Success audits record successful attempts and failure audits record unsuccessful attempts.

  Account lockout events are essential for understanding user activity and detecting potential attacks.

  | Event ID | Event message |
  |--|--|
  | 4625 | An account failed to log on. |

  - Event volume: **Low**.
  - Default setting: **Success**.

  </details>

  <details>
  <summary> Expand Audit User / Device Claims

  The **Audit User / Device Claims** policy allows you to audit user and device claims information in the account’s logon token. Events in this subcategory are generated on the computer on which a logon session is created. For an interactive logon, the security audit event is generated on the computer that the user logged on to. You must enable the Audit Logon subcategory in order to get events from this subcategory.

  For a network logon, such as accessing a shared folder on the network, the security audit event is generated on the computer hosting the resource.

  | Event ID | Event message |
  |--|--|
  | 4626 | User/Device claims information. |

  - Event volume: **Low** on a client computer. **Medium** on a domain controller or a network server
  - Default: **No Auditing**.

  </details>

  <details>
  <summary> Expand Audit Group Membership policy

  The **Audit Group Membership** policy allows you to audit the group membership information in the user's logon token. Events in this subcategory are generated on the computer on which a logon session is created. You must also enable the Audit Logon subcategory.

  For an interactive logon, the security audit event is generated on the computer that the user logged on to. For a network logon, such as accessing a shared folder on the network, the security audit event is generated on the computer hosting the resource.

  | Event ID | Event message |
  |--|--|
  | 4627 | Group membership information. |

  - Event volume: **Low** on a client computer. **Medium** on a domain controller or a network server.
  - Default: **No Auditing**.

  </details>

  <details>
  <summary> Expand Audit IPsec Extended Mode policy

  The **Audit IPsec Extended Mode** policy determines whether the operating system generates audit events for the results of the Internet Key Exchange (IKE) protocol and Authenticated Internet Protocol (AuthIP) during Extended Mode negotiations.

  IKE is an Internet standard, defined in [RFC 2409](https://www.rfc-editor.org/rfc/rfc2409), that defines a mechanism to establish IPsec security associations (SAs). An SA is a combination of a mutually agreeable policy and keys that define the security services and mechanisms that help protect communication between IPsec peers.

  AuthIP is an enhanced version of IKE that offers additional flexibility with support for user-based authentication, authentication with multiple credentials, improved authentication method negotiation, and asymmetric authentication. Like IKE, AuthIP supports main-mode and quick-mode negotiation. AuthIP also supports Extended Mode, a part of IPsec peer negotiation during which a second round of authentication can be performed. Extended Mode, which is optional, can be used for multiple authentications. For example, with extended mode you can perform separate computer-based and user-based authentications.

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
  <summary> Expand Audit IPsec Main Mode policy

  The **Audit IPsec Main Mode** policy determines whether the operating system generates audit events for the results of the Internet Key Exchange (IKE) protocol and Authenticated Internet Protocol (AuthIP) during Quick Mode negotiations. Like IKE, AuthIP supports Main Mode and Quick Mode negotiation.

  Main Mode Internet Key Exchange (IKE) negotiation establishes a secure channel, known as the Internet Security Association and Key Management Protocol (ISAKMP) security association (SA), between two computers. To establish the secure channel, Main Mode negotiation determines a set of cryptographic protection suites, exchanges keying material to establish the shared secret key, and authenticates computer identities.

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
  <summary> Expand Audit IPsec Quick Mode policy

  The **Audit IPsec Quick Mode** policy determines whether the operating system generates audit events for the results of the Internet Key Exchange (IKE) protocol and Authenticated Internet Protocol (AuthIP) during Quick Mode negotiations. Like IKE, AuthIP supports Main Mode and Quick Mode negotiation.

  Quick Mode (also known as Phase 2) IKE negotiation establishes a secure channel between two computers to protect data. Because this phase involves the establishment of security associations (SAs) that are negotiated on behalf of the IPsec service, the SAs that are created during Quick Mode are called the IPsec SAs. During Quick Mode, keying material is refreshed or, if necessary, new keys are generated. A protection suite that protects specified IP traffic is also selected. A protection suite is a defined set of data integrity or data encryption settings. Quick Mode is not considered a complete exchange because it is dependent on a Main Mode exchange.

  | Event ID | Event message |
  |--|--|
  | 4977 | During Quick Mode negotiation, IPsec received an invalid negotiation packet. If this problem persists, it could indicate a network issue or an attempt to modify or replay this negotiation. |
  | 5451 | An IPsec Quick Mode security association was established. |
  | 5452 | An IPsec Quick Mode security association ended. |

  - Event volume: **High**.
  - Default: **No Auditing**.

  </details>

  <details>
  <summary> Expand Audit Logoff policy

  The **Audit Logoff** policy determines whether the operating system generates audit events when logon sessions are terminated. These events occur on the computer that was accessed. In the case of an interactive logon, these events are generated on the computer that was logged on to.

  > [!NOTE]
  > There is no failure event in this subcategory because failed logoffs (such as when a system abruptly shuts down) do not generate an audit record.

  Logon events are essential to understanding user activity and detecting potential attacks. Logoff events are not 100 percent reliable. For example, the computer can be turned off without a proper logoff and shutdown; in this case, a logoff event is not generated.

  | Event ID | Event message |
  |--|--|
  | 4634 | An account was logged off. |
  | 4647 | User initiated logoff. |

  - Event volume: **Low**.
  - Default: **Success**.

  </details>

  <details>
  <summary> Expand Audit Logon policy

  The **Audit Logon** policy determines whether the operating system generates audit events when a user attempts to log on to a computer.

  These events are related to the creation of logon sessions and occur on the computer that was accessed. For an interactive logon, events are generated on the computer that was logged on to. For a network logon, such as accessing a share, events are generated on the computer that hosts the resource that was accessed. Logon events are essential to tracking user activity and detecting potential attacks. The following events are recorded:

  - Logon success and failure.
  - Logon attempts by using explicit credentials. This event is generated when a process attempts to log on an account by explicitly specifying that account's credentials. This most commonly occurs in batch configurations such as scheduled tasks, or when using the `runas` command.

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
  <summary> Expand Audit Network Policy Server policy

  The **Audit Network Policy Server** policy determines whether the operating system generates audit events for RADIUS (IAS) and Network Access Protection (NAP) activity on user access requests. These requests are:

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
  | 6277 | Network Policy Server granted access to a user but put it on probation because the host did not meet the defined health policy. |
  | 6278 | Network Policy Server granted full access to a user because the host met the defined health policy. |
  | 6279 | Network Policy Server locked the user account due to repeated failed authentication attempts. |
  | 6280 | Network Policy Server unlocked the user account. |

  - Event volume: **Medium** or **High** on NPS and IAS servers. **Moderate** on other servers or on client computers.
  - Default: **Success** and **Failure**.

  </details>

  <details>
  <summary> Expand Audit Other Logon/Logoff Events policy

  The **Audit Other Logon/Logoff Events** policy determines whether Windows generates audit events for other logon or logoff events. These other logon or logoff events include:

  - A Remote Desktop session connects or disconnects.
  - A workstation is locked or unlocked.
  - A screen saver is invoked or dismissed.
  - A replay attack is detected. This event indicates that a Kerberos request was received twice with identical information. This condition could also be caused by network misconfiguration.
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
  <summary> Expand Audit Special Logon policy

  The **Audit Special Logon** policy determines whether the operating system generates audit events under special sign on (or log on) circumstances. This security policy setting determines whether the operating system generates audit events when:

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
