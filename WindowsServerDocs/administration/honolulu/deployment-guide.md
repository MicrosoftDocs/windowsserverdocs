---
title: Deploy Project Honolulu Gateway
description: "Deploy Honolulu to manage Windows Server"
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: Honolulu
ms.tgt_pltfrm: na
ms.topic:
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 09/10/2017
---

# Deploy Project Honolulu Gateway

>Applies To: Windows Server, Windows Server 2016 and Windows 10

This article describes the System requirements, prerequisites, and steps to install Honolulu on Windows Server and Windows 10 computers.

## <a name="supported-operating-systems"></a>System requirements

 You can install Honolulu on the following Windows operating systems:

| **Version**             | **Gateway Service**   | **Managed Node** |
|-------------------------|-----------------------|------------------|
| Windows 10              | Yes (local user only) | No               |
| Windows Server          | Yes                   | Yes              |
| Windows Server 2016     | Yes                   | Yes              |
| Windows Server 2012 R2  | No                    | Yes              |
| Windows Server 2012     | No                    | Yes              |

## Install on Windows 10

When installing on Windows 10, Honolulu will use port 6515 by default, but you have the option to specify a different port. You are also given the choice to create a desktop shortcut and let Project Honolulu mange your TrustedHosts.

> [!NOTE]
> Modifying TrustedHosts is required in a workgroup environment, or when using local administrator credentials in a domain. If you choose to forego this setting, you must [configure TrustedHosts manually](honolulu-troubleshoot.md#configure-trustedhosts).

If you check the box to launch on exit, Honolulu will open automatically in your default browser after it installs. Otherwise, you can find **Project 'Honolulu' (Private Preview)** in your windows start menu:

![](../media/honolulu/start-icon.png) 

Launching from the start menu will open your default browser.

> [!IMPORTANT] 
> Internet Explorer is not supported in this release, if IE is your default browser, copy the URL from IE and paste it into Edge or Chrome.

Once you have launched Honolulu, you will have an icon in the system tray notification area of your desktop. Right-click this icon and choose **Open** to open the tool in your default browser, or choose **Exit** to quit the background process.

## Install on Windows Server and Windows Server 2016

On Windows Server 2016, Honolulu is installed as a network service. You must specify the port that the services listens on, and it requires a certificate for HTTPS. The installer can create a self-signed certificate for testing, or you can provide the thumbprint of a certificate already installed on the computer. If you use the generated certificate, it should match the DNS name of the server. If you used your own certificate, make sure to specify the name provided in the certificate. You are also given the choice to create a desktop shortcut and let Project Honolulu manage your TrustedHosts.

> [!NOTE]
> Modifying TrustedHosts is required in a workgroup environment, or when using local administrator credentials in a domain. If you choose to forego this setting, you must [configure TrustedHosts manually](honolulu-troubleshoot.md#configure-trustedhosts)

If you install on Windows Server with full desktop experience, you can choose the option to create a desktop shortcut that will be installed for all users in **C:\Users\Public\Desktop**.

Once the installer is complete, launch with the desktop shortcut, or open a browser and navigate to: **https://< name of server >:< port specified in setup >**.

## Install on Windows Server and Windows Server 2016 - Server Core configuration

> [!WARNING] 
> If you are using PowerShell, and the autocomplete adds ‘.’ to the name of the msi, it may cause the installer to fail.

Use the following commands from an Administrator prompt on the Windows Server Core machine to specify the SSL certificate:

   **Generate a self-signed SSL certificate**

        msiexec /i ServerManagementGateway.msi /qn /l *v log.txt SME_PORT=<port>
        SSL_CERTIFICATE_OPTION=generate
    
   **-- OR --** 

   **Specify a previously installed SSL certificate**

        msiexec /i ServerManagementGateway.msi /qn /l *v log.txt SME_PORT=<port>
        SME_THUMBPRINT=<thumbprint> SSL_CERTIFICATE_OPTION=installed

