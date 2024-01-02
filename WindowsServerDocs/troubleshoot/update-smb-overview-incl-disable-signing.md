---
title: Overview of Server Message Block signing
description: Learn how to configure SMB signing, how to determine whether SMB signing is enabled, and how to disable SMB signing.
ms.date: 01/19/2024
author: Deland-Han
ms.author: delhan
ms.topic: troubleshooting
---
# Overview of Server Message Block signing

This article describes Server Message Block (SMB) 2.x and 3.x signing, and how to determine whether SMB signing is required.

## Introduction

SMB signing is a security feature that uses the session key and cipher suite to add a signature to a message going across a connection. This signature contains a hash of the entire message in the SMB header. If someone tampers with the message in transit, the data in the tampered message won't match the hash in the signature. The hash also includes the identities of the original sender and the intended recipient. Signature mismatches alert users to possible foul play, helping them protect their deployments from relay and spoofing attacks.

SMB signing first appeared in Microsoft Windows 2000, Microsoft Windows NT 4.0, and Microsoft Windows 98. Signing algorithms have evolved over time. SMB 2.02 signing was improved by the introduction of hash-based message authentication code (HMAC) SHA-256, replacing the old MD5 method from the late 1990s that was used in SMB1. SMB 3.0 added AES-CMAC algorithms. In Windows Server 2022 and Windows 11 introduced added [AES-128-GMAC signing acceleration](/windows-server/storage/file-server/smb-security#new-signing-algorithm). If you want the best performance and protection combination, consider upgrading to the latest Windows versions.

## Prerequisites

In order to use SMB signing and maximize its capabilities, you need the following things:

- Windows 11 Insider Preview Build or later.

- A functioning deployment of Windows Server.

You should also follow these recommendations to ensure your SMB signatures are effective at securing your data:

- Use Kerberos instead of NTLMv2.

- Don't connect to shares using IP addresses.

- Don't use CNAME records.

## How SMB signing protects the connection

If someone changes a message during transmission, the hash won't match, and SMB will know that someone tampered with the data. The signature also confirms the sender's and receiver's identities. This prevents relay attacks. Ideally, you are using Kerberos instead of NTLMv2 so that your session key starts strong. Don't connect to shares by using IP addresses and don't use CNAME records, or you will use NTLM instead of Kerberos. Use Kerberos instead. See [Using Computer Name Aliases in place of DNS CNAME Records](https://techcommunity.microsoft.com/t5/core-infrastructure-and-security/using-computer-name-aliases-in-place-of-dns-cname-records/ba-p/259064) for more information.

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

SMB signing is enabled by default on the latest versions of Windows 11 and Windows Server 2022. All Windows environments support SMB signing. However, if your environment uses third-party servers, your system settings may prevent the default settings from taking effect.

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

- [SMB over QUIC](smb-over-quic.md)

- [SMB security enhancements](smb-security.md

- [Configure SMB Signing with Confidence](https://techcommunity.microsoft.com/t5/storage-at-microsoft/configure-smb-signing-with-confidence/ba-p/2418102)

- [How to Defend Users from Interception Attacks via SMB Client Defense](https://techcommunity.microsoft.com/t5/itops-talk-blog/how-to-defend-users-from-interception-attacks-via-smb-client/ba-p/1494995)

- [SMB 2 and SMB 3 security in Windows 10: the anatomy of signing and cryptographic keys](/archive/blogs/openspecification/smb-2-and-smb-3-security-in-windows-10-the-anatomy-of-signing-and-cryptographic-keys)

- [SMBv1 is not installed by default in Windows 10 version 1709, Windows Server version 1709 and later versions](/windows-server/storage/file-server/troubleshoot/smbv1-not-installed-by-default-in-windows)

- [Netdom computername](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc835082(v=ws.11))