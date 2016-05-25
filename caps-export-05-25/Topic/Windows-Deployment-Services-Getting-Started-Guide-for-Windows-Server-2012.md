---
title: Windows Deployment Services Getting Started Guide for Windows Server 2012
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5aa8ea78-8f95-459a-9e9a-cd96a3d698b9
---
# Windows Deployment Services Getting Started Guide for Windows Server 2012
This guide contains step\-by\-step guidance for how to use the Windows Deployment Services role. This guide focuses on the functionality of the complete installation of Windows Deployment Services.  
  
## <a name="WDS_Inthisguide"></a>In this guide  
**Contents**  
  
-   [Quick start checklist](#WDS_WhatisWindowsDeploymentServices)  
  
-   [What is Windows Deployment Services?](#WDS_WhatisWindowsDeploymentServices)  
  
-   [What’s new in Windows Deployment Services?](#WDS_WhatsnewinWindowsDeploymentServices)  
  
-   [Who should use this guide?](#WDS_Whoshouldusethisguide)  
  
-   [Benefits of Windows Deployment Services](#WDS_BenefitsofWindowsDeploymentServices)  
  
-   [Installing Windows Deployment Services](#WDS_InstallingWindowsDeploymentServices)  
  
-   [Configuring Windows Deployment Services](#WDS_ConfiguringWindowsDeploymentServices)  
  
-   [Installing Windows Deployment Services integrated with Active Directory](#WDS_InstallingWindowsDeploymentServicesintegratedwithActiveDirectory)  
  
-   [Steps for adding images](#WDS_Stepsforaddingimages)  
  
-   [Creating custom install images](#BKMK_CreateCustomInstall)  
  
-   [Creating discover images](#WDS_Creatingdiscoverimages)  
  
-   [Performing an unattended installation](#WDS_Performinganunattendedinstallation)  
  
-   [Creating a multicast transmission](#WDS_Creatingamulticasttransmission)  
  
-   [Additional References](#WDS_AdditionalReferences)  
  
## Quick start checklist  
To get up and running quickly, perform the following steps. Then you can use the instructions in the rest of this guide to perform more advanced tasks such as creating your own install images, creating discover images, or configuring an unattended installation.  
  
|Task|Reference|  
|--------|-------------|  
|Install Windows Deployment Services.|[Installing Windows Deployment Services](#WDS_InstallingWindowsDeploymentServices)|  
|Configure the server and add the default images \(Install.wim and Boot.wim\) that are included on the installation media \(in the \\Sources folder\).|[Configuring Windows Deployment Services](#WDS_ConfiguringWindowsDeploymentServices)|  
|Install an operating system.|[Installing an install image](#BKMK_InstallingInstallImage)|  
  
## <a name="WDS_WhatisWindowsDeploymentServices"></a>What is Windows Deployment Services?  
Windows Deployment Services enables you to deploy Windows operating systems. You can use it to set up new computers by using a network\-based installation. This means that you do not have to install each operating system directly from installation media, for example a DVD or USB drive.  
  
## <a name="WDS_WhatsnewinWindowsDeploymentServices"></a>What’s new in Windows Deployment Services?  
Windows Deployment Services has evolved as each version is released. You can read about the new features and improvements in Windows Deployment Services in [What’s New in Windows Deployment Services](http://technet.microsoft.com/library/hh974416).  
  
## <a name="WDS_Whoshouldusethisguide"></a>Who should use this guide?  
Windows Deployment Services is intended for deployment specialists who are responsible for the deployment of Windows operating systems. This guide assumes that you have a working knowledge of common desktop deployment technologies, as well as networking components such as Dynamic Host Configuration Protocol \(DHCP\), Domain Name System \(DNS\), and Active Directory Domain Services \(AD DS\). The target audiences are:  
  
-   IT planners or analysts evaluating Windows 7, Windows 8, [!INCLUDE[winblue_client_1](../Token/winblue_client_1_md.md)], Windows Server 2008 R2, Windows Server 2012, and [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)].  
  
-   Enterprise IT planners or designers.  
  
-   Deployment specialists interested in deploying images to computers.  
  
## <a name="WDS_BenefitsofWindowsDeploymentServices"></a>Benefits of Windows Deployment Services  
Windows Deployment Services provides the following benefits:  
  
-   Allows network\-based installation of Windows operating systems, including Windows 7, Windows 8, [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], Windows Server 2008 R2, Windows Server 2012, and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. It reduces the complexity and cost when compared to manual installations.  
  
-   Deploys Windows images to computers without operating systems.  
  
-   Supports mixed environments that include Windows Vista, Windows 7, Windows 8, [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], Windows Server 2008 R2, Windows Server 2012, [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], Windows XP, and Windows Server 2003.  
  
-   Uses standard Windows Server setup technologies, including Windows PE, .wim files, and image\-based setup.  
  
## <a name="WDS_InstallingWindowsDeploymentServices"></a>Installing Windows Deployment Services  
  
### Prerequisites for installing Windows Deployment Services  
The following are requirements for installing this role, depending on whether you choose the default installation \(both Deployment Server and Transport Server\), or only the Transport Server role service.  
  
|Deployment Server and Transport Server<br /><br />\(integrated with Active Directory\)|Transport Server|  
|----------------------------------------------------------------------------------|--------------------|  
|-   **AD DS**. A Windows Deployment Services server must be either a member of an AD DS domain or a domain controller for an AD DS domain. The AD DS domain and forest versions are irrelevant; all domain and forest configurations support Windows Deployment Services.<br />-   **DHCP**. You must have a working DHCP server with an active scope on the network because Windows Deployment Services uses PXE, which relies on DHCP for IP addressing.<br />-   **DNS**. You must have a working DNS server on the network before you can run Windows Deployment Services.<br />-   **NTFS volume**. The server running Windows Deployment Services requires an NTFS file system volume for the image store.<br />-   **Credentials**. To install the role, you must be a member of the Local Administrators group on the server. To initialize the server, you must be a member of the Domain Admins group.|The only prerequisite is that you must be a member of the Local Administrators group on the server to install Transport Server.|  
  
|Deployment Server and Transport Server<br /><br />\(Standalone mode, no dependency on Active Directory\)|Transport Server|  
|----------------------------------------------------------------------------------------------------|--------------------|  
|-   **NTFS volume**. The server running Windows Deployment Services requires an NTFS file system volume for the image store.<br />-   **DNS**. You must have a working DNS server on the network before you can run Windows Deployment Services.<br />-   **DHCP**. You must have a working DHCP server with an active scope on the network because Windows Deployment Services uses PXE, which relies on DHCP for IP addressing.<br />-   **Credentials**. To install the role, you must be a member of the Local Administrators group on the server.|The only prerequisite is that you must be a member of the Local Administrators group on the server to install Transport Server.|  
  
### Installation Methods  
You can install Windows Deployment Services by using Server Manager, or using Windows PowerShell.  
  
##### To install using Server Manager  
  
1.  In Server Manager, click **Manage**.  
  
2.  Click **Add roles and features**.  
  
3.  Select Role\-based or feature\-based installation and choose the server to deploy WDS.  
  
4.  On the **Select server roles** page select the **Windows Deployment Services** check box.  
  
5.  Click **Next** and follow the wizard to completion.  
  
During installation, on the **Select role services** page, the wizard presents the option to select role services to be installed in Windows Deployment Services. You can choose to install the Deployment Server and Transport Server, or leave both roles selected.  
  
-   **Transport Server**. This option provides a subset of the functionality of Windows Deployment Services. It contains only the core networking parts. You can use Transport Server to create multicast namespaces that transmit data \(including operating system images\) from a standalone server. You can also use it if you want to have a PXE server that allows clients to PXE boot and download your own custom setup application. You should use this option if you want to use either of these scenarios , but you do not want to incorporate all of Windows Deployment Services.  
  
-   **Deployment Server**. This option provides the full functionality of Windows Deployment Services, which you can use to configure and remotely install Windows operating systems. Note that Deployment Server is dependent on the core parts of Transport Server.  
  
    > [!NOTE]  
    > When you install Windows Deployment Services, it will automatically provide the option \(selected by default\) to install the Remote Server Administration Tools.  
    >   
    > You can also add this feature by using the Add Roles and Features Wizard and checking **Remote Server Administration Tools** on the **Select feature** page.  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]  
  
In [!INCLUDE[wps_2](../Token/wps_2_md.md)], unlike in the [!INCLUDE[arfw](../Token/arfw_md.md)], management tools and snap\-ins for a role are not included by default. To include management tools as part of a role installation, add the `-IncludeManagementTools` parameter to the cmdlet. If you are installing roles and features on a server that is running a Server Core Installation and you add a role’s management tools to an installation, you are prompted to change the installation option to a minimal\-shell option that allows the management tools to run. Otherwise, management tools and snap\-ins cannot be installed on servers that are running the Server Core Installation option of Windows Server.  
  
##### To install using Windows PowerShell  
  
1.  Do one of the following to open a [!INCLUDE[wps_2](../Token/wps_2_md.md)] session with elevated user rights.  
  
    -   On the Windows desktop, right\-click **Windows PowerShell** on the taskbar, and then click **Run as Administrator**.  
  
    -   On the Windows **Start** page, type any part of the name **Windows PowerShell**. Right\-click the shortcut for [!INCLUDE[wps_2](../Token/wps_2_md.md)] when it is displayed on the **Start** page in the **Apps** results, click **Advanced**, and then click **Run as Administrator**. To pin the [!INCLUDE[wps_2](../Token/wps_2_md.md)] shortcut to the **Start** page, right\-click the shortcut, and then click **Pin to Start**.  
  
2.  Type the following, and then press **Enter**, where *computer\_name* represents a remote computer on which you want to install Hyper\-V. To install WDS directly from a console session, do not include `-ComputerName <computer_name>` in the command.  
  
    ```  
    Install-WindowsFeature –Name WDS -ComputerName <computer_name> -IncludeManagementTools  
    ```  
  
3.  To view a list of available and installed roles and features on the local server, type **Get\-WindowsFeature** and then press **Enter**. The results of the cmdlet contain the command names of roles and features that have been added to this computer.  
  
    > [!NOTE]  
    > In [!INCLUDE[wps_2](../Token/wps_2_md.md)] 4.0, there is no need to import the [!INCLUDE[sm](../Token/sm_md.md)] cmdlet module into the [!INCLUDE[wps_2](../Token/wps_2_md.md)] session before running cmdlets that are part of the module. A module is automatically imported the first time you run a cmdlet that is part of the module. Also, [!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlets are not case\-sensitive.  
  
4.  When the installation is finished, verify installation by running `Get-WindowsFeature`. If you installed WDS remotely, include the `ComputerName` parameter \(`Get-WindowsFeature –ComputerName` <*computer\_name*>\) to view a list of roles and features that are installed on the server.  
  
> [!NOTE]  
> This will install both the Deployment Server and the Transport Server roles. The previous command line tool, Servermanagercmd.exe, was deprecated in Windows Server 2012. It is recommended that you use the Windows PowerShell cmdlets.  
  
### Install Windows Deployment Services  
  
##### To install the Windows Deployment Services role  
  
1.  Sign in to the server as a member of the local Administrators group.  
  
2.  Server Manager will start automatically. If it does not automatically start, click **Start**, type servermanager.exe, and then click **Server Manager**.  
  
3.  Click **Manage**.  
  
4.  Click **Add roles and features**, click **Next**.  
  
5.  On the **Before you begin** page of the **Add Roles and Features Wizard**, click **Next**.  
  
6.  On the **Select installation type** page, click **Role\-based or feature\-based installation**, and then click **Next**.  
  
7.  On the **Select destination server** page, select the appropriate server, and then click **Next**. The local server is selected by default.  
  
8.  On the **Select server roles** page, scroll down and then select the **Windows Deployment Services** check box. Click **Next**.  
  
9. Remote Server Administration Tools are required to manage this feature. Select **Include management tools \(if applicable\)**. Click **Add Features**.  Click **Next**.  
  
10. On the **Select features** page, click **Next**.  
  
11. On the **Select role services** page, select the role services to install for Windows Deployment Services. If you wish to install both the Deployment Server and Transport Server, leave these role services selected. Click **Next**.  
  
12. On the **Confirm installation selections** page, click **Install**.  
  
13. Windows Deployment Services will now be added to the server. Installation progress will now be illustrated in the Add Roles and Features Wizard.  
  
> [!NOTE]  
> For an Active Directory integrated installation, the Deployment Server requires that Active Directory Domain Services, DHCP, and DNS services are available on your network. Transport Server does not require any additional roles or services. Both of these services require an NTFS partition for the file store.  
  
> [!NOTE]  
> Before you begin, you need to configure Windows Deployment Services by running either the Windows Deployment Services Configuration Wizard or WDSUtil.exe. You will also need to add at least one boot image and one install image to the image store.  
  
> [!NOTE]  
> To install Windows operating systems from a Windows Deployment Services server, either the client computers must be PXE\-enabled, or you must use the latest version of the Windows Pre\-Installation Environment \(Windows PE\). See Windows Assessment and Deployment Kit \(ADK\) for [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)]in [Additional References](../Topic/Windows-Deployment-Services-Getting-Started-Guide-for-Windows-Server-2012.md#WDS_AdditionalReferences).  
  
## <a name="WDS_ConfiguringWindowsDeploymentServices"></a>Configuring Windows Deployment Services  
After you install the Windows Deployment Service role, you must configure the server. Once you have used the instructions in this section to configure the server, add a boot image, and an install image, you will be ready to deploy images. Then, you can use the instructions in the rest of this guide to perform more advanced tasks like creating your own install images, creating discover images, or configuring an unattended installation.  
  
### Prerequisites for configuring Windows Deployment Services  
  
1.  If Windows Deployment Services is integrated with Active Directory, the server must be a member of an Active Directory Domain Services \(AD DS\) domain, or a domain controller for an AD DS domain. If Windows Deployment Services is installed in Standalone mode, it can be configured without having a dependency on Active Directory.  
  
2.  There is an active DHCP server on the on Windows Deployment Services uses Pre\-Execution Environment \(PXE\), which relies on DHCP for IP addressing.  
  
3.  There is an active DNS server on the network.  
  
4.  The server has an NTFS file system partition on which to store images.  
  
### Steps for configuring Windows Deployment Services for Standalone Server  
There are two configuration options for Windows Deployment Services. It can be configured to integrate with Active Directory or be configured as a standalone server.  
  
To configure the server role in Standalone mode, use the following procedure. Then see the following section to add images to the server.  
  
##### To configure Windows Deployment Services in Standalone mode  
  
1.  Log on to the server as a member of the local Administrators group.  
  
2.  Server Manager will start automatically. If it does not automatically start, click **Start**, type **servermanager.exe**, and then click **Server Manager**.  
  
3.  Click **Tools**, and then click **Windows Deployment Services** to launch the Windows Deployment Services MMC\-snap \(or console\).  
  
4.  In the left pane of the Windows Deployment Services MMC snap\-in, expand the list of servers.  
  
5.  Right\-click the desired server, click **Configure Server**.  
  
6.  On the **Before you begin** page, click **Next**.  
  
7.  On the **Install options** page, choose **Standalone server**.  
  
8.  On the **Remote Installation Folder Locations** page, choose the default path or enter your own path to the remote installation folder. Click **Next**.  
  
9. On the **PXE Server Initial Settings** page, choose desired option to define which client computers this server will respond to. Click **Next**. This will complete the configuration of Windows Deployment Services.  
  
10. When the configuration is completed clear the **Add images to server now** check box, and then click **Finish**.  
  
11. If you want to modify any of the settings of the server, right\-click the server in the MMC\-snap in, and click **Properties**.  
  
Now that you have configured the server, you will need to add images. These images include a boot image \(which is the bootable environment that you initially boot the computer into, and the install images \(which are the actual images that you deploy\). For instructions, see [Steps for adding images](../Topic/Windows-Deployment-Services-Getting-Started-Guide-for-Windows-Server-2012.md#WDS_Stepsforaddingimages).  
  
## <a name="WDS_InstallingWindowsDeploymentServicesintegratedwithActiveDirectory"></a>Installing Windows Deployment Services integrated with Active Directory  
This section describes installing Windows Deployment Services integrated with Active Directory. You may skip this if you have chosen to install Standalone mode, and proceed to [Steps for adding images](../Topic/Windows-Deployment-Services-Getting-Started-Guide-for-Windows-Server-2012.md#WDS_Stepsforaddingimages).  
  
### Prerequisites for installing Windows Deployment Services  
The following are requirements for installing this role, depending on whether you choose the default installation \(both Deployment Server and Transport Server\), or only the Transport Server role service.  
  
To install Windows Deployment Services integrated with Active Directory, the following prerequisites are required.  
  
|||  
|-|-|  
|Deployment Server and Transport Server|Transport Server|  
|-   **AD DS**. A Windows Deployment Services server must be either a member of an AD DS domain or a domain controller for an AD DS domain. The AD DS domain and forest versions are irrelevant; all domain and forest configurations support Windows Deployment Services.<br />-   **DHCP**. You must have a working DHCP server with an active scope on the network because Windows Deployment Services uses PXE, which relies on DHCP for IP addressing.<br />-   **DNS**. You must have a working DNS server on the network before you can run Windows Deployment Services.<br />-   **NTFS volume**. The server running Windows Deployment Services requires an NTFS file system volume for the image store.<br />-   **Credentials**. To install the role, you must be a member of the Local Administrators group on the server. To initialize the server, you must be a member of the Domain Admins group.|The only prerequisite is that you must be a member of the Local Administrators group on the server to install Transport Server.|  
  
### Steps for configuring Windows Deployment Services integrated with Active Directory  
To configure the Windows Deployment Services server role integrated with Active Directory, use the following procedure.  
  
##### To configure Windows Deployment Services integrated with Active Directory  
  
1.  Log on to the server as a member of the Domain Administrators group.  
  
2.  Server Manager will start automatically. If it does not automatically start, click **Start**, type **servermanager.exe**, and then click **Server Manager**.  
  
3.  Click **Tools**, and then click **Windows Deployment Services** to launch the Windows Deployment Services MMC\-snap \(or console\).  
  
4.  In the left pane of the Windows Deployment Services MMC snap\-in, expand the list of servers.  
  
5.  Right\-click the desired server, click **Configure Server**.  
  
6.  On the **Before you begin** page, click **Next**.  
  
7.  On the **Install options** page, choose **Integrated with Active Directory**.  
  
8.  On the **Remote Installation Folder Locations** page, choose the default path or enter your own path to the remote installation folder. Click **Next**.  
  
9. If your server is running as a DHCP Server, you will see the **Proxy DHCP Server** page. Select **Do not listen on DHCP and DHCPv6 ports** and **Configure DHCP options for Proxy DHCP**. Click **Next**.  
  
10. On the **PXE Server Initial Settings** page, choose desired option to define which client computers this server will respond to. Click **Next**. This will complete the configuration of Windows Deployment Services.  
  
11. When the configuration is completed, click **Finish**.  
  
12. If you want to modify any of the settings of the server, right\-click the server in the MMC\-snap in, and click **Properties**.  
  
Now that you have configured the server integrated with Active Directory, you will need to add your images. These images include a boot image \(which is the bootable environment that you initially boot the computer into, and the install images \(which are the actual images that you deploy\). For instructions, see the next section, Steps for adding images.  
  
## <a name="WDS_Stepsforaddingimages"></a>Steps for adding images  
You must add at least one boot image and one install image before you will be able to boot to the Windows Deployment Services server and install an image.  
  
-   **Boot images**. Boot images are Windows PE images that you boot a client computer into to perform an operating system installation. In most scenarios, you should use the Boot.wim file from the installation media \(in the \\Sources folder\).  The Boot.wim file contains Windows PE and the Windows Deployment Services client.  
  
-   **Install images**. Install images are the operating system images that you deploy to the client computer. You can also use the Install.wim file from the installation media \(in the \\Sources folder\), or you can create your own install image by using the steps in [Creating custom install images](#BKMK_CreateCustomInstall) later in this guide.  
  
The following instructions use Windows 7 installation media as an example for creating an install image that can be deployed with Windows Deployment Services. You can also use the same instructions for server installation media.  
  
To add the default images, use the following procedures.  
  
#### To add the default boot image included on the product installation media  
  
1.  In the left pane of the Windows Deployment Services MMC snap\-in, right\-click the **Boot Images** node, and then click **Add Boot Image**.  
  
2.  Browse to choose the default boot image \(Boot.wim\) on the Windows installation media, located in the **\\Sources** folder.  
  
3.  Click **Open**, and then click **Next**.  
  
4.  On the **Image Metadata** page, enter the desired image name and description. Click **Next**.  
  
5.  On the **Summary** page, click **Next**.  
  
Repeat this procedure to add any additional boot images.  
  
### <a name="BKMK_InstallingInstallImage"></a>Installing an install image  
After you have at least one boot and one install image on the server, you can deploy an install image.  
  
### Prerequisites for installing an install image  
  
-   The client computer must be capable of performing a PXE boot.  
  
-   The client computer must have at least 512 MB of RAM, which is the minimum amount of RAM for using Windows PE.  
  
-   The client must meet the system requirements for the operating system of the install image.  
  
-   A local user account must be a created on the Windows Deployment Services server.  
  
### Steps for installing an install image  
To perform a PXE boot on a computer to install an image, use the following procedure.  
  
##### To install an operating system  
  
1.  Configure the BIOS of the computer to enable PXE booting, and set the boot order so that it is booting from the network first.  
  
2.  Restart the computer, and when prompted, press F12 to start the network boot.  
  
3.  Select the appropriate boot image from the boot menu. \(This boot image selection menu will be available only if you have two or more boot images on the server.  
  
4.  At the **Install Windows** page, choose your **Locale and Keyboard or Input Method**. Click **Next**.  
  
5.  At the **Connect to Your WDS Server** authentication dialog, enter your local user account and password. Click **OK**.  
  
6.  At the **Install Windows** dialog box, select the operating system you wish to install. If you only have one operating system to install, choose that and click **Next**.  
  
7.  If prompted at the **Where do you want to install Windows** page, select the partition you wish to install the operating system on. Click **Next**.  
  
8.  When the installation is completed, the computer will restart and Setup will continue.  
  
### Boot Image and Install Image Priorities  
When you have multiple boot or install images available to client computers, clients will be presented with a boot and an install menu that displays the selection of images to choose from.  
  
Windows Deployment Services allows you to set priorities to control the order that both boot and install image listings are presented to clients.  This ability is integrated directly into Windows Deployment Services.  
  
### Steps for configuring the boot menu  
  
##### To configure menu order for boot images  
  
1.  Open the Windows Deployment Services MMC snap\-in.  
  
2.  Click the **Boot Images** node. You will see your boot images appear in the right hand side of your Windows Deployment Services MMC snap\-in.  
  
3.  Right\-click your desired boot image from the right\-hand side of your Windows Deployment Services MMC snap\-in. Click **Properties**.  
  
4.  In the **Image Properties** dialog, on the **General** tab, enter in your desired priority into the Priority text box. The items that appear first on your install image menu are the ones with the lowest value.  
  
5.  Click **OK**.  
  
##### To configure menu order for install images  
  
1.  Open the Windows Deployment Services MMC snap\-in.  
  
2.  Double\-click the **Install Images** node. You will see your image group \(or image groups\) appear as a sub menu item. They will also appear in the right hand side of your Windows Deployment Services MMC snap\-in.  
  
3.  Click your desired **Image Group**.  
  
4.  Right\-click your desired image within your image group from the right\-hand side of your Windows Deployment Services MMC snap\-in. Click **Properties**.  
  
5.  On the **Image Properties** dialog, in the **General** tab, enter in your desired priority into the **Priority** text box. The items that appear first on your install image menu are the ones with the lowest value.  
  
6.  Click **OK**.  
  
When you have completed this procedure and you perform a PXE boot on a client computer, a boot or install menu with the menu order you set using priorities will appear. \(if those images apply to that computer\).  
  
Priorities are pre\-populated with a default value that lets you place images higher or lower on the list. The items that appear first on the list are the ones with the lowest value.  
  
## <a name="BKMK_CreateCustomInstall"></a>Creating custom install images  
Optionally, you can create custom install images for [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], and [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)]. To do this, use the instructions in this section to create a capture boot image, prepare a reference computer using Sysprep, and then capture the operating system using the Image Capture Wizard.  
  
### Prerequisites for creating custom install images  
  
-   You must ensure that there is enough disk space to create and store the new images.  
  
-   You must be a member of the Local Administrators group on the Windows Deployment Services server.  
  
### Known issues when creating custom install images  
When you boot into the capture image, the Image Capture Wizard will start. Note the following points about this wizard:  
  
-   You will only see drives that contain operating systems prepared with Sysprep.  
  
-   If you do not run Sysprep on the computer before you boot into the image, you will not see any drives to capture.  
  
You must enter a local location to save the new install image; otherwise, you will not be able to capture the image. This location can be a mapped network drive but we recommend that you use a local location to avoid image corruption in the event of a network malfunction.  
  
### Steps for creating a capture image  
To create an install image, you must first create a capture image. Capture images are boot images that you boot a client computer into to capture the operating system into a .wim file. You can also create media \(a CD, DVD, USB drive, or other type of media\) that contains a capture image, and then boot a computer from the media. These images provide an alternative to the command\-line utility, ImageX.exe. Except in advanced scenarios, you can create a capture image by using the Boot.wim file from the Windows installation media.  
  
##### To create a capture image  
  
1.  In the Windows Deployment Services MMC snap\-in, expand the **Boot Images** node.  
  
2.  Right\-click the image to use it as a capture image. In most cases, you can just use the Boot.wim file from the installation media.  
  
3.  Click **Create Capture Image**.  
  
4.  Type in your Image Name, Image Description, and the location and file name where you want to save a local copy of the file. You must specify a location in case there is a problem with the network when you deploy the capture image. Click Next.  
  
5.  Allow the Create Capture Image Wizard to complete.  
  
6.  Tick **Add Image to the Windows Deployment Server now**. Click **Next**  
  
7.  Enter the location of the Windows Image file that contains the images. Click **Next**.  
  
8.  Enter your **Image Name** and **Image Description**. Click **Next**.  
  
9. On the **Summary** page, click **Next**.  
  
10. Click **Finish**.  
  
After you have created the capture image, follow the instructions in the next section to boot a computer into the capture image and capture the operating system.  
  
### Steps for creating an install image  
Now that you have a capture image, you need to prepare a reference computer and then create the install image. The reference computer can be a computer with a standard Windows installation or a Windows installation that has been configured for your environment. First, you boot a computer \(which has been prepared with Sysprep\) into the capture image. Then a wizard creates an install image of the reference computer and saves it as a .wim file. After that, you can deploy the .wim file to a computer.  
  
##### To create a custom install image  
  
1.  Create a reference computer \(install the operating system, applications, and make any other changes that you want\).  
  
2.  Ensure that you have the correct version of Sysprep.exe on the computer.  
  
3.  At a command prompt on the reference computer, change folders to \\Windows\\System32\\Sysprep or the folder that contains Sysprep.exe and Setupcl.exe.  
  
4.  Type one of the following:  
  
    -   On computers running [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)], [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] run the command `sysprep /oobe /generalize /reboot`. If you prefer, you can also use the Sysprep graphical user interface by double\-clicking Sysprep.exe.  
  
5.  When the computer restarts, perform a network boot on the computer by pressing F12.  
  
6.  In the boot menu, select the capture boot image that you created in the preceding procedure, and then press ENTER.  
  
7.  You will be presented with the Windows Deployment Services Image Capture Wizard. Click **Next**.  
  
8.  On the **Directory to Capture** page, select **Volume to capture**, enter your **Image name** and **Image description**. Click **Next**.  
  
    > [!IMPORTANT]  
    > Referring to **Volume to capture**, you will see only drives that contain operating systems prepared with Sysprep. If you do not run the command in step 4, you will not see any drives to capture.  
  
9. Click **Browse** next to Name and location and browse to a local folder where you want to store the captured install image. Type a name for the image, using the .wim file name extension, and then click **Save**. Note that this location can be a mapped network drive.  
  
    > [!IMPORTANT]  
    > You must enter a local location to save the new image; otherwise, you will not be able to capture the image. This requirement is enforced to avoid image corruption if there is a network malfunction.  
  
10. Select the **Upload Image to a Windows Deployment Services** check box.  
  
11. Click **Connect**. If prompted for credentials, provide a user name and password for an account with permissions to connect to the Windows Deployment Services server.  
  
12. Select your **Image Group Name**. Click **Next**. The wizard will now complete and create a custom installation image and store it in the Windows Deployment Services store.  
  
13. Click **Finish**.  
  
When this process is complete, you can PXE boot a client computer to install this image. The image will be listed in the installation option.  
  
## <a name="WDS_Creatingdiscoverimages"></a>Creating discover images  
If you have a computer that is not PXE enabled, you can create a discover image and use it to install an operating system on that computer. Otherwise, you can skip this section. When you create a discover image and save it to media \(a CD, DVD, USB flash drive, or other type of media\), you can then boot a computer to the media.  
  
The discover image on the media locates a Windows Deployment Services server, and the server deploys the install image to the computer. You can configure discover images to target a specific Windows Deployment Services server. This means that if you have multiple servers in your environment, you can create a discover image for each one, and then name them based on the name of the server.  
  
### Prerequisites for creating discover images  
  
-   Have CD or DVD or flash drive to store the image.  
  
-   Have a disk\-burning utility if you are burning the image to CD or DVD.  
  
### Steps for creating discover images  
After you create the discover image, you will need to create media that contains the image. You must create discover images by using the Boot.wim file from your Windows installation media.  
  
##### To create a discover image  
  
1.  In the Windows Deployment Services MMC snap\-in, expand the **Boot images** node.  
  
2.  Right\-click the image you want to use as a discover image.  
  
3.  Click **Create Discover Image**.  
  
4.  In the **Metadata and Locations** page, enter your **Image Name** and **Image Description**. In the location and file name, click **Browse** and select the location for storing your discover boot image. Enter the name of your discover image. Optionally, enter the name of your Windows Deployment Services server that you want to respond when you boot a computer into this image. Click **Next**.  
  
5.  Click **Finish**.  
  
Use the following procedure to create media that contains the image.  
  
This following example details how to create media that contains a discovery image. However, it is an example only; you can substitute any values you require. For example, different architecture and folder names and locations.  
  
##### To create media that contains the discover image  
  
1.  Download and install the [Windows Assessment and Deployment Kit for Windows 8](http://www.microsoft.com/download/details.aspx?id=29929).  
  
2.  Log on to the server as a member of the local Administrators group.  
  
3.  Click **Start**, click **Deployment and Imaging Tools**. Otherwise, type **Deployment and Imaging Tools**, and then click **Deployment and Imaging Tools** from the search results pane. You will be presented with a Command Prompt window.  
  
4.  To create a Windows PE build environment, type:  
  
    ```  
    CopyPE  x86   c:\MYWinPEFolder.  
    ```  
  
5.  To copy the discover image that you created in the preceding procedure, type:  
  
    ```  
    copy /y c:\discover.wim C:\MYWinPEFolder\media\sources  
    ```  
  
6.  To change back to the Windows PE tools folder, type:  
  
    ```  
    cd C:\Program Files (x86)\Windows Kits\8.0\Assessment and Deployment Kit\Deployment Tools\x86\Oscdimg  
    ```  
  
7.  To create the bootable .iso image, type:  
  
    ```  
    oscdimg -n"C:\Program Files (x86)\Windows Kits\8.0\Assessment and Deployment Kit\Deployment Tools\x86\Oscdimg\eftsboot.com" C:\MYWinPEFolder\media\sources c:\discover.iso  
    ```  
  
8.  Use a utility that can create a CD or DVD to transfer the .iso image to the appropriate media.  
  
    > [!NOTE]  
    > Using the Windows copy command to copy the image to media will not create a bootable disk.  
  
9. Boot the client computer to the media. You may need to change the boot order in the client BIOS to do this. When the client boots to the media, your experience will be exactly the same as if you had booted to the network.  
  
## <a name="WDS_Performinganunattendedinstallation"></a>Performing an unattended installation  
Optionally, you can automate the entire installation. To do this, you use two different unattend files: one for the Windows Deployment Services UI screens, and one for the latter phases of Setup.  
  
-   **Windows Deployment Services client unattend file**. This file uses the Unattend.xml format and is stored on the Windows Deployment Services server in the C:\\RemoteInstall\\WDSClientUnattend folder. It is used to automate the Windows Deployment Services client user interface screens \(such as entering credentials, choosing an install image, and configuring the disk\).  
  
-   **Image unattend file**. This file can use either the Unattend.xml or Sysprep.inf format. It is stored in a subfolder \(either $OEM$ structure or \\Unattend\) in the per\-image folder. It is used to automate the remaining phases of setup \(for example, offline servicing, Sysprep specialize, and mini\-setup\).  
  
### Prerequisites for performing an unattended installation  
  
-   Ensure that you are a member of the Local Administrators group on the Windows Deployment Services server.  
  
-   Ensure that you have sufficient credentials to add a computer to a domain.  
  
### Steps for performing an unattended installation  
To automate the installation, create the appropriate unattend file depending on whether you are configuring the Windows Deployment Services screens or Windows Setup. We recommend that you use Windows System Image Manager \(included as part of the [Windows Assessment and Deployment Kit](http://www.microsoft.com/download/details.aspx?id=30652)\) to author the unattend files. The Windows System Image Manager \(Windows SIM\) creates and manages unattended Windows Setup answer files in a graphical user interface \(GUI\).  
  
You will then need to copy the unattend file to the appropriate location, and assign it for use. You can assign it at the server level or the client level. The server level assignment can further be broken down by architecture, enabling you to have different settings for x86\-based and x64\-based clients. Assignment at the client level overrides the server\-level settings.  
  
##### To associate a client unattend file by architecture  
  
1.  Create an Unattend.xml file with settings applicable to Windows Deployment Services.  
  
2.  Copy the client unattend file to a folder in the **RemoteInstall** folder. For example: **RemoteInstall\\WDSClientUnattend**.  
  
3.  Open the Windows Deployment Services MMC snap\-in, right\-click the server that contains the image that you want to associate the unattend file with, and then click **Properties**.  
  
4.  On the **Client** tab, select **Enable unattended installation**, browse to the appropriate unattend file, and then click **Open**.  
  
5.  Click **OK** to close the **Properties** page.  
  
##### To associate an image unattend file  
  
1.  Create an Unattend.xml file or Sysprep.inf file.  
  
2.  The next steps depend on which file you create:  
  
    -   **Save Sysprep.inf files.** Save these files to the $OEM$ structure of the image \(for example, D:\\RemoteInstall\\Images\\Windows XP\\winxpsp2\\$OEM$\\$1\\sysprep\\sysprep.inf\). Now when you deploy the image, Setup will automatically locate and use the Sysprep.inf file.  
  
    -   **Save Unattend.xml files.** Save Unattend.xml files to any location, and then associate the file with an image. To do this, open the WDS MMC snap\-in, right\-click the image that you want to associate with the unattend file, and then click **Properties**. On the **General** tab, click **Allow image to install in unattend mode**, click **Select File**, browse to select the unattend file, and then click **OK** twice. The Unattend.xml file will be saved to the following location:  
  
        \\RemoteInstall\\Images\\<imagegroup>\\<imagename>\\Unattend\\ImageUnattend.xml.  
  
## <a name="WDS_Creatingamulticasttransmission"></a>Creating a multicast transmission  
Multicast transmissions enable you to deploy an image to a large number of client computers without overburdening the network. When you create a multicast transmission, the image is sent over the network only once, which can drastically reduce the amount of network bandwidth that is used. Note that data is transferred only if clients request data.  
  
If no clients are connected \(that is, if the transmission is idle\), data will not be sent over the network. For information about using multicast functionality with Transport Server, see [Using Transport Server](http://go.microsoft.com/fwlink/?LinkID=115298).  
  
### Prerequisites for creating a multicast transmission  
  
-   Routers that support multicasting. In particular, Internet Group Membership Protocol \(IGMP\) snooping should be enabled on all devices. This will cause your network hardware to forward multicast packets only to those devices that are requesting data. If IGMP snooping is turned off, multicast packets are treated as broadcast packets, and will be sent to every device in the subnet.  
  
-   At least one install image that you want to transmit on the server.  
  
-   The Boot.wim file provided with [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
### Steps for creating a multicast transmission  
To enable multicasting for an image, you must create a multicast transmission for it. You have two options for creating a transmission:  
  
-   Right\-click the **Multicast Transmission** node, and then click **Create Multicast Transmission**.  
  
-   Right\-click an image, and then click **Create Multicast Transmission**.  
  
There are two types of multicast transmissions:  
  
-   **Auto\-Cast**. This option indicates that as soon as an applicable client requests an install image, a multicast transmission of the selected image begins. Then, as other clients request the same image, they too are joined to the transmission that is already started.  
  
-   **Scheduled\-Cast**. This option sets the start criteria for the transmission based on the number of clients that are requesting an image and\/or a specific day and time. If you do not select either of these check boxes, the transmission will not start until you manually start it.  
  
### Steps for configuring transmissions  
After a transmission has been created, you can perform the following actions:  
  
-   **Start the transmission**. If the transmission is the Scheduled\-Cast type, there is at least one client, and the transmission has not started yet, you can right\-click the transmission and then click **Start**.  
  
-   **Delete the transmission**. If you right\-click the transmission and click **Delete**, the multicast transmission stops and each client installation will fall back to using unicast transmission. That is, the client installations will not be deleted or stopped, but they will not use the multicast transmission to complete the installation.  
  
-   **Deactivate the transmission**. If you right\-click and then click **Deactivate**, each client that is currently installing will continue, but no new clients will be joined to the transmission. After each current client installation is completed, the transmission will be deleted. If there are no clients when you click this option, the transmission will be deleted instantly.  
  
-   **View the transmission's properties**. To view the properties, right\-click the transmission, and then click **Properties**. Note that you cannot edit the properties of a transmission after it is created. To make a change after you have created a transmission, you need to delete it and then recreate it.  
  
-   **Refresh the transmissions and data**. To do this, right\-click a transmission, and then click **Refresh**. You can also refresh the data by pressing F5.  
  
### Steps for configuring clients in a transmission  
After you have created the transmission, client computers can join it by selecting the image in the Windows Deployment Services client installation screens. Client computers can also join a transmission by using Wdsmcast.exe, a command\-line tool included in the Windows Assessment and Deployment Kit \(ADK\). You will find command line tool from the C:\\Program Files \(x86\)\\Windows Kits\\8.0\\Assessment and Deployment Kit\\Deployment Tools\\x86\\wdsmcast folder.  
  
When there are clients in a transmission, you can do any of the following:  
  
-   **View clients and see progress**. To view any connected clients, expand the **Multicast Transmissions** node, and click the image.  
  
-   **Stop a client installation**. To stop the installation completely, right\-click a client, and then click **Disconnect**. You should use this option with caution because the installation will fail and the computer could be left in an unusable state.  
  
-   **Disconnect a client from a multicast transmission**. To discontinue the transmission for a particular client but continue to transfer the image through unicasting, right\-click the client, and then click **Bypass multicast**.  
  
## <a name="WDS_AdditionalReferences"></a>Additional References  
  
### Understanding the Windows Assessment and Deployment Kit \(ADK\) for Windows 8.1  
Download the [Windows Assessment and Deployment Kit for Windows 8.1](http://www.microsoft.com/download/details.aspx?id=39982).  
  
Features available in the Windows Assessment and Deployment Kit \(ADK\) include:  
  
**Application Compatibility Toolkit \(ACT\)**  
  
The Application Compatibility Toolkit \(ACT\) helps IT Professionals understand potential application compatibility issues by identifying which applications are or are not compatible with the new versions of the Windows operating system. ACT helps to lower costs for application compatibility evaluation by providing an accurate inventory of the applications in your organization. ACT helps you to deploy Windows more quickly by helping to prioritize, test, and detect compatibility issues with your apps. By using ACT, you can become involved in the ACT Community and share your risk assessment with other ACT users. You can also test your web applications and web sites for compatibility with new releases of Internet Explorer. For more information, see [Application Compatibility Toolkit](http://msdn.microsoft.com/library/windows/desktop/dd562082(v=vs.85).aspx).  
  
**Deployment Tools**  
  
Deployment tools enable you to customize, manage, and deploy Windows images. Deployment tools can be used to automate Windows deployments, removing the need for user interaction during Windows setup. Tools included with this feature are Deployment Imaging Servicing and Management \(DISM\) command line tool, DISM PowerShell cmdlets, DISM API, Windows System Image Manager \(Windows SIM\), and OSCDIMG. For more information, see [Deployment and Imaging Tools Technical Reference](http://go.microsoft.com/fwlink/?LinkId=214548).  
  
**User State Migration Tool \(USMT\)**  
  
USMT is a scriptable command line tool that IT Professionals can use to migrate user data from a previous Windows installation to a new Windows installation. By using USMT, you can create a customized migration framework that copies the user data you select and excludes any data that does not need to be migrated. Tools included with the feature are ScanState, Loadstate, and USMTUtils command line tools. For more information, see [User State Migration Tool Technical Reference](http://go.microsoft.com/fwlink/?LinkId=214547).  
  
**Volume Activation Management Tool \(VAMT\)**  
  
The Volume Activation Management Tool \(VAMT\) enables IT professionals to automate and centrally manage the activation of Windows, Windows Server, Windows ThinPC, Windows POSReady 7, select add\-on product keys, and Office for computers in their organization. VAMT can manage volume activation using retail keys \(or single activation keys\), multiple activation keys \(MAKs\), or Windows Key Management Service \(KMS\) keys. For more information, see [Volume Activation Management Tool Technical Reference](http://go.microsoft.com/fwlink/?LinkId=214550).  
  
**Windows Performance Toolkit \(WPT\)**  
  
Windows Performance Toolkit includes tools to record system events and analyze performance data in a graphical user interface. Tools available in this toolkit include Windows Performance Recorder, Windows Performance Analyzer, and Xperf.  
  
**Windows Assessment Toolkit**  
  
Tools to discover and run assessments on a single computer. Assessments are tasks that simulate user activity and examine the state of the computer. Assessments produce metrics for various aspects of the system, and provide recommendations for making improvements.  
  
**Windows Assessment Services**  
  
Tools to remotely manage settings, computers, images, and assessments in a lab environment where Windows Assessment Services is installed. This application can run on any computer with access to the server that is running Windows Assessment Services.  
  
**Windows Preinstallation Environment \(Windows PE\)**  
  
Minimal operating system designed to prepare a computer for installation and servicing of Windows.  
  
