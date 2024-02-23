---
title: Manage SMB dialects in Windows (preview)
description: Learn how to manage SMB2 and SMB3 dialects using Group Policy and Windows PowerShell in Windows Server and Windows client.
ms.topic: how-to
author: gswashington
ms.author: nedpyle
ms.date: 02/20/2024

---

# Manage SMB dialects in Windows (preview)

>Applies to: Windows and Windows Server Insider Builds

> [!IMPORTANT]
> Windows Insider and Windows Server Insider builds are in PREVIEW. This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

SMB server has the ability to manage SMB2 and SMB3 dialects in Windows Server and Windows client. In this article, learn how to configure a minimum and maximum SMB dialect for the SMB server and client using Group Policy and Windows PowerShell.

By default SMB Server and client automatically negotiates the highest matched dialect from SMB 2.0.2 to 3.1.1. Beginning with [Windows 11 Insider Preview Build 25951](https://blogs.windows.com/windows-insider/2023/09/13/announcing-windows-11-insider-preview-build-25951-canary-channel/) and [Windows Server Preview Build 25951](https://techcommunity.microsoft.com/t5/windows-server-insiders/announcing-windows-server-preview-build-25951/m-p/3926636), you can specify the SMB protocols used, blocking older, less secure, versions from connecting to the server. For example, you can specify connection to only use SMB 3.1.1, the most secure dialect of the protocol.

## Configure maximum and minimum SMB dialects

You can configure the dialects available for negotiation using Group Policy or PowerShell. The minimum and maximum dialects can be set independently for the SMB server and client.

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