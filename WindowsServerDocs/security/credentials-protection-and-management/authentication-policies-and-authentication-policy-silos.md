---
title: Authentication Policies and Authentication Policy Silos
description: Learn about authentication policy silos and the policies that can restrict accounts to those silos.
ms.topic: article
ms.assetid: 7eb0e640-033d-49b5-ab44-3959395ad567
ms.author: roharwoo
author: robinharwood
manager: mtillman
ms.date: 10/12/2016
---
# Authentication Policies and Authentication Policy Silos

>This document needs a re-write. It contains an assortment of paragraphs relating to different topics:
-- Kerberos armoring and support for claims
-- Protected Users security group
-- Authentication policies and authentication policy silos
>
>The sections on Authentication policies and authentication policy silos need to be reorganised to contain the information specific to them.

This topic for the IT professional describes authentication policy silos and the policies that can restrict accounts to those silos. It also explains how authentication policies can be used to restrict the scope of accounts. Authentication policy silos and the accompanying policies provide a way to restrict high-privilege credentials to specific systems.

Authentication policies and authentication policy silos can be defined and managed in Active Directory Domain Services (AD DS) by using the Active Directory Administrative Center, and the Active Directory Windows PowerShell cmdlets.

Authentication policy silos are containers to which administrators can assign user accounts, computer accounts, and service accounts. Sets of accounts can then be managed by the authentication policies that have been applied to that container. This reduces the need for the administrator to track access to resources for individual accounts, and helps prevent malicious users from accessing other resources through credential theft.

Capabilities introduced in  Windows Server 2012 R2 , allow you to create authentication policy silos, which host a set of high-privilege users and hosts. You can then assign authentication policies for this container to limit where privileged accounts can be used in the domain. When accounts are in the Protected Users security group, additional controls are applied, such as the exclusive use of the Kerberos protocol.

### About authentication policy silos
An authentication policy silo controls which accounts can be restricted by the silo and defines the authentication policies to apply to the members.

Authentication policy silos can be configured by using the Active Directory Administrative Console or Windows PowerShell.

### About authentication policies
An authentication policy defines the Kerberos protocol ticket-granting ticket (TGT) lifetime properties and authentication access control conditions for an account type. 

Authentication policies control the following:

-   The TGT lifetime for the account, which is set to be non-renewable.

-   The conditions applied at sign-on of a user or service account to obtain a Ticket Granting Ticket (TGT)

-   The conditions applied to a user, service or computer account when requesting a service ticket from the Ticket Granting Service (TGS)

An authentication policy may, optionally, be assigned to members of an authentication policy silo. 


## How it works
This section describes how authentication policy silos and authentication policies work in conjunction with the Protected Users security group and implementation of the Kerberos protocol in Windows.

