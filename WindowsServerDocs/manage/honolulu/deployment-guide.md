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
ms.date: 03/19/2018
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
    - `-certPassword`: Optional. A SecureString password for the certificate .pfx provided in `-certPath`
    - `-generateSslCert`: Optional. If you do not want to provide a signed certificate, include this parameter flag to generate a self-signed certificate. Note that the self-signed certificate will expire in 90 days. 
    - `-portNumber`: Optional. If no port is specified, the gateway service will be deployed on port 443 (HTTPS). If you wish to use a different port, specify in this parameter. Note that if you use a custom port (anything besides 443), you will access the Project Honolulu by visiting `https://<clientAccessPoint>:<port>`.

For example, to install with a signed certificate:

    C:\PS> $certPassword = Read-Host -AsSecureString
    C:\PS> .\Install-HonoluluHA.ps1 -clusterStorage C:\ClusterStorage\Volume1 -clientAccessPoint contoso-ha-gateway -msiPath '.\ServerManagementGateway.msi' -certPath cert.pfx -certPassword $certPassword

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

## Gateway Access Management

> [!NOTE] 
> Access management only applies when you are running Honolulu as a service on Windows Server.

**Gateway users** can connect to the Honolulu gateway service in order to manage servers through that gateway, but they cannot change access permissions nor the authentication mechanism used to authenticate to the gateway.

**Gateway administrators** can configure who gets access as well as how users will authenticate to the gateway. Only gateway administrators can view and configure the Access settings in Honolulu. Local administrators on the gateway machine are always administrators of the Honolulu gateway service.

> [!NOTE] 
> Access to the gateway does not imply access to managed servers visible by the gateway. To manage a target server, the connecting user must use credentials (either via their passed through Windows credential, or via credentials provided in the Honolulu session using the "Manage as" action) that are local administrators or part of the administrators group of that target server.

By default, any user that navigates to the gateway URL has access to the Honolulu service. Only local administrators on the gateway machine have administrator access to the Honolulu service.

Under the "Access" tab in Project Honolulu general settings, administrators can configure gateway access using Active Directory/local groups OR Azure Active Directory (AAD). By choosing AAD authentication for the gateway, you can leverage additional security features like conditional access and multi-factor authentication provided by AAD. 

### Active Directory or local machine groups

When you choose Active Directory or local machine groups as your identity provider for gateway access, you can manage gateway user and administrator access from within the Honolulu interface.

Under the "Users" tab, you can control who can access Honolulu as a gateway user. By default, and if no security groups are listed, any user that access the gateway URL has access. Once you add one or more security groups to the users list, access is restricted to the members of those groups.

You can enforce **smartcard authentication** by specifying an additional _required_ group for smartcard-based security groups. Once you have added a smartcard-based security group, a user will only have access to the Honolulu service if they are a member of any security group AND a smartcard group included in the users list.

Under the "Administrators" tab, you can control who can access Honolulu as a gateway administrator. The local administrators group on the machine will always have full administrator access and cannot be removed from the list. By adding security groups, you give members of those groups privileges to change Honolulu gateway settings. The administrators list supports smartcard authentication in the same way as the users list: with the AND condition for a security group and a smartcard group.

### Azure Active Directory

