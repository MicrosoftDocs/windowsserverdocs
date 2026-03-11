---
title: Upgrade Windows Server in Place
description: Learn how to upgrade Windows Server in place using installation media or Windows Update. Keep settings, server roles, and data intact.
ms.topic: how-to
author: robinharwood
ms.author: roharwoo
ms.date: 03/11/2026
# Customer intent: As a server administrator, I want to perform an in-place upgrade of Windows Server
# so that my server remains supported and I can use the latest features.
---

# Perform an in-place upgrade of Windows Server

An in-place upgrade moves your server from an older version of Windows Server to a newer one while keeping your settings, server roles, and data intact. When you need to stay on a supported version or use the latest security and performance features, upgrading in place avoids rebuilding your environment.

This article walks you through the in-place upgrade process by running Windows Server Setup from installation media or by using the feature update in Windows Update.

## Prerequisites

- Administrative rights on the target server.

- A full backup of your server, including the operating system, apps, data, and any VMs. Perform a restore test to confirm the backup is valid and recoverable. You can use Windows Server Backup or a partner backup solution.

- A scheduled maintenance window, as downtime is required during the upgrade.

- Knowledge of:
  - The roles and features that support an in-place upgrade. See [Upgrade and migrate roles and features in Windows Server](upgrade-migrate-roles-features.md).
  - The Microsoft server applications that are supported on Windows Server. See [Microsoft server applications compatibility for Windows Server](application-compatibility.md).
  - Any non-Microsoft application vendor support requirements.

- A server that:
  - Meets or exceeds the [hardware requirements for Windows Server](hardware-requirements.md).
  - Isn't running in Azure.
  - Isn't clustered. If you're running a cluster, use the [Cluster-Aware Updating](../failover-clustering/cluster-aware-updating.md) feature or a [cluster operating system rolling upgrade](../failover-clustering/Cluster-Operating-System-Rolling-Upgrade.md) instead.

> [!IMPORTANT]
> While most Windows Server roles support an in-place upgrade, Active Directory Domain Controllers are an exception. Although an in-place upgrade might work, don't upgrade servers that run the Active Directory Domain Services role. For more information, see [Upgrade domain controllers to a newer version of Windows Server](../identity/ad-ds/deploy/upgrade-domain-controllers.md).

Depending on whether you upgrade by using installation media or Windows Update, **meet additional prerequisites**.

# [Installation media](#tab/media)

The installation media upgrade method applies to non-Azure servers only. To upgrade Windows Server in an Azure virtual machine (VM), see [In-place upgrade for VMs running Windows Server in Azure](/azure/virtual-machines/windows-in-place-upgrade) or use the Windows Update method.

