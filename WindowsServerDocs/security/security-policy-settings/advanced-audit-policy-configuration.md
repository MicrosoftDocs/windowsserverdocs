---
title: Advanced Audit Policy Configuration
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-policy-settings
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 49d6469f-73f6-46f1-b383-5261ae0d4eea
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Advanced Audit Policy Configuration

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This reference for the IT professional provides information about one collection of auditing settings which were introduced in Windows Server 2008 R2 and Windows 7, and the audit events that they generate.  
  
The security audit policy settings under **Security Settings\Advanced Audit Policy Configuration** can help your organization audit compliance with important business-related and security-related rules by tracking precisely defined activities, such as:  
  
-   A group administrator has modified settings or data on servers that contain finance information.  
  
-   An employee within a defined group has accessed an important file.  
  
-   The correct system access control list (SACL) is applied to every file and folder or registry key on a computer or file share as a verifiable safeguard against undetected access.  
  
These settings allow you to select only the behaviors that you want to monitor and exclude audit results for other behaviors. In addition, because security audit policies can be applied by using domain Group Policy, audit policy settings can be modified, tested, and deployed to selected users and groups.  
  
Audit policy settings under **Security Settings\Advanced Audit Policy Configuration** are available in the following categories:  
  
-   **Account Logon**  
  
    Configuring policy settings in this category can help you document attempts to authenticate account data on a domain controller or on a local Security Accounts Manager (SAM). Unlike Logon and Logoff policy settings and events, which track attempts to access a particular computer, settings and events in this category focus on the account database that is used. This category includes the following subcategories:  
  
    -   [Audit Credential Validation](../security-auditing/advanced-security-audit-policy-settings/audit-credential-validation.md)  
  
    -   [Audit Kerberos Authentication Service](../security-auditing/advanced-security-audit-policy-settings/audit-kerberos-authentication-service.md)  
  
    -   [Audit Kerberos Service Ticket Operations](../security-auditing/advanced-security-audit-policy-settings/audit-kerberos-service-ticket-operations.md)  
  
    -   [Audit Other Logon - Logoff Events](../security-auditing/advanced-security-audit-policy-settings/audit-other-logon-logoff-events.md)  
  
-   **Account Management**  
  
    The security audit policy settings in this category can be used to monitor changes to user and computer accounts and groups. This category includes the following subcategories:  
  
    -   [Audit Application Group Management](../security-auditing/advanced-security-audit-policy-settings/audit-application-group-management.md)  
  
    -   [Audit Computer Account Management](../security-auditing/advanced-security-audit-policy-settings/audit-computer-account-management.md)  
  
    -   [Audit Distribution Group Management](../security-auditing/advanced-security-audit-policy-settings/audit-distribution-group-management.md)  
  
    -   [Audit Other Account Management Events](../security-auditing/advanced-security-audit-policy-settings/audit-other-account-management-events.md)  
  
    -   [Audit Security Group Management](../security-auditing/advanced-security-audit-policy-settings/audit-security-group-management.md)  
  
    -   [Audit User Account Management](../security-auditing/advanced-security-audit-policy-settings/audit-user-account-management.md)  
  
-   **Detailed Tracking**  
  
    Detailed Tracking security policy settings and audit events can be used to monitor the activities of individual applications and users on that computer, and to understand how a computer is being used. This category includes the following subcategories:  
  
    -   [Audit DPAPI Activity](../security-auditing/advanced-security-audit-policy-settings/audit-dpapi-activity.md)  
  
    -   [Audit Process Creation](../security-auditing/advanced-security-audit-policy-settings/audit-process-creation.md)  
  
    -   [Audit Process Termination](../security-auditing/advanced-security-audit-policy-settings/audit-process-termination.md)  
  
    -   [Audit RPC Events](../security-auditing/advanced-security-audit-policy-settings/audit-rpc-events.md)  
  
