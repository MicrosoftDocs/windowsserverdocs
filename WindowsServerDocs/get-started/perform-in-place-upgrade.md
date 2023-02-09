---
title: Perform an in-place upgrade of Windows Server | Microsoft Docs
description: Learn how to perform an in-place upgrade to Windows Server.
ms.topic: how-to
author: robinharwood
ms.author: roharwoo
ms.date: 01/06/2023
# Customer intent: As a server administrator, I want upgrade Windows Server, so that my server
# remains supported and I can use the latest features.
---

# Perform an in-place upgrade of Windows Server

An in-place upgrade allows you to go from an older operating system to a newer one while keeping
your settings, server roles, and data intact. This article will teach you how to move to a later
version of Windows Server using an in-place upgrade.

> [!IMPORTANT]
> Looking to perform an in-place upgrade of Windows Server running in an Azure VM? See
> [In-place upgrade for VMs running Windows Server in Azure](/azure/virtual-machines/windows-in-place-upgrade).

## Prerequisites

Before you start upgrading, your computer must meet the following requirements:

- Determine
  [which version of Windows Server to upgrade to](upgrade-overview.md#which-version-of-windows-server-should-i-upgrade-to).
- The hardware meets or exceeds the [hardware requirements for Windows Server](hardware-requirements.md).
- Must not be running in Azure.
- The install media is ready to use.
- A valid product key and activation method are available. Keys and methods may depend based on the
  distribution channel that you received Windows Server media from, for example, a Commercial
  Licensing program, Retail, Original Equipment Manufacturer (OEM), and so on.
- PowerShell 5.1 or later.
- A location to store files away from your computer. For example, a USB flash drive or network
  location.
- Review the
  [upgrade and migrate roles and features in Windows Server](upgrade-migrate-roles-features.md)
  article.
- Review the
  [Microsoft server applications compatibility](application-compatibility-windows-server-2022.md)
  article.
- Review any third party application vendors support requirements.

### Collect diagnostic information

We recommend that you collect some information from your devices for diagnostic and troubleshooting
purposes in case the upgrade is unsuccessful. We also recommend you store the information somewhere
you can get to even if you can't access your device.

To collect your information:

1. Open an elevated PowerShell prompt, make a note of your current directory, and run the
   following commands.

   ```powershell
   Get-ComputerInfo -Property WindowsBuildLabEx,WindowsEditionID | Out-File -FilePath .\computerinfo.txt
   systeminfo.exe | Out-File -FilePath systeminfo.txt
   ipconfig /all | Out-File -FilePath ipconfig.txt
   ```

1. Using **File Explorer**, navigate to the directory you noted down, and **copy** the files to a
   USB flash drive or network location off of your computer.

> [!TIP]
> Get-ComputerInfo requires PowerShell 5.1 or later. If your Windows Server version doesn't include
> Powershell you can find this information in the registry. Open Registry Editor, go to the
> **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion** key, and then copy and paste
> the Windows Server **BuildLabEx** and **EditionID** values.

After you've collected all of your Windows Server-related information, we recommend that you backup
your server operating system, apps, and virtual machines. You must also shut down, quick migrate, or
live migrate any virtual machines currently running on the server. You can't have any virtual
machines running during the in-place upgrade.

## Perform the upgrade

Now you've completed your prerequisites and collected diagnostic information, you're ready to
perform the upgrade. In this section, you'll use the Windows Server Setup to select the settings for
the upgrade. Windows Server Setup will use these settings to upgrade your version of Windows Server,
during which time your computer will restart several times.

To perform the in-place upgrade:

1. Using **File Explorer**, navigate to the Windows Server Setup media. Then open **setup.exe**.
   For example, if you're using removal media the file path might be _D:\setup.exe_.

    > [!IMPORTANT]
    > Depending on your security settings, User Account Control may prompt you to allow setup to
    > make changes to your device. If you're happy to continue select **Yes**.

1. By default, setup will automatically download updates for the installation. If you're okay with
   the default settings, to continue select **Next**.

   If you don't want Setup to automatically
   download updates:

   - Select **Change how Setup downloads updates**, choose the option appropriate to your
     environment, then select **Next**.

1. If prompted, enter your product key, then select **Next**.

1. Select the edition of Windows Server you want to install, then select **Next**.

1. Review the applicable notices and license terms, if you agree to the terms, select **Accept**.

1. Select **Keep personal files and apps** to choose to do an in-place upgrade, then select
   **Next**.

1. After Setup finishes analyzing your device, setup will display the Ready to install screen, to
   continue the upgrade select **Install**.

The in-place upgrade will start, and you should see a progress bar. After the upgrade finishes, your
server will restart.

## Checking if your upgrade was successful

After the upgrade to Windows Server is done, you must make sure the upgrade was successful.

To make sure your upgrade was successful:

1. Open an elevated PowerShell prompt, run the following command to verify the version and edition
   matches the media and values you selected during setup.

   ```powershell
   Get-ComputerInfo -Property WindowsProductName
   ```

1. Make sure all of your applications are running and that your client connections to the
   applications are successful.

If your computer isn't working as expected after the upgrade, you can
[contact Microsoft Support](https://support.microsoft.com/contactus) for technical assistance.

## Next steps

Now that you've upgraded Windows Server, here are some articles that might help you as you use the
new version:

- [Install or Uninstall Roles, Role Services, or Features](../administration/server-manager/install-or-uninstall-roles-role-services-or-features.md)
- [Windows Server management overview](../administration/overview.md)
- [Get Started with Windows Admin Center](../manage/windows-admin-center/use/get-started.md)
- [Key Management Services (KMS) activation planning](kms-activation-planning.md)
- [Activate using Active Directory-based activation](/windows/deployment/volume-activation/activate-using-active-directory-based-activation-client)

If you'd like to learn more about deploying, post-installation configuration and activation options,
check out the
[Windows Server deployment, configuration, and administration learning path](/training/paths/windows-server-deployment-configuration-administration/).
