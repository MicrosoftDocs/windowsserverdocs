---
title: AD FS Password Attack protection
description:  This document describes how to protect AD FS users from password attacks
author: billmath
manager: amycolannino
ms.reviewer: andandyMSFT
ms.date: 08/15/2023
ms.topic: article
ms.author: billmath
---

# What is a password attack?

A requirement for federated single sign-on is the availability of endpoints to authenticate over the internet. The availability of authentication endpoints on the internet enables users to access the applications even when they are not on a corporate network.

This also means that some bad actors can take advantage of the federated endpoints available on the internet to use these endpoints to try to determine passwords or to create denial of service attacks. One such attack that is becoming more common is called a **password attack**.

There are two types of common password attacks. Password spray attack & brute force password attack.

## Password spray attack

In a password spray attack, these bad actors will try the most common passwords across many different accounts and services to gain access to any password protected assets they can find. Usually these span many different organizations and identity providers. For example, an attacker will use a commonly available toolkit to enumerate all of the users in several organizations and then try “P@$$w0rD” and “Password1” against all of those accounts. To give you the idea, an attack might look like:

|  Target User   | Target Password |
|----------------|-----------------|
| User1@org1.com |    Password1    |
| User2@org1.com |    Password1    |
| User1@org2.com |    Password1    |
| User2@org2.com |    Password1    |
|       …        |        …        |
| User1@org1.com |    P@$$w0rD     |
| User2@org1.com |    P@$$w0rD     |
| User1@org2.com |    P@$$w0rD     |
| User2@org2.com |    P@$$w0rD     |

This attack pattern evades most detection techniques because from the vantage point of an individual user or company, the attack just looks like an isolated failed login.

For attackers, it's a numbers game: they know that there are some passwords out there that are most common. The attacker will get a few successes for every thousand accounts attacked, and that's enough to be effective. They use the accounts to get data from emails, harvest contact info, and send phishing links or just expand the password spray target group. The attackers don't care much about who those initial targets are—just that they have some success that they can leverage.

But by taking a few steps to configure the AD FS and network correctly, AD FS endpoints can be secured against these type of attacks. This article covers 3 areas that need to be configured properly to help secure against these attacks.

## Brute force password attack

In this form of attack, an attacker will attempt multiple password attempts against a targeted set of accounts. In many cases, these accounts will be targeted against users that have a higher level of access within the organization. These could be executives within the organization or admins who manage critical infrastructure.

This type of attack could also result in DOS patterns. This could be at the service level where AD FS is unable to process a large number of requests due to insufficient number of servers. This could be at a user level where a user is locked out of their account.

## Securing AD FS against password attacks

But by taking a few steps to configure the AD FS and network correctly, AD FS endpoints can be secured against these types of attacks. This article covers 3 areas that need to be configured properly to help secure against these attacks.

- Level 1, Baseline: These are the basic settings that must be configured on an AD FS server to ensure that bad actors can't brute force attack federated users.
- Level 2, Protecting the extranet: These are the settings that must be configured to ensure the extranet access is configured to use secure protocols, authentication policies and appropriate applications.
- Level 3, Move to password-less for extranet access: These are advanced settings and guidelines to enable access to federated resources with more secure credentials rather than passwords that are prone to attack.

## Level 1: Baseline

1. In AD FS 2016, implement [extranet smart lockout](../../ad-fs/operations/Configure-AD-FS-Extranet-Smart-Lockout-Protection.md) Extranet smart lockout tracks familiar locations, and will allow a valid user to come through if they have previously logged in successfully from that location. By using extranet smart lockout, you can ensure that bad actors won't be able to brute force attack the users and at the same time will let legitimate user be productive.

   If you aren't on AD FS 2016, we strongly recommend you [upgrade](../../ad-fs/deployment/upgrading-to-ad-fs-in-windows-server.md) to AD FS 2016. It's a simple upgrade path from AD FS 2012 R2. If you are on AD FS 2012 R2, implement [extranet lockout](../../ad-fs/operations/Configure-AD-FS-Extranet-Soft-Lockout-Protection.md). One disadvantage of this approach is that valid users may be blocked from extranet access if you are in a brute force pattern. AD FS on Server 2016 doesn't have this disadvantage.