-   **DS Access**  
  
    DS Access security audit policy settings provide a detailed audit trail of attempts to access and modify objects in Active Directory Domain Services (AD DS). These audit events are logged only on domain controllers. This category includes the following subcategories:  
  
    -   [Audit Detailed Directory Service Replication](../security-auditing/advanced-security-audit-policy-settings/audit-detailed-directory-service-replication.md)  
  
    -   [Audit Directory Service Access](../security-auditing/advanced-security-audit-policy-settings/audit-directory-service-access.md)  
  
    -   [Audit Directory Service Changes](../security-auditing/advanced-security-audit-policy-settings/audit-directory-service-changes.md)  
  
    -   [Audit Directory Service Replication](../security-auditing/advanced-security-audit-policy-settings/audit-directory-service-replication.md)  
  
-   **Logon/Logoff**  
  
    Logon/Logoff security policy settings and audit events allow you to track attempts to log on to a computer interactively or over a network. These events are particularly useful for tracking user activity and identifying potential attacks on network resources. This category includes the following subcategories:  
  
    -   [Audit Account Lockout](../security-auditing/advanced-security-audit-policy-settings/audit-account-lockout.md)  
  
    -   [Audit IPsec Extended Mode](../security-auditing/advanced-security-audit-policy-settings/audit-ipsec-extended-mode.md)  
  
    -   [Audit IPsec Main Mode](../security-auditing/advanced-security-audit-policy-settings/audit-ipsec-main-mode.md)  
  
    -   [Audit IPsec Quick Mode](../security-auditing/advanced-security-audit-policy-settings/audit-ipsec-quick-mode.md)  
  
    -   [Audit Logoff](../security-auditing/advanced-security-audit-policy-settings/audit-logoff.md)  
  
    -   [Audit Logon](../security-auditing/advanced-security-audit-policy-settings/audit-logon.md)  
  
    -   [Audit Network Policy Server](../security-auditing/advanced-security-audit-policy-settings/audit-network-policy-server.md)  
  
    -   [Audit Other Logon - Logoff Events](../security-auditing/advanced-security-audit-policy-settings/audit-other-logon-logoff-events.md)  
  
    -   [Audit Special Logon](../security-auditing/advanced-security-audit-policy-settings/audit-special-logon.md)  
  
-   **Object Access**  
  
    Object Access policy settings and audit events allow you to track attempts to access specific objects or types of objects on a network or computer. To audit attempts to access a file, directory, registry key, or any other object, you must enable the appropriate Object Access auditing subcategory for success and/or failure events. For example, the File System subcategory needs to be enabled to audit file operations, and the Registry subcategory needs to be enabled to audit registry accesses.   
  
    This category includes the following subcategories:  
  
    -   [Audit Application Generated](../security-auditing/advanced-security-audit-policy-settings/audit-application-generated.md)  
  
    -   [Audit Certification Services](../security-auditing/advanced-security-audit-policy-settings/audit-certification-services.md)  
  
    -   [Audit Detailed File Share](../security-auditing/advanced-security-audit-policy-settings/audit-detailed-file-share.md)  
  
    -   [Audit File Share](../security-auditing/advanced-security-audit-policy-settings/audit-file-share.md)  
  
    -   [Audit File System](../security-auditing/advanced-security-audit-policy-settings/audit-file-system.md)  
  
    -   [Audit Filtering Platform Connection](../security-auditing/advanced-security-audit-policy-settings/audit-filtering-platform-connection.md)  
  
    -   [Audit Filtering Platform Packet Drop](../security-auditing/advanced-security-audit-policy-settings/audit-filtering-platform-packet-drop.md)  
  
    -   [Audit Handle Manipulation](../security-auditing/advanced-security-audit-policy-settings/audit-handle-manipulation.md)  
  
    -   [Audit Kernel Object](../security-auditing/advanced-security-audit-policy-settings/audit-kernel-object.md)  
  
    -   [Audit Other Object Access Events](../security-auditing/advanced-security-audit-policy-settings/audit-other-object-access-events.md)  
  
    -   [Audit Registry](../security-auditing/advanced-security-audit-policy-settings/audit-registry.md)  
  
    -   [Audit SAM](../security-auditing/advanced-security-audit-policy-settings/audit-sam.md)  
  
