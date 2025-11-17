---
title: Manage SMB dialects in Windows and Windows Server 2025
description: Learn how to manage SMB2 and SMB3 dialects using Group Policy and Windows PowerShell in Windows Server and Windows client.
ms.topic: how-to
author: dknappettmsft
ms.author: daknappe
ms.date: 10/25/2024
ms.custom: sfi-image-nochange

---

# Manage SMB dialects in Windows and Windows Server 2025

Administrators have the ability to manage SMB2 and SMB3 dialects in Windows Server and Windows client. In this article, learn how to configure a minimum and maximum SMB dialect for the SMB server and client using Group Policy and Windows PowerShell.

By default SMB Server and client automatically negotiates the highest matched dialect from SMB 2.0.2 to 3.1.1. Beginning with Windows 11, version 24H2, and [Windows Server 2025](/windows-server/get-started/whats-new-windows-server-2025), you can specify the SMB protocols used, blocking older, less secure, versions from connecting to the server. For example, you can specify connection to only use SMB 3.1.1, the most secure dialect of the protocol.

## Prerequisites

Before you can configure SMB dialects you need:

- An SMB server running on one of the following operating systems.
  - Windows Server 2025.
  - Windows 11, 24H2 or later.
- Administrative privileges to the computer.
- If you're using Group Policy on a domain, you need privileges to create or edit a Group Policy object (GPO) and link it to the appropriate organizational unit (OU).

## Configure maximum and minimum SMB dialects

You can configure the dialects available for negotiation using Group Policy or PowerShell. The minimum and maximum dialects can be set independently for the SMB server and client. Alternately, you can choose not to set a maximum. For example, you can set a minimum of 3.1.1 which effectively sets the maximum to 3.1.1.

## SMB server

You can configure the dialects available to your SMB server (that is, for inbound connections), by following these steps:

# [PowerShell](#tab/powershell)

Here's how to configure the minimum and maximum SMB dialects for the SMB server using PowerShell using the [Set-SmbServerConfiguration](/powershell/module/smbshare/set-smbserverconfiguration) cmdlet:

From an elevated PowerShell prompt, run the following commands:

```powershell
Set-SmbServerConfiguration -Smb2DialectMax {SMB202 | SMB210 |
SMB300 | SMB302 | SMB311 | None} -Smb2DialectMin {None | SMB202 | SMB210 | SMB300 | SMB302 | SMB311}
```

For example, to set the minimum dialect to SMB 3.0.0 and maximum dialects to SMB 3.1.1, run the following command:

```powershell
Set-SmbServerConfiguration -Smb2DialectMax SMB311 -Smb2DialectMin SMB300
```

# [Group Policy](#tab/group-policy)

Here's how to configure the minimum and maximum SMB dialects for the SMB server using Group Policy for domain joined machines.

To configure SMB dialect minimum and maximum for the SMB server:

1. Open the **Group Policy Management Console**.
1. Edit or create a Group Policy Object (GPO) that you want to use.
1. In the console tree, select **Computer Configuration > Administrative Templates > Network >
    Lanman Server**.
1. For the setting, right-click **Mandate the Minimum version of SMB** and select **Edit**.
1. Select the minimum version of the dialects using a dropdown menu and select **OK**.
1. For the setting, right-click **Mandate the Maximum version of SMB** and select **Edit**.
1. Select the maximum version of the dialects using a dropdown menu and select **OK**.

---

## SMB client

You can configure the dialects available to your SMB client (that is, for outbound connections), by following these steps:

# [PowerShell](#tab/powershell)

Here's how to configure the minimum and maximum SMB dialects for the SMB client using PowerShell using the [Set-SmbClientConfiguration](/powershell/module/smbshare/set-smbclientconfiguration) cmdlet:

From an elevated PowerShell prompt, run the following commands:

```powershell
Set-SmbClientConfiguration -Smb2DialectMax {SMB202 | SMB210 |
SMB300 | SMB302 | SMB311 | None} -Smb2DialectMin {None | SMB202 | SMB210 | SMB300 | SMB302 | SMB311}
```

For example, to set the minimum and maximum dialects to SMB 3.1.1, run the following command:

```powershell
Set-SmbClientConfiguration -Smb2DialectMax SMB311 -Smb2DialectMin SMB311
```

# [Group Policy](#tab/group-policy)

Here's how to configure the minimum and maximum SMB dialects for the SMB client using Group Policy for domain joined machines.

To configure SMB dialect minimum and maximum for the SMB client:

1. Open the **Group Policy Management Console**.
1. Edit or create a Group Policy Object (GPO) that you want to use.
1. In the console tree, select **Computer Configuration > Administrative Templates > Network >
    Lanman Workstation**.
1. For the setting, right-click **Mandate the minimum version of SMB** and select **Edit**.
1. Select the minimum version of the dialects using a dropdown menu and select **OK**.
1. For the setting, right-click **Mandate the maximum version of SMB** and select **Edit**.
1. Select the maximum version of the dialects using a dropdown menu and select **OK**.

   :::image type="content" source="media/manage-smb-dialects/select-minimum-maximum.jpg" alt-text="Screenshot showing group policy editor and select SMB version dropdown.":::

---

## Verify dialect negotiation

You can use a network capture tool like Wireshark to examine the client and server responses during negotiation of the SMB protocol. In the following example, the client requests SMB 3.1.1 only because it's configured with a minimum and maximum dialect of 3.1.1:

:::image type="content" source="media/manage-smb-dialects/capture-smb-session-creation.jpg" alt-text="Screenshot showing ethernet capture of SMB session creation.":::

## Related content

- [Protect SMB traffic from interception](smb-interception-defense.md)