- Installation media (ISO image, USB drive, or DVD) for the version of Windows Server that you want to upgrade to.
  - For information about available Windows Server versions and supported upgrade paths, see [Which version of Windows Server should I upgrade to?](upgrade-overview.md#which-version-of-windows-server-should-i-upgrade-to)
  - You can get installation media for your target version of Windows Server from an original equipment manufacturer (OEM), a retail distribution channel, a Visual Studio subscription, or the Microsoft 365 admin center.
- A valid product key and activation method. Keys and methods can vary depending on the distribution channel that you received the Windows Server installation media from, such as a Commercial Licensing program, a retail channel, or an OEM.
- A location to store files away from your server, such as a USB flash drive or network location.
- If Configuration Manager is installed on a Windows Server 2012 or Windows Server 2012 R2 server, follow the preupgrade and post-upgrade instructions at [Upgrade on-premises infrastructure that supports Configuration Manager](/mem/configmgr/core/servers/manage/upgrade-on-premises-infrastructure#before-upgrade).

# [Windows Update](#tab/windows-update)

To upgrade to Windows Server 2025 or later by using Windows Update, you need:

- Windows Server 2019 or Windows Server 2022 on all servers you want to upgrade.
- The required cumulative update installed on all servers you want to upgrade. Install the correct update for your operating system and restart the server if required.
  - [2026-03 Cumulative Update for Microsoft server operating system version 21H2 for x64-based Systems (KB5078766)](https://support.microsoft.com/help/5078766) or later for Windows Server 2022
  - [2026-03 Cumulative Update for Microsoft server operating system for x64-based Systems (KB5078752)](https://support.microsoft.com/help/5078752) or later for Windows Server 2019

---

## Collect pre-upgrade diagnostic information

Collect diagnostic information from your server before upgrading in case the upgrade fails. Store the diagnostic files where you can access them if your server goes down.

To collect your information:

1. Open an elevated PowerShell prompt, make a note of your current directory, and run the following commands:

   ```powershell
   Get-ComputerInfo -Property WindowsBuildLabEx,WindowsEditionID | Out-File -FilePath .\computerinfo.txt
   systeminfo.exe | Out-File -FilePath systeminfo.txt
   ipconfig /all | Out-File -FilePath ipconfig.txt
   ```

   The `Get-ComputerInfo` command requires PowerShell 5.1 or later. If your Windows Server version doesn't include PowerShell 5.1, open Registry Editor and find the `BuildLabEx` and `EditionID` values under `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion`.

1. Open File Explorer, go to the directory you noted down, and copy the files to a USB flash drive or network location off your computer.

Back up your server operating system, apps, and VMs after collecting your system information. Shut down or migrate any VMs currently running on the server. Make sure no VMs are running during the upgrade.

## Perform the in-place upgrade

You can perform the in-place upgrade by using installation media or Windows Update.

# [Installation media](#tab/media)

Run Windows Server Setup from your installation media to do the in-place upgrade. This procedure applies to non-Azure, nonclustered servers running Windows Server 2012 R2 or later. During the upgrade, your server restarts several times.

To do the in-place upgrade by using installation media:

1. Mount or insert the installation media. Open File Explorer, go to the root of the installation media, and then open `setup.exe`. For example, if you mounted an ISO image or inserted a DVD as drive D, the file path is `D:\setup.exe`. If **User Account Control** prompts you to allow Setup to make changes, select **Yes**.

1. By default, Setup automatically downloads updates for the installation. If you're okay with the default settings, select **Next** to continue.

   If you don't want Setup to automatically download updates, select **Change how Setup downloads updates**, select the appropriate option for your environment, and then select **Next**.

1. If prompted, enter your product key, and then select **Next**.

1. Select the edition of Windows Server you want to install, and then select **Next**.

1. Review the applicable notices and license terms. If you agree to the terms, select **Accept**.

1. Select **Keep files, settings, and apps** to do an in-place upgrade, and then select **Next**.

1. After Setup finishes analyzing your device, it displays the **Ready to install** screen. To start the in-place upgrade, select **Install**.

The in-place upgrade starts, and the screen displays the progress. After the in-place upgrade finishes, your server restarts.

# [Windows Update](#tab/windows-update)

Use the Windows Server feature update in Windows Update to perform the in-place upgrade without installation media.

### Enable the feature update from Windows Update

Add the following registry value to enable the feature update.

1. Open an elevated PowerShell prompt and run the following command:

   ```powershell
   New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"
   New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "AllowWindowsServerFeatureUpdate" -PropertyType DWord -Value 1
   ```

Alternatively, you can set the value manually in Registry Editor:

1. Open Registry Editor.

1. Go to `HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate`.

1. Create a new `DWORD` value named `AllowWindowsServerFeatureUpdate` and set it to `1`.

### Upgrade by using Windows Update

When you meet all the prerequisites and see the Windows Server feature update in Windows Update, proceed with the in-place upgrade.

1. Open **Settings**, and then select **Windows Update**. Verify that the feature update offer banner is visible.

1. Select **Download and Install** to begin the feature update process.

1. Review the **Important Information** for pricing, best practices, licenses, and privacy.

1. Select **Accept and install** to proceed with the download and installation of the feature update.

1. Wait for the feature update to download and install. Your server restarts during the installation.

> [!TIP]
> The feature update is also available for Server Core installations. Use SConfig option **6** to search for and install the feature update. For more information, see [Configure Windows Server Core Windows Update](../administration/server-core/server-core-servicing.md).

---

## Verify the in-place upgrade

After the server restarts, verify the upgrade succeeded by checking the Windows Server version and testing your applications.

1. Open an elevated PowerShell prompt. Run the following command to verify that the version and edition match what you expected.

   ```powershell
   Get-ComputerInfo -Property WindowsProductName
   ```

1. Ensure all applications are running and client connections are successful.

If your server isn't working as expected after the in-place upgrade, analyze the Setup log files in the `C:\Windows\Panther` directory. Also download the [`SetupDiag`](/windows/deployment/upgrade/setupdiag) tool to analyze the Setup log files.

If you need technical assistance, contact [Microsoft Support](https://support.microsoft.com/contactus).

## Related content

- [Overview of Windows Server upgrades](upgrade-overview.md)
- [Add or remove roles and features](../administration/server-manager/add-remove-roles-features.md)
- [Windows Server management overview](../administration/overview.md)
- [Get started with Windows Admin Center](../manage/windows-admin-center/use/get-started.md)
- [Key Management Services (KMS) activation planning](kms-activation-planning.md)
