---
title: Install Windows Admin Center
description: How to install Windows Admin Center on a Windows PC or on a server so that multiple users can access Windows Admin Center using a web browser.
ms.technology: manage
ms.topic: article
author: jwwool
ms.author: jeffrew
ms.date: 07/17/2019
ms.localizationpriority: medium
ms.prod: windows-server-threshold
---
# Install Windows Admin Center

> Applies to: Windows Admin Center, Windows Admin Center Preview

This topic describes how to install Windows Admin Center on a Windows PC or on a server so that multiple users can access Windows Admin Center using a web browser.

> [!Tip]
> New to Windows Admin Center?
> [Learn more about Windows Admin Center](../understand/windows-admin-center.md) or [Download now](https://aka.ms/windowsadmincenter).

## Determine your installation type

Review the [installation options](../plan/installation-options.md) which includes the [supported operating systems](../plan/installation-options.md#supported-operating-systems-installation). To install Windows Admin Center on a VM in Azure, see [Deploy Windows Admin Center in Azure](../azure/deploy-wac-in-azure.md).

## Install on Windows 10

When you install Windows Admin Center on Windows 10, it uses port 6516 by default, but you have the option to specify a different port. You can also create a desktop shortcut and let Windows Admin Center manage your TrustedHosts.

> [!NOTE]
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
