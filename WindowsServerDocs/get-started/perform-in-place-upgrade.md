---
title: Perform an In-Place Upgrade of Windows Server
description: See how to perform an in-place upgrade (a feature update) of an older operating system while keeping your settings, server roles, and data intact.
ms.topic: how-to
author: robinharwood
ms.author: roharwoo
ms.date: 04/22/2025
# Customer intent: As a server administrator, I want to perform a feature update of Windows Server so
# that my server remains supported and I can use the latest features.
---

# Perform an in-place upgrade of Windows Server

You can use an in-place operating system upgrade (a feature update) to go from an older operating system
to a newer one while keeping your settings, server roles, and data intact. This article shows you
how to move to a later version of Windows Server using installation media.

> [!IMPORTANT]
> This article covers the Windows Server upgrade process for non-Azure servers and virtual machines (VMs) only. To do an upgrade of Windows Server running in an Azure VM, see [In-place upgrade for VMs running Windows Server in Azure](/azure/virtual-machines/windows-in-place-upgrade).

## Prerequisites

Before you start upgrading, complete the following prerequisites:

- The setup media for the version of Windows Server that you want to upgrade to.
  - For information about available Windows Server versions and supported upgrade paths, see [Which version of Windows Server should I upgrade to?](upgrade-overview.md#which-version-of-windows-server-should-i-upgrade-to).
  - You can obtain setup media for your target version of Windows Server from an original equipment manufacturer (OEM), a retail distribution channel, a Visual Studio subscription, and the Microsoft 365 admin center.
- A valid product key and activation method. Keys and methods can vary depending on the distribution channel you receive Windows Server media from. Examples of channels include a Commercial Licensing program, a retail channel, or an OEM.
- A location to store files away from your computer, such as a USB flash drive or network location.
- Knowledge of:
  - The roles and features that support an in-place upgrade. See [Upgrade and migrate roles and features in Windows Server](upgrade-migrate-roles-features.md).
  - The Microsoft server applications that are supported on Windows Server. See [Microsoft server applications compatibility for Windows Server](application-compatibility.md).
  - Any non-Microsoft application vendor support requirements.
- A computer that:
  - Meets or exceeds the [hardware requirements for Windows Server](hardware-requirements.md).
  - Isn't running in Azure.
  - Isn't clustered. If you're running a cluster, instead use the [Cluster-Aware Updating](../failover-clustering/cluster-aware-updating.md) feature or a [cluster operating system rolling upgrade](../failover-clustering/cluster-operating-system-rolling-upgrade.md).
- A full backup of your computer. The backup should include the operating system, apps, data, and any VMs running on the server. You can use Windows Server Backup or a partner backup solution.

> [!NOTE]
> If you're performing a feature update of a Windows Server 2012 or Windows Server 2012 R2 server with Configuration Manager installed, follow the preupgrade and post-upgrade instructions at [Upgrade on-premises infrastructure that supports Configuration Manager](/intune/configmgr/core/servers/manage/upgrade-on-premises-infrastructure#before-upgrade).

### Collect diagnostic information

We recommend that you collect some information from your devices for diagnostic and troubleshooting
purposes in case the feature update is unsuccessful. We also recommend you store the information
somewhere you can access even if your device is unavailable.

To collect your information:

1. Open an elevated PowerShell prompt, make a note of your current directory, and run the
   following commands:

   ```powershell
   Get-ComputerInfo -Property WindowsBuildLabEx,WindowsEditionID | Out-File -FilePath .\computerinfo.txt
   systeminfo.exe | Out-File -FilePath systeminfo.txt
   ipconfig /all | Out-File -FilePath ipconfig.txt
   ```

   > [!TIP]
   > The `Get-ComputerInfo` command requires PowerShell 5.1 or later. If your Windows Server version doesn't include PowerShell, you can look in the registry for the information that the `Get-ComputerInfo` command returns:
   >
   > 1. Open Registry Editor.
   > 1. Go to the **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion** key.
   > 1. Copy the Windows Server **BuildLabEx** and **EditionID** values.

1. Open File Explorer, go to the directory you noted down, and copy the files to a
   USB flash drive or network location off your computer.

After you collect your Windows Server-related information, we recommend that you back up
your server operating system, apps, and VMs. You must also shut down, quick migrate, or
live migrate any VMs currently running on the server. You can't have any VMs running during the feature update.

## Perform the in-place upgrade

In this section, you use Windows Server Setup to select the settings
for the in-place upgrade. Windows Server Setup uses these settings to update your version of Windows
Server. During the update, your computer restarts several times.

To perform the in-place upgrade:

1. Open File Explorer, go to the Windows Server Setup media, and then open **setup.exe**.
   If you're using removal media, the file path might be _D:\setup.exe_.

   > [!IMPORTANT]
   > Depending on your security settings, the **User Account Control** dialog might prompt you to allow the setup to
   > make changes to your device. If you agree to the conditions, select **Yes**.

1. By default, the setup automatically downloads updates for the installation. If you're okay with
   the default settings, select **Next** to continue.

   If you don't want the setup to automatically download updates, select **Change how Setup downloads updates**, select the option that's appropriate for your environment, and then select **Next**.

1. If prompted, enter your product key, and then select **Next**.

1. Select the edition of Windows Server you want to install, and then select **Next**.

1. Review the applicable notices and license terms. If you agree to the terms, select **Accept**.

1. To do an in-place upgrade, select **Keep files, settings, and apps**, and then select **Next**.

1. After the setup finishes analyzing your device, it displays the **Ready to install** screen. To start the in-place upgrade, select **Install**.

The in-place upgrade starts, and the progress is displayed on the screen. After the in-place upgrade finishes, your server restarts.

## Check your in-place upgrade

When the in-place upgrade to Windows Server is complete, take the following steps to make sure the upgrade was successful:

1. Open an elevated PowerShell prompt. Run the following command to verify that the version and edition
   match the media and values you selected during setup.

   ```powershell
   Get-ComputerInfo -Property WindowsProductName
   ```

1. Make sure all your applications are running and that your client connections to the
   applications are successful.

If your computer isn't working as expected after the feature update and you need technical assistance, you can contact
[Microsoft Support](https://support.microsoft.com/contactus).

## Related content

The following articles can help you prepare for and use your new Windows Server version:

- [Install or uninstall roles, role services, or features](../administration/server-manager/install-or-uninstall-roles-role-services-or-features.md)
- [Windows Server management overview](../administration/overview.md)
- [Get started with Windows Admin Center](../manage/windows-admin-center/use/get-started.md)
- [Key Management Services (KMS) activation planning](kms-activation-planning.md)
- [Activate using Active Directory-based activation](/windows/deployment/volume-activation/activate-using-active-directory-based-activation-client)

To learn more about deployment and post-installation configuration and activation options, see the
[Windows Server deployment, configuration, and administration](/training/paths/windows-server-deployment-configuration-administration/) learning path.
