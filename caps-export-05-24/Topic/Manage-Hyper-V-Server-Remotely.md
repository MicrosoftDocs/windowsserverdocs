---
title: Manage Hyper-V Server Remotely
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7df55dd1-261e-4001-8a10-14ca5bd10c4d
author: cwatsonmsft
---
# Manage Hyper-V Server Remotely
This topic explains the various methods available for managing a computer running Microsoft Hyper\-V Server. You can manage the server in the following ways:  
  
-   Locally and remotely by using Windows PowerShell  
  
-   Remotely by using Server Manager  
  
-   Remotely by using Microsoft Management Console \(MMC\) snap\-ins  
  
-   Remotely by using Remote Desktop Services  
  
|Task|Description|  
|--------|---------------|  
|[1.1. Manage with Windows PowerShell](../Topic/Manage-a-Server-Core-Server.md#BKMK_1.1)|You can manage Hyper\-V Server by using Windows PowerShell locally or remotely.|  
|[1.2 Manage with Server Manager](../Topic/Manage-a-Server-Core-Server.md#BKMK_1.5)|By running Server Manager on a remote computer, you can connect to Hyper\-V Server.|  
|[1.3 Manage with Microsoft Management Console](../Topic/Manage-a-Server-Core-Server.md#BKMK_1.4)|By using MMC snap\-ins, you can connect to Hyper\-V Server.|  
|[1.4 Manage with Remote Desktop Services](../Topic/Manage-a-Server-Core-Server.md#BKMK_1.2)|By using another computer running the Windows operating system, you can use Remote Desktop Services to run scripts and tools on a computer running Hyper\-V Server.|  
  
There are some important limitations and tips to keep in mind when you work with Hyper\-V Server:  
  
-   If you close all Command Prompt windows and you want to open a new Command Prompt window, press CTRL\+ALT\+DELETE, click **Start Task Manager**, click **More Details**, click **File**, click **Run**, and then type **cmd.exe**. Alternatively, you can sign out and then sign in.  
  
-   If you close all Windows PowerShell windows, you can open a new one by typing **PowerShell** at a command prompt.  
  
-   Any command or tool that attempts to start Windows Explorer will not work. For example, typing **start .** at a command prompt will not work.  
  
-   There is no support for HTML rendering or HTML Help in a Server Core installation.  
  
-   There are no notifications for activation, new updates, or password expiration because these notifications require the Windows Explorer shell, which is not present.  
  
-   Hyper\-V Server supports Windows Installer in quiet mode so that you can install tools and utilities from Windows Installer files.  
  
-   When you install Windows Installer packages on Hyper\-V Server, use the **\/qb** option to display the basic user interface.  
  
-   To change the time zone, run `Set-Date`.  
  
-   To change international settings, run **control intl.cpl**.  
  
-   Control.exe will not run on its own. You must run Control.exe with Timedate.cpl or Intl.cpl.  
  
-   Winver.exe is not available. To obtain version information, use Systeminfo.exe.  
  
> [!NOTE]  
> [!INCLUDE[wps_howtorun](../Token/wps_howtorun_md.md)]  
  
## <a name="BKMK_1.1"></a>1.1. Manage with Windows PowerShell  
You can accomplish most management tasks locally or from a remote computer by using Windows PowerShell cmdlets and scripts. To start Windows PowerShell, type **powershell** in a Command Prompt window.  
  
For more information about working with Windows PowerShell, including running it remotely, see [Starting Windows PowerShell](http://technet.microsoft.com/library/hh857343.aspx).  
  
## <a name="BKMK_1.5"></a>1.2 Manage with Server Manager  
Server Manager is a management console in Windows Server that helps IT professionals provision and manage local and remote Windows\-based servers from their desktops. No physical access to the servers is required, and you do not need to enable Remote Desktop Protocol \(RDP\) connections to each server.  
  
To enable your local server to be managed by Server Manager that is running on a remote server, run the Windows PowerShell cmdlet `Configure-SMRemoting.exe –Enable`.  
  
Although Server Manager was available in Windows Server 2008 R2 and Windows Server 2008, Server Manager was completely redesigned for Windows Server 2012 to support remote, multiserver management, and to help increase the number of servers an administrator can manage. You must use the version of Server Manager in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or that is available as part of the Remote Server Administration Tools. Older versions of Server Manager will not work. To download these tools, see :  
  
-   [Remote Server Administration Tools for Windows 8.1](http://www.microsoft.com/download/details.aspx?id=39296)  
  
-   [Remote Server Administration Tools for Windows 8](http://go.microsoft.com/fwlink/p/?LinkID=238560)  
  
## <a name="BKMK_1.4"></a>1.3 Manage with Microsoft Management Console  
Many snap\-ins for Microsoft Management Console \(MMC\) can be use remotely to manage Hyper\-V Server.  
  
#### To use an MMC snap\-in to manage a computer running Hyper\-V Server that is a domain member  
  
1.  Start an MMC snap\-in, such as **Computer Management**.  
  
2.  In the left pane, right\-click the top of the tree, and then click **Connect to another computer**. \(In the **Computer Management** example, you would right\-click **Computer Management \(Local\)**.\)  
  
3.  In the **Another computer** text box, type the name of the computer running Hyper\-V Server, and then click **OK**. You can now use the MMC snap\-in to manage the computer running Hyper\-V Server the same way that you manage any computer running the Windows Server operating system.  
  
#### To use an MMC snap\-in to manage a computer running Hyper\-V Server that is not a domain member  
  
1.  If the Hyper\-V Server is not a member of a domain, type the following command at a command prompt on the remote computer. This establishes alternate credentials that you can use to connect to the computer running Hyper\-V Server.  
  
    **cmdkey \/add:<ServerName> \/user:<UserName> \/pass:<password>**  
  
    Where:  
  
    *ServerName* is the name of the computer running Hyper\-V Server.  
  
    *UserName* is the name of an administrator account.  
  
    > [!NOTE]  
    > If you want to be prompted for a password, omit the **\/pass** parameter.  
  
2.  When prompted, type the password for the user name that is specified in the previous step.  
  
3.  If the firewall on the computer running Hyper\-V Server is not already configured to allow MMC snap\-ins to connect, follow the steps in [To configure Windows Firewall to allow MMC snap\-ins to connect](../Topic/Manage-Hyper-V-Server-Remotely.md#BKMK_MMCConnect). Then return to this procedure.  
  
4.  On a different computer, start an MMC snap\-in, such as **Computer Management**.  
  
5.  In the left pane, right\-click the top of the tree, and then click **Connect to another computer**. \(In the **Computer Management** example, you would right\-click **Computer Management \(Local\)**.\)  
  
6.  In the **Another computer** text box, type the name of the computer running Hyper\-V Server, and then click **OK**. You can now use the MMC snap\-in to manage the computer running Hyper\-V Server the same way that you would manage any computer running the Windows Server operating system.  
  
### <a name="BKMK_MMCConnect"></a>To configure Windows Firewall to allow MMC snap\-ins to connect  
  
-   To allow all MMC snap\-ins to connect, run the following Windows PowerShell command:  
  
    `Enable-NetFirewallRule -DisplayGroup "Remote Administration"`  
  
-   To allow only specific MMC snap\-ins to connect, run the following Windows PowerShell command:  
  
    `Enable-NetFirewallRule -DisplayGroup "<rulegroup>"`  
  
    Where:  
  
    *Rulegroup* is one of the values from the following table, depending on which snap\-in you want to connect.  
  
|MMC snap\-in|Rule group|  
|----------------|--------------|  
|Event Viewer|Remote Event Log Management|  
|Services|Remote Services Management|  
|Shared Folders|File and Printer Sharing|  
|Task Scheduler|-   Performance Logs and Alerts<br />-   File and Printer Sharing|  
|Disk Management|Remote Volume Management|  
|Windows Firewall with Advanced Security|Windows Firewall Remote Management|  
  
> [!NOTE]  
> Some MMC snap\-ins do not have a corresponding rule group that allows them to connect through the firewall. However, enabling the rule groups for Event Viewer, Services, or Shared Folders will allow most other snap\-ins to connect. Additionally, certain snap\-ins require further configuration before they can connect through Windows Firewall:  
>   
> -   **Disk Management** You must first start the Virtual Disk Service \(VDS\) on the computer running Hyper\-V Server. You must also configure the Disk Management rules appropriately on the computer running the MMC snap\-in.  
> -   **IP Security Monitor** You must first enable remote management for this snap\-in. To do this, at a command prompt, type:  
>   
>     **Cscript \\windows\\system32\\scregedit.wsf \/im 1**  
> -   **Reliability and Performance** The snap\-in does not require any further configuration, but when you use it to monitor a computer running Hyper\-V Server, you can only monitor performance data. Reliability data is not available.  
  
## <a name="BKMK_1.2"></a>1.4 Manage with Remote Desktop Services  
You can use Remote Desktop Services to manage a computer running Hyper\-V Server.  
  
#### To use Remote Desktop to manage a computer running Hyper\-V Server  
  
1.  On the computer running Hyper\-V Server, run:  
  
    **cscript C:\\Windows\\System32\\Scregedit.wsf \/ar 0**  
  
    This enables Remote Desktop to accept connections.  
  
2.  On another computer, click **Start**, click **Run**, type **mstsc**, and then click **OK**.  
  
3.  In the **Computer** text box, enter the name of the computer running Hyper\-V Server, and click **Connect**.  
  
4.  Sign in by using an administrator account.  
  
5.  When the command prompt appears, you can manage the computer by using the Windows command\-line tools.  
  
6.  When you have finished remotely managing the computer running Hyper\-V Server, type **logoff** at the command prompt to end your Remote Desktop Services session.  
  
> [!NOTE]  
> If you are running Remote Desktop Services on a client with an earlier version of Windows, you must turn off the higher security level that is set by default in Windows Server. To do this, after Step 1, type the following command at the command prompt:**cscript C:\\Windows\\System32\\Scregedit.wsf \/cs 0**  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Microsoft Hyper\-V Server 2012 R2 and Hyper\-V Server 2012 \[MTPS TOC\]](../DocSets/Harvest_TH_Microsoft-Hyper-V-Server-2012-and-Microsoft-Hyper-V-Server-2012-R2/NotInToc/Microsoft-Hyper-V-Server-2012-R2-and-Hyper-V-Server-2012_deleted.md)  
  
-   [Hyper\-V Overview](assetId:///5aad349f-ef06-464a-b36f-366fbb040143)  
  
-   [Configure Hyper-V Server for Remote Management](../Topic/Configure-Hyper-V-Server-for-Remote-Management.md)  
  
-   [Configure Virtual Networks](assetId:///6f0db762-9ad6-44cf-90f3-922ef25ba059)  
  
-   [Install Hyper\-V Server 2012](assetId:///388e3ac7-cc7c-487e-ba99-c12ac1722bc9)  
  
-   [Configuring and Managing Server Core Installations](http://technet.microsoft.com/library/jj574091)  
  
-   [Microsoft Hyper\-V Server 2008 R2](http://technet.microsoft.com/library/ee815281(v=ws.10).aspx)  
  
