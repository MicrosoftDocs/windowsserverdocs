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
ms.date: 09/21/2017
---

# Deploy Project Honolulu Gateway

>Applies To: Windows Server, Windows Server 2016 and Windows 10

This article describes the system requirements, prerequisites, and steps to install Honolulu on Windows 10 and Windows Server computers.

## Supported operating systems ##

 You can install Project Honolulu on the following Windows operating systems:

| **Version**| **Install Honolulu** | **Managed node** via Server Manager, and **managed cluster** via Failover Cluster Mgr | **Managed HCI cluster** via HC Cluster Mgr (early preview)|
|-------------------------|---------------|-----|------------------------|
| Windows 10              | Yes (local)   | N/A | N/A                    |
| Windows Server, version 1709| Yes (gateway) | Yes | Yes, on Insider builds |
| Windows Server 2016     | Yes (gateway) | Yes | Future                 |
| Windows Server 2012 R2  | No            | Yes | N/A                    |
| Windows Server 2012     | No            | Yes | N/A                    |

## Install on Windows 10

When installing on Windows 10, Project Honolulu will use port 6515 by default, but you have the option to specify a different port. You are also given the choice to create a desktop shortcut and let Project Honolulu mange your TrustedHosts.

> [!NOTE]
> Modifying TrustedHosts is required in a workgroup environment, or when using local administrator credentials in a domain. If you choose to forego this setting, you must [configure TrustedHosts manually](honolulu-troubleshoot.md#configure-trustedhosts).

If you check the box to launch on exit, Project Honolulu will open automatically in your default browser after it installs. Otherwise, you can find **Project 'Honolulu' (Technical Preview)** in your Windows Start Menu.

Launching from the Start Menu will open your default browser.

> [!IMPORTANT] 
> Internet Explorer is not supported in this release. If Internet Explorer is configured as the default browser, copy the URL from Internet Explorer and paste it into Microsoft Edge.

Once you have launched Project Honolulu, you will have an icon in the notification area of your desktop. Right-click this icon and choose **Open** to open the tool in your default browser, or choose **Exit** to quit the background process.

## Install on Windows Server and Windows Server 2016

On Windows Server and Windows Server 2016, Project Honolulu is installed as a network service. You must specify the port that the services listens on, and it requires a certificate for HTTPS. The installer can create a self-signed certificate for testing, or you can provide the thumbprint of a certificate already installed on the computer. If you use the generated certificate, it should match the DNS name of the server. If you used your own certificate, make sure to specify the name provided in the certificate. You are also given the choice to create a desktop shortcut and let Project Honolulu manage your TrustedHosts.

> [!NOTE]
> Modifying TrustedHosts is required in a workgroup environment, or when using local administrator credentials in a domain. If you choose to forego this setting, you must [configure TrustedHosts manually](honolulu-troubleshoot.md#configure-trustedhosts)

If you install on Windows Server with full desktop experience, you can choose the option to create a desktop shortcut that will be installed for all users in **C:\Users\Public\Desktop**.

Once the installer is complete, launch with the desktop shortcut, or open a browser and navigate to: **https://< name of server >:< port specified in setup >**.

> [!WARNING]
> Automatically generated certificates expire 60 days after installation.

## Install on Windows Server and Windows Server 2016 - Core configuration

On Windows Server Core and Windows Server 2016 Core, Project Honolulu can installed via a Command Prompt instance (running as Administrator). A port and SSL certificate option must be specified, via the `SME_PORT` and `SSL_CERTIFICATE_OPTION` arguments respectively. If configuring Project Honolulu with an existing certificate, the `SME_THUMBPRINT` argument must be used to specify its thumbprint. 

> [!WARNING]
> Automatically generated certificates expire 60 days after installation.

   To install Project Honolulu and automatically generate a self-signed certificate:
   
        msiexec /i ServerManagementGateway.msi /qn /l *v log.txt SME_PORT=<port>
        SSL_CERTIFICATE_OPTION=generate
   
   To install Project Honolulu with an existing certificate:

        msiexec /i ServerManagementGateway.msi /qn /l *v log.txt SME_PORT=<port>
        SME_THUMBPRINT=<thumbprint> SSL_CERTIFICATE_OPTION=installed
        
> [!WARNING] 
> Invoking `msiexec` from PowerShell using dot-slash relative path notation (e.g. `.\ServerManagementGateway.msi`) is not supported
> and will result in installation failure. Remove the `.\` prefix or specify the full path to the MSI.
