---
title: Install Windows Admin Center
description: How to install Windows Admin Center on a Windows PC or on a server so that multiple users can access Windows Admin Center using a web browser.
ms.topic: install-set-up-deploy
author: robinharwood
ms.author: roharwoo
ms.date: 05/28/2025
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

1. Review the **Ready to install** window, select **Install** to start the installation process.

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
        Source = "https://aka.ms/WACdownload"
        Destination = ".\WindowsAdminCenter.exe"
   }
   Start-BitsTransfer @parameters
   ```

1. To install Windows Admin Center, run the following command:

   ```powershell
   Start-Process -FilePath '.\WindowsAdminCenter.exe' -ArgumentList '/VERYSILENT' -Wait
   ```

1. You may also need to start the Windows Admin Center service using the following command:

   ```powershell
   Start-Service -Name WindowsAdminCenter
   ```

You've now installed Windows Admin Center on your machine.

---

::: zone-end

:::zone pivot="windows-server-2022"

### [Desktop Experience](#tab/desktop-experience)

To install Windows Admin Center on your machine running the Windows Server Desktop Experience, follow these steps:

1. Sign in to the machine you want to install Windows Admin Center on.

1. Run the Windows Admin Center installer you previously downloaded.

1. On the **Welcome to the Windows Admin Center setup wizard** window, select **Next** to continue.

1. On the **License Terms and Privacy Statement** window, if you agree to the terms select **I accept these terms and understand the privacy statement**, then select **Next** to start the installation process.

1. In the **Select installation mode** window, select **Express setup**, then select **Next**.

1. In the **Select TLS certificate** window, select the option that matches your needs, then select **Next**.

   >[!NOTE]
   >You must select which Transport Layer Security (TLS) certificate Windows Admin Center should use. If you already have a certificate, it must be installed in the `LocalMachine\My` certificates store. If you're installing Windows Admin Center for testing purposes only, the installer can generate a self-signed certificate that expires after 60 days.

1. In the **Automatic updates** window, select your preferred update option, then select **Next**.  

1. In the **Send diagnostic data to Microsoft** window, select your preference, then select **Next**.

1. Review the **Ready to install** window, select **Install** to start the installation process.

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
        Source = "https://aka.ms/WACdownload"
        Destination = ".\WindowsAdminCenter.exe"
   }
   Start-BitsTransfer @parameters
   ```

1. To install Windows Admin Center, run the following command:

   ```powershell
   Start-Process -FilePath '.\WindowsAdminCenter.exe' -ArgumentList '/VERYSILENT' -Wait
   ```

1. You may also need to start the Windows Admin Center service using the following command:

   ```powershell
   Start-Service -Name WindowsAdminCenter
   ```

You've now installed Windows Admin Center on your machine.

---

::: zone-end

:::zone pivot="windows-client"

To install Windows Admin Center on your machine running the Windows client, follow these steps:

1. Sign in to the machine you want to install Windows Admin Center on.

1. Run the Windows Admin Center installer you previously downloaded.

1. On the **Welcome to the Windows Admin Center setup wizard** window, select **Next** to continue.

1. On the **License Terms and Privacy Statement** window, if you agree to the terms select **I accept these terms and understand the privacy statement**, then select **Next** to start the installation process.

1. In the **Select installation mode** window, select **Express setup**, then select **Next**.

1. In the **Select TLS certificate** window, select the option that matches your needs, then select **Next**.

   >[!NOTE]
   >You must select which Transport Layer Security (TLS) certificate Windows Admin Center should use. If you already have a certificate, it must be installed in the `LocalMachine\My` certificates store. If you're installing Windows Admin Center for testing purposes only, the installer can generate a self-signed certificate that expires after 60 days.

1. In the **Automatic updates** window, select your preferred update option, then select **Next**.  

1. In the **Send diagnostic data to Microsoft** window, select your preference, then select **Next**.

1. Select the Start Menu folder for where setup should place shortcuts. To use the default location, select **Next**. Alternatively, enter a folder name or select **Browse** followed by **Next**.

1. Review the **Ready to install** window, select **Install** to start the installation process.

1. After the installation process finishes, select **Start Windows Admin Center**, then select **Finish**.

1. Sign in as an administrator to start using Windows Admin Center.

>[!NOTE]
> You must modify TrustedHosts in a workgroup environment or when you use local administrator credentials in a domain. If you choose to skip this setting, you must [configure TrustedHosts manually](../support/troubleshooting.md#configure-trustedhosts) instead.

You've now installed Windows Admin Center on your machine.

::: zone-end
