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
ms.date: 01/31/2018
ms.localizationpriority: low
---

# Deploy Project Honolulu Gateway

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016 and Windows 10

This article describes the system requirements, prerequisites, and steps to install Honolulu on Windows 10 and Windows Server computers.

## Supported operating systems ##

You can *install* Honolulu on the following Windows operating systems:

| **Version** | **Installation Mode** |
|-------------|-----------------------|
|Windows 10   | Desktop mode |
|Windows Server, version 1709 | Gateway mode |
|Windows Server 2016 | Gateway mode |

**Desktop Mode:** Connect to the Honolulu gateway from the same computer on which it's installed (i.e. `http://localhost:[port]`)

**Gateway Mode:** Connect to the Honolulu  gateway from a client browser on a different machine (i.e. `https://servername`)

## Install on Windows 10

When installing on Windows 10, Project Honolulu will use port 6516 by default, but you have the option to specify a different port. You are also given the choice to create a desktop shortcut and let Project Honolulu manage your TrustedHosts.

> [!NOTE]
> Modifying TrustedHosts is required in a workgroup environment, or when using local administrator credentials in a domain. If you choose to forego this setting, you must [configure TrustedHosts manually](honolulu-troubleshoot.md#configure-trustedhosts).

If you check the box to launch on exit, Project Honolulu will open automatically in your default browser after it installs. Otherwise, you can find **Project 'Honolulu' (Technical Preview)** in your Windows Start Menu.

Launching from the Start Menu will open your default browser.

> [!IMPORTANT] 
> Internet Explorer is not supported. If Internet Explorer is configured as the default browser, copy the URL from Internet Explorer and paste it into Microsoft Edge.

Once you have launched Project Honolulu, you will have an icon in the notification area of your desktop. Right-click this icon and choose **Open** to open the tool in your default browser, or choose **Exit** to quit the background process.

## Install on Windows Server and Windows Server 2016

On Windows Server and Windows Server 2016, Project Honolulu is installed as a network service. You must specify the port that the services listens on, and it requires a certificate for HTTPS. The installer can create a self-signed certificate for testing, or you can provide the thumbprint of a certificate already installed on the computer. If you use the generated certificate, it will match the DNS name of the server. If you used your own certificate, make sure to specify the name provided in the certificate. You are also given the choice to create a desktop shortcut and let Project Honolulu manage your TrustedHosts.

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
   
        msiexec /i <HonoluluInstallerName>.msi /qn /L*v log.txt SME_PORT=<port> SSL_CERTIFICATE_OPTION=generate
   
   To install Project Honolulu with an existing certificate:

        msiexec /i <HonoluluInstallerName>.msi /qn /L*v log.txt SME_PORT=<port> SME_THUMBPRINT=<thumbprint> SSL_CERTIFICATE_OPTION=installed
        
> [!WARNING] 
> Invoking `msiexec` from PowerShell using dot-slash relative path notation (e.g. `.\<HonoluluInstallerName>.msi`) is not supported
> and will result in installation failure. Remove the `.\` prefix or specify the full path to the MSI.


## Deploy Project Honolulu with high availability
> [!NOTE]
> High availability deployment is supported in Project Honolulu version 1802. This version is currently available only to Windows Insiders and will be made available to the public early March. To get access to this feature now, [join the Windows Insider Program](https://insider.windows.com/for-business-getting-started-server/) and download Honolulu from [Windows Server Insider Preview](https://www.microsoft.com/software-download/windowsinsiderpreviewserver).

You can deploy Project Honolulu in a failover cluster to provide high availability of your Honolulu gateway service. The solution provided is an active-passive solution, where only one instance of Honolulu is active. If one of the nodes in the cluster fails, Project Honolulu gracefully fails over to another node, letting you continue managing the servers in your environment seamlessly. 

### Install Project Honolulu on a failover cluster

#### Prerequisites
- A Failover Cluster of 2 or more nodes on Windows Server 2016. [Learn more about deploying a Failover Cluster](https://docs.microsoft.com/en-us/windows-server/failover-clustering/failover-clustering-overview).
- A Cluster Shared Volume (CSV) for Project Honolulu to store persistent data that can be accessed by all the nodes in the cluster. 10 GB will be sufficient for your CSV.
- High-availability deployment scripts from [Honolulu HA Setup Scripts zipfile](http://aka.ms/HonoluluHASetupScripts). You can download the .zip file containing these scripts to a node on the cluster or to your local machine and then copy the scripts as needed based on the guidance below.
- Recommended, but optional: a signed certificate .pfx & password. You do not need to have already installed the certificate on to the cluster nodes – the script will do that for you. If you do not supply one, the installation script will generate a self-signed certificate, which expires after 90 days.

#### Installation
1.	Copy the Install-HonoluluHA.ps1 script to a node in your cluster. Download or copy the Project Honolulu .msi to the same node.
2.	Run the Install-HonoluluHA.ps1 script with the following parameters:
    - `-clusterStorage`: the local path of the Cluster Shared Volume to store Project Honolulu data 
    - `-clientAccessPoint`: choose a name that you will use to access Project Honolulu. For example, if you run the script with the parameter `-clientAccessPoint contosoHonolulu`, you will access the Project Honolulu service by visiting `https://contosoHonolulu.<domain>.com`
    - `-msiPath`: The path for the Project Honolulu .msi file.
    - `-certPath`: Optional. The path for a certificate .pfx file. 
    - `-certPassword`: Optional. The password for the certificate .pfx provided in `-certPath`
    - `-generateSslCert`: Optional. If you do not want to provide a signed certificate, include this parameter flag to generate a self-signed certificate. Note that the self-signed certificate will expire in 90 days. 
    - `-portNumber`: Optional. If no port is specified, the gateway service will be deployed on port 443 (HTTPS). If you wish to use a different port, specify in this parameter. Note that if you use a custom port (anything besides 443), you will access the Project Honolulu by visiting `https://<clientAccessPoint>:<port>`.

For example, to install with a signed certificate:

    C:\PS> .\Install-HonoluluHA.ps1 -clusterStorage C:\ClusterStorage\Volume1 -clientAccessPoint contoso-ha-gateway -msiPath '.\ServerManagementGateway.msi' -certPath cert.pfx -certPassword certPassword

And to install with a self-signed certificate:
    
    C:\PS> .\Install-HonoluluHA.ps1 -clusterStorage C:\ClusterStorage\Volume1 -clientAccessPoint contoso-ha-gateway -msiPath '.\ServerManagementGateway.msi' -generateSslCert

#### Troubleshooting
Installation logs are saved in the temp folder of the Cluster Shared Volume (e.g. C:\ClusterStorage\Volume1\temp)

### Update an existing HA installation
You can update your HA installation when a newer version of Honolulu is released, without losing your connection data saved in Project Honolulu.
1.	Copy the Update-HonoluluHA.ps1 script to a node in the Failover Cluster where Honolulu is deployed. Copy the new Honolulu .msi to the same node. 
2.	Run the Update-HonoluluHA.ps1 script with the parameter -msiPath, the path for the Project Honolulu .msi file.
    
    For example:
    
        C:\PS> .\Update-HonoluluHA.ps1 -msiPath '.\ServerManagementGateway.msi'

### Uninstall the Honolulu gateway from your failover cluster
The Uninstall-HonoluluHA.ps1 script uninstalls Honolulu from all the nodes on your failover cluster. 
1.	Run the Uninstall-HonoluluHA.ps1 on a node in the Failover Cluster where Honolulu is deployed. No parameters are needed.