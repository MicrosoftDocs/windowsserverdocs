---
title: Control SMB signing behavior
description: How to disable SMB signing on third-party servers in Windows 11 and Windows Server.
ms.topic: how-to
ms.author: roharwoo
author: robinharwood
ms.date: 08/13/2025
---

# Control SMB signing behavior

## How SMB signing works

Server Message Block (SMB) signing is a security feature that uses the session key and cipher suite to add a signature to a message going across a connection. This signature contains a hash of the entire message in the SMB header. If someone tampers with the message in transit, the data in the tampered message doesn't match the hash in the signature. The hash also includes the identities of the original sender and the intended recipient. Signature mismatches alert users to possible foul play, helping them protect their deployments from relay and spoofing attacks.

SMB signing requirements can involve both outbound signing, which covers traffic from the SMB client, and inbound signing, which covers traffic to the server. Windows and Windows Server can require outbound signing only, inbound signing only, both, or neither. For example:

- Windows 11, version 24H2 Enterprise, Pro, and Education require both outbound and inbound SMB signing.

- Windows Server 2025 requires outbound SMB signing only.

- Windows 11, version 24H2 Home edition doesn't require outbound or inbound SMB signing.

## SMB signing behavior

Although all versions of Windows and Windows Server support SMB signing, a third-party might opt to disable or not support it. If you try to connect to a remote share on a third-party SMB server that doesn't allow SMB signing, you might encounter one of the following error messages:

```error
0xc000a000
-1073700864
STATUS_INVALID_SIGNATURE
The cryptographic signature is invalid.
```

To resolve this issue, adjust the settings on your third-party SMB server to allow (enable) SMB signing.

When you try to connect to third-party devices that use guest accounts to simplify access, you might receive one of these error messages:

```error
You can't access this shared folder because your organization's security policies block
unauthenticated guest access. These policies help protect your PC from unsafe or malicious
devices on the network.
```

```error
Error code: 0x80070035
The network path was not found.
```

```error
System error 3227320323 has occurred.
```

Disabling SMB signing might be necessary if you're unable to disable guest usage for your third-party. However, this means that you're using guest access and preventing your client from ensuring signing to a trusted device.

> [!CAUTION]
> We don't recommend disabling SMB signing as a workaround for third-party servers. We also don't recommend trying to sign with guest accounts.

## Prerequisites

In order to control SMB signing behavior and maximize its capabilities, your system must be running one of the following two operating systems:

- Windows 11, version 24H2 or later
- Windows Server 2025 or later

You should also follow these recommendations to ensure your SMB signatures are effective at securing your data:

- Use Kerberos instead of NTLMv2.
- Don't connect to shares using IP addresses.
- Don't use CNAME Domain Name System (DNS) records. Instead, assign alternate computer names with `netdom.exe`.

## Disable SMB signing

SMB signing is required by default on the latest Insider Preview builds of Windows 11 and Windows Server 2025. All Windows environments support SMB signing. However, if your environment uses third-party servers and the third-party server doesn't support SMB signing, you can't connect to the remote share.

Requiring SMB signing also disables guest access to shares. In these cases, you must disable SMB signing manually to restore access for guest accounts. You can manually disable SMB signing through Group Policy, PowerShell, and Windows Admin Center.

> [!NOTE]
> If you need to modify the Active Directory domain-based group policy, use **Group Policy Management** (gpmc.msc).

# [Group Policy](#tab/group-policy)

To disable SMB signing in Group Policy, perform the following steps:

1. Select **Start**, type **gpedit.msc**, then hit <kbd>Enter</kbd>.

1. In the **Local Group Policy Editor**, navigate to **Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options**.

1. Open **Microsoft network client: Digitally sign communications (always)**, select **Disabled**, then select **OK**.

# [PowerShell](#tab/powershell)

1. Open an elevated PowerShell window.

1. To disable SMB client signing for outbound connections, run this command:

   ```powershell
   Set-SmbClientConfiguration -RequireSecuritySignature $false
   ```

1. To disable SMB server signing for inbound connections, run this command:

   ```powershell
   Set-SmbServerConfiguration -RequireSecuritySignature $false
   ```

# [Windows Admin Center](#tab/wac)

1. Open **Windows Admin Center**.

1. Select the name of the server you want to edit.

1. Select **Settings**.

1. Select **File Shares (SMB server)**.

1. Under **SMB signing**, select **Not required**.

1. Select **Save**.

Disabling SMB client for outbound connections can only be accomplished through Group Policy and PowerShell.

---

## Enable SMB signing

SMB signing ensures data integrity by verifying that data isn't tampered with during transmission. Additionally, SMB signing provides authentication by verifying the identity of the server and client, which helps prevent adversary-in-the-middle attacks.

# [Group Policy](#tab/group-policy)

To enable SMB signing in Group Policy, perform the following steps:

1. Select **Start**, type **gpedit.msc**, then hit <kbd>Enter</kbd>.

1. In the **Local Group Policy Editor**, navigate to **Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options**.

1. Open **Microsoft network client: Digitally sign communications (always)**, select **Enabled**, then select **OK**.

# [PowerShell](#tab/powershell)

1. Open an elevated PowerShell window.

1. To enable SMB client signing for outbound connections, run this command:

   ```powershell
   Set-SmbClientConfiguration -RequireSecuritySignature $true
   ```

1. To enable SMB server signing for inbound connections, run this command:

   ```powershell
   Set-SmbServerConfiguration -RequireSecuritySignature $true
   ```

# [Windows Admin Center](#tab/wac)

1. Open **Windows Admin Center**.

1. Select the name of the server you want to edit.

1. Select **Settings**.

1. Select **File Shares (SMB server)**.

1. Under **SMB signing**, select **Required**.

1. Select **Save**.

Enabling SMB client for outbound connections can only be accomplished through Group Policy and PowerShell.

---

## Verify SMB signing status

To check if SMB signing is enabled or disabled on your SMB client or SMB server, run the following command:

```powershell
Get-SmbClientConfiguration | FL RequireSecuritySignature
```

```powershell
Get-SmbServerConfiguration | FL RequireSecuritySignature
```

If the returned information is **True**, then SMB signing is enabled, otherwise, if the returned information is **False**, then SMB signing is disabled.

## See also

- [Overview of File Sharing using the SMB 3 protocol in Windows Server](file-server-smb-overview.md)

- [SMB over QUIC](smb-over-quic.md)

- [SMB security enhancements](smb-security.md)

- [How to enable insecure guest logons in SMB2 and SMB3](enable-insecure-guest-logons-smb2-and-smb3.md)

