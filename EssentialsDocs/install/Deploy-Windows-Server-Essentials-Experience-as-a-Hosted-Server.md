---
title: "Deploy Windows Server Essentials Experience as a Hosted Server"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a455c6b4-b29f-4f76-8c6b-1578b6537717
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Deploy Windows Server Essentials Experience as a Hosted Server

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

This document includes information that is specific to hosters who intend to deploy Microsoft Windows Server 16 with the Windows Server Essentials Experience role (referred to as Windows Server Essentials in the remainder of the document) installed in their lab and intend to offer Windows Server Essentials Experience as a service to their customers. This document includes the following sections:  
  

-   [Windows Server Essentials Experience overview](Deploy-Windows-Server-Essentials-Experience-as-a-Hosted-Server.md#BKMK_WSEEOverview)  
  
-   [Benefits of hosting Windows Server Essentials Experience](Deploy-Windows-Server-Essentials-Experience-as-a-Hosted-Server.md#BKMK_Benefits)  
  
-   [Supported deployment options](Deploy-Windows-Server-Essentials-Experience-as-a-Hosted-Server.md#BKMK_SupportedDeployment)  
  
-   [Supported network topologies](Deploy-Windows-Server-Essentials-Experience-as-a-Hosted-Server.md#BKMK_SupportedToplogy)  
  
-   [Customize the image of Windows Server Essentials Experience role](Deploy-Windows-Server-Essentials-Experience-as-a-Hosted-Server.md#BKMK_CustomizeImage)  
  
-   [Automate the deployment of Windows Server Essentials Experience](Deploy-Windows-Server-Essentials-Experience-as-a-Hosted-Server.md#BKMK_AutomateDeployment)  
  
-   [Migrate data from Windows Small Business Server to Windows Server Essentials Experience](Deploy-Windows-Server-Essentials-Experience-as-a-Hosted-Server.md#BKMK_Migrate)  
  
-   [Perform common tasks by using Windows PowerShell](Deploy-Windows-Server-Essentials-Experience-as-a-Hosted-Server.md#BKMK_PowerShell)  
  
-   [Email integration with Windows Server Essentials](Deploy-Windows-Server-Essentials-Experience-as-a-Hosted-Server.md#BKMK_EmailIntegration)  
  
-   [Monitor and manage by using native tools](Deploy-Windows-Server-Essentials-Experience-as-a-Hosted-Server.md#BKMK_Monitoring)  
  
-   [Test scenarios](Deploy-Windows-Server-Essentials-Experience-as-a-Hosted-Server.md#BKMK_Scenarios)  
  
-   [Support information](Deploy-Windows-Server-Essentials-Experience-as-a-Hosted-Server.md#BKMK_Support)  

-   [Windows Server Essentials Experience overview](Deploy-Windows-Server-Essentials-Experience-as-a-Hosted-Server.md#BKMK_WSEEOverview)  
  
-   [Benefits of hosting Windows Server Essentials Experience](Deploy-Windows-Server-Essentials-Experience-as-a-Hosted-Server.md#BKMK_Benefits)  
  
-   [Supported deployment options](Deploy-Windows-Server-Essentials-Experience-as-a-Hosted-Server.md#BKMK_SupportedDeployment)  
  
-   [Supported network topologies](Deploy-Windows-Server-Essentials-Experience-as-a-Hosted-Server.md#BKMK_SupportedToplogy)  
  
-   [Customize the image of Windows Server Essentials Experience role](Deploy-Windows-Server-Essentials-Experience-as-a-Hosted-Server.md#BKMK_CustomizeImage)  
  
-   [Automate the deployment of Windows Server Essentials Experience](Deploy-Windows-Server-Essentials-Experience-as-a-Hosted-Server.md#BKMK_AutomateDeployment)  
  
-   [Migrate data from Windows Small Business Server to Windows Server Essentials Experience](Deploy-Windows-Server-Essentials-Experience-as-a-Hosted-Server.md#BKMK_Migrate)  
  
-   [Perform common tasks by using Windows PowerShell](Deploy-Windows-Server-Essentials-Experience-as-a-Hosted-Server.md#BKMK_PowerShell)  
  
-   [Email integration with Windows Server Essentials](Deploy-Windows-Server-Essentials-Experience-as-a-Hosted-Server.md#BKMK_EmailIntegration)  
  
-   [Monitor and manage by using native tools](Deploy-Windows-Server-Essentials-Experience-as-a-Hosted-Server.md#BKMK_Monitoring)  
  
-   [Test scenarios](Deploy-Windows-Server-Essentials-Experience-as-a-Hosted-Server.md#BKMK_Scenarios)  
  
-   [Support information](Deploy-Windows-Server-Essentials-Experience-as-a-Hosted-Server.md#BKMK_Support)  

  
##  <a name="BKMK_WSEEOverview"></a> Windows Server Essentials Experience overview  
 The  Windows Server Essentials Experience is a server role that is available in the  Windows Server 2012 R2 Standard and  Windows Server 2012 R2 Datacenter. When the  Windows Server Essentials Experience role is installed on a server running  Windows Server 2012 R2, the customer can take advantage of all the features that are available in  Windows Server Essentials without the locks and limits. The  Windows Server Essentials Experience enables the following cross-premises solutions for small and midsize businesses:  
  
-   **Data storage and protection** You can store the customer „¢s data in a centralized location and protect server and client data by backing up the server and client computers (less than 75) within the network.  
  
-   **User management** You can manage the users and groups through the simplified server dashboard. In addition, integration with  Microsoft Azure Active Directory (Azure AD) enables easy data access for Microsoft online services (for example, Office 365, Exchange Online, and SharePoint Online) for users by using their domain credentials.  
  
-   **Service integration** You can integrate the server with Microsoft online services (such as Office 365, SharePoint Online, and  Microsoft Azure Backup). You can also integrate the server with your services or services provided by third-party providers.  
  
-   **Anywhere Access** The customer can access the server, network computers, and data from virtually anywhere they have an Internet connection and by using almost any device. Remote Web Access enables them to access applications and data with a streamlined, touch-friendly browser experience. The My Server app enables them to access data from a Windows Phone or a Microsoft Store app.  
  
-   **Media streaming** If you install the Media package on a server with  Windows Server Essentials Experience enabled, the end customer can store music, video, and photographs in shared folders, then access these media files from networked computers or Remote Web Access.  
  
-   **Health monitoring** You can monitor network health and obtain customized health reports.  
  
##  <a name="BKMK_Benefits"></a> Benefits of hosting Windows Server Essentials Experience  
  Windows Server Essentials Experience is a role in Windows Server, so you can reuse the existing deployment and management framework in Windows Server to deploy and configure the  Windows Server Essentials Experience role. Hosting the  Windows Server Essentials Experience role provides the following benefits:  
  
-   **Streamlined deployment** By simply turning on the  Windows Server Essentials Experience role, some of the most commonly used roles and features are turned on and configured with best practices for small and midsized businesses. You can customize the Windows Server Essentials features, or hide some of the on-premises features. If you use the  Windows Azure Pack, you can download the gallery template for  Windows Server Essentials Experience on  Windows Server 2012 R2.  
  
-   **Simplified dashboard** The Windows Server Essentials Dashboard simplifies common tasks such as managing server folders, server storage, backup and restore, user or group accounts, devices, remote access, and email. Small and midsized business customers can perform daily management tasks instead of calling the Help Desk for technical support.  
  
-   **Extensibility** The Windows Server Essentials Dashboard and Windows Server Essentials Connector software are extensible. You can add your own branding and service integration, so that your customers have one entry point for everything about their server and service.  
  
-   **Monitor** A new version of the System Center Monitoring Pack is available to monitor and manage multiple servers running Windows Server Essentials. To download the management pack, see [System Center Management Pack for Windows Server Essentials](https://www.microsoft.com/download/details.aspx?id=40809).  
  
##  <a name="BKMK_SupportedDeployment"></a> Supported deployment options  
  Windows Server Essentials Experience can be deployed as a domain controller in a new Active Directory environment; or it can be deployed into an existing Active Directory environment as a domain member.  
  
 We recommend that you first deploy  Windows Server 2012 R2 Standard or  Windows Server 2012 R2 Datacenter, and then install the  Windows Server Essentials Experience role. With this deployment method, you get all the functionalities of  Windows Server Essentials edition, without the locks and limits.  
  

 For more information about installing  Windows Server 2012 R2 with the  Windows Server Essentials Experience role, see [Install and Configure Windows Server Essentials](Install-and-Configure-Windows-Server-Essentials-or-Windows-Server-Essentials-Experience.md).  


  
##  <a name="BKMK_SupportedToplogy"></a> Supported network topologies  
 To use  Windows Server Essentials Experience from a roaming client, VPN should be enabled. To enable remote access to the server from roaming clients, you need to open port 443 and port 80 on the server.  
  
 Here are the two typical server-side networking topologies, and how the VPN and Remote Web Access could be configured:  
  
- **Topology 1** (This is the preferred topology, and it places all the servers and VPN IP range in the same subnet.):  
  
  -   Set up the Server in a separate virtual network under a Network Address Translation (NAT) device.  
  
  -   Enable the DHCP service in the virtual network, or assign a static IP address for the server.  
  
  -   Forward public IP port 443 on the router to local network address of the server.  
  
  -   Allow VPN passthrough for port 443.  
  
  -   Set the VPN IPv4 address pool in the same subnet range as the server address.  
  
  -   Assign second servers a static IP address within the same subnet, but out of the VPN address pool.  
  
- **Topology 2**:  
  
  -   Assign the server a private IP address.  
  
  -   Allow Port 443 on the server to reach a public port 443 IP address.  
  
  -   Allow VPN passthrough for port 443.  
  
  -   Assign different ranges for the VPN IPv4 address pool and the server address.  
  
  With Topology 2, second server scenarios are not supported because you cannot add another server to the same domain.  
  
  You can enable VPN during an unattended deployment by using our Windows PowerShell script, or it can be configured with the wizard after the initial configuration.  
  
  To enable VPN by using Windows PowerShell, run the following command with administrative privileges on the server running Windows Server Essentials, and provide all the necessary information.  
  
```  
##  
## To configure external domain and SSL certificate (if not yet done in unattended Initial Configuration).  
##  
  
$myExternalDomainName = 'remote.contoso.com';   ## corresponds to A or AAAA DNS record(s) that can be resolved on Internet and routed to the server  
$mySslCertificateFile = 'C:\ssl.pfx';   ## full path to SSL certificate file  
$mySslCertificatePassword = ConvertTo-SecureString  œAsPlainText  œForce '******';   ## password for private key of the SSL certificate  
$skipCertificateVerification = $true;   ## whether or not, skip verification for the SSL certificate  
  
Set-WssDomainNameConfiguration  œDomainName $myExternalDomainName  œCertificatePath $mySslCertificateFile  œCertificateFilePassword $mySslCertificatePassword  œNoCertificateVerification  
##  
## To install VPN with static IPv4 pool (and allow all existing users to establish VPN).  
##  
  
Install-WssVpnServer -IPv4AddressRange ('192.168.0.160','192.168.0.240') -ApplyToExistingUsers;  
  
```  
  
> [!NOTE]
>  If you cannot provide a VPN connection before the customer takes possession of the server, ensure that server port 3389 is reachable over the Internet so that the customer can use Remote Desktop Protocol to connect to the server and configure it.  
  
##  <a name="BKMK_CustomizeImage"></a> Customize the image of Windows Server Essentials Experience role  
 You can customize the image before configuring the Windows Server Essentials Experience role. To learn about the standard Windows Server Sysprep process, see [Windows Assessment and Deployment Kit](https://msdn.microsoft.com/library/hh825420.aspx). After you prepare the image by using Sysprep, you can use it or reseal it into Install.wim for a new deployment.  
  
 If you are using Virtual Machine Manager, you can create a template by using the running instance. This process uses Sysprep to prepare the instance, and it shuts down the computer. After you store the template in your library, you can use it on a case-by-case basis.  
  
 After you install the  Windows Server Essentials Experience role, you can customize the features in Windows Server Essentials. One of the most important customizations is the **IsHosted** registry key: **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Server\Deployment\IsHosted**.  
  
 If this key is set to 0x1, some of the on-premises features will change behavior. These feature changes include:  
  
- **Client Backup** Client backup will be turned off by default for newly joined client computers.  
  
- **Client Restore Service** Client Restore Service will be disabled, and the UI will be hidden from the Dashboard.  
  
- **File History** File History settings for newly created user accounts will not be automatically managed by the server.  
  
- **Server Backup** Server Backup service will be disabled, and the Server Backup UI will be hidden from the Dashboard.  
  
- **Storage Spaces** The UI for creating or managing Storage Spaces will be hidden from the Dashboard.  
  
- **Anywhere Access** Router and VPN configuration will be skipped by default when you run the Set Up Anywhere Access Wizard.  
  
  If you want to control the behavior of each feature listed, you can set the corresponding registry key for each of them. For information about how to set the registry key, refer to the [Customize and Deploy Windows Server Essentials in Windows Server 2012 R2](https://technet.microsoft.com/library/dn293241.aspx)  
  
##  <a name="BKMK_AutomateDeployment"></a> Automate the deployment of Windows Server Essentials Experience  
 To automate the deployment, you need to first deploy the operating system and then install the  Windows Server Essentials Experience role.  
  
-   To automatically deploy  Windows Server 2012 R2 Standard or  Windows Server 2012 R2 Datacenter, follow the instructions in [Windows Assessment and Deployment Kit](https://msdn.microsoft.com/library/hh825420.aspx).  
  
-   To learn how to install the  Windows Server Essentials Experience role by using Windows PowerShell, see [Install and Configure Windows Server Essentials](https://technet.microsoft.com/library/dn281793.aspx).  
  
> [!NOTE]
>  Ensure that the time zone settings of the host virtual machine and the  Windows Server Essentials Experience are the same. Otherwise, you may experience several errors. These include: the initial configuration of the server may not be successful on certificate related tasks, the certificate may not work for a few hours after the  Windows Server Essentials Experience role is installed, and device information will not update correctly.  
  
 After deployment, use the Windows PowerShell cmdlet **Get-WssConfigurationStatus** to verify if the initial configuration was successful. The returned status should be one of the following: **Notstarted**, **FinishedWithWarning**, **Running**, **Finished**, **Failed**, or **PendingReboot**.  
  
 The server will be restarted during the initial configuration. If you need to prevent this automatic restart, you can use the following command to add a registry key before you start the Initial Configuration:  
  
```  
New-ItemProperty "HKLM:\Software\Microsoft\Windows Server\Setup"Ã‚Â  -Name "WaitForReboot" -Value 1 -PropertyType "DWord" -Force -Confirm:$false  
  
```  
  
 After the initial configuration starts, you can use **Get-WssConfigurationStatus** to check the initial configuration status, and when the status is **PendingReboot**, you can restart your server.  
  
##  <a name="BKMK_Migrate"></a> Migrate data from Windows Small Business Server to Windows Server Essentials Experience  
 You can migrate data from servers running Windows Small Business Server 2011, Windows Small Business Server 2008, Windows Small Business Server 2003, or Windows Server Essentials to the server running  Windows Server Essentials. Review the [Migrate to Windows Server Essentials](../migrate/Migrate-from-Previous-Versions-to-Windows-Server-Essentials-or-Windows-Server-Essentials-Experience.md) migration guide for on-premises  2migrations, and make necessary customizations based on your hosting environment.  
  
> [!NOTE]
>  We recommend that you put the source server and the destination server in the same subnet. If this is not possible, you should make sure that:  
> 
> - The source server and the destination server can access each other „¢s internal DNS names.  
>   -   All the necessary ports are open.  
  
 After migration, you can upgrade your licenses to remove the locks and limits. For more information, see [Transition from Windows Server Essentials to Windows Server 2012 Standard](https://technet.microsoft.com/library/jj247582.aspx).  
  
##  <a name="BKMK_PowerShell"></a> Perform common tasks by using Windows PowerShell  
 This section explains some of the common tasks that you can perform by using Windows PowerShell.  
  
### Enable Remote Web Access  
 **Syntax**:  
  
 Enable-WssRemoteWebAccess [-SkipRouter] [-DenyAccessByDefault] [-ApplyToExistingUsers]  
  
 **Example**:  
  
 $Enable-WssRemoteWebAccess  œDenyAccessByDefault  œApplyToExistingUsers  
  
 This command will enable Remote Web Access with the router configured automatically, and change the default access permissions for all existing users.  
  
### Add user  
 **Syntax**:  
  
 Add-WssUser [-Name] <string\> [-Password] <securestring\> [-AccessLevel <string\> {User &#124; Administrator}] [-FirstName <string\>] [-LastName <string\>] [-AllowRemoteAccess] [-AllowVpnAccess]  [<CommonParameters\>]  
  
 **Example**:  
  
 $password = ConvertTo-SecureString "Passw0rd!" -asplaintext  œforce$Add-WssUser -Name User2Test -Password $password -Accesslevel Administrator -FirstName User2 -LastName Test  
  
 This command will add an administrator named User2Test with password Passw0rd!.  
  
### Add Server Folder  
 **Syntax**:  
  
 Add-WssFolder [-Name] <string\> [-Path] <string\> [[-Description] <string\>] [-KeepPermissions] [<CommonParameters\>]  
  
 **Example**:  
  
 $Add-WssFolder -Name "MyTestFolder" -Path "C:\ServerFolders\MyTestFolder"  
  
 This command will add a server folder named MyTestFolder at the specified location.  
  
##  <a name="BKMK_EmailIntegration"></a> Email integration with Windows Server Essentials  
 You can integrate  Windows Server Essentials Experience with Office 365 or hosted Exchange Server. If you want your  customer to use your hosted email, you need to develop an add-in to integrate Windows Server Essentials Experience with your hosted email solution. For more information, see [Windows Server Essentials SDK](https://msdn.microsoft.com/library/gg513877.aspx).  
  
##  <a name="BKMK_Monitoring"></a> Monitor and manage by using native tools  
 This section discusses the native tools that are available in  Windows Server 2012 R2 to monitor and manage the server.  
  
### Group Policy  
  Windows Server Essentials Experience leverages the native Group Policy support in  Windows Server 2012 R2 and provides a user interface to configure Folder Redirection and security settings.  
  
> [!NOTE]
>  In a hosted environment, if Folder Redirection for a user profile is enabled, it can increase the time for end user to sign in when the data size is big.  
  
### System Center Monitoring Pack  
 System Center Monitoring Pack for  Windows Server Essentials Experience monitors the health alert system to help you manage large numbers of servers running Windows Server Essentials that are dedicated to small business organizations. For more information, see [System Center Management Pack for Windows Server Essentials](https://www.microsoft.com/download/details.aspx?id=40809).  
  
### Backup and restore  
  Windows Server 2012 R2 with Windows Server Essentials Experience allows you to back up server and client computers in the network.  
  
#### Server Backup  
 Windows Server Essentials supports two ways to back up the server: on-premises backup and off-premises backup. You can customize these options if you want to deploy your own server backup solution.  
  
-   **On-premises backup** Allows you to perform block-level incremental backups on a regular basis to a separate disk. As a hoster, you could attach a virtual hard disk to the virtual machine running Windows Server Essentials, and then configure the server backup to this virtual hard disk. The virtual hard disk should be located on a different physical disk than the virtual machine running Windows Server Essentials.  
  
    > [!NOTE]
    >  If you have other backup solutions for your virtual machines and you do not want your users to see the Windows Server Essentials native Server Backup feature, you can turn it off and remove the related user interface from the Dashboard. For more information, see the [Customize Server Backup](https://technet.microsoft.com/library/dn293413.aspx) section of [Customize and Deploy Windows Server Essentials in Windows Server 2012 R2](https://technet.microsoft.com/library/dn293241.aspx).  
  
-   **Off-premises backup** Allows you to periodically back up your server data to a cloud-based service. You can download and install the  Microsoft Azure Backup Integration Module for Windows Server Essentials to leverage the  Azure Backup that is provided by Microsoft.  
  
     For more information, see the Integrate Windows Azure Backup with Windows Server Essentials section in [Manage Server Backup](../manage/Manage-Server-Backup-in-Windows-Server-Essentials.md).  
  
     If you or your users prefer another cloud service, you should consider the following:  
  
    -   Update the user interface of the Dashboard so that it links to your preferred cloud service instead of to the default  Azure Backup.  
  
    -   (Optional) Develop an add-in for the Dashboard to configure and manage the cloud-based backup service.  
  
#### Client Computer Backup  
 Windows Server Essentials Experience supports two kinds of client data backup: full client backup and File History.  
  
> [!NOTE]
>  Backing up the client might impact performance because the data needs to be transferred from the client to the server over VPN.  
  
##### Full client backup  
 Full client backup is on by default for all the client devices that are connected to the Windows Server Essentials network. It fully backs up the system information and data for the client and supports data deduplication. The backup data will be stored on the server running  Windows Server Essentials. This enables a failed client to retrieve data from a previous backup point.  
  
 Some considerations for full client computer backup are:  
  
-   **Performance** Initial client backup might be time consuming because of the amount of data to be uploaded.  
  
-   **Stability** Sometimes the Internet connection is not stable on the client side. Client backup is designed to resume automatically, and the client backup database creates a checkpoint every time 40 GB of data is backed up. You can change this value to a smaller number if you expect the Internet connection to be unreliable.  
  
    -   To enable a checkpoint job: On the server, set registry key **HKLM\Software\Microsoft\Windows Server\Backup\GetCheckPointJobs** to 1.  
  
    -   To change the checkpoint threshold: On the client, change **HKLM\Software\Microsoft\Windows Server\Backup\CheckPointThreshold** from its default value of 40 GB.  
  
-   **Client bare metal restore** Because the Windows Preinstall Environment does not support a VPN connection, client bare metal restore is not supported. You should hide the Client Restore Service task by following the steps in [Customize and Deploy Windows Server Essentials in Windows Server 2012 R2](https://technet.microsoft.com/library/dn293241.aspx).  
  
##### File History  
 File History is a feature in Windows 8.1 and Windows 8 for backing up profile data (Libraries, Desktop, Contacts, Favorites) to a network share. You can centrally manage the File History setting of all computers running Windows 8.1 or Windows 8 that are joined to Windows Server Essentials network. The backup data is stored on the server running Windows Server Essentials. You should hide the Client Restore Service task by following the steps in [Customize and Deploy Windows Server Essentials in Windows Server 2012 R2](https://technet.microsoft.com/library/dn293241.aspx)  
  
### Storage management  
 Storage Spaces allows you to aggregate the physical storage capacity of disparate hard drives, dynamically add hard drives, and create data volumes with specified levels of resilience. You can do this on the host or on the virtual machine. If you want to hide this feature in a virtual machine running Windows Server Essentials, follow the instructions in [Customize and Deploy Windows Server Essentials in Windows Server 2012 R2](https://technet.microsoft.com/library/dn293241.aspx).  
  
##  <a name="BKMK_Scenarios"></a> Test scenarios  
 From the hosting perspective, we recommend that you test the following scenarios:  
  

-   [Server deployment](Deploy-Windows-Server-Essentials-Experience-as-a-Hosted-Server.md#BKMK_ServerDeploy)  
  
-   [Server configuration](Deploy-Windows-Server-Essentials-Experience-as-a-Hosted-Server.md#BKMK_ServerConfig2)  
  
-   [Server management](Deploy-Windows-Server-Essentials-Experience-as-a-Hosted-Server.md#BKMK_ServerManage)  
  
-   [Client experience](Deploy-Windows-Server-Essentials-Experience-as-a-Hosted-Server.md#BKMK_ClientXP)  

  
###  <a name="BKMK_ServerDeploy"></a> Server deployment  
 You can test the following server deployment scenarios:  
  
-   Deploy a server running  Windows Server 2012 R2 as a domain controller in your lab environment, and then install the Windows Server Essentials Experience role.  
  
-   Deploy a server running  Windows Server 2012 R2 in your lab environment, join this server to an existing domain, and then install the Windows Server Essentials Experience role.  
  
-   Customize the Windows Server Essentials image as needed.  
  
-   Automate the Windows Server Essentials deployment with unattended file and Windows PowerShell.  
  
-   Migrate on-premises servers running Windows Small Business Server to hosted servers running Windows Server Essentials.  
  
###  <a name="BKMK_ServerConfig2"></a> Server configuration  
 You can test the following server configuration scenarios :  
  
-   Configure Anywhere Access (virtual private network, Remote Web Access, and DirectAccess).  
  
-   Configure Storage and Server Folders.  
  
-   Turn on BranchCache.  
  
-   (If applicable) Configure Server Backup, Online Backup, Client Backup, and File History.  
  
-   (If applicable) Configure and manage Storage Spaces.  
  
-   (If applicable) Configure email solution integration (Office 365 and hosted Exchange Server).  
  
-   (If applicable) Configure integration with other Microsoft online services.  
  
-   (If applicable) Configure Media Server.  
  
###  <a name="BKMK_ServerManage"></a> Server management  
 You can test the following server management scenarios:  
  
-   Manage users and groups.  
  
-   Configure and receive email notification of alerts.  
  
-   Run Best Practices Analyzer to see if there is an error or warning message.  
  
-   Configure the System Center Operations Manager pack.  
  
-   Configure server recovery, in the event of corruption in the operating system.  
  
###  <a name="BKMK_ClientXP"></a> Client experience  
 You can test the following end user scenarios:  
  
-   Deploy clients over the Internet (PC or Mac operating systems).  
  
-   Use Launchpad on the client to access Shared Folders.  
  
-   Access server assets over Remote Web Access from different devices (PC, phone, and tablet).  
  
-   Access My Server app for Windows Phone.  
  
-   (If applicable) Access File History, Client Backup and Restore, and Folder Redirection.  
  
-   (If applicable) Verify the email integration experience.  
  
##  <a name="BKMK_Support"></a> Support information  
 You can download the Windows Server Essentials Software Development Kit (SDK) and the Windows Server Essentials Assessment and Deployment Kit (ADK):  
  
-   [Windows Server Essentials Software Development Kit](https://msdn.microsoft.com/library/gg513877.aspx)SDK  
  
-   [Customize and Deploy Windows Server Essentials in Windows Server 2012 R2](https://technet.microsoft.com/library/dn293241.aspx)  
  
## See also  
  
-   [What's New in Windows Server Essentials](../get-started/what-s-new.md)  

-   [Install Windows Server Essentials](Install-Windows-Server-Essentials.md)  

-   [Get started with Windows Server Essentials](../get-started/get-started.md)
