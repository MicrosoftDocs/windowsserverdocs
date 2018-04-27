---
title: Install Windows Admin Center
description: Install Windows Admin Center (Project Honolulu)
ms.technology: manage
ms.topic: article
author: nwashburn-ms
ms.author: niwashbu
ms.date: 04/05/2018
ms.localizationpriority: low
ms.prod: windows-server-threshold
---

# Install Windows Admin Center

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows 10

> [!Tip]
> New to Windows Admin Center?
> [Learn more about Windows Admin Center](../understand/windows-admin-center.md) or [Download now](https://aka.ms/wacdownload).

## Supported operating systems ##

You can install Windows Admin Center on the following Windows operating systems:

| **Version** | **Installation Mode** |
|-------------|-----------------------|
|Windows 10 (1709) | Desktop mode |
|Windows Server, version 1709 | Gateway mode |
|Windows Server 2016 | Gateway mode |
<!-- I removed all references to 1803 due to the date slip and an associated freeze of anything mentioning them. Will add back prior to RS4 GA -->
**Desktop Mode:** Connect to the Windows Admin Center gateway from the same computer on which it's installed (for example, `https://localhost:6516`)

**Gateway Mode:** Connect to the Windows Admin Center gateway from a client browser on a different machine (for example, `https://servername`)

## Install on Windows 10

When you install Windows Admin Center on Windows 10, it uses port 6516 by default, but you have the option to specify a different port. You can also create a desktop shortcut and let Windows Admin Center manage your TrustedHosts.

> [!NOTE]
> Modifying TrustedHosts is required in a workgroup environment, or when using local administrator credentials in a domain. If you choose to forego this setting, you must [configure TrustedHosts manually](../use/troubleshooting.md#configure-trustedhosts).

When you start Windows Admin Center from the **Start** menu, it opens in your default browser.

> [!IMPORTANT]
> Internet Explorer is not supported. If Internet Explorer is your default browser, copy the URL from Internet Explorer and paste it into Microsoft Edge.

When you start Windows Admin Center for the first time, you'll see an icon in the notification area of your desktop. Right-click this icon and choose **Open** to open the tool in your default browser, or choose **Exit** to quit the background process.

## Install on Windows Server 2016

<!-- I think this section only applies to Windows Server 2016, since 1709 and 1803 don't have/won't have anything but server core. -->
On Windows Server 2016, Windows Admin Center is installed as a network service. You must specify the port that the service listens on, and it requires a certificate for HTTPS. The installer can create a self-signed certificate for testing, or you can provide the thumbprint of a certificate already installed on the computer. If you use the generated certificate, it will match the DNS name of the server. If you use your own certificate, make sure to specify the name provided in the certificate. You are also given the choice to create a desktop shortcut and let Windows Admin Center manage your TrustedHosts.

> [!NOTE]
> Modifying TrustedHosts is required in a workgroup environment, or when using local administrator credentials in a domain. If you choose to forego this setting, you must [configure TrustedHosts manually](../use/troubleshooting.md#configure-trustedhosts)

If you install on Windows Server 2016 with Desktop Experience, you can create a desktop shortcut for all users in **C:\Users\Public\Desktop**.

Once the install is complete, start Windows Admin Center with the desktop shortcut, or open a browser and navigate to **https://'name of server':'port specified in setup'**.

> [!WARNING]
> Automatically generated certificates expire 60 days after installation.

## Install on Server Core

If you have a Server Core installation of Windows Server, you can install Windows Admin Center from the command prompt (running as Administrator). Specify a port and SSL certificate by using the `SME_PORT` and `SSL_CERTIFICATE_OPTION` arguments respectively. If you're going to use an existing certificate, use the `SME_THUMBPRINT` to specify its thumbprint.

> [!WARNING]
> Automatically generated certificates expire 60 days after installation.

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

## Update Windows Admin Center 

If you already have a previous version Windows Admin Center (or Project 'Honolulu' Technical Preview) The installer will detect and preserve your previous settings. 