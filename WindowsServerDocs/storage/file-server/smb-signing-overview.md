---
title: Overview of Server Message Block signing in Windows
description: Learn how to configure SMB signing, how to determine whether SMB signing is enabled, and how to disable SMB signing.
ms.date: 10/25/2024
author: robinharwood
ms.author: roharwoo
ms.topic: overview
#customer intent: As an IT administrator, I want to understand what SMB signing is so that I can better support my customers and design secure file storage solutions.
---

# What is Server Message Block signing?

This article describes Server Message Block (SMB) 2.x and 3.x signing in Windows and Windows Server. The article also describes SMB signing security considerations and policy settings.

SMB signing means that every SMB message contains a signature generated using a session key and AES. SMB signing adds a signature containing a hash of the entire message in the SMB header. If someone tampers with the message in transit, the data in the tampered message doesn't match the hash in the signature. The hash also includes the identities of the original sender and the intended recipient. Signature mismatches alert users to possible foul play, helping them protect their deployments from relay and spoofing attacks.

## How signing works

SMB signing is a security feature that uses the session key and cipher suite to add a signature to a message going across a connection. SMB2 message integrity manifests on a signed session where signed packets flow from client to server. On a signed session, every signed packet includes a signature that the receiver can validate. Unlike SMB1 signing that uses the MD5 [RFC1321] hashing algorithm, SMB2 uses a better hashing for signing. The security model in MS-SMB2 relies upon authenticating the client-user identity before accessing a share on the server. After the user is authenticated, the server can mandate message signing or encryption. The server also controls access to the share based on which users, groups, or claims are authorized to have various levels of access.

