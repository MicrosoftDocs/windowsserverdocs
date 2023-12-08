---
title: Control SMB signing behavior
description: How to disable SMB singing on third-party servers using Windows 11.
ms.topic: article
author: Heidilohr
ms.author: helohr
ms.date: 12/07/2023
ms.prod: windows-server
---
# Control SMB signing behavior (preview)

As of Windows 11 Insider Preview Build 25318, Windows Server now requires SMB signing by default (preview) for all connections.

## How SMB signing works

SMB signing is a security feature that uses the session key and cipher suite to add a signature to a message going across a connection. This signature contains a hash of the entire message in the SMB header. If someone tampers with the message in transit, the data in the tampered message won't match the hash in the signature. The hash also includes the identities of the original sender and the intended recipient. Signature mismatches alert users to possible foul play, helping them protect their deployments from relay and spoofing attacks.

## Prerequisites

In order to use SMB signing and maximize its capabilities, you need the following things:

- Windows 11 Insider Preview Build or later.

- A functioning deployment of Windows Server.

You should also follow these recommendations to ensure your SMB signatures are effective at securing your data:

- Use Kerberos instead of NTLMv2.

- Don't connect to shares using IP addresses.

- Don't use CNAME records.

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

- [SMB security enhancements](smb-security.md)
