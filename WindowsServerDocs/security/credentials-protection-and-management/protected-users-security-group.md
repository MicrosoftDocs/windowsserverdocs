---
title: Protected Users Security Group
description: Learn about the Active Directory security group Protected Users feature, and how it works.
ms.topic: article
ms.assetid: 1b0b5180-f65a-43ac-8ef3-66014116f296
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/12/2016
---
# Protected Users Security Group

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

Protected Users is a global security group for Active Directory (AD) designed to protect against credential theft attacks. It's particularly effective with machines running Windows 8.1 and later or Windows Server 2012 R2 and later, as their host machines don't cache credentials that Protected Users doesn't support. If you plan to use Protected Users, we recommend you don't use earlier versions of Windows or Windows Server, as they lack the extra cache potential to maximize the security impact of the Protected Users group.

## Prerequisites

Your system must meet the following requirements before you can deploy a Protected Users group:

- Hosts must be running one of the following operating systems:
  
  - Windows 8.1 or later
  - Windows Server 2012 R2 or later

- If you need to host a PDC emulator role on a domain controller running an earlier version of Windows Server, you must create the Protected Users group by following the directions in [Adding a Protected User global security group to down-level domains](#adding-a-protected-user-global-security-group-to-down-level-domains) to [transfer the primary domain controller (PDC) emulator role](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc816944(v=ws.10)) to a domain controller that runs Windows Server 2012 R2, then replicate that group object to the other domain controllers.

- The domain functional level must be Windows Server 2012 R2. For more information about functional levels, see [Understanding Active Directory Domain Services (AD DS) Functional Levels](../active-directory-functional-levels.md).

> [!NOTE]
> The built-in domain Administrator, `S-1-5-<domain>-500`, is always exempt from Authentication Policies, even when they're assigned to an Authentication Policy Silo.

- Members of the Protected Users group must be able to authenticate using Kerberos with Advanced Encryption Standards (AES).

- You must replicate the global Protected Users security group across all domain controllers in the account domain.

## Protected Users limitations

For users with machines running Windows 8.1 and later or Windows Server 2012 R2 and later, becoming a member of the Protected Users group means AD automatically applies certain pre-configured limitations that the users won't be able to change unless they stop being group members.

The following features are limited or restricted for Protected Users group members running Windows 8.1 or later:

- Default credential delegation (CredSSP) is disabled by default. AD won't cache plain text credentials even when the user enables the **Allow delegating default credentials** setting on their machine.

- Windows Digest is disabled by default.

- New Technology Lan Manager (NTLM) is disabled because AD no longer caches the new technology one-way function hash (NTOWF).

- Kerberos long term keys: the user acquires their Kerberos ticket-granting ticket (TGT) when they sign in and can't reacquire it automatically.

- Sign-on offline is disabled because AD doesn't create a cached logon verifier.

The following restrictions apply to group members in domains running Windows Server 2012 R2 or later:

- Users can no longer authenticate using NTLM authentication.

- Users can no longer use Data Encryption Standard (DES) or RC4 cipher suites in Kerberos pre-authentication.

- You can't delegate users Users with unconstrained or constrained delegation.

- Users can't renew user tickets (TGTs) beyond their initial four-hour lifetime.

## How the Protected Users group works

You can add users to the Protected Users group using the following methods:

- [UI tools](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc753515(v=ws.11)), such as Active Directory Administrative Center (ADAC) or Active Directory Users and Computers.
- A command-line tool, such as [Dsmod group](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/cc732423(v=ws.11)).
- With PowerShell, using the [`Add-ADGroupMember`](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee617210(v=technet.10)) cmdlet.

>[!IMPORTANT]
>Never add accounts for services and computers to the Protected Users group. For those accounts, membership doesn't provide local protections because the password and certificiate is always available on the host.
>
>Don't add accounts that are already members of highly privileged groups, such as the Enterprise Admins or Domain Admins groups, until you can guarantee adding them won't have negative consequences. Highly privileged users in the Protected Users are subject to the same [limitations and restrictions](#protected-users-limitations) as regular users, and it's not possible to work around or change those settings. If you add all members of those groups to the Protected Users group, it's possible to accidentally lock out their accounts. It's important to test your system to make sure the mandatory setting changes won't interfere with account access for these privileged user groups.

Members of the Protected Users group can only authenticate using Kerberos with Advanced Encryption Standards (AES). This method requires AES keys for the account in Active Directory. The built-in Administrator doesn't have an AES key unless the password for the domain running Windows Server 2008 or later changes. Any account who has their password changed by a domain controller running an earlier version of Windows Server is locked out of authentication.

To avoid lockouts and missing AES keys, we recommend you follow these guidelines:

- Don't run tests in domains unless *all domain controllers run Windows Server 2008 or later.

- Change passwords for all domain accounts you created before you created the domain. Otherwise, these accounts won't be able to authenticate.

- Change passwords for every user before you add them as members of the Protected Users group. Alternatively, make sure their passwords changed recently on a domain controller running Windows Server 2008 or later.

### Adding a Protected User global security group to down-level domains

Domain controllers that run an operating system earlier than Windows Server 2012 R2 can support adding members to the new Protected User security group. This way, these members can benefit from device protections before you upgrade the domain.

> [!NOTE]
> Domain controllers running earlier versions of Windows than 8.1 don't support domain protections.

To create a Protected Users group on a domain controller running an earlier version of WIndows Server:

1. [Transfer the PDC emulator role](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc816944(v=ws.10)) to a domain controller that runs Windows Server 2012 R2.

1. Replicate the group object to the other domain controllers.

After that, you should be able to host the PDC emulator role on a domain controller running an earlier version of Windows Server.

### Protected Users group AD properties

The following table specifies the Active Directory properties of the Protected Users group.

|Attribute|Value|
|-------|-----|
|Well-known SID/RID|S-1-5-21-\<domain>-525|
|Type|Domain Global|
|Default container|CN=Users, DC=\<domain>, DC=|
|Default members|None|
|Default member of|None|
|Protected by ADMINSDHOLDER?|No|
|Safe to move out of default container?|Yes|
|Safe to delegate management of this group to non-service admins?|No|
|Default user rights|No default user rights|

## How the Protected Users security group protects users

This section describes how the Protected Users security group provides protections for a new member that has:

- Signed in to a Windows device

- A user account domain in a domain functional level running Windows Server 2012 R2 or later

### Device protections for signed in Protected Users

When the signed in user is a member of the Protected Users group, the group provides the following protections:

- Credential delegation (CredSSP) doesn't cache the user's plain text credentials even when the user enables the **Allow delegating default credentials** Group Policy setting.

- For Windows 8.1 and later and Windows Server 2012 R2 and later, Windows Digest doesn't cache the user's plaintext credentials even when they've enabled Windows Digest.

> [!NOTE]
> After installing [Microsoft Security Advisory 2871997](/security-updates/SecurityAdvisories/2016/2871997) Windows Digest will keep caching credentials you've configured the registry key. See [Microsoft Security Advisory: Update to improve credentials protection and management: May 13, 2014](https://support.microsoft.com/help/2871997/microsoft-security-advisory-update-to-improve-credentials-protection-a) for instructions about how to stop caching.

- NTLM stops caching the user's plaintext credentials or NT one-way function (NTOWF).

- Kerberos stops creating DES or RC4 keys. Also Kerberos doesn't cache the user's plaintext credentials or long-term keys after acquiring the initial TGT.

- The system doesn't create a cached verifier at user sign-in or unlock, so member systems no longer support offline sign-in.

After you add a new user account to the Protected Users group, these protections will activate when the new Protected User signs in to their device.

### Domain controller protections for Protected Users

Protected User accounts that authenticate to a domain running Windows Server 2012 R2 or later are unable to do the following:

- Authenticate with NTLM authentication.

- Use DES or RC4 encryption types in Kerberos pre-authentication.

- Delegate with unconstrained or constrained delegation.

- Renew Kerberos TGTs beyond their initial four-hour lifetime.

The Protected Users group applies non-configurable settings to TGT expiration for every member account. Normally, the domain controller sets the TGT lifetime and renewal based on the following two domain policies:

- Maximum lifetime for user ticket
- Maximum lifetime for user ticket renewal

For Protected Users members, the group automatically sets these lifetime limits to 600 minutes. The user can't change this limit unless they leave the group.

For more information, see [How to Configure Protected Accounts](../../identity/ad-ds/manage/how-to-configure-protected-accounts.md).

## Troubleshooting

<!--I don't think this section should be here. It needs to be in a dedicated article.-->

Two operational administrative logs are available to help troubleshoot events that are related to Protected Users. These new logs are located in Event Viewer and are disabled by default, and are located under **Applications and Services Logs\Microsoft\Windows\Authentication**.

|Event ID and Log|Description|
|----------|--------|
|104<p>**ProtectedUser-Client**|Reason: The security package on the client does not contain the credentials.<p>The error is logged in the client computer when the account is a member of the Protected Users security group. This event indicates that the security package does not cache the credentials that are needed to authenticate to the server.<p>Displays the package name, user name, domain name, and server name.|
|304<p>**ProtectedUser-Client**|Reason: The security package does not store the Protected User's credentials.<p>An informational event is logged in the client to indicate that the security package does not cache the user's sign-in credentials. It is expected that Digest (WDigest), Credential Delegation (CredSSP), and NTLM fail to have sign-on credentials for Protected Users. Applications can still succeed if they prompt for credentials.<p>Displays the package name, user name, and domain name.|
|100<p>**ProtectedUserFailures-DomainController**|Reason: An NTLM sign-in failure occurs for an account that is in the Protected Users security group.<p>An error is logged in the domain controller to indicate that NTLM authentication failed because the account was a member of the Protected Users security group.<p>Displays the account name and device name.|
|104<p>**ProtectedUserFailures-DomainController**|Reason: DES or RC4 encryption types are used for Kerberos authentication and a sign-in failure occurs for a user in the Protected User security group.<p>Kerberos preauthentication failed because DES and RC4 encryption types cannot be used when the account is a member of the Protected Users security group.<p>(AES is acceptable.)|
|303<p>**ProtectedUserSuccesses-DomainController**|Reason: A Kerberos ticket-granting-ticket (TGT) was successfully issued for a member of the Protected User group.|

## Additional resources

- [Credentials Protection and Management](credentials-protection-and-management.md)

- [Authentication Policies and Authentication Policy Silos](authentication-policies-and-authentication-policy-silos.md)

- [How to Configure Protected Accounts](../../identity/ad-ds/manage/how-to-configure-protected-accounts.md)
