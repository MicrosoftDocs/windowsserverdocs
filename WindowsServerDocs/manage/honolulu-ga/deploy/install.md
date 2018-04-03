---
title: Install Windows Admin Center
description: "Install Windows Admin Center"
ms.technology: Windows Admin Center
ms.topic: article
author: nwashburn-ms
ms.author: niwashbu
ms.manager: samli
ms.date: 03/30/2018
---

# Install Windows Admin Center

## Install on Windows 10

When installing on Windows 10, Windows Admin Center will use port 6516 by default, but you have the option to specify a different port. You are also given the choice to create a desktop shortcut and let Windows Admin Center manage your TrustedHosts.

> [!NOTE]
> Modifying TrustedHosts is required in a workgroup environment, or when using local administrator credentials in a domain. If you choose to forego this setting, you must [configure TrustedHosts manually](honolulu-troubleshoot.md#configure-trustedhosts).

If you check the box to launch on exit, Windows Admin Center will open automatically in your default browser after it installs. Otherwise, you can find **Windows Admin Center** in your Windows Start Menu.

Launching from the Start Menu will open your default browser.

> [!IMPORTANT] 
> Internet Explorer is not supported. If Internet Explorer is configured as the default browser, copy the URL from Internet Explorer and paste it into Microsoft Edge.

Once you have launched Windows Admin Center, you will have an icon in the notification area of your desktop. Right-click this icon and choose **Open** to open the tool in your default browser, or choose **Exit** to quit the background process.

## Install on Windows Server and Windows Server 2016

On Windows Server and Windows Server 2016, Windows Admin Center is installed as a network service. You must specify the port that the services listens on, and it requires a certificate for HTTPS. The installer can create a self-signed certificate for testing, or you can provide the thumbprint of a certificate already installed on the computer. If you use the generated certificate, it will match the DNS name of the server. If you used your own certificate, make sure to specify the name provided in the certificate. You are also given the choice to create a desktop shortcut and let Windows Admin Center manage your TrustedHosts.

> [!NOTE]
> Modifying TrustedHosts is required in a workgroup environment, or when using local administrator credentials in a domain. If you choose to forego this setting, you must [configure TrustedHosts manually](honolulu-troubleshoot.md#configure-trustedhosts)

If you install on Windows Server with full desktop experience, you can choose the option to create a desktop shortcut that will be installed for all users in **C:\Users\Public\Desktop**.

Once the installer is complete, launch with the desktop shortcut, or open a browser and navigate to: **https://< name of server >:< port specified in setup >**.

> [!WARNING]
> Automatically generated certificates expire 60 days after installation.

## Install on Windows Server and Windows Server 2016 - Core configuration

On Windows Server Core and Windows Server 2016 Core, Windows Admin Center can installed via a Command Prompt instance (running as Administrator). A port and SSL certificate option must be specified, via the `SME_PORT` and `SSL_CERTIFICATE_OPTION` arguments respectively. If configuring Windows Admin Center with an existing certificate, the `SME_THUMBPRINT` argument must be used to specify its thumbprint. 

> [!WARNING]
> Automatically generated certificates expire 60 days after installation.

   To install Windows Admin Center and automatically generate a self-signed certificate:
   
        msiexec /i <WindowsAdminCenterInstallerName>.msi /qn /L*v log.txt SME_PORT=<port> SSL_CERTIFICATE_OPTION=generate
   
   To install Windows Admin Center with an existing certificate:

        msiexec /i <WindowsAdminCenterInstallerName>.msi /qn /L*v log.txt SME_PORT=<port> SME_THUMBPRINT=<thumbprint> SSL_CERTIFICATE_OPTION=installed
        
> [!WARNING] 
> Invoking `msiexec` from PowerShell using dot-slash relative path notation (e.g. `.\<WindowsAdminCenterInstallerName>.msi`) is not supported
> and will result in installation failure. Remove the `.\` prefix or specify the full path to the MSI.
