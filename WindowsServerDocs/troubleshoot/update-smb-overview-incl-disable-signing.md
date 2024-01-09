---
title: Overview of Server Message Block signing
description: Learn how to configure SMB signing, how to determine whether SMB signing is enabled, and how to disable SMB signing.
ms.date: 01/19/2024
author: Deland-Han
ms.author: delhan
ms.topic: troubleshooting
---
# Overview of Server Message Block signing

This article describes Server Message Block (SMB) 2.x and 3.x signing, how to determine whether SMB signing is required and enabled, and how to disable signing.

## Introduction

SMB signing is a security feature that uses the session key and cipher suite to add a signature to a message going across a connection. This signature contains a hash of the entire message in the SMB header. If someone tampers with the message in transit, the data in the tampered message won't match the hash in the signature. The hash also includes the identities of the original sender and the intended recipient. Signature mismatches alert users to possible foul play, helping them protect their deployments from relay and spoofing attacks.

SMB signing requirements can involve both outbound signing, which covers traffic from the SMB client, and inbound signing, which covers traffic to the server. Windows and Windows Server can require outbound signing only, inbound signing only, both, or neither. For example:

- Windows 11 Insiders Enterprise, Pro, and Education require both outbound and inbound SMB signing.

- Windows Server Vnext Insider requires outbound SMB signing only.

- Windows 11 Insider Home edition doesn't require outbound or inbound SMB signing.

SMB signing first appeared in Microsoft Windows 2000, Microsoft Windows NT 4.0, and Microsoft Windows 98. SMB2 message integrity manifests on a signed session where signed packets flow from client to server. On a signed session, every signed packet includes a signature that the receiver can validate. Unlike SMB1 signing which uses MD5 [RFC1321] as hashing algorithm, SMB2 uses a better hashing for signing. SMB 2.02 and SMB 2.1 use HMAC SHA-256. The security model in MS-SMB2 relies upon authenticating the client-user identity before accessing a share on the server. Once the user is authenticated, the server may mandate message signing or encryption. The server also controls access to the share based on which users, groups, or claims are authorized to have various levels of access. 