1. Monitor & Block suspicious IP addresses

    If you have Microsoft Entra ID P1 or P2, implement Connect Health for AD FS, and use the [Risky IP report](/azure/active-directory/connect-health/active-directory-aadconnect-health-adfs#risky-ip-report-public-preview) notifications that it provides.

    a. Licensing is not for all users and requires 25 licenses per AD FS/WAP server that may be easy for a customer.

    b. You can now investigate IP's that are generating large number of failed logins.

    c. This will require you to enable auditing on your AD FS servers.

1. Block suspicious IP's. This potentially blocks DOS attacks.

    a. If on 2016, use the [*Extranet Banned IP addresses*](../../ad-fs/operations/configure-ad-fs-banned-ip.md) feature to block any requests from IP's flagged by #3 (or manual analysis).

     b. If you are on AD FS 2012 R2 or lower, block the IP address directly at Exchange Online and optionally on your firewall.

1. If you have Microsoft Entra ID P1 or P2, use [Microsoft Entra Password Protection](/azure/active-directory/authentication/concept-password-ban-bad-on-premises) to prevent guessable passwords from getting into Microsoft Entra ID.

    a. If you have guessable passwords, you can crack them with just 1-3 attempts. This feature prevents these from getting set.

    b. From our preview stats, nearly 20-50% of new passwords get blocked from being set. This implies that % of users are vulnerable to easily guessed passwords.

## Level 2: Protect your extranet

1. Move to modern authentication for any clients accessing from the extranet. Mail clients are a large part of this.

    a. You'll need to use Outlook Mobile for mobile devices. The new iOS native mail app supports modern authentication as well.

    b. You'll need to use Outlook 2013 (with the latest CU patches) or Outlook 2016.

1. Enable MFA for all extranet access. This gives you added protection for any extranet access.

    a. If you have Microsoft Entra ID P1 or P2, use [Microsoft Entra Conditional Access policies](/azure/active-directory/conditional-access/overview) to control this.  This is better than implementing the rules at AD FS.  This is because modern client apps are enforced on a more frequent basis.  This occurs, at Microsoft Entra ID, when requesting a new access token (typically every hour) using a refresh token.

    b. If you don't have Microsoft Entra ID P1 or P2 or have additional apps on AD FS that you allow internet based access, implement Microsoft Entra multifactor authentication and configure a [global multifactor authentication policy](../../ad-fs/operations/configure-authentication-policies.md#to-configure-multi-factor-authentication-globally) for all extranet access.

## Level 3: Move to password-less for extranet access

1. Move to Window 10 and use [Hello For Business](/windows/security/identity-protection/hello-for-business/hello-identity-verification).

1. For other devices, if on AD FS 2016, you can use [Microsoft Entra multifactor authentication OTP](../../ad-fs/operations/configure-ad-fs-and-azure-mfa.md) as the first factor and password as the 2nd factor.

1. For mobile devices, if you only allow MDM managed devices, you can use [Certificates](../../ad-fs/operations/configure-user-certificate-authentication.md) to log the user in.

## Urgent handling

If the AD FS environment is under active attack, the following steps should be implemented at the earliest:

- Disable username and password endpoints in AD FS and require everyone to use a VPN to get access or be inside your network. This requires you to have step **Level 2 #1a** completed. Otherwise, all internal Outlook requests will still be routed via the cloud via EXO proxy auth.
- If the attack is only coming via EXO, you can disable basic authentication for Exchange protocols (POP, IMAP, SMTP, EWS, etc.) using Authentication Policies, these protocols and authentication methods are being used on the majority of these attacks. Additionally, Client Access Rules in EXO and per-mailbox protocol enablement are evaluated post-authentication and won't help on mitigating the attacks.
- Selectively offer extranet access using **Level 3 #1-3**.

## Next steps

- [Upgrade to AD FS server 2016](../../ad-fs/deployment/upgrading-to-ad-fs-in-windows-server.md)
- [Extranet smart lockout in AD FS 2016](../../ad-fs/operations/Configure-AD-FS-Extranet-Smart-Lockout-Protection.md)
- [Configure conditional access policies](/azure/active-directory/conditional-access/overview)
- [Microsoft Entra password protection](/azure/active-directory/authentication/howto-password-ban-bad-on-premises)
