---
title: Protect SMB traffic from interception
description: How to configure Windows Server to harden SMB protocol to defend against interception attacks.
ms.topic: conceptual
author: robinharwood
ms.author: roharwoo
ms.date: 12/12/2022
# Customer Intent: As a system or security administrator, I want to prevent SMB interception
# attacks, so that I can mitigate security risks within my environment
---

# Protect SMB traffic from interception

In this article, you'll learn about some of the ways an attacker might use interception techniques
against the SMB protocol and how you might mitigate an attack. The concepts will support you with
developing your own defense-in-depth strategy for the SMB protocol.

## What is an interception attack?

An adversary-in-the-middle (AITM) attack intends to modify the network communication between a
client and server, allowing a threat actor to intercept traffic. After interception, a malicious
actor may have the ability to spoof, tamper, disclose, or deny access to your organizations data or
account credentials.

Many organizations rely on SMB to share files between users and to support other applications or
technologies like Active Directory Domain Services. With such broad adoption, SMB is both a popular
target for attackers and has the potential for business-wide impact.

For example, an AITM attack might be used for industrial or state-level espionage, extortion, or
finding sensitive security data stored in files. It could also be used as part of a wider attack to
enable the attacker to move laterally within your network or to target multiple endpoints.

Attacks are constantly evolving, with attackers often using a combination of established and new
techniques. When protecting your system against SMB interception, there are two main goals:

- Reduce the number of attack methods available.
- Secure the pathways you present to your users.

Due to the diversity of technology and clients within many organizations, a well-rounded defense
will combine multiple methods and will follow the Zero Trust principles. Learn more about
Zero Trust in the [What is Zero Trust?](/security/zero-trust/zero-trust-overview) article.

Now you'll learn about some of the typical good practice configurations to reduce the risk of SMB
interception.

## Reducing the attack methods available

To protect your system against SMB interception attacks, your first step should be to reduce the
attack surface. Attack surfaces are places where your system is vulnerable to cyberthreats and
compromise.

In the following sections, we'll discuss some of the basic steps you should take to reduce the
attack surface.

### Install updates

Regularly install all available security updates on both your Windows Server and client systems as
close to their release as your organization allows. Installing the latest security updates is the
quickest and easiest way to protect your systems from the current known security vulnerabilities
affecting not just SMB, but all Microsoft products and services.

You can install security updates using a few different methods depending on your organizations
requirements. Typical methods are:

