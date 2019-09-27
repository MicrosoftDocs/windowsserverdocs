---
title: AD FS Password Attack protection
description:  This document describes how to protect AD FS users from password attacks
author: billmath
manager: mtillman
ms.reviewer: andandyMSFT
ms.date: 11/15/2018
ms.topic: article
ms.prod: windows-server
ms.technology: identity-adfs
ms.author: billmath
---



# AD FS Password Attack protection

## What is a password attack?

A requirement for federated single sign-on is the availability of endpoints to authenticate over the internet. The availability of authentication endpoints on the internet enables users to access the applications even when they are not on a corporate network. 

However, this also means that some bad actors can take advantage of the federated endpoints available on the internet and use these endpoints to try and determine passwords or to create denial of service attacks. One such attack that is becoming more common is called a **password attack**. 

There are 2 types of common password attacks. Password spray attack & brute force password attack. 

### Password Spray Attack
In a password spray attack, these bad actors will try the most common passwords across many different accounts and services to gain access to any password protected assets they can find. Usually these span many different organizations and identity providers. For example, an attacker will use a commonly available toolkit to enumerate all of the users in several organizations and then try “P@$$w0rd” and “Password1” against all of those accounts. To give you the idea, an attack might look like:


|  Target User   | Target Password |
|----------------|-----------------|
| User1@org1.com |    Password1    |
| User2@org1.com |    Password1    |
| User1@org2.com |    Password1    |
| User2@org2.com |    Password1    |
|       …        |        …        |
| User1@org1.com |    P@$$w0rd     |
| User2@org1.com |    P@$$w0rd     |
| User1@org2.com |    P@$$w0rd     |
| User2@org2.com |    P@$$w0rd     |

This attack pattern evades most detection techniques because from the vantage point of an individual user or company, the attack just looks like an isolated failed login.

For attackers, it's a numbers game: they know that there are some passwords out there that are very common.  The attacker will get a few successes for every thousand accounts attacked, and that's enough to be effective. They use the accounts to get data from emails, harvest contact info, and send phishing links or just expand the password spray target group. The attackers don't care much about who those initial targets are—just that they have some success that they can leverage.

But by taking a few steps to configure the AD FS and network correctly, AD FS endpoints can be secured against these type of attacks. This article covers 3 areas that need to be configured properly to help secure against these attacks.

### Brute Force Password Attack 
In this form of attack, an attacker will attempt multiple password attempts against a targeted set of accounts. In many cases these accounts will be targeted against users that have a higher level of access within the organization. These could be executives within the organization or admins who manage critical infrastructure.  

This type of attack could also result in DOS patterns. This could be at the service level where ADFS is unable to process a large # of requests due to insufficient # of servers or could be at a user level where a user is locked out of their account.  

## Securing AD FS against password attacks 

But by taking a few steps to configure the AD FS and network correctly, AD FS endpoints can be secured against these types of attacks. This article covers 3 areas that need to be configured properly to help secure against these attacks. 


- Level 1, Baseline: These are the basic settings that must be configured on an AD FS server to ensure that bad actors cannot brute force attack federated users. 
- Level 2, Protecting the extranet: These are the settings that must be configured to ensure the extranet access is configured to use secure protocols, authentication policies and appropriate applications. 
- Level 3, Move to password-less for extranet access: These are advanced settings and guidelines to enable access to federated resources with more secure credentials rather than passwords which are prone to attack. 

## Level 1: Baseline

1. If ADFS 2016, implement [extranet smart lockout](../../ad-fs/operations/Configure-AD-FS-Extranet-Smart-Lockout-Protection.md) Extranet smart lockout tracks familiar locations and will allow a valid user to come through if they have previously logged in successfully from that location. By using extranet smart lockout, you can ensure that bad actors will not be able to brute force attack the users and at the same time will let legitimate user be productive.
    - If you are not on AD FS 2016, we strongly recommend you [upgrade](../../ad-fs/deployment/upgrading-to-ad-fs-in-windows-server.md) to AD FS 2016. It is a simple upgrade path from AD FS 2012 R2. If you are on AD FS 2012 R2, implement [extranet lockout](../../ad-fs/operations/Configure-AD-FS-Extranet-Soft-Lockout-Protection.md). One disadvantage of this approach is that valid users may be blocked from extranet access if you are in a brute force pattern. AD FS on Server 2016 does not have this disadvantage.

