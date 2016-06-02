---
title: Configure Remote Management in Server Manager
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-management-and-automation
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 509182ed-c37d-4b81-84bc-aee43d006873
author: coreyp
---
# Configure Remote Management in Server Manager
In [!INCLUDE[winthreshold_server_1](includes/winthreshold_server_1_md.md)], you can use [!INCLUDE[sm](includes/sm_md.md)] to perform management tasks on remote servers. Remote management is enabled by default on servers that are running [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)]. To manage a server remotely by using [!INCLUDE[sm](includes/sm_md.md)], you add the server to the [!INCLUDE[sm](includes/sm_md.md)] server pool.  
  
You can use [!INCLUDE[sm](includes/sm_md.md)] to manage remote servers that are running older releases of Windows Server, but the following updates are required to fully manage these older operating systems.  
  
To manage servers that are running Windows Server releases older than [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)], install the following software and updates to make the older releases of Windows Server manageable by using [!INCLUDE[sm](includes/sm_md.md)] in [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)].  
  
|Operating System|Required Software|Manageability|  
|--------------------|---------------------|-----------------|  
|[!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)]|-   [.NET Framework 4.6](http://www.microsoft.com/download/details.aspx?id=45497)<br />-   [Windows Management Framework 5.0](http://go.microsoft.com/fwlink/?LinkID=395058). The Windows Management Framework 5.0 download package updates Windows Management Instrumentation \(WMI\) providers on [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)], [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], and [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)]. The updated WMI providers let [!INCLUDE[sm](includes/sm_md.md)] collect information about roles and features that are installed on the managed servers. Until the update is applied, servers that are running [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)], [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], or [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)] have a manageability status of **Not accessible**.<br />-   The performance update associated with [Knowledge Base article 2682011](http://go.microsoft.com/fwlink/p/?LinkID=245487) is no longer necessary on servers that are running [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)].||  
|[!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)]|-   [.NET Framework 4.5](http://www.microsoft.com/download/details.aspx?id=30653)<br />-   [Windows Management Framework 4.0](http://go.microsoft.com/fwlink/?LinkId=293881). The Windows Management Framework 4.0 download package updates Windows Management Instrumentation \(WMI\) providers on [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)]. The updated WMI providers let [!INCLUDE[sm](includes/sm_md.md)] collect information about roles and features that are installed on the managed servers. Until the update is applied, servers that are running [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)] have a manageability status of **Not accessible**.<br />-   The performance update associated with [Knowledge Base article 2682011](http://go.microsoft.com/fwlink/p/?LinkID=245487) lets [!INCLUDE[sm](includes/sm_md.md)] collect performance data from [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)].||  
|[!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)]|-   [.NET Framework 4](http://www.microsoft.com/download/en/details.aspx?id=17718)<br />-   [Windows Management Framework 3.0](http://go.microsoft.com/fwlink/p/?LinkID=229019) The Windows Management Framework 3.0 download package updates Windows Management Instrumentation \(WMI\) providers on [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)]. The updated WMI providers let [!INCLUDE[sm](includes/sm_md.md)] collect information about roles and features that are installed on the managed servers. Until the update is applied, servers that are running [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)] have a manageability status of **Not accessible – Verify earlier versions run Windows Management Framework 3.0**.<br />-   The performance update associated with [Knowledge Base article 2682011](http://go.microsoft.com/fwlink/p/?LinkID=245487) lets [!INCLUDE[sm](includes/sm_md.md)] collect performance data from [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)].||  
  
For detailed information about how to add servers that are in workgroups to manage, or manage remote servers from a workgroup computer that is running [!INCLUDE[sm](includes/sm_md.md)], see [Add Servers to Server Manager_1](Add-Servers-to-Server-Manager_1.md).  
  
## <a name="BKMK_remote"></a>Enabling or disabling remote management  
In [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)], remote management is enabled by default. Before you can connect to a computer that is running [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)] remotely by using [!INCLUDE[sm](includes/sm_md.md)], [!INCLUDE[sm](includes/sm_md.md)] remote management must be enabled on the destination computer if it has been disabled. The procedures in this section describe how to disable remote management, and how to re\-enable remote management if it has been disabled. In the [!INCLUDE[sm](includes/sm_md.md)] console, the remote management status for the local server is displayed in the **Properties** area of the **Local Server** page.  
  