Signing algorithms have evolved over time, with SMB 2.02 signing was improved with HMAC-SHA-256, replacing the old MD5 method that was in SMB1. Additionally, SMB 3.0 introduced AES-CMAC. Windows Server 2022 and Windows 11 introduced AES-128-GMAC signing acceleration. To learn more about the AES-128-GMAC signing, see [AES-128-GMAC signing acceleration](smb-security.md#new-signing-algorithm).

SMB signing is enabled in all versions of Windows. SMB signing requirements can involve both outbound signing, which covers traffic from the SMB client, and inbound signing, which covers traffic to the server. Windows and Windows Server can require outbound signing only, inbound signing only, both, or neither. If your environment uses non-Microsoft file servers, your system settings can prevent the default settings and connections from taking effect. In this case, you might need to disable the requirement for SMB signing. See [Control SMB signing behavior](smb-signing.md) for guidance on how to disable SMB signing.

### Security considerations in SMB2 and SMB3

All cryptographic keys used in SMB 2.x and 3.x signing are derived from the session key. The security of SMB 2/3 signing and encryption relies on the session key. If someone changes a message during transmission, the hash doesn't match, and SMB knows that someone tampered with the data. The signature also confirms the sender's and receiver's identities, and prevents relay attacks.

When using SMB signing, you should consider:

- Because the session key itself is derived from your password, using a long, complex, nondictionary password enhances SMB signing and encryption.
- Using Kerberos instead of NTLMv2 is recommended so that your session key starts strong.
- Don't connect to shares by using IP addresses or CNAME records, otherwise NTLM is used instead of Kerberos. We recommend using Kerberos. To learn more about alternatives to using CNAME records, see [Using Computer Name Aliases in place of DNS CNAME Records](https://techcommunity.microsoft.com/t5/core-infrastructure-and-security/using-computer-name-aliases-in-place-of-dns-cname-records/ba-p/259064).

By default, domain controllers require SMB signing of anyone connecting to them, typically for SYSVOL and NETLOGON to get group policy and logon scripts. UNC Hardening from the client also requires signing when talking to those same two shares and goes further by requiring Kerberos. SMB signing is also automatically used as part of pre-authentication integrity to prevent downgrade attacks. For more information, see [SMB 3.1.1 Pre-authentication integrity in Windows 10](/archive/blogs/openspecification/smb-3-1-1-pre-authentication-integrity-in-windows-10?WT.mc_id=ITOPSTALK-blog-abartolo).

## Policy locations for SMB signing

The policies for SMB signing are located in **Computer Configuration** > **Windows Settings** > **Security Settings** > **Local Policies** > **Security Options**.

- **Microsoft network client: Digitally sign communications (always)**  
  Registry key: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanManWorkstation\Parameters`  
  Registry value: **RequireSecuritySignature**  
  Data Type: `REG_DWORD`  
  Data: 0 (disable), 1 (enable)
  
- **Microsoft network server: Digitally sign communications (always)**  
  Registry key: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters`  
  Registry value: **RequireSecuritySignature**  
  Data Type: `REG_DWORD`
  Data: 0 (disable), 1 (enable)
  
>[!Note]
>In these policies *always* indicates that SMB signing is required.

### Understanding "RequireSecuritySignature" and "EnableSecuritySignature"

The **EnableSecuritySignature** registry setting for SMB2 and later clients and servers is ignored. Therefore, this setting does nothing unless you're using SMB1. SMB 2.02 and later signing is controlled solely by being required or not. This setting is used when either the server or client requires SMB signing. Signing doesn't occur only when both the server and client have signing set to **0**.

In summary SMB is signed when:

- Both the SMB client and server have **RequireSecuritySignature** set to **1**.
- The SMB client has **RequireSecuritySignature** set to **1** and the server has **RequireSecuritySignature** set to **0**.
- The SMB server has **RequireSecuritySignature** set to **1** and the client has **RequireSecuritySignature** set to **0**.

Signing isn't used when:

- The SMB client and server have **RequireSecuritySignature** set to **0**.

## SMB signing and encryption auditing

Starting with Windows 11, version 24H2, administrators can enable auditing for the SMB client to detect third-party clients or servers that don't support SMB encryption or signing. If a third-party device or software claims to support SMB 3.1.1, but doesn't support SMB signing, it violates the [SMB 3.1.1 pre-authentication integrity](/archive/blogs/openspecification/smb-3-1-1-pre-authentication-integrity-in-windows-10) protocol requirement.

Adjusting the SMB signing and encryption auditing settings can be modified in Group Policy or through PowerShell. These settings for Group Policy are stored in the paths:

- `Computer Configuration\Administrative Templates\Network\Lanman Server\Audit client does not support encryption`

- `Computer Configuration\Administrative Templates\Network\Lanman Server\Audit client does not support signing`

- `Computer Configuration\Administrative Templates\Network\Lanman Workstation\Audit server does not support encryption`

- `Computer Configuration\Administrative Templates\Network\Lanman Workstation\Audit server does not support signing`

For PowerShell, running the following commands enables auditing the same settings:

```powershell
Set-SmbServerConfiguration -AuditClientDoesNotSupportEncryption $true
Set-SmbServerConfiguration -AuditClientDoesNotSupportSigning $true

Set-SmbClientConfiguration -AuditServerDoesNotSupportEncryption $true
Set-SmbClientConfiguration -AuditServerDoesNotSupportSigning $true
```

The Event Viewer captures these events under the following paths with their respective Event IDs:

|Path|Event ID|
|-|-|
|Applications and Services Logs\Microsoft\Windows\SMBClient\Audit|31998 <br> 31999|
|Applications and Services Logs\Microsoft\Windows\SMBServer\Audit|3021 <br> 3022|

## Related content

The following articles provide additional information about SMB:

- [Control SMB signing behavior](smb-signing.md)

- [Overview of File Sharing using the SMB 3 protocol in Windows Server](file-server-smb-overview.md)

- [SMB security enhancements](smb-security.md)

- [Configure SMB Signing with Confidence](https://techcommunity.microsoft.com/t5/storage-at-microsoft/configure-smb-signing-with-confidence/ba-p/2418102)