-   **Policy Change**  
  
    Policy Change audit events allow you to track changes to important security policies on a local system or network. Because policies are typically established by administrators to help secure network resources, monitoring changes or attempts to change these policies can be an important aspect of security management for a network. This category includes the following subcategories:  
  
    -   [Audit Audit Policy Change](../security-auditing/advanced-security-audit-policy-settings/audit-audit-policy-change.md)  
  
    -   [Audit Authentication Policy Change](../security-auditing/advanced-security-audit-policy-settings/audit-authentication-policy-change.md)  
  
    -   [Audit Authorization Policy Change](../security-auditing/advanced-security-audit-policy-settings/audit-authorization-policy-change.md)  
  
    -   [Audit Filtering Platform Policy Change](../security-auditing/advanced-security-audit-policy-settings/audit-filtering-platform-policy-change.md)  
  
    -   [Audit MPSSVC Rule-Level Policy Change](../security-auditing/advanced-security-audit-policy-settings/audit-mpssvc-rule-level-policy-change.md)  
  
    -   [Audit Other Policy Change Events](../security-auditing/advanced-security-audit-policy-settings/audit-other-policy-change-events.md)  
  
-   **Privilege Use**  
  
    Permissions on a network are granted for users or computers to complete defined tasks. Privilege Use security policy settings and audit events allow you to track the use of certain permissions on one or more systems. This category includes the following subcategories:  
  
    -   [Audit Non-Sensitive Privilege Use](../security-auditing/advanced-security-audit-policy-settings/audit-non-sensitive-privilege-use.md)  
  
    -   [Audit Sensitive Privilege Use](../security-auditing/advanced-security-audit-policy-settings/audit-sensitive-privilege-use.md)  
  
    -   [Audit Other Privilege Use Events](../security-auditing/advanced-security-audit-policy-settings/audit-other-privilege-use-events.md)  
  
-   **System**  
  
    System security policy settings and audit events allow you to track system-level changes to a computer that are not included in other categories and that have potential security implications. This category includes the following subcategories:  
  
    -   [Audit IPsec Driver](../security-auditing/advanced-security-audit-policy-settings/audit-ipsec-driver.md)  
  
    -   [Audit Other System Events](../security-auditing/advanced-security-audit-policy-settings/audit-other-system-events.md)  
  
    -   [Audit Security State Change](../security-auditing/advanced-security-audit-policy-settings/audit-security-state-change.md)  
  
    -   [Audit Security System Extension](../security-auditing/advanced-security-audit-policy-settings/audit-security-system-extension.md)  
  
    -   [Audit System Integrity](../security-auditing/advanced-security-audit-policy-settings/audit-system-integrity.md)  
  
-   **Global Object Access**  
  
    Global Object Access Auditing policy settings allow administrators to define computer system access control lists (SACLs) per object type for the file system or for the registry. The specified SACL is then automatically applied to every object of that type.  
  
    Auditors will be able to prove that every resource in the system is protected by an audit policy by viewing the contents of the Global Object Access Auditing policy settings. For example, if auditors see a policy setting called "Track all changes made by group administrators," they know that this policy is in effect.  
  
    Resource SACLs are also useful for diagnostic scenarios. For example, setting the Global Object Access Auditing policy to log all the activity for a specific user and enabling the policy to track "Access denied" events for the file system or registry can help administrators quickly identify which object in a system is denying a user access.  
  
    > [!NOTE]  
    > If a file or folder SACL and a Global Object Access Auditing policy setting (or a single registry setting SACL and a Global Object Access Auditing policy setting) are configured on a computer, the effective SACL is derived from combining the file or folder SACL and the Global Object Access Auditing policy. This means that an audit event is generated if an activity matches the file or folder SACL or the Global Object Access Auditing policy.  
  
    This category includes the following subcategories:  
  
    -   [File System &#40;Global Object Access Auditing&#41;](../security-auditing/advanced-security-audit-policy-settings/file-system-global-object-access-auditing.md)  
  
    -   [Registry &#40;Global Object Access Auditing&#41;](../security-auditing/advanced-security-audit-policy-settings/registry-global-object-access-auditing.md)  
  
## See Also  
[Which Editions of Windows Support Advanced Audit Policy Configuration](../security-auditing/which-editions-of-windows-support-advanced-audit-policy-configuration.md)  
  

