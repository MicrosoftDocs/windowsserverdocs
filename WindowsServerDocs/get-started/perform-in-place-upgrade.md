---
title: Perform an in-place upgrade of Windows Server
description: Learn how to perform an in-place OS upgrade (feature update) of an older operating system while keeping your settings, server roles, and data intact.
ms.topic: how-to
author: robinharwood
ms.author: roharwoo
ms.date: 01/20/2025
# Customer intent: As a server administrator, I want perform a Feature Update of Windows Server, so
# that my server remains supported and I can use the latest features.
---

# Perform an in-place upgrade of Windows Server

An in-place OS upgrade (feature update) allows you to go from an older operating system
to a newer one while keeping your settings, server roles, and data intact. This article teaches you
how to move to a later version of Windows Server by using a Feature Update.

> [!IMPORTANT]
> This article covers the Windows Server Feature Update process for non-Azure servers and virtual machines (VMs) only. To do a Feature Update of Windows Server running in an Azure virtual machine (VM), see [In-place upgrade for VMs running Windows Server in Azure](/azure/virtual-machines/windows-in-place-upgrade).

## Prerequisites

Before you start upgrading, complete the following prerequisites:

- Determine [which version of Windows Server to update to](upgrade-overview.md#which-version-of-windows-server-should-i-upgrade-to).
- Make sure you have a valid product key and activation method. Keys and methods might vary depending on the distribution channel you received Windows Server media from, for example a Commercial Licensing program, Retail, or Original Equipment Manufacturer (OEM).
- You need to have the setup media for the version of Windows Server that you want to upgrade to. Setup media for the target version of Windows Server can be obtained from OEM, Retail, Visual Studio Subscriptions, and the Volume Licensing Service Center (VLSC) channels.
- Have a location to store files away from your computer, such as a USB flash drive or network location.
- Review [Upgrade and migrate roles and features in Windows Server](upgrade-migrate-roles-features.md).
- Review [Microsoft server applications compatibility](application-compatibility-windows-server-2022.md).
- Review any non-Microsoft application vendor support requirements.
- Make sure your computer:
  - Meets or exceeds the [hardware requirements for Windows Server](hardware-requirements.md).
  - Isn't running in Azure.
- Perform a full backup of your computer. The backup should include the operating system, apps, data, and any virtual machines (VMs) running on the server. You can use Windows Server Backup or a partner backup solution.

> [!NOTE]
> If you're performing a Feature Update of a Windows Server 2012 or Windows Server 2012 R2 server with Configuration Manager installed, follow the preupgrade and post-upgrade instructions at [Upgrade on-premises infrastructure that supports Configuration Manager](/mem/configmgr/core/servers/manage/upgrade-on-premises-infrastructure#before-upgrade).

### Collect diagnostic information

We recommend that you collect some information from your devices for diagnostic and troubleshooting
purposes in case the Feature Update is unsuccessful. We also recommend you store the information
somewhere you can access even if your device is unavailable.

To collect your information:

1. Open an elevated PowerShell prompt, make a note of your current directory, and run the
   following commands.

   ```powershell
   Get-ComputerInfo -Property WindowsBuildLabEx,WindowsEditionID | Out-File -FilePath .\computerinfo.txt
   systeminfo.exe | Out-File -FilePath systeminfo.txt
   ipconfig /all | Out-File -FilePath ipconfig.txt
   ```

   > [!TIP]
   > `Get-ComputerInfo` requires PowerShell 5.1 or later. If your Windows Server version doesn't include PowerShell, you can find this information in the registry. Open Registry Editor, go to the **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion** key, and then copy and paste the Windows Server **BuildLabEx** and **EditionID** values.

1. Using **File Explorer**, navigate to the directory you noted down, and **copy** the files to a
   USB flash drive or network location off of your computer.

After you collect all of your Windows Server-related information, we recommend that you back up
your server operating system, apps, and VMs. You must also shut down, quick migrate, or
live migrate any VMs currently running on the server. You can't have any VMs running during the Feature Update.

## Perform the in-place upgrade

Now that you completed the prerequisites and collected diagnostic information, you're ready to
perform the in-place upgrade. In this section, you use Windows Server Setup to select the settings
for the in-place upgrade. Windows Server Setup uses these settings to update your version of Windows
Server, during which time your computer restarts several times.

To perform the in-place upgrade:

1. Using **File Explorer**, navigate to the Windows Server Setup media. Then open **setup.exe**.
   For example, if you're using removal media the file path might be _D:\setup.exe_.

    > [!IMPORTANT]
    > Depending on your security settings, User Account Control might prompt you to allow setup to
    > make changes to your device. If you're happy to continue, select **Yes**.

1. By default, setup automatically downloads updates for the installation. If you're okay with
   the default settings, select **Next** to continue.

   If you don't want Setup to automatically download updates, select **Change how Setup downloads updates**, choose the option appropriate to your environment, and then select **Next**.

1. If prompted, enter your product key and then select **Next**.

1. Select the edition of Windows Server you want to install and then select **Next**.

1. Review the applicable notices and license terms. If you agree to the terms, select **Accept**.

1. Select **Keep personal files and apps** to choose to do an in-place upgrade, and then select **Next**.

1. After Setup finishes analyzing your device, it displays the **Ready to install** screen. To continue the in-place upgrade, select **Install**.

The in-place upgrade starts, and you should see a progress bar. After the in-place upgrade finishes, your server restarts.

## Checking if your in-place upgrade was successful

After the in-place upgrade to Windows Server is done, you must make sure the upgrade was successful.

To make sure your in-place upgrade was successful:

1. Open an elevated PowerShell prompt and run the following command to verify that the version and edition
   matches the media and values you selected during setup.

   ```powershell
   Get-ComputerInfo -Property WindowsProductName
   ```

1. Make sure all of your applications are running and that your client connections to the
   applications are successful.

If your computer isn't working as expected after the Feature Update, you can
[contact Microsoft Support](https://support.microsoft.com/contactus) for technical assistance.

## Next steps

The following articles can help you prepare for and use your new Windows Server version:

- [Install or uninstall roles, role services, or features](../administration/server-manager/install-or-uninstall-roles-role-services-or-features.md)
- [Windows Server management overview](../administration/overview.md)
- [Get started with Windows Admin Center](../manage/windows-admin-center/use/get-started.md)
- [Key Management Services (KMS) activation planning](kms-activation-planning.md)
- [Activate using Active Directory-based activation](/windows/deployment/volume-activation/activate-using-active-directory-based-activation-client)

If you'd like to learn more about deploying and post-installation configuration and activation options, check out the
[Windows Server deployment, configuration, and administration learning path](/training/paths/windows-server-deployment-configuration-administration/).
