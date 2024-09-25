---
title: Install Windows Admin Center
description: How to install Windows Admin Center on a Windows PC or on a server so that multiple users can access Windows Admin Center using a web browser.
ms.topic: article
author: gswashington
ms.author: robinharwood
ms.date: 09/30/2024
zone_pivot_groups: windows-os
---
# Install Windows Admin Center

>Applies to: Windows Admin Center, Windows Admin Center (preview)

This topic describes how to install Windows Admin Center on a Windows client machine or on a remote server so that multiple users can access Windows Admin Center using a web browser.

> [!Tip]
> New to Windows Admin Center?
> [Learn more about Windows Admin Center](../overview.md) or [Download now](../overview.md).

## Determine your installation type

Review the [installation options](../plan/installation-options.md) which includes the [supported operating systems](../plan/installation-options.md#installation-supported-operating-systems). To install Windows Admin Center on a VM in Azure, see [Deploy Windows Admin Center in Azure](../azure/deploy-wac-in-azure.md).

## Windows Server 2025

:::zone pivot="windows-server-2025"

### [Server Core](#tab/server-core)

If you have a Server Core installation of Windows Server 2025, you can install Windows Admin Center from the command prompt (running as Administrator). Specify a port and SSL certificate by using the `SME_PORT` and `SSL_CERTIFICATE_OPTION` arguments respectively. If you're going to use an existing certificate, use the `SME_THUMBPRINT` to specify its thumbprint.

To install Windows Admin Center on your machine running Windows Server 2025 (preview) Server Core installation:

> [!WARNING]
> Installing Windows Admin Center will restart the WinRM service, which will sever all remote PowerShells sessions. It is recommended that you install from a local Cmd or PowerShell. If you are installing with an automation solution that would be broken by the WinRM service restarting, you can add the parameter ```RESTART_WINRM=0``` to the install arguments, but WinRM must be restarted for Windows Admin Center to function.

Run the following command to install Windows Admin Center and automatically generate a self-signed certificate:

```
msiexec /i <WindowsAdminCenterInstallerName>.msi /qn /L*v log.txt SME_PORT=<port> SSL_CERTIFICATE_OPTION=generate
```

Run the following command to install Windows Admin Center with an existing certificate:

```
msiexec /i <WindowsAdminCenterInstallerName>.msi /qn /L*v log.txt SME_PORT=<port> SME_THUMBPRINT=<thumbprint> SSL_CERTIFICATE_OPTION=installed
```

> [!WARNING]
> Don't invoke `msiexec` from PowerShell using dot-slash relative path notation, such as  `.\<WindowsAdminCenterInstallerName>.msi`. Windows Admin Center doesn't support that notation, and any attempt to use it in an installation won't work. Instead, either remove the `.\` prefix or specify the full path to the MSI.

## Upgrading to a new version of Windows Admin Center

You can update non-preview versions of Windows Admin Center by using Microsoft Update or a manual installation.

Windows Admin Center preserves your settings when you upgrade to the latest version. We don't officially support upgrading Insider Preview versions of Windows Admin Center, and we recommend you do a "clean" installation by installing the latest version of Preview and starting over, but we don't block attempts to manually carry over settings for Preview upgrades. 

### [Desktop Experience](#tab/desktop-experience)

To install Windows Admin Center on your machine running the Windows Server 2025 (preview) Desktop Experience:

1. Open the **Start** menu and enter **admin** into the search bar to search for Windows Admin Center.

1. Select the **Windows Admin Center Setup app** from the **Best match** list.

1. Select **Run as administrator** to open the **Get started with Windows Admin Center** window.

1. Select **Next** to accept the license terms. After that, the installation app opens, and the Installer download starts automatically.

1. Once the installer has finished downloading, select **Install**.

1. On the License Agreement, select **I accept the agreement**, then select **Next** to start the installation process.

1. In the **Select installation mode** window, select **Express local setup**, then select **Next**.

>[!NOTE]
>You must select what Transport Layer Security (TLS) certificate Windows Admin Center should use. If you already have an official certificate, it must be installed in the LocalMachine\My certificate store. If you're installing Windows Admin Center for testing purposes only, the installer can generate a self-signed certificate that expires after 60 days.

1. In the **Select TLS certificate** window, select the option that matches your needs, then select **Next**.

1. In the **Automatic updates** window, select your preferred update option, then select **Next**.  

1. In the **Send diagnostic data to Microsoft** window, select your preference, then select **Next**.

1. Select **Shortcut and Desktop shortcut preferences**, then select **Next**.

1. In the **Ready to install** window, select **Install** to start the installation process.

1. After the installation process finishes, select **Start Windows Admin Center**, then select **Finish**.

1. Wait for Windows Admin Center to automatically start.

1. Sign in as Administrator and then select **Sign In**. 

1. Wait for Windows Admin Center to automatically start.

You should now be able to see the name, machine type, and connection history of the machine you installed Windows Admin Center on listed on the **All connections** page at the top of the **Name** column.

---

## Windows Server 2022 and earlier

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

## Upgrading to a new version of Windows Admin Center

You can update non-preview versions of Windows Admin Center by using Microsoft Update or by manually installing.

Your settings are preserved when upgrading to a new version of Windows Admin Center. We don't officially support upgrading Insider Preview versions of Windows Admin Center - we think it's better to do a clean install - but we don't block it.

### [Desktop Experience](#tab/desktop-experience)

To install Windows Admin Center on your Windows Server 2022 and earlier versions running Desktop Experience installation:

1. Open [Windows Admin Center Evaluation Center](https://www.microsoft.com/evalcenter/download-windows-admin-center).

1. Under **Please select your Windows Admin Center download**, select **Download now**.

1. Select your preference for sharing diagnostic data with Microsoft, then select **Next**.

1. In the **Installing Windows Admin Center** window, select the port that you want the Windows Admin Center site to use. . 

>[!NOTE] 
>The default port is 6516. The **Allow Windows Admin Center to modify this machine's trusted host settings** checkbox is selected by default. We recommend leaving this check box selected, but you can also deselect the box to disable this setting if you don't want Windows Admin Center to be able to modify your machine's trusted host settings.

1. Select **Install**. Windows Admin Center installation begins. 

1. In the **One more thing** window, select the correct certificate for Windows Admin Center to use. 

1. Select the option that's highlighted and then select **Finish**. 

1. Wait for Windows Admin Center to automatically start. 

You should now be able to see the name, machine type, and connection history of the machine you installed Windows Admin Center on listed on the **All connections** page at the top of the **Name** column.

---
::: zone-end

## Install Windows Admin Center on Windows 10

:::zone pivot="windows-client"

When you install Windows Admin Center on Windows 10, it uses port 6516 by default, but you have the option to specify a different port. You can also create a desktop shortcut and let Windows Admin Center manage your TrustedHosts.

To install Windows Admin Center on your Windows client machine:

1. Open [Windows Admin Center Evaluation Center](https://www.microsoft.com/evalcenter/download-windows-admin-center).

1. Under **Please select your Windows Admin Center download**, select **Download now**.

1. Select your preference for sharing diagnostic data with Microsoft, then select **Next**.

1. In the **Installing Windows Admin Center** window, select the port that you want the Windows Admin Center site to use.  

>[!NOTE]
>The default port is 6516. The **Allow Windows Admin Center to modify this machine's trusted host settings** checkbox is selected by default. We recommend leaving this check box selected, but you can also deselect the box to disable this setting if you don't want Windows Admin Center to be able to modify your machine's trusted host settings.

1. Select **Install**. Windows Admin Center installation begins. 

1. In the One more thing window, select the correct certificate for Windows Admin Center to use. Select the option that's highlighted and then select **Finish**. 

1. Windows Admin Center should start automatically. 

You should now be able to see the name, machine type, and connection history of the machine you installed Windows Admin Center on listed on the **All connections** page at the top of the **Name** column.

>[!NOTE]
> You must modify TrustedHosts in a workgroup environment or when you use local administrator credentials in a domain. If you choose to skip this setting, you must [configure TrustedHosts manually](../support/troubleshooting.md#configure-trustedhosts) instead.

When you start Windows Admin Center from the **Start** menu, it opens in your default browser.

When you start Windows Admin Center for the first time, you should see an icon in the notification area of your desktop. Right-click this icon and select **Open** to open the tool in your default browser. To stop the background process, select **Exit**.

## Install on Windows Server with desktop experience

On Windows Server, Windows Admin Center is installed as a network service. You must specify the port that the service listens on, and it requires a certificate for HTTPS. The installer can create a self-signed certificate for testing, or you can provide the thumbprint of a certificate already installed on the computer. If you use the generated certificate, it will match the DNS name of the server. If you use your own certificate, make sure the name provided in the certificate matches the machine name (wildcard certificates are not supported.) You are also given the choice to let Windows Admin Center manage your TrustedHosts.

> [!NOTE]
> You must modify TrustedHosts in a workgroup environment or when you use local administrator credentials in a domain. If you choose to skip this setting, you must [configure TrustedHosts manually](../support/troubleshooting.md#configure-trustedhosts) instead.

Once the install is complete, open a browser from a remote computer and navigate to URL presented in the last step of the installer.

> [!WARNING]
> Automatically generated certificates expire 60 days after installation.

## Install on Server Core

If you have a Server Core installation of Windows Server with desktop experience, you can install Windows Admin Center from the command prompt (running as Administrator). Specify a port and SSL certificate by using the `SME_PORT` and `SSL_CERTIFICATE_OPTION` arguments respectively. If you're going to use an existing certificate, use the `SME_THUMBPRINT` to specify its thumbprint.

> [!WARNING]
> Installing Windows Admin Center will restart the WinRM service, which will sever all remote PowerShells sessions. It is recommended that you install from a local Cmd or PowerShell. If you are installing with an automation solution that would be broken by the WinRM service restarting, you can add the parameter ```RESTART_WINRM=0``` to the install arguments, but WinRM must be restarted for Windows Admin Center to function.

Run the following command to install Windows Admin Center and automatically generate a self-signed certificate:

```cmd
msiexec /i <WindowsAdminCenterInstallerName>.msi /qn /L*v log.txt SME_PORT=<port> SSL_CERTIFICATE_OPTION=generate
```

Run the following command to install Windows Admin Center with an existing certificate:

```cmd
msiexec /i <WindowsAdminCenterInstallerName>.msi /qn /L*v log.txt SME_PORT=<port> SME_THUMBPRINT=<thumbprint> SSL_CERTIFICATE_OPTION=installed
```

> [!WARNING]
> Don't invoke `msiexec` from PowerShell using dot-slash relative path notation (like,  `.\<WindowsAdminCenterInstallerName>.msi`). That notation isn't supported, the installation will fail. Remove the `.\` prefix or specify the full path to the MSI.

## Upgrading to a new version of Windows Admin Center

You can update non-preview versions of Windows Admin Center by using Microsoft Update or by manually installing.

Windows Admin Center preserves your settings when you upgrade to the latest version. We don't officially support upgrading Insider Preview versions of Windows Admin Center, and we recommend you do a "clean" installation by installing the latest version of Preview and starting over, but we don't block attempts to manually carry over settings for Preview upgrades. 

## Updating the certificate used by Windows Admin Center

When you have Windows Admin Center deployed as a service, you must provide a certificate for HTTPS. To update this certificate at a later time, re-run the installer and choose ```change```.

1. Open [Windows Admin Center Evaluation Center](https://www.microsoft.com/evalcenter/download-windows-admin-center).

1. Under **Please select your Windows Admin Center download**, select **Download now**.

1. Select your preference for sharing diagnostic data with Microsoft, then select **Next**.

1. In the **Installing Windows Admin Center** window, select the port that you want the Windows Admin Center site to use. 

>[!NOTE]
>The default port is 6516. The **Allow Windows Admin Center to modify this machine's trusted host settings** checkbox is selected by default. We recommend leaving this check box selected, but you can also deselect the box to disable this setting if you don't want Windows Admin Center to be able to modify your machine's trusted host settings.

1. Select **Install**. Windows Admin Center installation begins. 

1. In the One more thing window, select the correct certificate for Windows Admin Center to use. Select the option that's highlighted and then select **Finish**. 

1. Windows Admin Center should start automatically. 

You should now be able to see the name, machine type, and connection history of the machine you installed Windows Admin Center on listed on the **All connections** page at the top of the **Name** column.

### [Desktop Experience](#tab/desktop-experience)

To install Windows Admin Center on your Windows Server 2022 and earlier versions running Desktop Experience installation:

1. Open [Windows Admin Center Evaluation Center](https://www.microsoft.com/evalcenter/download-windows-admin-center).

1. Under **Please select your Windows Admin Center download**, select **Download now**.

1. Select your preference for sharing diagnostic data with Microsoft, then select **Next**.

1. In the **Installing Windows Admin Center** window, select the port that you want the Windows Admin Center site to use.  

>[!NOTE]
>The default port is 6516. The **Allow Windows Admin Center to modify this machine's trusted host settings** checkbox is selected by default. We recommend leaving this check box selected, but you can also deselect the box to disable this setting if you don't want Windows Admin Center to be able to modify your machine's trusted host settings.

1. Select **Install**. Windows Admin Center installation begins. 

1. In the One more thing window, select the correct certificate for Windows Admin Center to use. Select the option that's highlighted and then select **Finish**. 

1. Windows Admin Center should start automatically. 

You should now be able to see the name, machine type, and connection history of the machine you installed Windows Admin Center on listed on the **All connections** page at the top of the **Name** column.

---
::: zone-end

## Install Windows Admin Center on Windows 10

:::zone pivot="windows-client"

When you install Windows Admin Center on Windows 10, it uses port 6516 by default, but you have the option to specify a different port. You can also create a desktop shortcut and let Windows Admin Center manage your TrustedHosts.

To install Windows Admin Center on your Windows client machine:

1. Open [Windows Admin Center Evaluation Center](https://www.microsoft.com/evalcenter/download-windows-admin-center).

1. Under **Please select your Windows Admin Center download**, select **Download now**.

1. Select your preference for sharing diagnostic data with Microsoft, then select **Next**.

1. In the **Installing Windows Admin Center** window, select the port that you want the Windows Admin Center site to use.  

>[!NOTE]
>The default port is 6516. The **Allow Windows Admin Center to modify this machine's trusted host settings** checkbox is selected by default. We recommend leaving this check box selected, but you can also deselect the box to disable this setting if you don't want Windows Admin Center to be able to modify your machine's trusted host settings.

1. Select **Install**. Windows Admin Center installation begins. 

1. In the One more thing window, select the correct certificate for Windows Admin Center to use. Select the option that's highlighted and then select **Finish**. 

1. Windows Admin Center should start automatically. 

You should now be able to see the name, machine type, and connection history of the machine you installed Windows Admin Center on listed on the **All connections** page at the top of the **Name** column.

>[!NOTE]
> You must modify TrustedHosts in a workgroup environment or when you use local administrator credentials in a domain. If you choose to skip this setting, you must [configure TrustedHosts manually](../support/troubleshooting.md#configure-trustedhosts) instead.

When you start Windows Admin Center from the **Start** menu, it opens in your default browser.

When you start Windows Admin Center for the first time, you should see an icon in the notification area of your desktop. Right-click this icon and select **Open** to open the tool in your default browser. To stop the background process, select **Exit**.

---
::: zone-end

## Install on Windows Server with desktop experience

On Windows Server, you install Windows Admin Center as a network service. You must specify which port the service listens on and provide an HTTPS certificate. The installer can create a self-signed certificate for testing, or you can provide the thumbprint of a certificate already installed on the computer. If you use the generated certificate, its name matches the DNS name of the server. If you use your own certificate, make sure the name you give the certificate matches the machine name. Windows Admin Center doesn't support wildcard certificates. You can also configure a setting that lets Windows Admin Center manage your TrustedHosts.

> [!NOTE]
> You must modify TrustedHosts in a workgroup environment or when you use local administrator credentials in a domain. If you choose to skip this setting, you must [configure TrustedHosts manually](../support/troubleshooting.md#configure-trustedhosts) instead.

Once the install is complete, open a browser from a remote computer and navigate to URL presented in the last step of the installer.

> [!WARNING]
> Automatically generated certificates expire 60 days after installation.

## Install on Server Core

If you have a Server Core installation of Windows Server, you can install Windows Admin Center from the command prompt (running as Administrator). Specify a port and SSL certificate by using the `SME_PORT` and `SSL_CERTIFICATE_OPTION` arguments respectively. If you're going to use an existing certificate, use the `SME_THUMBPRINT` to specify its thumbprint.

> [!WARNING]
> Installing Windows Admin Center restarts the WinRM service, which disconnects all remote PowerShells sessions. We recommend you install from a local command prompt or PowerShell window. If you're using an automated solution to install the service that disconnects if the WinRM process restarts, you can add the parameter ```RESTART_WINRM=0``` to the install arguments.

Run the following command to install Windows Admin Center and automatically generate a self-signed certificate:

```cmd
msiexec /i <WindowsAdminCenterInstallerName>.msi /qn /L*v log.txt SME_PORT=<port> SSL_CERTIFICATE_OPTION=generate
```

Run the following command to install Windows Admin Center with an existing certificate:

```cmd
msiexec /i <WindowsAdminCenterInstallerName>.msi /qn /L*v log.txt SME_PORT=<port> SME_THUMBPRINT=<thumbprint> SSL_CERTIFICATE_OPTION=installed
```

> [!WARNING]
> Don't invoke `msiexec` from PowerShell using dot-slash relative path notation, such as `.\<WindowsAdminCenterInstallerName>.msi`. WIndows Admin Center doesn't support that type of path notation. You must either remove the `.\` prefix or specify the full path to the MSI.

## Upgrading to a new version of Windows Admin Center

Your settings are preserved when upgrading to a new version of Windows Admin Center. We don't officially support upgrading Insider Preview versions of Windows Admin Center - we think it's better to do a clean install - but we don't block it. 

The service saves your settings when you upgrade to the latest version of Windows Admin Center. However, this feature may not work as intended when upgrading Insider Preview versions of Windows Admin Center. When upgrading preview versions, we recommend starting over with a new installation instead.

## Updating the certificate used by Windows Admin Center

When you have Windows Admin Center deployed as a service, you must provide a certificate for HTTPS. To update this certificate at a later time, re-run the installer and select **Change**.