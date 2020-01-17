---
title: Protected Users Security Group
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: security-credential-protection
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1b0b5180-f65a-43ac-8ef3-66014116f296
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Protected Users Security Group

> Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

This topic for the IT professional describes the Active Directory security group Protected Users, and explains how it works. This group was introduced in  Windows Server 2012 R2 domain controllers.

## <a name="BKMK_ProtectedUsers"></a>Overview

This security group is designed as part of a strategy to manage credential exposure within the enterprise. Members of this group automatically have non-configurable protections applied to their accounts. Membership in the Protected Users group is meant to be restrictive and proactively secure by default. The only method to modify these protections for an account is to remove the account from the security group.

> [!WARNING]
> Accounts for services and computers should never be members of the Protected Users group. This group provides incomplete protection anyway, because the password or certificate is always available on the host. Authentication will fail with the error \"the user name or password is incorrect\" for any service or computer that is added to the Protected Users group.

This domain-related, global group triggers non-configurable protection on devices and host computers running  Windows Server 2012 R2  and Windows 8.1 or later for users in domains with a primary domain controller running  Windows Server 2012 R2 . This greatly reduces the default memory footprint of credentials when users sign-in to computers with these protections.

For more information, see [How the Protected Users group works](#BKMK_HowItWorks) in this topic.


## <a name="BKMK_Requirements"></a>Protected Users group requirements
Requirements to provide device protections for members of the Protected Users group include:

- The Protected Users global security group is replicated to all domain controllers in the account domain.

- Windows 8.1 and Windows Server 2012 R2 added support by default. [Microsoft Security Advisory 2871997](https://technet.microsoft.com/library/security/2871997) adds support to Windows 7, Windows Server 2008 R2 and Windows Server 2012.

Requirements to provide domain controller protection for members of the Protected Users group include:

- Users must be in domains which are Windows Server 2012 R2 or higher domain functional level.

### Adding Protected User global security group to down-level domains

Domain controllers that run an operating system earlier than Windows Server 2012 R2 can support adding members to the new Protected User security group. This allows the users to benefit from device protections before the domain is upgraded. 

> [!Note]
> The domain controllers will not support domain protections. 

Protected Users group can be created by [transferring the primary domain controller (PDC) emulator role](https://technet.microsoft.com/library/cc816944(v=ws.10).aspx) to a domain controller that runs Windows Server 2012 R2. After that group object is replicated to other domain controllers, the PDC emulator role can be hosted on a domain controller that runs an earlier version of Windows Server.

### <a name="BKMK_ADgroup"></a>Protected Users group AD properties

The following table specifies the properties of the Protected Users group.

|Attribute|Value|
|-------|-----|
|Well-known SID/RID|S-1-5-21-<domain>-525|
|Type|Domain Global|
|Default container|CN=Users, DC=<domain>, DC=|
|Default members|None|
|Default member of|None|
|Protected by ADMINSDHOLDER?|No|
|Safe to move out of default container?|Yes|
|Safe to delegate management of this group to non-service admins?|No|
|Default user rights|No default user rights|

## <a name="BKMK_HowItWorks"></a>How Protected Users group works
This section explains how the Protected Users group works when:

- Signed in a Windows device

- User account domain is in a Windows Server 2012 R2 or higher domain functional level

### Device protections for signed in Protected Users
When the signed in user is a member of the Protected Users group the following protections are applied:

- Credential delegation (CredSSP) will not cache the user's plain text credentials even when the **Allow delegating default credentials** Group Policy setting is enabled.

- Beginning with Windows 8.1 and Windows Server 2012 R2, Windows Digest will not cache the user's plain text credentials even when Windows Digest is enabled.

> [!Note]
> After installing [Microsoft Security Advisory 2871997](https://technet.microsoft.com/library/security/2871997) Windows Digest will continue to cache credentials until the registry key is configured. See [Microsoft Security Advisory: Update to improve credentials protection and management: May 13, 2014](https://support.microsoft.com/help/2871997/microsoft-security-advisory-update-to-improve-credentials-protection-a) for instructions.

- NTLM will not cache the user's plain text credentials or NT one-way function (NTOWF).

- Kerberos will no longer create DES or RC4 keys. Also it will not cache the user's plain text credentials or long-term keys after the initial TGT is acquired.

- A cached verifier is not created at sign-in or unlock, so offline sign-in is no longer supported.

After the user account is added to the Protected Users group, protection will begin when the user signs in to the device.

### Domain controller protections for Protected Users
Accounts that are members of the Protected Users group that authenticate to a  Windows Server 2012 R2  domain are unable to:

- Authenticate with NTLM authentication.

- Use DES or RC4 encryption types in Kerberos pre-authentication.

- Be delegated with unconstrained or constrained delegation.

- Renew the Kerberos TGTs beyond the initial four-hour lifetime.

Non-configurable settings to the TGTs expiration are established for every account in the Protected Users group. Normally, the domain controller sets the TGTs lifetime and renewal, based on the domain policies, **Maximum lifetime for user ticket** and **Maximum lifetime for user ticket renewal**. For the Protected Users group, 600 minutes is set for these domain policies.

For more information, see [How to Configure Protected Accounts](how-to-configure-protected-accounts.md).

## Troubleshooting
Two operational administrative logs are available to help troubleshoot events that are related to Protected Users. These new logs are located in Event Viewer and are disabled by default, and are located under **Applications and Services Logs\Microsoft\Windows\Authentication**.

|Event ID and Log|Description|
|----------|--------|
|104<br /><br />**ProtectedUser-Client**|Reason: The security package on the client does not contain the credentials.<br /><br />The error is logged in the client computer when the account is a member of the Protected Users security group. This event indicates that the security package does not cache the credentials that are needed to authenticate to the server.<br /><br />Displays the package name, user name, domain name, and server name.|
|304<br /><br />**ProtectedUser-Client**|Reason: The security package does not store the Protected User's credentials.<br /><br />An informational event is logged in the client to indicate that the security package does not cache the user's sign-in credentials. It is expected that Digest (WDigest), Credential Delegation (CredSSP), and NTLM fail to have sign-on credentials for Protected Users. Applications can still succeed if they prompt for credentials.<br /><br />Displays the package name, user name, and domain name.|
|100<br /><br />**ProtectedUserFailures-DomainController**|Reason: An NTLM sign-in failure occurs for an account that is in the Protected Users security group.<br /><br />An error is logged in the domain controller to indicate that NTLM authentication failed because the account was a member of the Protected Users security group.<br /><br />Displays the account name and device name.|
|104<br /><br />**ProtectedUserFailures-DomainController**|Reason: DES or RC4 encryption types are used for Kerberos authentication and a sign-in failure occurs for a user in the Protected User security group.<br /><br />Kerberos preauthentication failed because DES and RC4 encryption types cannot be used when the account is a member of the Protected Users security group.<br /><br />(AES is acceptable.)|
|303<br /><br />**ProtectedUserSuccesses-DomainController**|Reason: A Kerberos ticket-granting-ticket (TGT) was successfully issued for a member of the Protected User group.|


## Additional resources

- [Credentials Protection and Management](credentials-protection-and-management.md)

- [Authentication Policies and Authentication Policy Silos](authentication-policies-and-authentication-policy-silos.md)

- [How to Configure Protected Accounts](how-to-configure-protected-accounts.md)
