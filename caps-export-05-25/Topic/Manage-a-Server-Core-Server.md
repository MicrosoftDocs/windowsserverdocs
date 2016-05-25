---
title: Manage a Server Core Server
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - server-general
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ddb147c1-621c-4b89-9003-81c93ba050d7
author: jaimeo
---
# Manage a Server Core Server
This topic explains the various methods available for managing a [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] server in Server Core mode, as well as how to add hardware and manage drivers. You can manage the server in the following ways:  
  
-   Locally and remotely using Windows PowerShell  
  
-   Remotely using Server Manager  
  
-   Remotely using an MMC snap\-in  
  
-   Remotely with Remote Desktop Services  
  
-   Converting the server to Server with a GUI mode  
  
|Task|Description|  
|--------|---------------|  
|[1.1. Manage with Windows PowerShell](../Topic/Manage-a-Server-Core-Server.md#BKMK_1.1)|You can manage servers in Server Core mode using Windows PowerShell either locally or remotely.|  
|[1.2 Manage with Server Manager](../Topic/Manage-a-Server-Core-Server.md#BKMK_1.5)|By running Server Manager on a remote computer, you can connect to a server that is in Server Core mode.|  
|[1.3 Manage with Microsoft Management Console](../Topic/Manage-a-Server-Core-Server.md#BKMK_1.4)|By using a Microsoft Management Console \(MMC\) snap\-in, you can connect to a server that is in Server Core mode.|  
|[1.4 Manage with Remote Desktop Services](../Topic/Manage-a-Server-Core-Server.md#BKMK_1.2)|By using another computer running Windows, you can use Remote Desktop Services to run scripts and tools on a server that is in Server Core mode.|  
|[1.5 Switch to Server with a GUI mode](../Topic/Manage-a-Server-Core-Server.md#BKMK_1.6)|You can switch the computer to Server with a GUI mode, use the usual user interface tools to accomplish your tasks, and then switch back to Server Core mode.|  
|[1.6 Add hardware and manage drivers locally](../Topic/Manage-a-Server-Core-Server.md#BKMK_1.7)|You can add hardware and manage drivers locally while in Server Core mode.|  
  
There are some important limitations and tips to keep in mind when you work with a server in Server Core mode:  
  
-   If you close all command prompt windows and want to open a new Command Prompt window, press CTRL\+ALT\+DELETE, click **Start Task Manager**, click **More Details**, click **File**, click **Run**, and then type **cmd.exe**. Alternatively, you can log off and log back on.  
  
-   If you close all Windows PowerShell windows and want to open a new one, press CTRL\+ALT\+DELETE, open Task Manager, click **More Details**. The File menu opens. In the **File** menu, click **Run new task**, and then start either Cmd.exe or Powershell.exe.  
  
-   Any command or tool that attempts to start Windows Explorer will not work. For example, **start .** used from a command prompt will not work.  
  
-   There is no support for HTML rendering or HTML help in Server Core mode.  
  
-   When in Server Core mode, there are no notifications for activation, new updates, or password expiration because these notifications require the Windows Explorer shell, which is not present in Server Core mode.  
  
-   If you need to write a script for managing a server in Server Core mode that requires the secure inclusion of an administrative password, see the scripting column on Microsoft TechNet \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=56421](http://go.microsoft.com/fwlink/?LinkID=56421)\).  
  
-   Server Core mode supports Windows Installer in quiet mode so that you can install tools and utilities from Windows Installer files.  
  
-   When installing Windows Installer packages on a server in Server Core mode, use the **\/qb** option to display the basic user interface.  
  
-   To change the time zone while in Server Core mode, run `Set-Date`.  
  
-   To change international settings while in Server Core mode, run **control intl.cpl**.  
  
-   Control.exe will not run on its own. You must run it with either Timedate.cpl or Intl.cpl.  
  
-   Winver.exe is not available in Server Core mode. To obtain version information use Systeminfo.exe.  
  
> [!NOTE]  
> [!INCLUDE[wps_howtorun](../Token/wps_howtorun_md.md)]  
  
## <a name="BKMK_1.1"></a>1.1. Manage with Windows PowerShell  
You can accomplish most management tasks locally or from a remote computer by using Windows PowerShell cmdlets and scripts. To start Windows PowerShell, run **powershell** in a command prompt.  
  
To run Windows PowerShell remotely, see [1.7. Enable Windows PowerShell remoting](../Topic/Configure-a-Server-Core-Server.md#BKMK_1.7)  
  
For more information about working with Windows PowerShell, see [http:\/\/technet.microsoft.com\/library\/hh857343.aspx](http://technet.microsoft.com/library/hh857343.aspx).  
  
## <a name="BKMK_1.5"></a>1.2 Manage with Server Manager  
Server Manager is a management console in Windows Server® 2012 that helps IT professionals provision and manage both local and remote Windows\-based servers from their desktops, without requiring either physical access to servers, or the need to enable Remote Desktop protocol \(RDP\) connections to each server. Although Server Manager is available in Windows Server 2008 R2 and Windows Server 2008, Server Manager has been completely redesigned for Windows Server 2012, to support remote, multi\-server management, and help increase the number of servers an administrator can manage.  
  
> [!NOTE]  
> You must use the version of Server Manager in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or that is available as part of the [Remote Server Administration Tools](http://go.microsoft.com/fwlink/p/?LinkID=238560) for Windows 8 download package. Older versions of Server Manager will not work.  
  
To enable your local server to be managed by Server Manager running on a remote server, run the Windows PowerShell cmdlet `Configure-SMRemoting.exe –Enable`.  
  
## <a name="BKMK_1.4"></a>1.3 Manage with Microsoft Management Console  
Many snap\-ins for Microsoft Management Console \(MMC\) can be use remotely to manage your Server Core server.  
  
#### To manage a server in Server Core mode that is a domain member with an MMC snap\-in  
  
1.  Start an MMC snap\-in, such as **Computer Management**.  
  
2.  In the left pane, right\-click the top of the tree and click **Connect to another computer**. \(In the Computer Management example, you would right\-click **Computer Management \(Local\)**.\)  
  
3.  In **Another computer**, type the computer name of the server that is in Server Core mode and click **OK**. You can now use the MMC snap\-in to manage the Server Core server as you would any other computer running a Windows Server operating system.  
  
#### To manage a server in Server Core mode that is not a domain member with an MMC snap\-in  
  
1.  If the Server Core server is not a member of a domain, establish alternate credentials to use to connect to the Server Core computer by typing the following command at a command prompt on the remote computer:  
  
    **cmdkey \/add:<ServerName> \/user:<UserName> \/pass:<password>**  
  
    Where:  
  
    *ServerName* is the name of the Server Core server  
  
    *UserName* is the name of an administrator account  
  
    To be prompted for a password, omit the **\/pass** option.  
  
2.  When prompted, type the password for the user name that is specified in the previous step.  
  
3.  If the firewall on the Server Core server is not already configured to allow MMC snap\-ins to connect, follow the steps in "To configure Windows Firewall to allow MMC snap\-in\(s\) to connect." Then return to this procedure.  
  
4.  On a different computer, start an MMC snap\-in, such as Computer Management.  
  
5.  In the left pane, right\-click the top of the tree and click **Connect to another computer**. \(In the Computer Management example, you would right\-click **Computer Management \(Local\)**.\)  
  
6.  In **Another computer**, type the computer name of the server that is in Server Core mode and click **OK**. You can now use the MMC snap\-in to manage the Server Core server as you would any other computer running a Windows Server operating system.  
  
#### To configure Windows Firewall to allow MMC snap\-in\(s\) to connect  
  
-   To allow all MMC snap\-ins to connect, run  
  
    `Enable-NetFirewallRule -DisplayGroup "Remote Administration"`  
  
-   To allow only specific MMC snap\-ins to connect, run:  
  
    `Enable-NetFirewallRule -DisplayGroup "<rulegroup>"`  
  
    Where:  
  
    *Rulegroup* is one of the values from the table below, depending on which snap\-in you want to connect.  
  
|MMC snap\-in|Rule group|  
|----------------|--------------|  
|Event Viewer|Remote Event Log Management|  
|Services|Remote Service Management|  
|Shared Folders|File and Printer Sharing|  
|Task Scheduler|-   Performance Logs and Alerts<br />-   File and Printer Sharing|  
|Disk Management|Remote Volume Management|  
|Windows Firewall with Advanced Security|Windows Firewall Remote Management|  
  
> [!NOTE]  
> Some MMC snap\-ins do not have a corresponding rule group that allows them to connect through the firewall. However, enabling the rule groups for Event Viewer, Services, or Shared Folders will allow most other snap\-ins to connect. Additionally, certain snap\-ins require further configuration before they can connect through Windows Firewall:  
>   
> -   **Disk Management.** You must first start the Virtual Disk Service \(VDS\) on the Server Core computer. You must also configure the Disk Management rules appropriately on the computer that is running the MMC snap\-in.  
> -   **IP Security Monitor.** You must first enable remote management of this snap\-in. To do this, at a command prompt, type:  
>   
>     **Cscript \\windows\\system32\\scregedit.wsf \/im 1**  
> -   **Reliability and Performance.** The snap\-in does not require any further configuration, but when you use it to monitor a Server Core computer, you can only monitor performance data. Reliability data is not available.  
  
## <a name="BKMK_1.2"></a>1.4 Manage with Remote Desktop Services  
You can use Remote Desktop to manage a server in Server Core mode from remote computers by using Remote Desktop Services.  
  
#### To manage a Server Core server using Remote Desktop  
  
1.  On the Server Core server, run:  
  
    **cscript C:\\Windows\\System32\\Scregedit.wsf \/ar 0**  
  
    This enables the Remote Desktop for Administration mode to accept connections.  
  
2.  On another computer, click **Start**, click **Run**, type **mstsc**, and then click **OK**.  
  
3.  In **Computer**, enter the name of the server that is in Server Core mode, and click **Connect**.  
  
4.  Log on using an administrator account.  
  
5.  When the command prompt appears, you can manage the computer using the Windows command\-line tools.  
  
6.  When you have finished remotely managing the Server Core computer, type **logoff** in the command prompt to end your Remote Desktop session  
  
> [!NOTE]  
> If you are running the Remote Desktop Services client on a previous version of Windows, you must turn off the higher security level that is set by default in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. To do this, after step 1, type the following command at the command prompt:**cscript C:\\Windows\\System32\\Scregedit.wsf \/cs 0**  
  
## <a name="BKMK_1.6"></a>1.5 Switch to Server with a GUI mode  
There may be situations in which you need to use the graphical user interfaces available in Server with a GUI mode. You can switch the system to Server with a GUI mode by following the steps below, although a restart is required. For more information about the differences between Server Core mode and Server with a GUI mode, as well as information about the Minimal Server Interface and Features on demand, see [Windows Server Installation Options](../Topic/Windows-Server-Installation-Options.md).  
  
#### To convert from Server Core mode to Server with a GUI mode when the server was initially installed in Server with a GUI mode  
  
-   Run `Install-WindowsFeature Server-Gui-Mgmt-Infra,Server-Gui-Shell –Restart`  
  
#### To convert from Server Core mode to Server with a GUI mode when the server was initially installed in Server Core mode  
  
1.  Determine the index number for a Server with a GUI image \(for example, **SERVERDATACENTER**, not **SERVERDATACENTERCORE**\) using this cmdlet: `Get-WindowsImage -ImagePath <path to wim>\install.wim`  
  
2.  Run `Install-WindowsFeature Server-Gui-Mgmt-Infra, Server-Gui-Shell –Restart –Source wim:<path to wim>\install.wim:<Index # from step 1>`  
  
3.  Alternatively, if you want to use Windows Update as the source instead of a WIM file, use this Windows PowerShell cmdlet:  
  
    `Install-WindowsFeature Server-Gui-Mgmt-Infra,Server-Gui-Shell –Restart`  
  
After you have accomplished the management tasks, you can switch the server back to Server Core mode whenever it is convenient \(a restart is required\) with the Windows PowerShell cmdlet `Uninstall-WindowsFeature Server-Gui-Mgmt-Infra -restart`  
  
## <a name="BKMK_1.7"></a>1.6 Add hardware and manage drivers locally  
  
#### To add hardware to a server in Server Core mode  
  
1.  Follow the instructions provided by the hardware vendor for installing new hardware:  
  
    -   If the driver for the hardware is included in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], Plug and Play will start and install the driver.  
  
    -   If the driver for the hardware is not included, proceed with the steps 2 and 3.  
  
2.  Copy the driver files to a temporary folder on the server running a Server Core installation.  
  
3.  At a command prompt, open the folder where the driver files are located, and then run the following command:  
  
    **pnputil –i –a <driverinf>**  
  
    Where:  
  
    *driverinf* is the file name of the .inf file for the driver.  
  
4.  If prompted, restart the computer.  
  
#### To obtain a list of drivers that are installed  
  
-   At a command prompt, run  
  
    **sc query type\= driver**  
  
> [!NOTE]  
> You must include the space after the equal sign for the command to complete successfully.  
  
#### To disable a device driver  
  
-   At a command prompt, run  
  
    **sc delete <service\_name>**  
  
    Where:  
  
    *service\_name* is the name of the service that you obtain by running **sc query type\= driver**  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Service Updates on a Server Core Server](../Topic/Service-Updates-on-a-Server-Core-Server.md)  
  
-   [Install Server Roles and Features on a Server Core Server](../Topic/Install-Server-Roles-and-Features-on-a-Server-Core-Server.md)  
  
-   [Configure and Manage Server Core Installations](../Topic/Configure-and-Manage-Server-Core-Installations.md)  
  
-   [Windows Server Installation Options](../Topic/Windows-Server-Installation-Options.md)  
  
-   [Evaluation Versions and Upgrade Options for Windows Server 2012](http://go.microsoft.com/fwlink/?LinkId=260917)  
  
