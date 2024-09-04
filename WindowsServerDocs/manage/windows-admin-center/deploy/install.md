---
title: Install Windows Admin Center
description: How to install Windows Admin Center on a Windows PC or on a server so that multiple users can access Windows Admin Center using a web browser.
ms.topic: article
author: gswashington
ms.author: robinharwood
ms.date: 09/30/2024
zone_pivot_groups: zone_pivot_groups: windows-os
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

:::zone pivot="windows-server 2025"

### [Server Core](#tab/server-core)

To install Windows Admin Center on your machine running Windows Server 2025 (preview) Server Core installation:

1. Go to go [Windows Admin Center Evaluation Center](https://www.microsoft.com/evalcenter/download-windows-admin-center).
1. On the Please select your Windows Admin Center download, in the Windows Admin Center box, click **Download now**.
1. Select your preference for sharing diagnostic data with Microsoft and click **Next**.
1. In the Installing Windows Admin Center window, select the port that you want the Windows Admin Center site to use. The default port is 6516. The Allow Windows Admin Center to modify this machine's trusted host settings box is selected by default (recommended). Deselect this box if you don't want Windows Admin Center to be able to modify your machine's trusted host settings.
1. Click **Install**. Windows Admin Center installation begins. 
1. In the One more thing window, select the correct certificate for Windows Admin Center to use. Select the highlighted option and then click **Finish**. 
1. Windows Admin Center should start automatically. 

You should see the name of the machine you installed Windows Admin Center n listed on the All connections page at the top of the Name column, along with machine type and data on connection history.

### [Desktop Experience](#tab/desktop-experience)

To install Windows Admin Center on your machine running Windows Server 2025 (preview) Desktop Experience installation:

1. Search for Windows Admin Center by typing “admin” in Start.
1. Select the Windows Admin Center Setup app from the Best match list.
1. Click **Run as administrator**. The Get started with Windows Admin Center window opens.
1. Click **Next** to accept the license terms. The Install Windows Admin Center window opens and the Installer download begins.
1. When installation is done, click **Install**.
1. On the License Agreement, select I accept the agreement and then click **Next**. The installation will begin.
1. In the Select installation mode window, select Express local setup and then click **Next**.

You must select what Transport Layer Security (TLS) certificate Windows Admin Center should use. If you already have an official certificate, it must be installed in the LocalMachine\My certificate store. If you are installing Windows Admin Center for testing purposes only, the installer can generate a self-signed certificate that will expire after 60 days.

1. In the Select TLS certificate window, select the option that matches your needs and then click **Next**.
1. In the Automatic updates window, select your preferred update option and then click **Next**.  
1. In the Send diagnostic data to Microsoft window, select your preference and then click **Next**.
1. Select Shortcut and Desktop shortcut preferences and then click **Next**.
1. In the Ready to install window, click **Install**. Installation begins.
1. When install is complete, select Start Windows Admin Center and then click **Finish**. The Sign in to Windows Admin Center page opens. 
1. Sign in as Administrator and then click **Sign In**. Windows Admin Center starts.

You should see the name of the machine you installed Windows Admin Center On the All connections page at the top of the Name column, along with machine type and data on connection history.

---

::: zone-end

## Windows Server 2022 and earlier

:::zone pivot="windows-server 2022 and earlier"

### [Server Core](#tab/server-core)

To install Windows Admin Center on your Windows Server 2022 and earlier versions running Server Core installation:

1. Go to go [Windows Admin Center Evaluation Center](https://www.microsoft.com/evalcenter/download-windows-admin-center).
1. On the Please select your Windows Admin Center download, in the Windows Admin Center box, click **Download now**.
1. Select your preference for sharing diagnostic data with Microsoft and click **Next**.
1. In the Installing Windows Admin Center window, select the port that you want the Windows Admin Center site to use. The default port is 6516. The Allow Windows Admin Center to modify this machine's trusted host settings box is selected by default (recommended). Deselect this box if you don't want Windows Admin Center to be able to modify your machine's trusted host settings.
1. Click **Install**. Windows Admin Center installation begins. 
1. In the One more thing window, select the correct certificate for Windows Admin Center to use. Select the highlighted option and then click **Finish**. 
1. Windows Admin Center should start automatically. 

You should see the name of the machine you installed Windows Admin Center n listed on the All connections page at the top of the Name column, along with machine type and data on connection history.

1. Go to go [Windows Admin Center Evaluation Center](https://www.microsoft.com/evalcenter/download-windows-admin-center).
1. On the Please select your Windows Admin Center download, in the Windows Admin Center box, click **Download now**.
1. Select your preference for sharing diagnostic data with Microsoft and click **Next**.
1. In the Installing Windows Admin Center window, select the port that you want the Windows Admin Center site to use. The default port is 6516. The Allow Windows Admin Center to modify this machine's trusted host settings box is selected by default (recommended). Deselect this box if you don't want Windows Admin Center to be able to modify your machine's trusted host settings.
1. Click **Install**. Windows Admin Center installation begins. 
1. In the One more thing window, select the correct certificate for Windows Admin Center to use. Select the highlighted option and then click **Finish**. 
1. Windows Admin Center should start automatically. 

You should see the name of the machine you installed Windows Admin Center n listed on the All connections page at the top of the Name column, along with machine type and data on connection history.

### [Desktop Experience](#tab/desktop-experience)

To install Windows Admin Center on your Windows Server 2022 and earlier versions running Desktop Experience installation:

1. Go to go [Windows Admin Center Evaluation Center](https://www.microsoft.com/evalcenter/download-windows-admin-center).
1. On the Please select your Windows Admin Center download, in the Windows Admin Center box, click **Download now**.
1. Select your preference for sharing diagnostic data with Microsoft and click **Next**.
1. In the Installing Windows Admin Center window, select the port that you want the Windows Admin Center site to use. The default port is 6516. The Allow Windows Admin Center to modify this machine's trusted host settings box is selected by default (recommended). Deselect this box if you don't want Windows Admin Center to be able to modify your machine's trusted host settings.
1. Click **Install**. Windows Admin Center installation begins. 
1. In the One more thing window, select the correct certificate for Windows Admin Center to use. Select the highlighted option and then click **Finish**. 
1. Windows Admin Center should start automatically. 

You should see the name of the machine you installed Windows Admin Center n listed on the All connections page at the top of the Name column, along with machine type and data on connection history.

---
::: zone-end

## Install Windows Admin Center on Windows 10

:::zone pivot="windows-client"

When you install Windows Admin Center on Windows 10, it uses port 6516 by default, but you have the option to specify a different port. You can also create a desktop shortcut and let Windows Admin Center manage your TrustedHosts.

To install Windows Admin Center on your Windows client machine:

1. Go to go [Windows Admin Center Evaluation Center](https://www.microsoft.com/evalcenter/download-windows-admin-center).
1. On the Please select your Windows Admin Center download, in the Windows Admin Center box, click **Download now**.
1. Select your preference for sharing diagnostic data with Microsoft and click **Next**.
1. In the Installing Windows Admin Center window, select the port that you want the Windows Admin Center site to use. The default port is 6516. The Allow Windows Admin Center to modify this machine's trusted host settings box is selected by default (recommended). Deselect this box if you don't want Windows Admin Center to be able to modify your machine's trusted host settings.
1. Click **Install**. Windows Admin Center installation begins. 
1. In the One more thing window, select the correct certificate for Windows Admin Center to use. Select the highlighted option and then click **Finish**. 
1. Windows Admin Center should start automatically. 

You should see the name of the machine you installed Windows Admin Center n listed on the All connections page at the top of the Name column, along with machine type and data on connection history.

>[!NOTE]
> Modifying TrustedHosts is required in a workgroup environment, or when using local administrator credentials in a domain. If you choose to forego this setting, you must [configure TrustedHosts manually](../support/troubleshooting.md#configure-trustedhosts).

When you start Windows Admin Center from the **Start** menu, it opens in your default browser.

When you start Windows Admin Center for the first time, you'll see an icon in the notification area of your desktop. Right-click this icon and choose **Open** to open the tool in your default browser, or choose **Exit** to quit the background process.

## Install on Windows Server with desktop experience

On Windows Server, Windows Admin Center is installed as a network service. You must specify the port that the service listens on, and it requires a certificate for HTTPS. The installer can create a self-signed certificate for testing, or you can provide the thumbprint of a certificate already installed on the computer. If you use the generated certificate, it will match the DNS name of the server. If you use your own certificate, make sure the name provided in the certificate matches the machine name (wildcard certificates are not supported.) You are also given the choice to let Windows Admin Center manage your TrustedHosts.

> [!NOTE]
> Modifying TrustedHosts is required in a workgroup environment, or when using local administrator credentials in a domain. If you choose to forego this setting, you must [configure TrustedHosts manually](../support/troubleshooting.md#configure-trustedhosts)

Once the install is complete, open a browser from a remote computer and navigate to URL presented in the last step of the installer.

> [!WARNING]
> Automatically generated certificates expire 60 days after installation.

## Install on Server Core

If you have a Server Core installation of Windows Server, you can install Windows Admin Center from the command prompt (running as Administrator). Specify a port and SSL certificate by using the `SME_PORT` and `SSL_CERTIFICATE_OPTION` arguments respectively. If you're going to use an existing certificate, use the `SME_THUMBPRINT` to specify its thumbprint.

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
> Don't invoke `msiexec` from PowerShell using dot-slash relative path notation (like,  `.\<WindowsAdminCenterInstallerName>.msi`). That notation isn't supported, the installation will fail. Remove the `.\` prefix or specify the full path to the MSI.

## Upgrading to a new version of Windows Admin Center

You can update non-preview versions of Windows Admin Center by using Microsoft Update or by manually installing.

Your settings are preserved when upgrading to a new version of Windows Admin Center. We don't officially support upgrading Insider Preview versions of Windows Admin Center - we think it's better to do a clean install - but we don't block it.

## Updating the certificate used by Windows Admin Center

When you have Windows Admin Center deployed as a service, you must provide a certificate for HTTPS. To update this certificate at a later time, re-run the installer and choose ```change```.

1. Go to go [Windows Admin Center Evaluation Center](https://www.microsoft.com/evalcenter/download-windows-admin-center).
1. On the Please select your Windows Admin Center download, in the Windows Admin Center box, click **Download now**.
1. Select your preference for sharing diagnostic data with Microsoft and click **Next**.
1. In the Installing Windows Admin Center window, select the port that you want the Windows Admin Center site to use. The default port is 6516. The Allow Windows Admin Center to modify this machine's trusted host settings box is selected by default (recommended). Deselect this box if you don't want Windows Admin Center to be able to modify your machine's trusted host settings.
1. Click **Install**. Windows Admin Center installation begins. 
1. In the One more thing window, select the correct certificate for Windows Admin Center to use. Select the highlighted option and then click **Finish**. 
1. Windows Admin Center should start automatically. 

You should see the name of the machine you installed Windows Admin Center n listed on the All connections page at the top of the Name column, along with machine type and data on connection history.

1. Go to go [Windows Admin Center Evaluation Center](https://www.microsoft.com/evalcenter/download-windows-admin-center).
1. On the Please select your Windows Admin Center download, in the Windows Admin Center box, click **Download now**.
1. Select your preference for sharing diagnostic data with Microsoft and click **Next**.
1. In the Installing Windows Admin Center window, select the port that you want the Windows Admin Center site to use. The default port is 6516. The Allow Windows Admin Center to modify this machine's trusted host settings box is selected by default (recommended). Deselect this box if you don't want Windows Admin Center to be able to modify your machine's trusted host settings.
1. Click **Install**. Windows Admin Center installation begins. 
1. In the One more thing window, select the correct certificate for Windows Admin Center to use. Select the highlighted option and then click **Finish**. 
1. Windows Admin Center should start automatically. 

You should see the name of the machine you installed Windows Admin Center n listed on the All connections page at the top of the Name column, along with machine type and data on connection history.

### [Desktop Experience](#tab/desktop-experience)

To install Windows Admin Center on your Windows Server 2022 and earlier versions running Desktop Experience installation:

1. Go to go [Windows Admin Center Evaluation Center](https://www.microsoft.com/evalcenter/download-windows-admin-center).
1. On the Please select your Windows Admin Center download, in the Windows Admin Center box, click **Download now**.
1. Select your preference for sharing diagnostic data with Microsoft and click **Next**.
1. In the Installing Windows Admin Center window, select the port that you want the Windows Admin Center site to use. The default port is 6516. The Allow Windows Admin Center to modify this machine's trusted host settings box is selected by default (recommended). Deselect this box if you don't want Windows Admin Center to be able to modify your machine's trusted host settings.
1. Click **Install**. Windows Admin Center installation begins. 
1. In the One more thing window, select the correct certificate for Windows Admin Center to use. Select the highlighted option and then click **Finish**. 
1. Windows Admin Center should start automatically. 

You should see the name of the machine you installed Windows Admin Center n listed on the All connections page at the top of the Name column, along with machine type and data on connection history.

---
::: zone-end

## Install Windows Admin Center on Windows 10

:::zone pivot="windows-client"

When you install Windows Admin Center on Windows 10, it uses port 6516 by default, but you have the option to specify a different port. You can also create a desktop shortcut and let Windows Admin Center manage your TrustedHosts.

To install Windows Admin Center on your Windows client machine:

1. Go to go [Windows Admin Center Evaluation Center](https://www.microsoft.com/evalcenter/download-windows-admin-center).
1. On the Please select your Windows Admin Center download, in the Windows Admin Center box, click **Download now**.
1. Select your preference for sharing diagnostic data with Microsoft and click **Next**.
1. In the Installing Windows Admin Center window, select the port that you want the Windows Admin Center site to use. The default port is 6516. The Allow Windows Admin Center to modify this machine's trusted host settings box is selected by default (recommended). Deselect this box if you don't want Windows Admin Center to be able to modify your machine's trusted host settings.
1. Click **Install**. Windows Admin Center installation begins. 
1. In the One more thing window, select the correct certificate for Windows Admin Center to use. Select the highlighted option and then click **Finish**. 
1. Windows Admin Center should start automatically. 

You should see the name of the machine you installed Windows Admin Center n listed on the All connections page at the top of the Name column, along with machine type and data on connection history.

>[!NOTE]
> Modifying TrustedHosts is required in a workgroup environment, or when using local administrator credentials in a domain. If you choose to forego this setting, you must [configure TrustedHosts manually](../support/troubleshooting.md#configure-trustedhosts).

When you start Windows Admin Center from the **Start** menu, it opens in your default browser.

When you start Windows Admin Center for the first time, you'll see an icon in the notification area of your desktop. Right-click this icon and choose **Open** to open the tool in your default browser, or choose **Exit** to quit the background process.

## Install on Windows Server with desktop experience

On Windows Server, Windows Admin Center is installed as a network service. You must specify the port that the service listens on, and it requires a certificate for HTTPS. The installer can create a self-signed certificate for testing, or you can provide the thumbprint of a certificate already installed on the computer. If you use the generated certificate, it will match the DNS name of the server. If you use your own certificate, make sure the name provided in the certificate matches the machine name (wildcard certificates are not supported.) You are also given the choice to let Windows Admin Center manage your TrustedHosts.

> [!NOTE]
> Modifying TrustedHosts is required in a workgroup environment, or when using local administrator credentials in a domain. If you choose to forego this setting, you must [configure TrustedHosts manually](../support/troubleshooting.md#configure-trustedhosts)

Once the install is complete, open a browser from a remote computer and navigate to URL presented in the last step of the installer.

> [!WARNING]
> Automatically generated certificates expire 60 days after installation.

## Install on Server Core

If you have a Server Core installation of Windows Server, you can install Windows Admin Center from the command prompt (running as Administrator). Specify a port and SSL certificate by using the `SME_PORT` and `SSL_CERTIFICATE_OPTION` arguments respectively. If you're going to use an existing certificate, use the `SME_THUMBPRINT` to specify its thumbprint.

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
> Don't invoke `msiexec` from PowerShell using dot-slash relative path notation (like,  `.\<WindowsAdminCenterInstallerName>.msi`). That notation isn't supported, the installation will fail. Remove the `.\` prefix or specify the full path to the MSI.

## Upgrading to a new version of Windows Admin Center

You can update non-preview versions of Windows Admin Center by using Microsoft Update or by manually installing.

Your settings are preserved when upgrading to a new version of Windows Admin Center. We don't officially support upgrading Insider Preview versions of Windows Admin Center - we think it's better to do a clean install - but we don't block it.

## Updating the certificate used by Windows Admin Center

When you have Windows Admin Center deployed as a service, you must provide a certificate for HTTPS. To update this certificate at a later time, re-run the installer and choose ```change```.
