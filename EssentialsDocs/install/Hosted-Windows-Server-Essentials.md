---
title: "Hosted Windows Server Essentials"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fda5628c-ad23-49de-8d94-430a4f253802
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Hosted Windows Server Essentials

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

This document includes information that is specific to hosters who intend to deploy Windows Server Essentials in their lab and offer Windows Server Essentials as a service to their customers.  
  
## What is Windows Server Essentials?  
 Windows Server Essentials is a cross-premises small business solution, which incorporates best-of-breed, 64-bit product technologies to deliver a server environment well suited for the vast majority of small businesses. The following technologies are included in Windows Server Essentials.  
  
 **Server Operating System:** Windows Server 2012 product technologies provide the core of Windows Server Essentials. For more information, visit the [Windows Server 2012 website](https://www.microsoft.com/en-us/server-cloud/products/windows-server-2012-r2/default.aspx#fbid=ZH0GD_CRAWh).  
  
 **Data Protection:** Windows Server Essentials leverages several new features available in Windows Server 2012 to provide greatly improved data protection capabilities. The [new Storage Spaces feature](https://technet.microsoft.com/library/hh831739.aspx) allows you to aggregate the physical storage capacity of disparate hard drives, dynamically add hard drives, and create data volumes with specified levels of resilience. Windows Server Essentials can perform complete system backups and bare-metal restores of the server itself as well as the client computers connected to the network ?now with support for volumes larger than 2 TB. New with Windows Server 2012, the [Windows Azure Online Backup](https://technet.microsoft.com/library/hh831419.aspx) can be used to protect files and folders in a cloud-based storage service that is managed by Microsoft. Windows Server Essentials also centrally manages and configures the File History feature of Windows 8.1 clients, helping users to recover from accidentally deleted or overwritten files without requiring administrator assistance.  
  
 **Anywhere Access:** Remote Web Access provides a streamlined, touch-friendly browser experience for accessing applications and data from virtually anywhere you have an Internet connection and using almost any device. Windows Server Essentials also provides an updated Windows Phone app and a new app for Windows 8.1 client computers, allowing users to intuitively connect to, search across, and access files and folders on the server. Files are also automatically cached for offline access and synchronized when a connection to the server becomes available. Windows Server Essentials turns setting up virtual private networking (VPN) into a painless, wizard-driven process of just a few clicks, and simplifies the management of VPN access for users. Client computers can leverage a VPN connection to remotely join the Windows SBS environment without the need to commute to the office.  
  
 **Workload Flexibility:** Windows Server Essentials has been designed to allow customers the flexibility to choose which applications and services run on premises and which run in the cloud. In previous versions, Windows Small Business Server Standard included Exchange Server as a component product, which added expense and complexity for customers who wished to leverage cloud-based messaging and collaboration services. With Windows Server Essentials, customers can take advantage of the same type of integrated management experience whether they choose to run an on-premises copy of Exchange Server, subscribe to a hosted Exchange service, or subscribe to Microsoft Office 365.  
  
 **Health Monitoring:** Windows Server Essentials monitors its own health status and the status of client computers running Windows 8.1, Windows 7, and Mac OS X version 10.5 and later. Health status notifies you of issues or problems related to computer backups, server storage, low disk space, and more.  
  
 **Extensibility:** Windows Server Essentials builds on the extensibility model of Windows SBS 2011 Essentials, which allows other software vendors to add capabilities and features to the core product, and adds a new set of web services APIs. It also maintains compatibility with the existing [software development kit](https://msdn.microsoft.com/library/gg513958.aspx) (SDK) and [add-ins](https://pinpoint.microsoft.com/applications/search?fpt=300105&q=small+business+server+essentials) created for Windows SBS 2011 Essentials.  
  
## How can I customize an image?  
 Refer to the [Windows Server Essentials](https://go.microsoft.com/fwlink/p/?LinkID=249124), which is a standard Windows Server sysprep process with additional Windows Server Essentials customization steps. To finish the customization, follow the instructions in [Create a Simple Customized Image](https://technet.microsoft.com/library/jj200117) and [Customize the Image](https://technet.microsoft.com/library/jj200161), and then follow the instructions in [Preparing the Image for Deployment](https://technet.microsoft.com/library/jj200142) to capture your final image.  
  
 You should pay attention to the following points:  
  
1. You should skip the Initial Configuration (IC) by adding a SkipIC.txt file to the root of any drive. After installing the server, before IC, press Shift+F10 to launch the cmd window and create a SkipIC.txt file under the C:/ drive. After customization, you must remember to delete the SkipIC.txt file.  
  
2. If you need to deploy Windows Server Essentials on a disk smaller than 90 GB, you should add a registry key before sysprep:  
  
   ```  
   %systemroot%\system32\reg.exe add "HKLM\Software\microsoft\windows server\setup" /v HWRequirementChecks /t REG_DWORD /d 0 /f  
   ```  
  
   After sysprep, you can use the sysprepped disk image, or reseal it back into Install.wim for new deployment.  
  
   If you are using Virtual Machine Manager, you can create a template using the running instance. Creating a template will sysprep the instance and shut down the server. After you store it in your library, you can bring up the instance on a case-by-case basis.  
  
##  <a name="BKMK_automatedeployment"></a> How do I automate the deployment?  
 After you get the customized image, you can do the deployment with your own image. In order to do semiunattended installation, you need to provide/deploy unattend.xml for WinPE setup. To do a fully unattended installation, you also need to provide the cfg.ini file for Windows Server Essentials Initial Configuration.  
  
1. Perform only unattended WinPE setup. This will automate only the WinPE setup, and let the installation stop before Initial Configuration so that end users can provide Corp, Domain, and Administrator information by themselves after RDP into server session. To do this:  
  
   1.  Provide the Windows unattend.xml file. Follow the [Windows 8.1 ADK](https://go.microsoft.com/fwlink/?LinkId=248694) to generate the file, and provide all necessary information including server name, product keys, and administrator password. In the Microsoft-Windows-Setup section of the unattend.xml file, provide the information as below.  
  
       ```  
       <InstallFrom>  
                <MetaData>  
                    <Key>IMAGE/WINDOWS/EDITIONID</Key>  
                    <Value>ServerSolution</Value>  
                </MetaData>  
                <MetaData>  
                    <Key>IMAGE/WINDOWS/INSTALLATIONTYPE</Key>  
                    <Value>Server</Value>  
                </MetaData>  
          </InstallFrom>  
       ```  
  
   2.  RDP port 3389 must be opened on a public IP so that the customer can use Administrator and the password specified in the unattend.xml file to RDP into the server to finish Initial Configuration.  
  
   > [!NOTE]
   >  If you do not change the default password, the server installation will stop on a screen asking for a password to be entered.**Note** End users must use the default administrator account to log on to the server and perform Initial Configuration.  
  
   If you are using Virtual Machine Manager, you can specify the administrator password in the console when you create a new instance from the template.  
  
2. Perform complete unattended setup including unattended Initial Configuration. To do this:  
  
   1.  Provide the unattend.xml file as you did above, if the deployment starts from WinPE setup.  
  
   2.  Refer to the Windows Server Essentials ADK section entitled, [Create the Cfg.ini File](https://technet.microsoft.com/library/jj200150), to generate the cfg.ini.  
  
   3.  Provide information in [InitialConfiguration].  
  
       ```  
       WebDomainName=yourdomainname  
       TrustedCertFileName=c:\cert\a.pfx  
       TrustedCertPassword=Enteryourpassword  
       EnableVPN=true  
       EnableRWA=true  
       ; Provide all information so that after setup is complete, your customer can use your domain name to visit the server directly with the admin/user information you provide in the [InitialConfiguration] section.  
  
       VpnIPv4StartAddress=<IPV4Address>  
       VpnIPv4EndAddress=<IPV4Address>  
       VpnBaseIPv6Address=<IPV6Address>  
       VpnIPv6PrefixLength=<number>  
       ; Provide this information. IPv4StartAddress and IPv4Endaddress are required so that your VPN client can acquire valid IP through this range.  
  
       IPv4DNSForwarder=<IPV4Address,IPV4Address,Â¦>  
       IPv6DNSForwarder=<IPV6Address,IPV6Address,Â¦>  
       ; Provide this information as needed according to your network environment settings.  
       ```  
  
   4.  Provide information in [PostOSInstall].  
  
       ```  
       IsHosted=true   
       ; Must have, this will prevent Initial Configure webpage available for other computers under same subnet.  
  
       StaticIPv4Address=<IPV4Address>  
       StaticIPv4Gateway=<IPV4Address>  
       StaticIPv6Address=<IPV6Address>  
       StaticIPv6SubnetPrefixLength=<number>  
       StaticIPv6Gateway=<IPV6Address>  
       ; All these are optional if you have DHCP Server Service on the subnet, otherwise provide static IP here.  
       ```  
  
   5.  If you provide the WebDomainName parameter, make sure the DNS record is also being updated to point to the server s public IP.  
  
   6.  If you did not provide the WebDomainName information above, make sure to open port 3389 so that customers can use RDP to connect to the server and finish VPN configurations.  
  
> [!NOTE]
>  Ensure that the time zone setting of the VM host server and the Windows Server Essentials VM is the same. Otherwise, you might experience several different errors (Initial Configuration may fail on certificate related tasks; certificate may not work for a few hours after installation; device information will not update correctly; and so on).  
  
 After deployment, check the following registry key under HKLM\software\microsoft\windows server\setup to verify if Initial Configuration was successful. If SetupStage == ICDone && ICStatus == 1, it means the Initial Configuration finished successfully.  
  
## What is the supported network topology?  
 To use Windows Server Essentials from a roaming client, VPN should be enabled. We recommend enabling port 443 for VPN SSTP connections. If the Media Server feature is needed for Remote Web Access or Web Service apps, port 80 should also be enabled.  
  
 VPN enabling can be done during unattended deployment via our Windows PowerShell script, or it can be configured with our wizard after initial configuration.  
  

- To enable VPN during unattended deployment, see [How do I automate the deployment?](Hosted-Windows-Server-Essentials.md#BKMK_automatedeployment) in this document.  

- To enable VPN during unattended deployment, see [How do I automate the deployment?](../install/Hosted-Windows-Server-Essentials.md#BKMK_automatedeployment) in this document.  

  
- To enable VPN via Windows PowerShell, run the following cmdlet with administrative privilege and provide all necessary information.  
  
  ```  
  ##  
  ## To configure external domain and SSL certificate (if not yet done in unattended Initial Configuration).  
  ##  
  
  $myExternalDomainName = 'remote.contoso.com';   ## corresponds to A or AAAA DNS record(s) that can be resolved on Internet and routed to the server  
  $mySslCertificateFile = 'C:\ssl.pfx';   ## full path to SSL certificate file  
  $mySslCertificatePassword = ConvertTo-SecureString '******';   ## password for private key of the SSL certificate  
  $skipCertificateVerification = $true;   ## whether or not, skip verification for the SSL certificate  
  
  Add-Type -AssemblyName 'Wssg.Web.DomainManagerObjectModel';  
  [Microsoft.WindowsServerSolutions.RemoteAccess.Domains.DomainConfigurationHelper]::SetDomainNameAndCertificate($myExternalDomainName,$mySslCertificateFile,$mySslCertificatePassword,$skipCertificateVerification);  
  ##  
  ## To install VPN with static IPv4 pool (and allow all existing users to establish VPN).  
  ##  
  
  Install-WssVpnServer -IPv4AddressRange ('192.168.0.160','192.168.0.240') -ApplyToExistingUsers;  
  ```  
  
  If you cannot provide a VPN connection before giving the server to customers, ensure that server port 3389 is reachable on the Internet so that end users can use RDP to connect to the server and do the configuration by themselves.  
  
  Here are the two typical server-side networking topologies, and how the VPN/Remote Web Access (RWA) could be configured:  
  
- Topology 1 (preferred)  
  
  -   Server in a separate virtual network under a NAT device.  
  
  -   DHCP service is enabled in the virtual network, or the server is assigned with a static IP address.  
  
  -   Server port 443 is reachable from public IP port 443.  
  
  -   VPN passthrough is allowed for port 443.  
  
  -   VPN IPv4 address pool should be ranged in the same subnet of the server address.  
  
  -   Any second server should be assigned a static IP within the same subnet, but out of the VPN address pool.  
  
- Topology 2:  
  
  -   The server has a private IP address.  
  
  -   Port 443 on the server is reachable from a public IP address s port 443.  
  
  -   VPN passthrough is allowed for port 443.  
  
  -   VPN IPv4 address pool is in a different range of the server address.  
  
  With Topology 2, second server scenarios are not supported.  
  
## How do I perform common tasks via Windows PowerShell?  
 **Enable Remote Web Access**  
  
```  
Enable-WssRemoteWebAccess [-SkipRouter] [-DenyAccessByDefault] [-ApplyToExistingUsers]  
```  
  
 Example:  
  
```  
$Enable-WssRemoteWebAccess  œDenyAccessByDefault  œApplyToExistingUsers  
```  
  
 This command will enable Remote Web Access with the router configured automatically, and change the default access permissions for all existing users.  
  
 **Add User**  
  
```  
Add-WssUser [-Name] <string> [-Password] <securestring> [-AccessLevel <string> {User | Administrator}] [-FirstName <string>] [-LastName <string>] [-AllowRemoteAccess] [-AllowVpnAccess]   [<CommonParameters>]  
```  
  
 Example:  
  
```  
$password = ConvertTo-SecureString "Passw0rd!" -asplaintext  œforce  
$Add-WssUser -Name User2Test -Password $password -Accesslevel Administrator -FirstName User2 -LastName Test  
```  
  
 This command will add an administrator named User2Test with password Passw0rd!.  
  
 **Enable/Disable User**  
  
 Example:  
  
```  
$CurrentUser = get-wssuser  œname user2test  
$CurrentUser.UserStatus = 0  
$CurrentUser.Commit()  
```  
  
 This command will disable the user named user2test. Setting UserStatus to 1 will enable the user.  
  
 **Add Server Folder**  
  
```  
Add-WssFolder [-Name] <string> [-Path] <string> [[-Description] <string>] [-KeepPermissions] [<CommonParameters>]  
```  
  
 Example:  
  
```  
$Add-WssFolder -Name "MyTestFolder" -Path "C:\ServerFolders\MyTestFolder"  
```  
  
 This command will add a server folder named MyTestFolder at the specified location.  
  
## How do I add a second server to the Windows Server Essentials domain?  
 Because Windows Server Essentials is a domain controller, you can join a second server to the domain in the standard fashion.  
  
## Which email solutions can be integrated?  
 Windows Server Essentials supports integration with two email solutions out of the box: Office 365 and on-premises Exchange. If you are running your own hosted email solution, you will need to develop an add-in to integrate Windows Server Essentials with your hosted email solution.  
  
## How do I migrate on-premises Windows SBS (2011/2008/2003) to the hosted Windows Server Essentials?  
 Migration guides are available for on-premises Windows Small Business Server (Windows SBS) to Windows Server Essentials migrations. Some of the steps may not apply exactly the same to your hosted environment. However, the general tasks and the workloads to be migrated should be the same. We recommend that you refer to the [migration guides](https://go.microsoft.com/fwlink/p/?LinkID=254292) and make necessary customizations based on your hosting environment.  
  
 It is recommended that you put the source server and the destination server in the same subnet. If this is not possible, you should make sure that:  
  
-   The internal DNS name of the source server and destination server are reachable by each other.  
  
-   All the necessary ports are open.  
  
## How can I upgrade Windows Server Essentials to Windows Server Standard?  
 You can upgrade Windows Server Essentials to Windows Server Standard. Remove locks and limits, and add the packages that are missing from Windows Server Standard. For more information, [download the document](https://go.microsoft.com/fwlink/p/?LinkID=253181).  
  
## What are the native tools for monitoring and management?  
  
### Group Policy management  
 Windows Server Essentials leverages native Group Policy support in Windows Server 2012 and provides the user interface to configure folder redirection and security settings.  
  
> [!NOTE]
>  In a hosted environment, if the folder redirection for a user profile is enabled, it may increase the time for end users to log on when the data size is big.  
  
### Management pack  
 Windows Server Essentials Management Pack provides monitoring function over the health alert system in Windows Server Essentials to help hosters manage large numbers of Windows Server Essentials servers dedicated to different small business companies. The monitoring in this version includes only critical alerts in the system.  
  
#### Management pack scope  
 This management pack helps you to monitor features specific to Windows Server Essentials. It does not monitor features that are generic in the Windows Server 2012 Standard operating system. In order to monitor Windows Server Essentials, you should use both the Windows Server Essentials Management Pack and the Management Pack for Windows Server 2012 Standard.  
  
#### Mandatory configuration  
 The following steps need to be taken before you can use the management pack:  
  
1.  Install the Agent and configure trust using certificate trust. Because Windows Server Essentials is preconfigured as a domain controller and cannot have trust with other domains or forests, the System Center Operation Manager Agent should be installed on Windows Server Essentials and configured trust with the management server using certificates.  
  
2.  Download the management pack. To monitor Windows Server Essentials by using Operations Manager 2007, you must first download the [Windows Server Operating System Management Pack](https://connect.microsoft.com/WindowsServer/Downloads/DownloadDetails.aspx?DownloadID=45010) from the Management Pack Catalog.  
  
3.  Import management pack file. If you are using a localized version of the management pack, you need to import both the main management pack file and the language pack.  
  
#### Files in this Monitoring Pack  
 The Monitoring Pack for Windows Server Essentials includes the following files:  
  
-   Microsoft.Windows.Server.2012.Essentials.mp  
  
-   Microsoft.Windows.Server.2012.Essentials.<locale\>.mp  
  
### Back up and restore  
 Windows Server Essentials allows you to back up both the server and the client.  
  
#### Back up the server  
 Windows Server Essentials supports two ways of backing up the server: on-premises backup and off-premises backup.  
  
 **On-premises backup** allows you to perform block-level incremental backup on a regular basis to a separate disk. As a hoster, you could attach a virtual disk to the Windows Server Essentials VM and configure server backup to this virtual disk. The virtual disk should be located on a different physical disk than the Windows Server Essentials VM.  
  
- If you have another mechanism to back up the Windows Server Essentials VM, and you do not want your user to see the Windows Server Essentials native Server Backup feature, you could turn it off and remove all related user interface from the Windows Server Essentials Dashboard. For more information, refer to the Customize Server Backup section of the [ADK document](https://go.microsoft.com/fwlink/p/?LinkID=249124).  
  
  **Off-premises backup** allows you to periodically back up server data to a cloud service. You can download and install the  Microsoft Azure Backup Integration Module for Windows Server Essentials to leverage the  Azure Backup provided by Microsoft.  
  
  If you or your users prefer another cloud service, you should:  
  
1.  Update the user interface of the Windows Server Essentials Dashboard so that it provides a link to your preferred cloud service, instead of the default  Azure Backup. For more information, refer to the Customize the Image section of the [ADK document](https://go.microsoft.com/fwlink/p/?LinkID=249124).  
  
2.  (Optional) Develop an add-in for Windows Server Essentials Dashboard to configure and manage the cloud backup service.  
  
#### Back up the client  
 Windows Server Essentials supports two kinds of client data backup: full client backup, and File History.  
  
> [!NOTE]
>  Backing up the client might impact performance because the data needs to be transferred from the client to the server over VPN.  
  
 **Full client backup** is by default on for all the client devices connected to the Windows Server Essentials network. It backs up the full client (system and data) incrementally and supports data deduplication. The backup data will be on the server running Windows Server Essentials. A failed client can get its data back to a previous backup point. You could turn this feature off by following the steps in the Create the Cfg.ini File section of the [ADK document](https://technet.microsoft.com/library/jj200150).  
  
 Some considerations for full client backup are:  
  
- Performance: initial client backup might be time consuming because of the amount of data to be uploaded.  
  
- Stability: sometimes the Internet connection is not stable on the client side. Client backup is designed to be resumable, and the default checkpoint is 40 GB (the client backup database will create a checkpoint every time 40 GB data has been backed up). You could change this value to a smaller number if you expect the Internet connection to be unreliable.  
  
  -   To enable a checkpoint job, on the server, set registry key HKLM\Software\Microsoft\Windows Server\Backup\GetCheckPointJobs to 1.  
  
  -   To change the checkpoint threshold, on the client, change HKLM\Software\Microsoft\Windows Server\Backup\CheckPointThreshold from its default value (40 GB).  
  
- Client Bare Metal Restore: because Windows Preinstall Environment does not support VPN connection, Client Bare Metal Restore is not supported.  
  
  **File History** is a Windows 8.1 feature for backing up profile data (Libraries, Desktop, Contacts, Favorites) to a network share. In Windows Server Essentials, we allow central management of the File History setting of all the Windows 8.1 clients joined to Windows Server Essentials. The backup data is stored on the server running Windows Server Essentials. You can turn this feature off by following the steps in the Create the Cfg.ini File section of the [ADK document](https://technet.microsoft.com/library/jj200150).  
  
### Storage management  
 The [new Storage Spaces feature](https://technet.microsoft.com/library/hh831739.aspx) allows you to aggregate the physical storage capacity of disparate hard drives, dynamically add hard drives, and create data volumes with specified levels of resilience. You can also attach an iSCSI disk to Windows Server Essentials to expand its storage.  
  
## What are the main scenarios I should test?  
 From the hosting perspective, it is recommended that you test the following scenarios:  
  
 **Server Deployment**  
  
- Deploy Windows Server Essentials server in your lab environment.  
  
- Customize the Windows Server Essentials image as needed.  
  
- Automate Windows Server Essentials deployment with unattended file and cfg.ini.  
  
- Migrate on-premises Windows SBS to hosted Windows Server Essentials.  
  
- Upgrade from Windows Server Essentials to Windows Server 2012.  
  
  **Server Configuration**  
  
- Configure Anywhere Access (VPN, Remote Web Access, DirectAccess).  
  
- Configure Storage and Server Folder.  
  
- (If applicable) Configure Server Backup, Online Backup, Client Backup, File History.  
  
- (If applicable) Configure and manage Storage Spaces.  
  
- (If applicable) Configure email solution integration (Office 365, hosted Exchange, and so on).  
  
- (If applicable) Configure Media Server.  
  
  **Server Management**  
  
- Manage users.  
  
- Configure and receive email notification of alerts.  
  
- Run BPA in case of error/warning.  
  
- Configure System Center Monitoring Pack.  
  
- Configure server recovery, in case of corruption.  
  
  **Client Experience**  
  
- Client deployment over the internet (personal computer or Mac OS).  
  
- Use Launchpad on the client to access Shared Folder.  
  
- Access server assets over Remote Web Access, from different devices (personal computer, phone, tablet).  
  
- My Server app for Windows Phone.  
  
- (If applicable) File History, Client Backup and Restore (no BMR), Folder Redirection.  
  
- (If applicable) Email integration experience.  
  
## Where can I get more support?  
 You can get SDK and ADK documents from the links below:  
  
- [SDK](https://go.microsoft.com/fwlink/p/?LinkID=248648)  
  
- [ADK](https://go.microsoft.com/fwlink/p/?LinkID=249124)  
  
  You can report a bug to the feature team through Connect. To generate logs, zip the folder on both the server and the clients joining the server: C:\ProgramData\Microsoft\Windows Server\Logs.
