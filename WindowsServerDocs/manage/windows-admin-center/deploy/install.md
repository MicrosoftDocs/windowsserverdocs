---
title: Install Windows Admin Center
description: How to install Windows Admin Center on a Windows PC or on a server so that multiple users can access Windows Admin Center using a web browser.
ms.topic: article
author: robinharwood
ms.author: roharwoo
ms.date: 02/21/2025
zone_pivot_groups: windows-admin-center-os
---
# Install Windows Admin Center

This topic describes how to install Windows Admin Center on a Windows client machine or on a Windows Server 2025 remote server so that multiple users can access Windows Admin Center using a web browser.

> [!TIP]
> New to Windows Admin Center?
> [Learn more about Windows Admin Center](../overview.md) or [Download now](../overview.md).

## Determine your installation type

Review the [installation options](../plan/installation-options.md) which includes the [supported operating systems](../plan/installation-options.md#installation-supported-operating-systems). To install Windows Admin Center on a virtual machine in Azure, see [Deploy Windows Admin Center in Azure](../azure/deploy-wac-in-azure.md).

## Prerequisites

To install Windows Admin Center, you need the following prerequisites:

- A Windows PC or server to install Windows Admin Center on.

- Administrative privileges or equivalent permissions on the machine you're installing Windows Admin Center on.

- Optional: An SSL certificate used for _Server Authentication (1.3.6.1.5.5.7.3.1)_. You can use a self-signed certificate for testing, but you should always use a certificate from a trusted certificate authority for production environments. If you don't have a certificate, you can use the Windows Admin Center installer to generate a self-signed certificate. The certificate is valid for 60 days.

:::zone pivot="windows-server-2022,windows-client"

- Download the Windows Admin Center installer from the [Windows Admin Center Evaluation Center](https://www.microsoft.com/evalcenter/download-windows-admin-center) to a location on the machine you want to install Windows Admin Center on.

::: zone-end

:::zone pivot="windows-server-2025"

- If you're using the Server Core experience, download the Windows Admin Center installer from the [Windows Admin Center Evaluation Center](https://www.microsoft.com/evalcenter/download-windows-admin-center) to a location on the machine you want to install Windows Admin Center on.

::: zone-end

## Installing Windows Admin Center

To install Windows Admin Center, perform the following steps:

:::zone pivot="windows-server-2025"

### [Desktop Experience](#tab/desktop-experience)

To install Windows Admin Center on your machine running the Windows Server Desktop Experience, follow these steps:

1. Open the **Start** menu and enter **Windows Admin Center Setup** into the search bar to search for Windows Admin Center.

1. Select the **Windows Admin Center Setup** app from the **Best match** list.

1. On the **Get started with Windows Admin Center** window, if you agree to the license terms, select **Next** to continue.

1. The latest installer download starts automatically and is saved to the _Downloads_ folder, when complete, select **Install**. Selecting **Install** initiates the installer from the Downloads folder.

1. On the **Welcome to the Windows Admin Center setup wizard** window, select **Next** to continue.

1. On the **License Terms and Privacy Statement** window, if you agree to the terms select **I accept these terms and understand the privacy statement**, then select **Next** to start the installation process.

1. In the **Select installation mode** window, select **Express setup**, then select **Next**.

1. In the **Select TLS certificate** window, select the option that matches your needs, then select **Next**.

   >[!NOTE]
   >You must select which Transport Layer Security (TLS) certificate Windows Admin Center should use. If you already have a certificate, it must be installed in the `LocalMachine\My` certificates store. If you're installing Windows Admin Center for testing purposes only, the installer can generate a self-signed certificate that expires after 60 days.

1. In the **Automatic updates** window, select your preferred update option, then select **Next**.  

1. In the **Send diagnostic data to Microsoft** window, select your preference, then select **Next**.

1. In the **Ready to install** window, select **Install** to start the installation process.

1. After the installation process finishes, select **Start Windows Admin Center**, then select **Finish**.

1. Sign in as an administrator to start using Windows Admin Center.

You've now installed Windows Admin Center on your machine.

### [Server Core](#tab/server-core)

To install Windows Admin Center on your machine running the Windows Server Core experience or using PowerShell, follow these steps:

1. Sign-in to your machine. If you're on Server core, from the SConfig menu, enter option **15**, then press <kbd>Enter</kbd>
   to open a PowerShell session. If you're on the desktop experience, remote desktop into your VM and launch PowerShell.

1. Download the Windows Admin Center installer
   and copy it to your computer using the following PowerShell command:

   ```powershell
   $parameters = @{
        Source = "https://go.microsoft.com/fwlink/?linkid=2220149"
        Destination = ".\WindowsAdminCenter.exe"
   }
   Start-BitsTransfer @parameters
   ```

1. To install the Standalone Package, run the following command:

   ```powershell
   & .\WindowsAdminCenter.exe /VERYSILENT
   ```

1. TODO: how to verify? Services seem to run then crash, then require a restart

1. Restart your machine to complete the installation.

You've now installed Windows Admin Center on your machine.

---

::: zone-end

:::zone pivot="windows-server-2022"

### [Desktop Experience](#tab/desktop-experience)

To install Windows Admin Center on your machine running the Windows Server Desktop Experience, follow these steps:

1. Open the **Start** menu and enter **Windows Admin Center Setup** into the search bar to search for Windows Admin Center.

1. Select the **Windows Admin Center Setup** app from the **Best match** list.

1. On the **Get started with Windows Admin Center** window, if you agree to the license terms, select **Next** to continue.

1. The latest installer download starts automatically and is saved to the _Downloads_ folder, when complete, select **Install**. Selecting **Install** initiates the installer from the Downloads folder.

1. On the **Welcome to the Windows Admin Center setup wizard** window, select **Next** to continue.

1. On the **License Terms and Privacy Statement** window, if you agree to the terms select **I accept these terms and understand the privacy statement**, then select **Next** to start the installation process.

1. In the **Select installation mode** window, select **Express setup**, then select **Next**.

1. In the **Select TLS certificate** window, select the option that matches your needs, then select **Next**.

   >[!NOTE]
   >You must select which Transport Layer Security (TLS) certificate Windows Admin Center should use. If you already have a certificate, it must be installed in the `LocalMachine\My` certificates store. If you're installing Windows Admin Center for testing purposes only, the installer can generate a self-signed certificate that expires after 60 days.

1. In the **Automatic updates** window, select your preferred update option, then select **Next**.  

1. In the **Send diagnostic data to Microsoft** window, select your preference, then select **Next**.

1. In the **Ready to install** window, select **Install** to start the installation process.

1. After the installation process finishes, select **Start Windows Admin Center**, then select **Finish**.

1. Sign in as an administrator to start using Windows Admin Center.

You've now installed Windows Admin Center on your machine.

### [Server Core](#tab/server-core)

To install Windows Admin Center on your machine running the Windows Server Core experience or using PowerShell, follow these steps:

1. Sign-in to your machine. If you're on Server core, from the SConfig menu, enter option **15**, then press <kbd>Enter</kbd>
   to open a PowerShell session. If you're on the desktop experience, remote desktop into your VM and launch PowerShell.

1. Download the Windows Admin Center installer
   and copy it to your computer using the following PowerShell command:

   ```powershell
   $parameters = @{
        Source = "https://go.microsoft.com/fwlink/?linkid=2220149"
        Destination = ".\WindowsAdminCenter.exe"
   }
   Start-BitsTransfer @parameters
   ```

1. To install the Standalone Package, run the following command:

   ```powershell
   & .\WindowsAdminCenter.exe /VERYSILENT
   ```

1. TODO: how to verify? Services seem to run then crash, then require a restart

1. Restart your machine to complete the installation.

You've now installed Windows Admin Center on your machine.

---

::: zone-end

:::zone pivot="windows-client"

To install Windows Admin Center on your Windows client machine, follow the steps.

1. Sign in to the machine you want to install Windows Admin Center on.

1. Run the Windows Admin Center installer you previously downloaded.

1. On the **windows Admin Center Setup** screen, if you agree to the terms, check the box to accept, then select **Next**.

1. Select your preference for sharing diagnostic data with Microsoft, then select **Next**.

1. Select **Use Microsoft Update when I check for updates (recommended)**, then select **Next**.

1. Select **Next** to continue.

1. On the **Installing Windows Admin Center** screen, select the port that you want the Windows Admin Center site to use and confirm the settings. Select **Install** to begin the installation.

   >[!NOTE]
   >
   > - The default port is 6516. The **Allow Windows Admin Center to modify this machine's trusted host settings** and **Automatically update Windows Admin Center** checkboxes are selected by default. We recommend leaving the defaults selected, but you can also deselect the box to disable this setting if you don't want Windows Admin Center to be able to modify your machine's trusted host settings or update automatically.
   >
   > - You must modify TrustedHosts in a workgroup environment or when you use local administrator credentials in a domain. If you choose to skip this setting, you must [configure TrustedHosts manually](../support/troubleshooting.md#configure-trustedhosts) instead.

1. On the **One more thing** screen, check **Open Windows Admin Center**, then select **Finish**.

1. Wait for Windows Admin Center to launch, in the **Select a certificate for authentication** select the **Windows Admin Center Client**, then select **OK**.

You've now installed Windows Admin Center on your Windows client machine.

::: zone-end

## Upgrade to a new version

You can update non-preview versions of Windows Admin Center by using Microsoft Update or a manual installation.

Windows Admin Center preserves your settings when you upgrade to the latest version. Upgrading Insider Preview versions of Windows Admin Center isn't supported, we recommend you do a new installation by installing the latest version of Preview and starting over.

## Update the certificate used by Windows Admin Center

When you have Windows Admin Center deployed as a service, you must provide a certificate for HTTPS. To update this certificate, use the following these steps.

> [!IMPORTANT]
> When changing your certificate, you need to restart the Windows Admin Center service for the changes to take effect.

1. Sign-in to your machine. If you're on Server core, from the SConfig menu, enter option **15**, then press <kbd>Enter</kbd>
   to open a PowerShell session. If you're on the desktop experience, remote desktop into your VM and launch PowerShell.

1. Import the Windows Admin Center configuration PowerShell module using the following command:

   ```powershell
   Import-Module "$env:ProgramFiles\WindowsAdminCenter\PowerShellModules\Microsoft.WindowsAdminCenter.Configuration"
   ```

1. Apply the new certificate using the following command, making sure to replace `<subject name>` with the subject name of the certificate:

   ```powershell
   Set-WACCertificateSubjectName -SubjectName "<subject name>"
   ```

   > [!TIP]
   > Make sure the certificate uses a unique subject name. Alternatively, you can use the SHA1 thumbprint of the certificate using the **Thumbprint** parameter.

1. Updated the certificate access control list to grant permissions for the _Network Service_ account to access the certificate. Use the following command, replacing `<subject name>` with the subject name of the certificate:

   ```powershell
   Set-WACCertificateAcl -SubjectName "<subject name>"
   ```

1. Restart the Windows Admin Center service using the following command:

   ```powershell
   Restart-Service -Name WindowsAdminCenter
   ```

You've now updated the certificate used by Windows Admin Center.
