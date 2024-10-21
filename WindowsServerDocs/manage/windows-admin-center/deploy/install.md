---
title: Install Windows Admin Center
description: How to install Windows Admin Center on a Windows PC or on a server so that multiple users can access Windows Admin Center using a web browser.
ms.topic: article
author: gswashington
ms.author: roharwoo
ms.date: 10/21/2024
zone_pivot_groups: windows-admin-center-os
---
# Install Windows Admin Center

>Applies to: Windows Admin Center, Windows Admin Center (preview)

This article describes how to install Windows Admin Center on a Windows client machine or on a remote server so that multiple users can access Windows Admin Center using a web browser. Select the button that corresponds to the operating system you plan to install Windows Admin Center on.

> [!TIP]
> New to Windows Admin Center?
> [Learn more about Windows Admin Center](../overview.md) or [Download now](../overview.md).

## Determine your installation type

Review the [installation options](../plan/installation-options.md) which includes the [supported operating systems](../plan/installation-options.md#installation-supported-operating-systems). To install Windows Admin Center on a virtual machine in Azure, see [Deploy Windows Admin Center in Azure](../azure/deploy-wac-in-azure.md).

## Prerequisites

To install Windows Admin Center, you need the following prerequisites:

- A Windows PC or server to install Windows Admin Center on.

- Administrative privileges or equivalent permissions on the machine you're installing Windows Admin Center on.

- Optional: An SSL certificate. You can use a self-signed certificate for testing, but you should always use a certificate from a trusted certificate authority for production environments. If you don't have a certificate, you can use the Windows Admin Center installer to generate a self-signed certificate. The certificate is valid for 60 days.

:::zone pivot="windows-server-2022,windows-client"

- Download the Windows Admin Center installer from the [Windows Admin Center Evaluation Center](https://www.microsoft.com/evalcenter/download-windows-admin-center) to a location on the machine you want to install Windows Admin Center on.

::: zone-end

## Installing Windows Admin Center

To install Windows Admin Center, perform the following steps:

:::zone pivot="windows-server-2025"

### [Server Core](#tab/server-core)

If you have a Server Core installation of Windows Server 2025, you can install Windows Admin Center from the command prompt (running as Administrator). Specify a port and SSL certificate by using the `SME_PORT` and `SSL_CERTIFICATE_OPTION` arguments respectively. If you're going to use an existing certificate, use the `SME_THUMBPRINT` to specify its thumbprint.

To install Windows Admin Center on your machine running Windows Server 2025 (preview) Server Core installation:

> [!WARNING]
> Installing Windows Admin Center will restart the WinRM service, which will sever all remote PowerShells sessions. It is recommended that you install from a local Cmd or PowerShell. If you are installing with an automation solution that would be broken by the WinRM service restarting, you can add the parameter ```RESTART_WINRM=0``` to the install arguments, but WinRM must be restarted for Windows Admin Center to function.

Run the following command to install Windows Admin Center and automatically generate a self-signed certificate:

```cli
msiexec /i <WindowsAdminCenterInstallerName>.msi /qn /L*v log.txt SME_PORT=<port> SSL_CERTIFICATE_OPTION=generate
```

Run the following command to install Windows Admin Center with an existing certificate:

```cli
msiexec /i <WindowsAdminCenterInstallerName>.msi /qn /L*v log.txt SME_PORT=<port> SME_THUMBPRINT=<thumbprint> SSL_CERTIFICATE_OPTION=installed
```

> [!WARNING]
> Don't invoke `msiexec` from PowerShell using dot-slash relative path notation, such as  `.\<WindowsAdminCenterInstallerName>.msi`. Windows Admin Center doesn't support that notation, and any attempt to use it in an installation won't work. Instead, either remove the `.\` prefix or specify the full path to the MSI.

### [Desktop Experience](#tab/desktop-experience)

To install Windows Admin Center on your machine running the Windows Server Desktop Experience, follow these steps:

1. Open the **Start** menu and enter **Windows Admin Center Setup** into the search bar to search for Windows Admin Center.

1. Select the **Windows Admin Center Setup** app from the **Best match** list.

1. On the **Get started with Windows Admin Center** window, select **Next** to accept the license terms. After that, the installation app opens, and the Installer download starts automatically.

1. Once the installer finishes downloading, select **Install**.

1. On the License Agreement, if you agree to the terms select **I accept the agreement**, then select **Next** to start the installation process.

1. In the **Select installation mode** window, select **Express remote setup**, then select **Next**.

1. In the **Select TLS certificate** window, select the option that matches your needs, then select **Next**.

   >[!NOTE]
   >You must select which Transport Layer Security (TLS) certificate Windows Admin Center should use. If you already have a certificate, it must be installed in the `LocalMachine\My` certificates store. If you're installing Windows Admin Center for testing purposes only, the installer can generate a self-signed certificate that expires after 60 days.

1. In the **Automatic updates** window, select your preferred update option, then select **Next**.  

1. In the **Send diagnostic data to Microsoft** window, select your preference, then select **Next**.

1. Select **Shortcut and Desktop shortcut preferences**, confirm the selection, then select **Next**.

1. In the **Ready to install** window, select **Install** to start the installation process.

1. After the installation process finishes, select **Start Windows Admin Center**, then select **Finish**.

1. Sign in as Administrator and then select **Sign In**.

You've now installed Windows Admin Center on your machine.

---

::: zone-end

:::zone pivot="windows-server-2022"

### [Server Core](#tab/server-core)

If you have a Server Core installation of Windows Server 2022 and earlier, you can install Windows Admin Center from the command prompt (running as Administrator). Specify a port and SSL certificate by using the `SME_PORT` and `SSL_CERTIFICATE_OPTION` arguments respectively. If you're going to use an existing certificate, use the `SME_THUMBPRINT` to specify its thumbprint.

To install Windows Admin Center on your Windows Server 2022 and earlier versions running Server Core installation:

> [!WARNING]
> Installing Windows Admin Center will restart the WinRM service, which will which will end all remote PowerShell sessions. We recommend that you install from a local command prompt or PowerShell window. If you're using an automated solution that restarting the WinRM service disrupts to install WIndows Admin Center, you can add the parameter ```RESTART_WINRM=0``` to the install arguments to restart the service. However, you must restart WinRM to make sure Windows Admin Center installs correctly.

Run the following command to install Windows Admin Center and automatically generate a self-signed certificate:

```cmd
msiexec /i <WindowsAdminCenterInstallerName>.msi /qn /L*v log.txt SME_PORT=<port> SSL_CERTIFICATE_OPTION=generate
```

Run the following command to install Windows Admin Center with an existing certificate:

```cmd
msiexec /i <WindowsAdminCenterInstallerName>.msi /qn /L*v log.txt SME_PORT=<port> SME_THUMBPRINT=<thumbprint> SSL_CERTIFICATE_OPTION=installed
```

> [!WARNING]
> Don't invoke `msiexec` from PowerShell using dot-slash relative path notation, such as  `.\<WindowsAdminCenterInstallerName>.msi`. Windows Admin Center doesn't support that notation, and any attempt to use it in an installation won't work. Instead, either remove the `.\` prefix or specify the full path to the MSI.

### [Desktop Experience](#tab/desktop-experience)

To install Windows Admin Center on your machine running the Windows Server Desktop Experience, follow these steps:

1. Sign in to the machine you want to install Windows Admin Center on.

1. Run the Windows Admin Center installer you previously downloaded.

1. On the **windows Admin Center Setup** screen, if you agree to the terms, check the box to accept, then select **Next**.

1. Select your preference for sharing diagnostic data with Microsoft, then select **Next**.

1. Select your preference for using Microsoft Update, then select **Next**.

1. Select **Next** to continue.

1. In the **Installing Windows Admin Center** window, confirm the settings, then select **Next** to continue.

   >[!NOTE]
   >
   > - The **Allow Windows Admin Center to modify this machine's trusted host settings** and **Automatically update Windows Admin Center** checkboxes are selected by default. We recommend leaving the defaults selected, but you can also deselect the box to disable these settings if you don't want Windows Admin Center to be able to modify your machine's trusted host settings or update automatically.
   >
   > - You must modify TrustedHosts in a workgroup environment or when you use local administrator credentials in a domain. If you choose to skip this setting, you must [configure TrustedHosts manually](../support/troubleshooting.md#configure-trustedhosts) instead.

1. Confirm or enter the port for the Windows Admin Center site to use, specify your preferred SSL certificate option, then select **Install**.

1. Select the URL to open Windows Admin Center in a browser, then Select **Finish**.

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
> When changing your certificate, the Windows Admin Center service will restart for the changes to take effect.

1. Run the Windows Admin Center installer.

1. On the _Welcome to the Windows Admin Center Setup Wizard_ screen, select **Next** to continue.

1. Select **Change** to update the certificate.

1. Select the certificate you want to use by entering the thumbprint of your certificate. Once completed, select **Change**. The installer beings to change your Windows Admin Center installation.

You've now updated the certificate used by Windows Admin Center.
