---
title: Control SMB signing behavior (preview)
description: How to disable SMB singing on third-party servers in Windows 11 and Windows Server.
ms.topic: article
author: Heidilohr
ms.author: helohr
ms.date: 12/07/2023
ms.prod: windows-server
---
# Control SMB signing behavior (preview)

> [!IMPORTANT]
> Windows Server Insider builds are in PREVIEW.
> This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

## How SMB signing works

SMB signing is a security feature that uses the session key and cipher suite to add a signature to a message going across a connection. This signature contains a hash of the entire message in the SMB header. If someone tampers with the message in transit, the data in the tampered message won't match the hash in the signature. The hash also includes the identities of the original sender and the intended recipient. Signature mismatches alert users to possible foul play, helping them protect their deployments from relay and spoofing attacks.

> [!IMPORTANT]
> As of Windows 11 Insider Preview Build 25318, Windows Server now requires SMB signing by default (preview) for all connections.

## Prerequisites

In order to control SMB signing behavior and maximize its capabilities, you need the following things:

- Windows 11 Insider Preview Build 25905 or later.

  Or

- Windows Server Preview Build 26010, or later.

You should also follow these recommendations to ensure your SMB signatures are effective at securing your data:

- Use Kerberos instead of NTLMv2.

- Don't connect to shares using IP addresses.

- Don't use CNAME records.

## Disable SMB signing

SMB signing is enabled by default on the latest Insider Preview builds of Windows 11 and Windows Server. All Windows environments support SMB signing. However, if your environment uses third-party servers and the third-party server doesn't support SMB signing, you not be able to connect to the remote share.

Enabling SMB signing also disables guest access to shares. In these cases, you must disable SMB signing manually to restore access for guest accounts.

> [!CAUTION]
> We don't recommend disabling SMB signing or using SMB1 as a workaround for third-party servers.

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

- [SMB security enhancements](smb-security.md)
