---
title: Configure a Server Core Server with Sconfig.cmd
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - server-general
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9e024a2d-484c-43dd-b67a-8e2ad799723f
author: jaimeo
---
# Configure a Server Core Server with Sconfig.cmd
In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], you can use the Server Configuration tool \(Sconfig.cmd\) to configure and manage several common aspects of Server Core installations. You must be a member of the Administrators group to use the tool.  
  
Sconfig.cmd is available in the Minimal Server Interface and in Server with a GUI mode.  
  
#### To start the Server Configuration Tool  
  
1.  Change to the system drive.  
  
2.  Type **Sconfig.cmd**, and then press ENTER. The Server Configuration tool interface opens:  
  
![](../Image/Sconfigcmdscreenshot.gif)  
  
## <a name="BKMK_Domainworkgroup"></a>Domain\/Workgroup settings  
The current Domain\/Workgroup settings are displayed in the default Server Configuration tool screen. You can join a domain or a workgroup by accessing the **Domain\/Workgroup** settings page from the main menu and following the instructions on the following pages, supplying any required information.  
  
If a domain user has not been added to the local administrators group, you will not be able to make system changes, such as changing the computer name, by using the domain user. To add a domain user to the local administrators group, allow the computer to restart. Next, log on to the computer as the local administrator and follow the steps in the [Local administrator settings](assetId:///3c2f8ca4-6adc-4ebd-8daf-eb0de16c2c7d#BKMK_Localadministratorsettings) section later in this document.  
  
> [!NOTE]  
> You are required to restart the server to apply any changes to domain or workgroup membership. However, you can make additional changes and restart the server after all of the changes to avoid the need to restart the server multiple times. By default, running virtual machines are automatically saved prior to restarting the Hyper\-V Server.  
  
## Computer name settings  
The current computer name is displayed in the default Server Configuration Tool screen. You can change the computer name by accessing the “Computer Name” settings page from the main menu and following the instructions.  
  
> [!NOTE]  
> You are required to restart the server to apply any changes to domain or workgroup membership. However, you can make additional changes and restart the server after all of the changes to avoid the need to restart the server multiple times. By default, running virtual machines are automatically saved prior to restarting the Hyper\-V Server.  
  
## <a name="BKMK_Localadministratorsettings"></a>Local administrator settings  
To add additional users to the local administrators group, use the **Add Local Administrator** option on the main menu. On a domain joined machine, enter the user in the following format: domain\\username. On a non\-domain joined machine \(workgroup machine\), enter only the user name. The changes take effect immediately.  
  
## Network settings  
You can configure the IP address to be assigned automatically by a DHCP Server or you can assign a static IP address manually. This option allows you to configure DNS Server settings for the server as well.  
  
> [!NOTE]  
> These options and many more are now available using the Networking Windows PowerShell cmdlets. For more information, see [Network Adapter Cmdlets](http://technet.microsoft.com/library/jj134956.aspx) in the Windows Server Library.  
  
## Windows Update settings  
The current Windows Update settings are displayed in the default Server Configuration Tool screen. You can configure the server to use Automatic or Manual updates on the **Windows Update Settings** configuration option on the main menu.  
  
When **Automatic Updates** are selected, the system will check for and install updates every day at 3:00 AM. The settings take effect immediately. When **Manual** updates are selected, the system will not check for updates automatically.  
  
At any time, you can download and install applicable updates from the **Download and Install Updates** option on the main menu.  
  
## Remote Desktop settings  
The current status of remote desktop settings is displayed in the default Server Configuration Tool screen. You can configure the following Remote Desktop settings by accessing the **Remote Desktop** main menu option and following the instructions on screen.  
  
-   enable Remote Desktop for Clients running Remote Desktop with Network Level Authentication  
  
-   enable Remote Desktop for clients running any version of Remote Desktop  
  
-   disable Remote  
  
## Date and time settings  
You can access and change date and time settings by accessing the **Date and Time** main menu option  
  
## To enable remote management  
You can enable various remote management scenarios from the **Configure Remote Management** main menu option:  
  
-   Microsoft Management Console remote management  
  
-   Windows PowerShell  
  
-   Server Manager  
  
## To log off, restart, or shut down the server  
To log off, restart, or shut down the server, access the corresponding menu item from the main menu. These options are also available from the Windows Security menu which can be accessed from any application at any time by pressing CTRL\+ALT\+DEL.  
  
## To exit to the command line  
Select the **Exit to the Command Line** option and press ENTER to exit to the command line. To return to the Server Configuration Tool, type **Sconfig.cmd**, and then press ENTER  
  