> [!NOTE]
> AAD authentication is supported in Project Honolulu version 1803, which is only available to Windows Insiders. To get access to this feature, [join the Windows Insider Program](https://insider.windows.com/for-business-getting-started-server/) and download Honolulu from [Windows Server Insider Preview](https://www.microsoft.com/software-download/windowsinsiderpreviewserver).

If you choose Azure Active Directory (AAD) as your identity provider, you will manage user and administrator access from the Azure Portal, rather from within the Honolulu UI.

To set up AAD, you must first [connect your gateway to Azure](#connect-your-gateway-to-azure) (you only need to do this once for your Honolulu gateway). This step creates an AAD application, from which you can manage gateway user and gateway administrator access.

By default, all members of the AAD tenant will have user access to the Honolulu gateway service. Only local administrators on the gateway machine will have administrator access to the Honolulu gateway.

If you want to give specific AAD users or groups gateway user or gateway administrator access to the Honolulu service, you must do the following:

1.	Go to your SME AAD application in the Azure portal. 
    -	When you click **Change access control** and then select **Azure Active Directory** from the Honolulu Access settings, you can use the hyperlink provided in the UI to access your AAD application in the Azure portal. This hyperlink is also available in the Access settings after you click save and have selected AAD as your access control identity provider.
    -	You can also find your application in the Azure portal by going to **Azure Active Directory** > **Enterprise applications** > **All applications** and searching **SME** (the AAD app will be named SME-<gateway>). If you don’t get any search results, ensure **Show** is set to **all applications**, **application status** is set to **any** and click Apply, then try your search. Once you’ve found the application, go to **Users and groups**
2.	In the Properties tab, set **User assignment required** to Yes.
    Once you’ve done this, only members listed in the Users and groups tab will be able to access the Honolulu gateway.
3.	In the Users and groups tab, select **Add user**. You must assign a gateway user or gateway administrator role for each user/group added.

Once you save the AAD access control in the “Change access control” pane, the gateway service will restart and you must refresh your browser. You can update user access for the SME AAD application in the Azure portal at any time. 

Users will now be prompted to login using their Azure Active Directory identity when they attempt to access the Honolulu gateway URL. From the Azure tab of Honolulu general settings, users and administrators can view their currently logged in account and as well as sign-out of this AAD account.

#### Conditional access and multi-factor authentication

One of the benefits of using Azure Active Directory as your identity provider for controlling access to the Honolulu gateway is that you can leverage AAD’s powerful security features like conditional access and multi-factor authentication. To set up conditional access, you can follow the [guidance here](https://docs.microsoft.com/azure/active-directory/active-directory-conditional-access-azure-portal-get-started).

## Connect your gateway to Azure

To allow the Honolulu gateway to communicate with Azure to leverage Azure Active Directory authentication for gateway access, or to create Azure resources on your behalf (e.g. to protect VMs managed in Honolulu using Azure Site Recovery), you must first connect your Honolulu gateway to Azure. This must only be done once for your Honolulu gateway and is preserved upon updating your gateway to a newer version.

To connect your gateway, you must run the [New-AadApp.ps1 PowerShell script](https://aka.ms/HonoluluAzureConnectScript) available for download (there is also a hyperlink in the Honolulu UI for this download), which creates a web application in Azure AD with the name “SME-<gateway>” and registers the application with the Honolulu gateway. This allows Honolulu to connect to Azure resources like AAD on your behalf. The script can be run from any machine that has access to the Honolulu gateway and to Azure, with the Honolulu gateway URL as the -GatewayEndpoint parameter. For example,

    PS> .\New-AadApp.ps1 -GatewayEndpoint "https://gateway.contoso.com"

If you are NOT using port 443, the GatewayEndpoint parameter should contain the port (i.e. https://myComputer:6516).

If there are multiple tenants associated with your Azure account, you can use the -TenantId parameter to specify the tenant in which you want to create the AAD application and associate with your Honolulu gateway. For example,

    PS> .\New-AadApp.ps1 -GatewayEndpoint "https://gateway.contoso.com" -TenantId "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

This script requires two Azure PowerShell modules: AzureRm.Resources and AzureAD. If you do not have these modules installed, execute the following commands in an elevated PowerShell console:

    PS C:>Install-Module AzureRM.Resources
    PS C:>Install-Module AzureAD

After running the script, you must refresh the browser page from which you are accessing the Honolulu gateway. 

### Other considerations

If you have already configured your gateway for Azure connectivity when setting up Azure Site Recovery and used the New-AsrAadApp.ps1 available in our documentation prior to the 1803 release, you will need to delete your existing AAD application by navigating to the Azure portal > **Azure Active Directory** > **Application registration** > **All applications** and searching “ASR” (the old AAD app will be named "ASR-Honolulu-*gateway*"). Then run the [New-AadApp.ps1 script](https://aka.ms/HonoluluAzureConnectScript) to create the replacement application with the correct permissions.