SMB 3.0 introduces end-to-end encryption built in the protocol with the addition of AES-CMAC algorithms. In SMB 3.1.1 (Windows 10), the encryption algorithm can be negotiated, and the cryptographic key computation is enhanced with pre-authentication integrity. SMB 3.1.1 pre-authentication integrity enhances protection against security-downgrade attacks by verifying the integrity of all messages preceding the session establishment. This mandatory feature protects against any tampering with Negotiate and Session Setup messages by leveraging cryptographic hashing SHA-51. See [SMB 3.1.1 Pre-authentication integrity in Windows 10](https://blogs.msdn.microsoft.com/openspecification/2015/08/11/smb-3-1-1-pre-authentication-integrity-in-windows-10/) for more information. Windows Server 2022 and Windows 11 introduced AES-128-GMAC signing acceleration. See [AES-128-GMAC signing acceleration](/windows-server/storage/file-server/smb-security#new-signing-algorithm) for detailed guidance.

### Security considerations in SMB2 and SMB3

All cryptographic keys used in SMB 2.x and 3.x are derived from the SessionKey. Therefore, the security of SMB 2/3 signing and encryption relies in part on the session key. This key must be unique, kept secret, and genuinely impossible to guess.

The server should choose an authentication mechanism that provides unique and randomly generated session keys to ensure the security of the signing key, encryption key, and decryption key.

Signing and cryptographic keys in SMB2 and SMB3 directly or indirectly support the following security features:

In SMB 2.0.2 and 2.1 dialects:

- Message integrity across an authenticated session.

In SMB 3.0 dialect:

- Message integrity (with a stronger algorithm) across an authenticated session.
- Encryption of traffic between client and server.
- Session binding to multiple connections (multichannel).
- Validation of negotiated information.

In SMB 3.1.1 dialect:

- All the above 3.0 dialect security features, except the validation of negotiated information.
- Negotiation of encryption and integrity algorithms.
- Protection of negotiation and session establishment.

See the tutorial [SMB 2 and SMB 3 security in Windows 10: the anatomy of signing and cryptographic keys]() for detailed information on SMB2 and SMB3 security features.

## Prerequisites

In order to use SMB signing and maximize its capabilities, you need the following things:

- Windows 11 Insider Preview Build or later.

- A functioning deployment of Windows Server.

You should also follow these recommendations to ensure your SMB signatures are effective at securing your data:

- Use Kerberos instead of NTLMv2.

- Don't connect to shares using IP addresses.

- Don't use CNAME records.

## How SMB signing protects the connection

If someone changes a message during transmission, the hash won't match, and SMB will know that someone tampered with the data. The signature also confirms the sender's and receiver's identities. This prevents relay attacks. Using Kerberos instead of NTLMv2 is recommended so that your session key starts strong. Don't connect to shares by using IP addresses and don't use CNAME records, or you'll use NTLM instead of Kerberos. Use Kerberos. See [Using Computer Name Aliases in place of DNS CNAME Records](https://techcommunity.microsoft.com/t5/core-infrastructure-and-security/using-computer-name-aliases-in-place-of-dns-cname-records/ba-p/259064) for more information.

## Policy locations for SMB signing

The policies for SMB signing are located in **Computer Configuration** > **Windows Settings** > **Security Settings** > **Local Policies** > **Security Options**.

- **Microsoft network client: Digitally sign communications (always)**  
  Registry key: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanManWorkstation\Parameters`  
  Registry value: **RequireSecuritySignature**  
  Data Type: REG_DWORD  
  Data: 0 (disable), 1 (enable)
- **Microsoft network client: Digitally sign communications (if server agrees)**  
  Registry key: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanManWorkstation\Parameters`  
  Registry value: **EnableSecuritySignature**  
  Data Type: REG_DWORD  
  Data: 0 (disable), 1 (enable)
- **Microsoft network server: Digitally sign communications (always)**  
  Registry key: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters`  
  Registry value: **RequireSecuritySignature**  
  Data Type: REG_DWORD  
  Data: 0 (disable), 1 (enable)
- **Microsoft network server: Digitally sign communications (if client agrees)**  
  Registry key: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters`  
  Registry value: **EnableSecuritySignature**  
  Data Type: REG_DWORD  
  Data: 0 (disable), 1 (enable)

**Note** In these policies, "always" indicates that SMB signing is required, and "if server agrees" or "if client agrees" indicates that SMB signing is enabled.

### Understanding "RequireSecuritySignature" and "EnableSecuritySignature"

The **EnableSecuritySignature** registry setting for SMB2+ client and SMB2+ server is ignored. Therefore, this setting does nothing unless you're using SMB1. SMB 2.02 and later signing is controlled solely by being required or not. This setting is used when either the server or client requires SMB signing. Only if both have signing set to **0** will signing not occur.

|-|Server – RequireSecuritySignature=1|Server – RequireSecuritySignature=0|
|---|---|---|
|Client – RequireSecuritySignature=1|Signed|Signed|
|Client – RequireSecuritySignature=0|Signed|Not signed|

## How to disable SMB signing

SMB signing is enabled by default on the latest versions of Windows 11 and Windows Server 2022. All Windows environments support SMB signing. However, if your environment uses third-party servers, your system settings can prevent the default settings from taking effect.

>[!IMPORTANT]
>We don't recommend using SMB1 as a workaround for third-party servers.

In some third-party servers, enabling SMB signing can cause compatibility issues that can prevent guest users from accessing their accounts. In these cases, you must disable SMB signing manually to restore access for guest accounts.

To disable SMB signing manually on third-party servers:

1. Open an elevated PowerShell window as an administrator.

1. Run the following command to check the SMB signing settings for your server.

   ```powershell
   Get-SmbServerConfiguration | FL requiresecuritysignature
   ```

1. To disable SMB signing for outbound connections, run this command:

   ```powershell
   Set-SmbClientConfiguration -RequireSecuritySignature $false
   ```

1. To disable SMB signing for inbound connections, run this command:

   ```powershell
   Set-SmbServerConfiguration -RequireSecuritySignature $false
   ```

## Related content

- [Overview of File Sharing using the SMB 3 protocol in Windows Server](file-server-smb-overview.md)

- [SMB 2 and SMB 3 security in Windows 10: the anatomy of signing and cryptographic keys](https://learn.microsoft.com/en-us/archive/blogs/openspecification/smb-2-and-smb-3-security-in-windows-10-the-anatomy-of-signing-and-cryptographic-keys?WT.mc_id=ITOPSTALK-blog-abartolo)

- [SMB over QUIC](smb-over-quic.md)

- [SMB security enhancements](smb-security.md

- [Configure SMB Signing with Confidence](https://techcommunity.microsoft.com/t5/storage-at-microsoft/configure-smb-signing-with-confidence/ba-p/2418102)

- [How to Defend Users from Interception Attacks via SMB Client Defense](https://techcommunity.microsoft.com/t5/itops-talk-blog/how-to-defend-users-from-interception-attacks-via-smb-client/ba-p/1494995)

- [SMB 2 and SMB 3 security in Windows 10: the anatomy of signing and cryptographic keys](/archive/blogs/openspecification/smb-2-and-smb-3-security-in-windows-10-the-anatomy-of-signing-and-cryptographic-keys)

- [SMBv1 is not installed by default in Windows 10 version 1709, Windows Server version 1709 and later versions](/windows-server/storage/file-server/troubleshoot/smbv1-not-installed-by-default-in-windows)

- [Netdom computername](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc835082(v=ws.11))