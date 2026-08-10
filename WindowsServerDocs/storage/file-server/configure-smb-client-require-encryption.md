---
title: Configure the SMB client to require encryption in Windows
description: Learn how to configure SMB encryption mandate in Windows and Windows Server using Group Policy and PowerShell.
ms.topic: how-to
author: robinharwood
ms.author: roharwoo
ms.date: 10/25/2024

---

# Configure the SMB client to require encryption in Windows

Beginning with Windows 11, version 24H2, and Windows Server 2025, the SMB client supports requiring encryption of all outbound SMB connections. Administrators can require all destination servers to support encryption with SMB 3.0 or later. In this article, learn how to configure the SMB client to require encryption for all outbound connections.

Encryption of all outbound SMB client connections enforces the highest level of network security and brings management parity to SMB signing, which allows both client and server requirements. When enabled, the SMB client won't connect to an SMB server that doesn't support SMB 3.0 or later, or that doesn't support SMB encryption. For example, a third-party SMB server might support SMB 3.0 but not SMB encryption.

SMB Encryption supplies SMB data end-to-end protection from interception attacks and snooping. The SMB client can require encryption per mapped drive, by UNC hardening, or on a per machine setting as described in this article. SMB server can also require SMB encryption on a per share basis or for the entire file server. To learn more about SMB encryption for SMB server and UNC Hardening, see [SMB encryption](smb-security.md#smb-encryption).

## Prerequisites

Before you can configure the SMB client to require encryption, you need:

- An SMB client running on one of the following operating systems.
  - Windows 11, version 24H2, or later.
  - Windows Server 2025 or later.
- Administrative privileges to the computer.
- If you're using Group Policy on a domain, you need privileges to create or edit a Group Policy object (GPO) and link it to the appropriate organizational unit (OU).

## Configure SMB encryption mandate using Group Policy

You can configure the SMB client to always require encryption regardless of server, share, UNC hardening, or mapped drive requirements. An administrator can globally force a Windows machine to use SMB encryption (and therefore SMB 3.x) on all connections, refusing to connect if the SMB server doesn't support either.

> [!TIP]
> SMB encryption has associated performance and compatibility overhead. SMB signing features better performance and tamper protection but does not provide snooping protection. Forgoing encryption and signing completely offers the best performance but of course provides no security beyond connection authorization and pre-auth integrity protection. SMB encryption supersedes SMB signing and supplies the same level of tamper protection; if your SMB client requires signing, SMB encryption turns it off.

You can configure the SMB client to require encryption for outbound connections using Group Policy or PowerShell.

# [Group Policy](#tab/group-policy)

Here's how to configure the SMB client to require encryption for all outbound connections using Group Policy.

To configure SMB client for required encryption to all SMB servers (that is, for outbound connections):

1. Open the **Group Policy Management Console**.
1. Edit or create a Group Policy Object (GPO) that you want to use.
1. In the console tree, select **Computer Configuration > Administrative Templates > Network > Lanman Workstation**.
1. For the setting, right-click **Require encryption** and select **Edit**.
1. Select **Enable** and select **OK**.

:::image type="content" source="media/configure-smb-client-require-encryption/group-policy-editor-ui.png" alt-text="Screenshot showing Group Policy editor.":::

Setting the policy to disabled or not configured removes the encryption requirement.

>[!IMPORTANT]
>Be careful when deploying SMB encryption through organization-wide. Legacy SMB servers such as Windows Server 2008 R2 don't support SMB 3.0. Older third-party SMB servers in some cases can support SMB 3.0 but might not support encryption.

# [PowerShell](#tab/powershell)

Here's how to configure the SMB client to require encryption for all outbound connections using the [Set-SmbClientConfiguration](/powershell/module/smbshare/set-smbclientconfiguration)  PowerShell cmdlet.

From an elevated PowerShell prompt, set the following PowerShell parameter:

```powershell
Set-SmbClientConfiguration -RequireEncryption $true
```

Run the following command to see the effective setting on a machine:

```powershell
Get-SmbClientConfiguration | Format-List -Property RequireEncryption
```

---

## Related content

- [SMB security enhancements](smb-security.md)