2. Monitor & Block suspicious IP addresses 
    - If you have Azure AD Premium, implement Connect Health for ADFS and use the [Risky IP report](https://docs.microsoft.com/azure/active-directory/connect-health/active-directory-aadconnect-health-adfs#risky-ip-report-public-preview) notifications that it provides.

        a. Licensing is not for all users and requires 25 licenses/ADFS/WAP server which may be easy for a customer.

        b. You can now investigate IP's that are generating large # of failed logins

        c. This will require you to enable auditing on your ADFS servers.

3.  Block suspicious IP's.  This potentially blocks DOS attacks.

    a. If on 2016, use the [*Extranet Banned IP addresses*](../../ad-fs/operations/configure-ad-fs-banned-ip.md) feature to block any requests from IP's flagged by #3 (or manual analysis).

    b. If you are on AD FS 2012 R2 or lower, block the IP address directly at Exchange Online and optionally on your firewall.

4. If you have Azure AD Premium, use [Azure AD Password Protection](https://docs.microsoft.com/azure/active-directory/authentication/concept-password-ban-bad-on-premises) to prevent guessable passwords from getting into Azure AD  

    a. Note that if you have guessable passwords, you can crack them with just 1-3 attempts. This feature prevents these from getting set. 

    b. From our preview stats, nearly 20-50% of new passwords get blocked from being set. This implies that % of users are vulnerable to easily guessed passwords.

## Level 2: Protect your extranet

5. Move to modern authentication for any clients accessing from the extranet. Mail clients are a big part of this. 

    a. You will need to use Outlook Mobile for mobile devices. The new iOS native mail app supports modern authentication as well. 

    b. You will need to use Outlook 2013 (with the latest CU patches) or Outlook 2016.

6. Enable MFA for all extranet access. This gives you added protection for any extranet access.

   a.  If you have Azure AD premium, use [Azure AD Conditional Access policies](https://docs.microsoft.com/azure/active-directory/conditional-access/overview) to control this.  This is better than implementing the rules at AD FS.  This is because modern client apps are enforced on a more frequent basis.  This occurs, at Azure AD, when requesting a new access token (typically every hour) using a refresh token.  

   b.  If you don't have Azure AD premium or have additional apps on AD FS that you allow internet based access, implement MFA (Can be Azure MFA as well on AD FS 2016) and do a [global MFA policy](../../ad-fs/operations/configure-authentication-policies.md#to-configure-multi-factor-authentication-globally) for all extranet access.

## Level 3: Move to password less for extranet access

7. Move to Window 10 and use [Hello For Business](https://docs.microsoft.com/windows/security/identity-protection/hello-for-business/hello-identity-verification).

8. For other devices, if on AD FS 2016, you can use [Azure MFA OTP](../../ad-fs/operations/configure-ad-fs-and-azure-mfa.md) as the first factor and password as the 2nd factor. 

9. For mobile devices, if you only allow MDM managed devices, you can use [Certificates](../../ad-fs/operations/configure-user-certificate-authentication.md) to log the user in. 

## Urgent Handling

If the AD FS environment is under active attack, the following steps should be implemented at the earliest:

 - Disable U/P endpoint in ADFS and require everyone to VPN to get access or be inside your network. This requires you to have step **Level 2 #1a** completed. Otherwise, all internal Outlook requests will still be routed via the cloud via EXO proxy auth.
 - If the attack is only coming via EXO, you can disable basic authentication for Exchange protocols (POP, IMAP, SMTP, EWS, etc) using Authentication Policies, these protocols and authentication methods are being used on the vast majority of these attacks. Additionally, Client Access Rules in EXO and per-mailbox protocol enablement are evaluated post-authentication and won't help on mitigating the attacks. 
 - Selectively offer extranet access using Level 3 #1-3.

## Next steps

- [Upgrade to AD FS server 2016](../../ad-fs/deployment/upgrading-to-ad-fs-in-windows-server.md) 
- [Extranet smart lockout in AD FS 2016](../../ad-fs/operations/Configure-AD-FS-Extranet-Smart-Lockout-Protection.md)
- [Configure conditional access policies](https://docs.microsoft.com/azure/active-directory/conditional-access/overview)
- [Azure AD password protection](https://docs.microsoft.com/azure/active-directory/authentication/howto-password-ban-bad-on-premises)