- [Azure Update Management](/azure/automation/update-management/overview)
- [Windows Update](https://support.microsoft.com/windows/get-the-latest-windows-update-7d20e88c-0568-483a-37bc-c3885390d212#WindowsVersion=Windows_11)
- [Windows Server Update Services (WSUS)](../../administration/windows-server-update-services/get-started/windows-server-update-services-wsus.md)
- [Software updates in Endpoint Configuration Manager](/mem/configmgr/sum/understand/software-updates-introduction)

Consider subscribing to notifications in the
[Microsoft Security Response Center (MSRC) Security Update Guide](https://msrc.microsoft.com/update-guide/).
The _Security Update Guide Notification System_ will let you know when software updates are
published to address new and existing Common Vulnerabilities and Exposures (CVEs).

### Remove SMB 1.0

You should remove or disable the SMB 1.0 feature from all Windows Servers and clients that don't
require it. For systems that do require SMB 1.0, you should move to SMB 2.0 or higher as soon as
possible. Starting in the Windows 10 Fall Creators Update and Windows Server 2019, [SMB 1.0 is no
longer installed by default](Troubleshoot/smbv1-not-installed-by-default-in-windows.md).

> [!TIP]
> Windows 10 Home and Windows 10 Pro still contain the SMB 1.0 client by default after a clean
> installation or in-place upgrade. This behavior is changing in Windows 11, you can read more in
> the article
> [SMB1 now disabled by default for Windows 11 Home Insiders builds](https://techcommunity.microsoft.com/t5/storage-at-microsoft/smb1-now-disabled-by-default-for-windows-11-home-insiders-builds/ba-p/3289473).

Removing SMB 1.0 protects your systems by eliminating several well known security vulnerabilities.
SMB 1.0 lacks the security features of SMB 2.0 and later that help protect against interception. For
example, to prevent a compromised connection SMB 3.0 or later uses pre-authentication integrity,
encryption, and signing. Learn more in the [SMB security enhancements](smb-security.md) article.

Before removing the SMB 1.0 feature, be sure no applications and processes on the computer require
it. For more information on how to detect and disable SMB 1.0, see the article
[How to detect, enable and disable SMBv1, SMBv2, and SMBv3 in Windows](Troubleshoot/detect-enable-and-disable-smbv1-v2-v3.md#how-to-detect-status-enable-and-disable-smb-protocols).

You can also use the Windows Admin Center
[Files and file sharing tool](../../manage/windows-admin-center/use/manage-servers.md) to both
quickly enable the auditing of SMB1 client connections and to uninstall SMB 1.  

### Disable guest authentication and fallback

In SMB 1.0 when a user's credentials fail, the SMB client will try guest access. Starting in Windows
10, version 1709, and Windows Server 2019, SMB2 and SMB3 clients no longer allow guest account
access or fallback to the guest account by default. You should use SMB 2.0 or higher and disable
the use of SMB guest access on any systems where guest access isn't disabled by default.

> [!TIP]
> Windows 11 Home and Pro editions are unchanged from their previous default behavior; they allow
> guest authentication by default.

When guest access is disabled, it prevents a malicious actor from creating a server and tricking users
into accessing it using guest access. For example, when a user accesses the spoofed share, their
credentials would fail and SMB 1.0 would fall back to using guest access. Disabling guest access
stops the SMB session from connecting, preventing the user from accessing the share and any
malicious files.

To prevent the use of guest fallback on Windows SMB clients where guest access isn't disabled by
default (including Windows Server):

# [Group Policy](#tab/group-policy)

1. Open the **Group Policy Management Console**.
1. In the console tree, select **Computer Configuration > Administrative Templates > Network >
    Lanman Workstation**.
1. For the setting, right-click **Enable insecure guest logons** and select **Edit**.
1. Select **Enabled** and select **OK**.

# [PowerShell](#tab/powershell)

From an elevated PowerShell prompt, run the following commands:

```powershell
Set-SmbClientConfiguration -EnableInsecureGuestLogons $false -Confirm:$false 
```

---

To learn more about guest access default behavior, read the article
[Guest access in SMB2 and SMB3 disabled by default in Windows](/troubleshoot/windows-server/networking/guest-access-in-smb2-is-disabled-by-default).

### Disable the WebDAV protocol

Windows clients may not require the `WebClient` service to be running. The service
provides the Web Distributed Authoring and Versioning (WebDAV) protocol. If your clients aren't
accessing SMB shares over HTTP or HTTPS using WebDAV, you can disable the service.

When your users are accessing files using WebDAV, there's no method to force a TLS based connection
over HTTPS. For example, your server may be configured to require SMB signing or encryption, however
the Webclient could connect to HTTP/80 if WebDAV has been enabled. Any resulting connection would be
unencrypted, regardless of your SMB configuration.

You can use Group Policy Preferences to disable the service on a large number of machines when
you're ready to implement. For more information about configuring Group Policy Preferences, see
[Configure a Service Item](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc732482(v=ws.10)).

### Restrict outbound SMB destinations

Block outbound SMB traffic to devices outside your network as a minimum. Blocking outbound SMB
prevents data being sent to external endpoints. Malicious actors often try spoofing, tampering or
phishing attacks that attempt to send users to malicious endpoints disguised as friendly links or
shortcuts within emails or other files. To learn more about blocking outbound SMB access, read the
[Secure SMB Traffic in Windows Server](smb-secure-traffic.md#block-outbound-smb-access) article.

Take this principle further by introducing micro-perimeters and micro-segmentation into your
architecture. Blocking outbound SMB traffic to external networks helps to prevent the direct
exfiltration of data to internet, however modern attacks use advanced techniques to indirectly gain
access by attacking other systems, then moving laterally within your network. Micro-perimeters and
micro-segmentation aim to reduce the number of systems and users being able to directly connect to
your SMB share unless that explicitly need to. Learn more about
[Network segmentation](/security/zero-trust/deploy/networks) as part of our
[Zero Trust Guidance](/security/zero-trust/).

## Secure the protocol

Your second goal is to secure the pathways between your users and their data, known as
data-in-transit protection. Data-in-transit protection typically involves the use of encryption,
interface hardening, and removing insecure protocols to improve your resistance to attack.

In the following sections, we'll discuss some of the basic steps you should take to secure the SMB
protocol.

### Use SMB 3.1.1

Windows always negotiates to the highest available protocol, ensure your devices and machines
support SMB 3.1.1.

SMB 3.1.1 is available beginning with Windows 10 and Windows Server 2016. SMB 3.1.1 includes a new
mandatory security feature called _pre-authentication integrity_. Pre-authentication integrity signs
or encrypts the early phases of SMB connections to prevent the tampering of Negotiate and Session
Setup messages by using cryptographic hashing.

Cryptographic hashing means the client and server can mutually trust the connection and session
properties. Pre-authentication integrity supersedes _secure dialect negotiation_ introduced in SMB
3.0. You can’t turn off pre-authentication integrity, but if a client uses an older dialect, it
won’t be used.

You can enhance your security posture further by forcing the use of SMB 3.1.1 as a minimum. To set
the minimum SMB dialect to 3.1.1, from an elevated PowerShell prompt, run the following commands:

```powershell
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" -Name "MinSMB2Dialect" -Value 0x000000311
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" -Name "MaxSMB2Dialect" -Value 0x000000311
```

To learn more about how to set the minimum SMB dialect used, see
[Controlling SMB dialects](https://techcommunity.microsoft.com/t5/storage-at-microsoft/controlling-smb-dialects/ba-p/860024?WT.mc_id=ITOPSTALK-blog-abartolo).

### Use UNC hardening to require signing, encryption, and mutual authentication

Enable UNC hardening for all SMB shares by requiring at least mutual authentication (Kerberos) and
integrity (SMB signing). You should also consider evaluating privacy (SMB encryption) instead of SMB
signing. There's no need to configure both SMB signing and encryption because encryption implicitly
includes the signatures used by signing.

> [!CAUTION]
> SMB encryption was introduced with SMB 3 in Windows 8 and Windows Server 2012. You shouldn't
> require encryption unless all your machines support SMB 3.0 or later, or are third parties with
> SMB 3 and encryption support. If you configure SMB encryption on clients or UNC paths hosted by
> servers that do not support SMB Encryption, the SMB client will be unable to access the specified
> path. Also, if you configure your server for SMB encryption and it is accessed by clients that
> don't support it, those clients will again be unable to access the path.

UNC Hardening gives the ability to check UNC paths for mandated security settings and will refuse to
connect if a server couldn't meet them. Beginning with Windows Server 2016 and Windows 10, UNC
Hardening is enabled by default for SYSVOL and NETLOGON shares on domain controllers. It's a highly
effective tool against spoofing and tampering because the client can authenticate the identity of
the server and validate the integrity of the SMB payloads.

When configuring UNC hardening, you can specify various UNC path patterns. For example:

- `\\<Server>\<Share>` - The configuration entry applies to the share that has the specified name on
  the specified server.
- `\\*\<Share>` - The configuration entry applies to the share that has the specified name on any server.
- `\\<Server>\*` - The configuration entry applies to any share on the specified server.

You can use Group Policy to apply the UNC hardening feature to a large number of machines when
you're ready to implement it. For more information about configuring UNC hardening through
Group Policy, see the security bulletin
[MS15-011](https://support.microsoft.com/topic/ms15-011-vulnerability-in-group-policy-could-allow-remote-code-execution-february-10-2015-91b4bda2-945d-455b-ebbb-01d1ec191328).

### Map drives on demand with mandated signing or encryption

In addition to UNC hardening, you can use signing or encryption when mapping network drives.
Beginning in Windows version 1709 and later, you can create encrypted or signed mapped drives on
demand using Windows PowerShell or Command Prompt. You can use the `NET USE` command or the
PowerShell `New-SmbMapping` command to map drives by specifying **RequireIntegrity** (signing) or
**RequirePrivacy** (encryption) parameters.

The commands can be used by administrators or included in scripts to automate the mapping of drives
that require encryption or integrity checks.

The parameters don't change how signing or encryption work, or the dialect requirements. If you try
to map a drive and the server refuses to honor your requirement for signing or encryption, the drive
mapping will fail rather than connect unsafely.

Learn about the syntax and parameters for the `New-SmbMapping` command in
[New-SmbMapping](/powershell/module/smbshare/new-smbmapping) reference article.

### Beyond SMB

Stop using NTLM and increase your Kerberos security. You can start by enabling auditing for NTLM
usage, then reviewing the logs to find where NTLM is used.

Removing NTLM helps to protect you against common attacks like pass-the-hash, brute-force or rainbow
hash tables due to its use of older MD4/MD5 cryptography hash function. NTLM also isn't able to
verify the server identity, unlike more recent protocols like Kerberos, making it vulnerable to NTLM
relay attacks as well. Many of these common attacks are easily mitigated with Kerberos.

To learn how to audit NTLM as part of your effort to begin the transition to Kerberos, see the
[Assessing NTLM usage](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/jj865670(v%3dws.10)?WT.mc_id=ITOPSTALK-blog-abartolo)
article. You can also read learn about detecting insecure protocols using Azure Sentinel in the
[Azure Sentinel Insecure Protocols Workbook Implementation Guide](https://techcommunity.microsoft.com/t5/microsoft-sentinel-blog/azure-sentinel-insecure-protocols-workbook-implementation-guide/ba-p/1197564?WT.mc_id=ITOPSTALK-blog-abartolo)
blog article.

In parallel to removing NTLM, you should consider adding more layers of protection for offline
and ticket passing attacks. Use the following items as a guide when enhancing Kerberos security.

1. **Deploy Windows Hello for Business or smart cards** - Two-factor authentication with Windows
   Hello for Business adds an entire new layer of protection. Learn about
   [Windows Hello for Business](/windows/security/identity-protection/hello-for-business/hello-overview).
1. **Enforce long passwords and phrases** - We encourage using longer password lengths such as 15
   characters or more to reduce your resistance to brute force attacks. You should also avoid common
   words or phrases to make your password even stronger.
1. **Deploy Azure AD Password Protection for Active Directory Domain Services** - Use Azure AD
   Password Protect to block known weak passwords and terms that are specific to your organization.
   To learn more, review
   [Enforce on-premises Azure AD Password Protection for Active Directory Domain Services](/azure/active-directory/authentication/concept-password-ban-bad-on-premises).
1. **Use group Managed Service Accounts (gMSA)** - gMSA enabled services with their 127 random
   character construction, makes brute force and dictionary attacks to crack passwords incredibly
   time consuming. Read about what gMSAs are in the article
   [Group Managed Service Accounts Overview](../../security/group-managed-service-accounts/group-managed-service-accounts-overview.md).
1. **Kerberos Armoring, known as Flexible Authentication Secure Tunneling (FAST)** - FAST prevents
   [Kerberoasting](https://www.microsoft.com/security/blog/2020/08/27/stopping-active-directory-attacks-and-other-post-exploitation-behavior-with-amsi-and-machine-learning/) because the user’s pre-authentication data is protected and no longer subject to
   offline brute force or dictionary attacks. It also prevents downgrade attacks from spoofed KDCs,
   to learn more review
   [Kerberos Armoring](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831747(v=ws.11)).
1. **Use Windows Defender Credential Guard** - Credential Guard makes the local compromise of
   tickets harder by preventing ticket-granting and cached service tickets from being stolen. Learn
   more in the
   [How Windows Defender Credential Guard works](/windows/security/identity-protection/credential-guard/credential-guard-how-it-works)
   article.
1. **Consider requiring SCRIL: Smart Card Required for Interactive Logon** - When deploying SCRIL,
   AD changes the user's password to a random 128-bit set which users can no longer use to sign in
   interactively. SCRIL is typically only suitable for environments with
   specific security requirements. To learn more about passwordless strategies, review
   [Configuring user accounts to disallow password authentication](/windows/security/identity-protection/hello-for-business/passwordless-strategy).

## Next steps

Now you've learned about some of the security controls and mitigations to prevent SMB interception, you'll understand there’s no single step to prevent all interception attacks. The goal is to create a
thoughtful, holistic, and prioritized combination of risk mitigations spanning multiple technologies
through layered defenses.

You can continue to learn more about these concepts in the articles below.

- [Secure SMB traffic in Windows Server](smb-secure-traffic.md).
- [SMB security enhancements](smb-security.md)
- [SMB 3.1.1 Pre-authentication integrity in Windows 10](/archive/blogs/openspecification/smb-3-1-1-pre-authentication-integrity-in-windows-10?WT.mc_id=ITOPSTALK-blog-abartolo)
- [SMB 2 and SMB 3 security in Windows 10: the anatomy of signing and cryptographic keys](/archive/blogs/openspecification/smb-2-and-smb-3-security-in-windows-10-the-anatomy-of-signing-and-cryptographic-keys?WT.mc_id=ITOPSTALK-blog-abartolo)
- [Zero Trust Guidance Center](/security/zero-trust/)