-   [How the Kerberos protocol is used with authentication silos and policies](#BKMK_HowKerbUsed)

-   [How restricting a user sign-in works](#BKMK_HowRestrictingSignOn)

-   [How restricting service ticket issuance works](#BKMK_HowRestrictingServiceTicket)

**Configurable TGT**

The default Kerberos TGTs lifetime setting of four hours is configurable by using authentication policies and silos, which can be accessed through the Active Directory Administrative Center. This means that when four hours has passed, the user must authenticate again.
When an authentication policy is enforced and the authentication service request for a domain account is received on the domain controller, the domain controller returns a non-renewable TGT with the configured lifetime (unless the domain TGT lifetime is shorter).

**Authentication policies**
Authentication policies provide a way to apply configurable restrictions to accounts. Authentication policies are enforced during the Kerberos protocol authentication service (AS) or ticket-granting service (TGS) exchange. Restricting user sign-in to specific hosts requires the domain controller to validate the host's identity. When using Kerberos authentication with Kerberos armoring (which is part of Dynamic Access Control), the Key Distribution Center is provided with the TGT of the host from which the user is authenticating. The content of this armored TGT is used to complete an access check to determine if the host is allowed.

When the authentication service request for a domain account is received on the domain controller, the domain controller checks if authentication is allowed for the device before issuing the TGT.

When a ticket-granting service request is received by the domain controller for a domain account, the domain controller checks if authentication is allowed based on the request's ticket Privilege Attribute Certificate (PAC) data before issuing the service ticket. The PAC contains various types of authorization data, including groups that the user is a member of, rights the user has, and what policies apply to the user. This information is used to generate the user's access token. If it is an enforced authentication policy which allows authentication to a user, device, or service, the domain controller checks if authentication is allowed based on the request's ticket PAC data.

If the authentication policy is in audit mode, and the access is not allowed, a warning is raised in the event log. If an authentication policy is in enforced mode, the request is denied and an error is raised in the event log.

**Authentication policy silos**
When a domain account is linked to an authentication policy silo, and the user signs in, the Security Accounts Manager adds the claim type of Authentication Policy Silo that includes the silo as the value. This claim on the account provides the access to the targeted silo.

> [!NOTE]
> The domain account must be either directly linked or linked through silo membership to an audited authentication policy which allows authentication to a user, device or service,

You can use a single authentication policy for all members of a silo, or you can use separate policies for users, computers, and managed service accounts.

Authentication policies can be configured for each silo by using the Active Directory Administrative Console or Windows PowerShell. For more information, see [How to Configure Protected Accounts](../../identity/ad-ds/manage/how-to-configure-protected-accounts.md).

**Service accounts**
Because these authentication policies are applied to an account, it also applies to accounts that are used by services. If you want to limit the usage of a password for a service to specific hosts, this setting is useful. For example, group managed service accounts are configured where the hosts are allowed to retrieve the password from Active Directory Domain Services. However, that password can be used from any host for initial authentication. By applying an access control condition, an additional layer of protection can be achieved by limiting the password to only the set of hosts that can retrieve the password.

However, when services that run as system, network service, or other local service identity connect to network services, they use the host's computer account. Computer accounts cannot be restricted. So even if the service is using a computer account that is not for a Windows host, it cannot be restricted.

**Support for Kerberos extensions**

Authentication policies and authentication policy silos require that the client and the KDC both support armored requests and support for claims. If the user is sending the request from a computer that does not support armoring, such as computers running Windows 7 or Windows Vista, the request fails.

## <a name="BKMK_ErrorandEvents"></a>Associated error and informational event messages
The following table describes the events that are associated with Protected Users security group and the authentication policies that are applied to authentication policy silos.

The events are recorded in the Applications and Services Logs at **Microsoft\Windows\Authentication**.

For troubleshooting steps that use these events, see [Troubleshoot Authentication Policies](../../identity/ad-ds/manage/how-to-configure-protected-accounts.md#BKMK_CreateAuthNPolicies) and [Troubleshoot events related to Protected Users](../../identity/ad-ds/manage/how-to-configure-protected-accounts.md#BKMK_TroubleshootingEvents).

|Event ID and Log|Description|
|----------|--------|
|101<p>**AuthenticationPolicyFailures-DomainController**|Reason: An NTLM sign-in failure occurs because the authentication policy is configured.<p>An event is logged in the domain controller to indicate that NTLM authentication failed because access control restrictions are required, and those restrictions cannot be applied to NTLM.<p>Displays the account, device, policy, and silo names.|
|105<p>**AuthenticationPolicyFailures-DomainController**|Reason: A Kerberos restriction failure occurs because the authentication from a particular device was not permitted.<p>An event is logged in the domain controller to indicate that a Kerberos TGT was denied because the device did not meet the enforced access control restrictions.<p>Displays the account, device, policy, silo names, and TGT lifetime.|
|305<p>**AuthenticationPolicyFailures-DomainController**|Reason: A potential Kerberos restriction failure might occur because the authentication from a particular device was not permitted.<p>In audit mode, an informational event is logged in the domain controller to determine if a Kerberos TGT will be denied because the device did not meet the access control restrictions.<p>Displays the account, device, policy, silo names, and TGT lifetime.|
|106<p>**AuthenticationPolicyFailures-DomainController**|Reason: A Kerberos restriction failure occurs because the user or device was not allowed to authenticate to the server.<p>An event is logged in the domain controller to indicate that a Kerberos service ticket was denied because the user, device, or both do not meet the enforced access control restrictions.<p>Displays the device, policy, and silo names.|
|306<p>**AuthenticationPolicyFailures-DomainController**|Reason: A Kerberos restriction failure might occur because the user or device was not allowed to authenticate to the server.<p>In audit mode, an informational event is logged on the domain controller to indicate that a Kerberos service ticket will be denied because the user, device, or both do not meet the access control restrictions.<p>Displays the device, policy, and silo names.|

## Additional References
[How to Configure Protected Accounts](../../identity/ad-ds/manage/how-to-configure-protected-accounts.md)

[Credentials Protection and Management](credentials-protection-and-management.md)

[Protected Users Security Group](protected-users-security-group.md)
