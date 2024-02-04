---
title: Control SMB signing behavior (preview)
description: How to disable SMB signing on third-party servers in Windows 11 and Windows Server.
ms.topic: article
author: Heidilohr
ms.author: helohr
ms.date: 01/16/2024
---
# Control SMB signing behavior (preview)

> [!IMPORTANT]
> Windows Insider and Windows Server Insider builds are in PREVIEW.
> This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

## How SMB signing works

Server Message Block (SMB) signing is a security feature that uses the session key and cipher suite to add a signature to a message going across a connection. This signature contains a hash of the entire message in the SMB header. If someone tampers with the message in transit, the data in the tampered message doesn't match the hash in the signature. The hash also includes the identities of the original sender and the intended recipient. Signature mismatches alert users to possible foul play, helping them protect their deployments from relay and spoofing attacks.

SMB signing requirements can involve both outbound signing, which covers traffic from the SMB client, and inbound signing, which covers traffic to the server. Windows and Windows Server can require outbound signing only, inbound signing only, both, or neither. For example:

- Windows 11 Insiders Enterprise, Pro, and Education require both outbound and inbound SMB signing.

- Windows Server Insiders requires outbound SMB signing only.

- Windows 11 Insider Home edition doesn't require outbound or inbound SMB signing.

## Prerequisites

In order to control SMB signing behavior and maximize its capabilities, your system must be running one of the following two operating systems:

- Windows 11 Insider Preview Build 25905 or later

- Windows Server Preview Build 26010 or later

You should also follow these recommendations to ensure your SMB signatures are effective at securing your data:

- Use Kerberos instead of NTLMv2.

- Don't connect to shares using IP addresses.

- Don't use CNAME DNS records. Instead, assign alternate computer names with NETDOM.EXE.

## Disable SMB signing

SMB signing is required by default on the latest Insider Preview builds of Windows 11 and Windows Server. All Windows environments support SMB signing. However, if your environment uses third-party servers and the third-party server doesn't support SMB signing, you can't connect to the remote share.

Requiring SMB signing also disables guest access to shares. In these cases, you must disable SMB signing manually to restore access for guest accounts.

> [!CAUTION]
> We don't recommend disabling SMB signing or using SMB1 as a workaround for third-party servers. We also don't recommend trying to sign with guest accounts.

To disable SMB signing manually on servers running Windows or Windows Server:

#### [Windows Admin Center](#tab/windows)

1. Open **Windows Admin Center**.

1. Select the name of the server you want to edit.

1. Select **Settings**.

1. Select **File Shares (SMB server)**.

1. Under **SMB signing**, select **Required**.

1. Select **Save**.

#### [PowerShell](#tab/powershell)

1. Open an elevated PowerShell window as an administrator.

1. Run the following command to check the SMB signing settings on Windows or Windows Server.

   ```powershell
   Get-SmbServerConfiguration | FL requiresecuritysignature
   ```

1. To disable SMB client signing for outbound connections, run this command:

   ```powershell
   Set-SmbClientConfiguration -RequireSecuritySignature $false
   ```

1. To disable SMB server signing for inbound connections, run this command:

   ```powershell
   Set-SmbServerConfiguration -RequireSecuritySignature $false
   ```

--- 

## Related content

- [Overview of File Sharing using the SMB 3 protocol in Windows Server](file-server-smb-overview.md)

- [SMB over QUIC](smb-over-quic.md)

- [SMB security enhancements](smb-security.md)
