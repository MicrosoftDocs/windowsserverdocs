---
title: Deploy a Server Core Server
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - server-general
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6a3ce419-03ee-4d5f-acf3-f03d2847d9d0
author: jaimeo
---
# Deploy a Server Core Server
This topic addresses basic information concerning installation and deployment of [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] in Server Core mode.  
  
When you install [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], you can choose between **Server Core Installation** and **Server with a GUI**. The “Server with a GUI” option is the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] equivalent of the Full installation option available in Windows Server 2008 R2. The “Server Core Installation” option reduces the space required on disk, the potential attack surface, and especially the requirements for servicing and restarting the server, so we recommend that you choose the Server Core installation unless you have a particular need for the additional user interface elements and graphical management tools that are included in the “Server with a GUI” option. For this reason, the Server Core installation is now the default. Because you can freely switch between these options at any time later, one approach might be to initially install the Server with a GUI option, use the graphical tools to configure the server, and then later switch to the Server Core Installation option.  
  
If you choose the Server Core option, the standard user interface \(the “Server Graphical Shell”\) is not installed; you manage the server using remote user interface tools, Windows PowerShell, or, if necessary, locally using the command line \(or Windows PowerShell\). For more information about the differences between Server Core and Server with a GUI, the features included in each mode, switching between the modes, the Minimal Server Interface mode, and Features on Demand, see [http:\/\/technet.microsoft.com\/library\/hh831786](http://technet.microsoft.com/library/hh831786).  
  
## Initial installation  
At the time you run Setup, you have the option to install the server in Server Core mode or Server with a GUI mode.  
  
#### Using Setup to install the server directly in Server Core mode  
  
1.  Insert the appropriate [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] installation media into your DVD drive.  
  
2.  When the auto\-run dialog box appears, click **Install Now**.  
  
3.  Follow the instructions on the screen to complete Setup.  
  
4.  You will be prompted to set a password for the Administrator account.  
  
## Using an unattend file to install the server directly in Server Core mode  
Using an unattend file to install directly in Server Core mode enables you to perform most of the initial configuration tasks during Setup.  
  
#### To install directly in Server Core mode with an unattend file  
  
1.  Create a .xml file titled Unattend.xml by using a text editor or Windows System Image Manager.  
  
2.  Copy the Unattend.xml file to a local drive or shared network resource.  
  
3.  Boot your computer to Windows Preinstallation Environment \(Windows PE\).  
  
4.  Insert the media disk with the Server Core installation of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] into your disk drive. If the auto\-run Setup window appears, click **Cancel**.  
  
5.  Change to the drive that contains the installation media.  
  
6.  Run **setup \/unattend:<path>\\unattend.xml**, where *path* is the path to the Unattend.xml file.  
  
7.  Allow Setup to complete.  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Configure a Server Core Server](../Topic/Configure-a-Server-Core-Server.md)  
  
-   [Configure and Manage Server Core Installations](../Topic/Configure-and-Manage-Server-Core-Installations.md)  
  
-   [Windows Server Installation Options](../Topic/Windows-Server-Installation-Options.md)  
  
-   [Evaluation Versions and Upgrade Options for Windows Server 2012](http://go.microsoft.com/fwlink/?LinkId=260917)  
  
