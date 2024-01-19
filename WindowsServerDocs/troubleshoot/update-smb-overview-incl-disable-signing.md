---
title: Overview of Server Message Block signing
description: Learn how to configure SMB signing, how to determine whether SMB signing is enabled, and how to disable SMB signing.
ms.date: 01/31/2024
author: Deland-Han
ms.author: delhan
ms.topic: troubleshooting
---
# Overview of Server Message Block signing

This article describes Server Message Block (SMB) 2.x and 3.x signing in Windows and Windows Server, including how to determine whether SMB signing is required and enabled.

## Introduction

SMB signing is a security feature that uses the session key and cipher suite to add a signature to a message going across a connection. This signature contains a hash of the entire message in the SMB header. If someone tampers with the message in transit, the data in the tampered message won't match the hash in the signature. The hash also includes the identities of the original sender and the intended recipient. Signature mismatches alert users to possible foul play, helping them protect their deployments from relay and spoofing attacks.

SMB signing requirements can involve both outbound signing, which covers traffic from the SMB client, and inbound signing, which covers traffic to the server. Windows and Windows Server can require outbound signing only, inbound signing only, both, or neither.

SMB signing first appeared (SMB1) in Microsoft Windows 2000, Microsoft Windows NT 4.0, and Microsoft Windows 98. SMB2 message integrity manifests on a signed session where signed packets flow from client to server. On a signed session, every signed packet includes a signature that the receiver can validate. Unlike SMB1 signing which uses MD5 [RFC1321] as hashing algorithm, SMB2 uses a better hashing for signing. SMB 2.02 and SMB 2.1 use HMAC SHA-256. The security model in MS-SMB2 relies upon authenticating the client-user identity before accessing a share on the server. After the user is authenticated, the server can mandate message signing or encryption. The server also controls access to the share based on which users, groups, or claims are authorized to have various levels of access.

Windows Server 2022 and Windows 11 introduced AES-128-GMAC signing acceleration. See [AES-128-GMAC signing acceleration](/windows-server/storage/file-server/smb-security#new-signing-algorithm) for detailed guidance.

SMB signing is enabled in all versions of Windows. SMB signing requirements can involve both outbound signing, which covers traffic from the SMB client, and inbound signing, which covers traffic to the server. Windows and Windows Server can require outbound signing only, inbound signing only, both, or neither. If your environment uses third-party servers, your system settings can prevent the default settings and conncections from taking effect. In this case, you'll want to disable SMB signing. See [Control SMB signing behavior]() for guidance on how to disable SMB signing.
 
### Security considerations in SMB2 and SMB3

All cryptographic keys used in SMB 2.x and 3.x signing are derived from the session key. The security of SMB 2/3 signing and encryption relies on the session key. Because the session key itself is derived from your password, using a long, complex, non-dictionary password enhances SMB signing and encryption.

See the tutorial [SMB 2 and SMB 3 security in Windows 10: the anatomy of signing and cryptographic keys]() for detailed information on SMB2 and SMB3 security features.

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

### WHen is a message signed?

The SMB2+ client and server negotiate signing by using the SecurityMode field in the SMB2 Negotiate request and response exchange. The client also communicates the SecurityMode in the SessionSetup Request.

`SMB2_NEGOTIATE_SIGNING_ENABLED (0x0001)`
`SMB2_NEGOTIATE_SIGNING_REQUIRED (0x0002)`

Windows SMB 2/3 clients always set SMB2_NEGOTIATE_SIGNING_ENABLED flag in the negotiate request and Windows-based servers set it likewise in the response because all entities support signing.

MS-SMB2 requires all SMB 2/3 servers to implement signing, regardless of whether they set the SMB2_NEGOTIATE_SIGNING_ENABLED flag.

#### Signing configuration

By default, Windows client and server have the following settings:

Get-SmbClientConfiguration  | fl EnableSecuritySignature,RequireSecuritySignature
EnableSecuritySignature  : True
RequireSecuritySignature : False

The corresponding registry keys on the client are under HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters

Get-SmbServerConfiguration | fl EnableSecuritySignature,RequireSecuritySignature
EnableSecuritySignature  : False
RequireSecuritySignature : False

The corresponding registry keys on the server are under HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters

See [Basics of SMB Signing](https://blogs.technet.microsoft.com/josebda/2010/12/01/the-basics-of-smb-signing-covering-both-smb1-and-smb2) for more information on signing configuration and behavior.

#### Requiring signing

A session will have Session.SigningRequired = TRUE if one the following conditions is met:

- Signing is required by negotiation.
- The server configuration requires message signing.
- The SessionSetup requires signing.

> [!NOTE]
> Guest (anonymous) sessions can't have signing required. Guest sessions don't have proper security context for SMB signing.

## Related content

- [Overview of File Sharing using the SMB 3 protocol in Windows Server](file-server-smb-overview.md)

- [SMB over QUIC](smb-over-quic.md)

- [SMB security enhancements](smb-security.md

- [Configure SMB Signing with Confidence](https://techcommunity.microsoft.com/t5/storage-at-microsoft/configure-smb-signing-with-confidence/ba-p/2418102)

- [SMBv1 is not installed by default in Windows 10 version 1709, Windows Server version 1709 and later versions](/windows-server/storage/file-server/troubleshoot/smbv1-not-installed-by-default-in-windows)

- [Netdom computername](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc835082(v=ws.11))