Local administrator accounts other than the built\-in Administrator account may not have rights to manage a server remotely, even if remote management is enabled. The Remote User Account Control \(UAC\) **LocalAccountTokenFilterPolicy** registry setting must be configured to allow local accounts of the Administrators group other than the built\-in administrator account to remotely manage the server.  
  
In [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)], [!INCLUDE[sm](includes/sm_md.md)] relies on Windows Remote Management \(WinRM\) and the Distributed Component Object Model \(DCOM\) for remote communications. The settings that are controlled by the **Configure Remote Management** dialog box only affect parts of [!INCLUDE[sm](includes/sm_md.md)] and [!INCLUDE[wps_2](includes/wps_2_md.md)] that use WinRM for remote communications. They do not affect parts of [!INCLUDE[sm](includes/sm_md.md)] that use DCOM for remote communications. For example, [!INCLUDE[sm](includes/sm_md.md)] uses WinRM to communicate with remote servers that are running [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)], [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)], or [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], but uses DCOM to communicate with servers that are running [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)] and [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)], but do not have the [Windows Management Framework 4.0](http://go.microsoft.com/fwlink/?LinkId=293881) or [Windows Management Framework 3.0](http://go.microsoft.com/fwlink/p/?LinkID=229019) updates applied. Microsoft Management Console \(MMC\) and other legacy management tools use DCOM. For more information about how to change these settings, see [To configure MMC or other tool remote management over DCOM](#BKMK_dcom) in this topic.  
  
> [!NOTE]  
> Procedures in this section can be completed only on computers that are running Windows Server. You cannot enable or disable remote management on a computer that is running [!INCLUDE[winthreshold_client_2](includes/winthreshold_client_2_md.md)] by using these procedures, because the client operating system cannot be managed by using [!INCLUDE[sm](includes/sm_md.md)].  
  
-   To enable WinRM remote management, select one of the following procedures.  
  
    -   [To enable Server Manager remote management by using the Windows interface](#BKMK_windows)  
  
    -   [To enable Server Manager remote management by using Windows PowerShell](#BKMK_ps)  
  
    -   [To enable Server Manager remote management by using the command line](#BKMK_cmdline)  
  
    -   [To enable Server Manager and Windows PowerShell remote management on earlier releases of Windows Server](#BKMK_old)  
  
-   To disable WinRM and [!INCLUDE[sm](includes/sm_md.md)] remote management, select one of the following procedures.  
  
    -   [To disable remote management by using Group Policy](#BKMK_disableGP)  
  
    -   [To disable remote management by using an answer file during unattended installation](#BKMK_unattend)  
  
-   To configure DCOM remote management, see [To configure DCOM remote management](#BKMK_dcom).  
  
### <a name="BKMK_windows"></a>To enable Server Manager remote management by using the Windows interface  
  
1.  > [!NOTE]  
    > The settings that are controlled by the **Configure Remote Management** dialog box do not affect parts of [!INCLUDE[sm](includes/sm_md.md)] that use DCOM for remote communications.  
  
    On the computer that you want to manage remotely, open [!INCLUDE[sm](includes/sm_md.md)], if it is not already open. On the Windows taskbar, click **Server Manager**. On the **Start** screen, click the **Server Manager** tile.  
  
2.  In the **Properties** area of the **Local Servers** page, click the hyperlinked value for the **Remote management** property.  
  
3.  Do one of the following, and then click **OK**.  
  
    -   To prevent this computer from being managed remotely by using [!INCLUDE[sm](includes/sm_md.md)] \(or [!INCLUDE[wps_2](includes/wps_2_md.md)] if it is installed\), clear the **Enable remote management of this server from other computers** check box.  
  
    -   To let this computer be managed remotely by using [!INCLUDE[sm](includes/sm_md.md)] or [!INCLUDE[wps_2](includes/wps_2_md.md)], select **Enable remote management of this server from other computers**.  
  
### <a name="BKMK_ps"></a>To enable Server Manager remote management by using Windows PowerShell  
  
1.  On the computer that you want to manage remotely, do one of the following to open a [!INCLUDE[wps_2](includes/wps_2_md.md)] session with elevated user rights.  
  
    -   On the Windows desktop, right\-click **Windows PowerShell** on the taskbar, and then click **Run as Administrator**.  
  
    -   On the Windows **Start** screen, right\-click **Windows PowerShell**, and then on the app bar, click **Run as Administrator**.  
  
2.  Type the following, and then press **Enter** to enable all required firewall rule exceptions.  
  
    **Configure\-SMRemoting.exe \-enable**  
  
### <a name="BKMK_cmdline"></a>To enable Server Manager remote management by using the command line  
  
1.  On the computer that you want to manage remotely, open a command prompt session with elevated user rights. To do this, on the **Start** screen, type **cmd**, right\-click the **Command Prompt** tile when it is displayed in the **Apps** results, and then on the app bar, click **Run as Administrator**.  
  
2.  Run the following executable file.  
  
    **%windir%\\system32\\Configure\-SMRemoting.exe**  
  
3.  Do one of the following:  
  
    -   To disable remote management, type **Configure\-SMRemoting.exe \-disable**, and then press **Enter**.  
  
    -   To enable remote management, type **Configure\-SMRemoting.exe \-enable**, and then press **Enter**.  
  
    -   To view the current remote management setting, type **Configure\-SMRemoting.exe \-get**, and then press ENTER.  
  
### <a name="BKMK_old"></a>To enable Server Manager and Windows PowerShell remote management on earlier releases of Windows Server  
  
-   Do one of the following:  
  
    -   To enable remote management on servers that are running [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], see [To enable Server Manager remote management by using the Windows interface](#BKMK_windows) in this topic.  
  
    -   To enable remote management on servers that are running [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)], see [Remote Management with Server Manager](http://go.microsoft.com/fwlink/?LinkID=137378) in the [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)] Help.  
  
    -   To enable remote management on servers that are running [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)], see [Enable and Use Remote Commands in Windows PowerShell](http://go.microsoft.com/fwlink/p/?LinkId=242565).  
  
### <a name="BKMK_dcom"></a>To configure MMC or other tool remote management over DCOM  
  
1.  Do one of the following to open the Windows Firewall with Advanced Security snap\-in.  
  
    -   In the **Properties** area of the **Local Server** page in [!INCLUDE[sm](includes/sm_md.md)], click the hypertext value for the **Windows Firewall** property, and then click **Advanced settings**.  
  
    -   On the **Start** screen, type **WF.msc**, and then click the snap\-in tile when it is displayed in the **Apps** results.  
  
2.  In the tree pane, select **Inbound Rules**.  
  
3.  Verify that exceptions to the following firewall rules are enabled, and have not been disabled by Group Policy settings. If any are not enabled, go on to the next step.  
  
    -   COM\+ Network Access \(DCOM\-In\)  
  
    -   Remote Event Log Management \(NP\-In\)  
  
    -   Remote Event Log Management \(RPC\)  
  
    -   Remote Event Log Management \(RPC\-EPMAP\)  
  
4.  Right\-click the rules that are not enabled, and then click **Enable Rule** on the context menu.  
  
5.  Close the Windows Firewall with Advanced Security snap\-in.  
  
### <a name="BKMK_disableGP"></a>To disable remote management by using Group Policy  
  
1.  Do one of the following to open Local Group Policy Editor.  
  
    -   On a server that is running [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)], [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)], or [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], on the **Start** screen, type **gpedit.msc**, and then click the **gpedit** tile when it is displayed.  
  
    -   On a server that is running [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)] or [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)], in the **Run** dialog box, type **gpedit.msc**, and then press **Enter**.  
  
2.  Open **Computer Configuration\\Administrative Templates\\Windows Components\\Windows Remote Management \(WinRM\)\\WinRM Service**.  
  
3.  In the content pane, double\-click **Allow remote server management through WinRM**.  
  
4.  In the dialog box for the **Allow remote server management through WinRM** policy setting, select **Disabled** to disable remote management. Click **OK** to save your changes and close the policy setting dialog box.  
  
### <a name="BKMK_unattend"></a>To disable remote management by using an answer file during unattended installation  
  
1.  Create an unattended installation answer file for [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)] installations by using Windows System Image Manager \(Windows SIM\). For more information about how to create an answer file and use Windows SIM, see [What is Windows System Image Manager?](http://technet.microsoft.com/library/cc766347.aspx) and [Step-by-Step: Basic Windows Deployment for IT Professionals](http://technet.microsoft.com/library/dd349348.aspx).  
  
2.  In your answer file, locate the setting **Microsoft\-Windows\-Web\-Services\-for\-Management\-Core\\EnableServerRemoteManagement**.  
  
3.  To disable [!INCLUDE[sm](includes/sm_md.md)] remote management by default on all servers to which you want to apply the answer file, set **Microsoft\-Windows\-Web\-Services\-for\-Management\-Core \\EnableServerRemoteManagement** to **False**.  
  
    > [!NOTE]  
    > This setting disables remote management as part of the operating system setup process. Configuring this setting does not prevent an administrator from enabling [!INCLUDE[sm](includes/sm_md.md)] remote management on a server after operating system setup is complete. Administrators can enable [!INCLUDE[sm](includes/sm_md.md)] remote management again by using steps in [To configure Server Manager remote management by using the Windows interface](#BKMK_windows) or [To enable Server Manager remote management by using Windows PowerShell](#BKMK_ps) in this topic.  
    >   
    > If you disable remote management by default as part of an unattended installation, and do not enable remote management on the server again after installation, servers to which this answer file is applied cannot be fully managed by using [!INCLUDE[sm](includes/sm_md.md)]. Servers that are running [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)], [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)], or [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)]—and that have remote management disabled by default—generate manageability status errors in the [!INCLUDE[sm](includes/sm_md.md)] console after they are added to the [!INCLUDE[sm](includes/sm_md.md)] server pool.  
  
## Windows Remote Management \(WinRM\) listener settings  
[!INCLUDE[sm](includes/sm_md.md)] relies on default WinRM listener settings on the remote servers that you want to manage. If the default authentication mechanism or the WinRM listener port number on a remote server has been changed from default settings, [!INCLUDE[sm](includes/sm_md.md)] cannot communicate with the remote server.  
  
The following list shows default WinRM listener settings for managing by using [!INCLUDE[sm](includes/sm_md.md)].  
  
-   The WinRM service is running.  
  
-   A WinRM listener is created to accept HTTP requests through port number 5985.  
  
-   Port number 5985 is enabled in Windows Firewall settings to allow requests through WinRM.  
  
-   Both **Kerberos** and **Negotiate** authentication types are enabled.  
  
The default port number is 5985 for WinRM to communicate with a remote computer.  
  
For more information about how to configure WinRM listener settings, at a command prompt, type **winrm help config**, and then press ENTER.  
  
## See Also  
[Add Servers to Server Manager_1](Add-Servers-to-Server-Manager_1.md)  
[Windows PowerShell: about_Remote_Troubleshooting on the Windows Server TechCenter](http://technet.microsoft.com/library/dd347642.aspx)  
[Description of User Account Control](http://support.microsoft.com/kb/951016)  
  

