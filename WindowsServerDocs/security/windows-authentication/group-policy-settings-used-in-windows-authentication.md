---
title: Group Policy Settings Used in Windows Authentication
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: security-windows-auth
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9e237f89-45b1-4a4e-9b72-11dc7d6a470b
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Group Policy Settings Used in Windows Authentication

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

This reference topic for the IT professional describes the use and impact of Group Policy settings in the authentication process.

You can manage authentication in Windows operating systems by adding user, computer, and service accounts to groups, and then by applying authentication policies to those groups. These policies are defined as local security policies and as administrative templates, also known as Group Policy settings. Both sets can be configured and distributed throughout your organization by using Group Policy.

> [!NOTE]
> Features introduced in  Windows Server 2012 R2 , let you configure authentication policies for targeted services or applications, commonly called authentication silos, by using protected accounts. For information about how to do this in Active Directory, see [How to Configure Protected Accounts](how-to-configure-protected-accounts.md).

For example, you can apply the following policies to groups, based on their function in the organization:

-   Log on locally or to a domain

-   Log on over a network

-   Reset accounts

-   Create accounts

The following table lists policy groups relevant to authentication and provides links to documentation that can help you configure those policies.

|Policy group|Location|Description|
|--------|------|--------|
|**Password Policy**|Local Computer Policy\Computer Configuration\Windows Settings\Security Settings\Account Policies|Password policies affect the characteristics and behavior of passwords. Password policies are used for domain accounts or local user accounts. They determine settings for passwords, such as enforcement and lifetime.<br /><br />For information about specific settings, see [Password Policy](https://technet.microsoft.com/itpro/windows/keep-secure/password-policy).|
|**Account Lockout Policy**|Local Computer Policy\Computer Configuration\Windows Settings\Security Settings\Account Policies|Account lockout policy options disable accounts after a set number of failed logon attempts. Using these options can help you detect and block attempts to break passwords.<br /><br />For information about account lockout policy options, see [Account Lockout Policy](https://technet.microsoft.com/itpro/windows/keep-secure/account-lockout-policy).|
|**Kerberos Policy**|Local Computer Policy\Computer Configuration\Windows Settings\Security Settings\Account Policies|Kerberos-related settings include ticket lifetime and enforcement rules. Kerberos policy does not apply to local account databases because the Kerberos authentication protocol is not used to authenticate local accounts. Therefore, the Kerberos policy settings can be configured only by means of the default domain Group Policy Object (GPO), where it affects domain logons.<br /><br />For information about Kerberos Policy options for the domain controller, see [Kerberos Policy](https://technet.microsoft.com/itpro/windows/keep-secure/kerberos-policy).|
|**Audit Policy**|Local Computer Policy\Computer Configuration\Windows Settings\Security Settings\Local Policies\Audit Policy|Auditing policy lets you control and understand access to objects, such as files and folders, and to manage user and group accounts and user logons and logoffs. Auditing policies can specify the categories of events that you want to audit, set the size and behavior of the security log, and determine of which objects you want to monitor access and what type of access you want to monitor.<br /><br />|
|**User Rights Assignment**|Local Computer Policy\Computer Configuration\Windows Settings\Security Settings\Local Policies\User Rights Assignment|User rights are typically assigned on the basis of the security groups to which a user belongs, such as Administrators, Power Users, or Users. The policy settings in this category are typically used to grant or deny permission to access a computer based on the method of access and security group memberships.|
|**Security Options**|Local Computer Policy\Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options|Policies relevant to authentication include:<br /><br />-   Devices<br />-   Domain controller<br />-   Domain member<br />-   Interactive logon<br />-   Microsoft network server<br />-   Network access<br />-   Network security<br />-   Recovery console<br />-   Shutdown<br /><br />|
|**Credentials Delegation**|Computer Configuration\Administrative Templates\System\Credentials Delegation|The delegation of credentials is a mechanism that lets local credentials be used on other systems, most notably member servers and domain controllers within a domain. These settings apply to applications by using the Credential Security Support Provider (Cred SSP). Remote Desktop Connection is an example.|
|**KDC**|Computer Configuration\Administrative Templates\System\KDC|These policy settings affect how the Key Distribution Center (KDC), which is a service on the domain controller, handles Kerberos authentication requests.|
|**Kerberos**|Computer Configuration\Administrative Templates\System\Kerberos|These policy settings affect how Kerberos is configured to handle support for claims, Kerberos armoring, compound authentication, identifying proxy servers, and other configurations.|
|**Logon**|Computer Configuration\Administrative Templates\System\Logon|These policy settings control how the system presents the logon experience for users.|
|**Net Logon**|Computer Configuration\Administrative Templates\System\Net Logon|These policy settings control how the system handles network logon requests including how the Domain Controller Locator behaves.<br /><br />For more information about how the Domain Controller Locator fits into replication processes, see [Understanding Replication Between Sites](https://technet.microsoft.com/library/cc771251.aspx).|
|**Biometrics**|Computer Configuration\Administrative Templates\Windows Components\Biometrics|These policy settings generally permit or deny the use of Biometrics as an authentication method.<br /><br />For information about the Windows implementation of biometrics, see Windows Biometric Framework Overview.|
|**Credential User Interface**|Computer Configuration\Administrative Templates\Windows Components\Credential User Interface|These policy settings control how credentials are managed at the point of entry.|
|**Password Synchronization**|Computer Configuration\Administrative Templates\Windows Components\Password Synchronization|These policy settings determine how the system manages the synchronization of passwords between Windows and UNIX-based operating systems.<br /><br />For more information, see [Password Synchronization](https://technet.microsoft.com/library/cc732609.aspx).|
|**Smart Card**|Computer Configuration\Administrative Templates\Windows Components\Smart Card|These policy settings control how the system manages smart card logons.<br /><br />|
|**Windows Logon Options**|Computer Configuration\Administrative Templates\Windows Components\Windows Logon Options|These policy settings control when and how logon opportunities are available.|
|**Ctrl+Alt+Del Options**|Computer Configuration\Administrative Templates\Windows Components\Ctrl+Alt+Del Options|These policy settings affect the appearance of and accessibility to features on the logon UI (Secure Desktop), such as Task Manager and the keyboard lock of the computer.|
|**Logon**|Computer Configuration\Administrative Templates\Windows Components\Logon|These policy settings determine if or which processes can run when the user logs on.|

## See also
[Windows Authentication Technical Overview](windows-authentication-technical-overview.md)


