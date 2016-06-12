---
title: Configure remote management in Server manager
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-management-and-automation
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 509182ed-c37d-4b81-84bc-aee43d006873
---
# Configure remote management in Server manager
In Windows Server® 2016 Technical Preview, you can use Server manager to perform management tasks on remote servers. remote management is enabled by default on servers that are running Windows Server 2016 Technical Preview. To manage a server remotely by using Server manager, you add the server to the Server manager server pool.

You can use Server manager to manage remote servers that are running older releases of Windows Server, but the following updates are required to fully manage these older operating systems.

To manage servers that are running Windows Server releases older than Windows Server 2016 Technical Preview, install the following software and updates to make the older releases of Windows Server manageable by using Server manager in Windows Server 2016 Technical Preview.

|Operating System|Required Software|manageability|
|--------------------|---------------------|-----------------|
| Windows Server 2012 R2  or  Windows Server 2012 |-   [.NET Framework 4.6](http://www.microsoft.com/download/details.aspx?id=45497)<br />-   [Windows management Framework 5.0](http://go.microsoft.com/fwlink/?LinkID=395058). The Windows management Framework 5.0 download package updates Windows management Instrumentation \(WMI\) providers on  Windows Server 2012 R2 ,  Windows Server 2012 , and  Windows Server 2008 R2 . The updated WMI providers let Server manager collect information about roles and features that are installed on the managed servers. Until the update is applied, servers that are running  Windows Server 2012 R2 ,  Windows Server 2012 , or  Windows Server 2008 R2  have a manageability status of **Not accessible**.<br />-   The performance update associated with [Knowledge Base article 2682011](http://go.microsoft.com/fwlink/p/?LinkID=245487) is no longer necessary on servers that are running  Windows Server 2012 R2  or  Windows Server 2012 .||
| Windows Server 2008 R2 |-   [.NET Framework 4.5](http://www.microsoft.com/download/details.aspx?id=30653)<br />-   [Windows management Framework 4.0](http://go.microsoft.com/fwlink/?LinkId=293881). The Windows management Framework 4.0 download package updates Windows management Instrumentation \(WMI\) providers on  Windows Server 2008 R2 . The updated WMI providers let Server manager collect information about roles and features that are installed on the managed servers. Until the update is applied, servers that are running  Windows Server 2008 R2  have a manageability status of **Not accessible**.<br />-   The performance update associated with [Knowledge Base article 2682011](http://go.microsoft.com/fwlink/p/?LinkID=245487) lets Server manager collect performance data from  Windows Server 2008 R2 .||
| Windows Server 2008 |-   [.NET Framework 4](http://www.microsoft.com/download/en/details.aspx?id=17718)<br />-   [Windows management Framework 3.0](http://go.microsoft.com/fwlink/p/?LinkID=229019) The Windows management Framework 3.0 download package updates Windows management Instrumentation \(WMI\) providers on  Windows Server 2008 . The updated WMI providers let Server manager collect information about roles and features that are installed on the managed servers. Until the update is applied, servers that are running  Windows Server 2008  have a manageability status of **Not accessible – verify earlier versions run Windows management Framework 3.0**.<br />-   The performance update associated with [Knowledge Base article 2682011](http://go.microsoft.com/fwlink/p/?LinkID=245487) lets Server manager collect performance data from  Windows Server 2008 .||

for detailed information about how to add servers that are in workgroups to manage, or manage remote servers from a workgroup computer that is running Server manager, see [add Servers to Server manager_1](add-servers-server-manager_1.md).

## <a name="BKMK_remote"></a>Enabling or disabling remote management
In Windows Server 2016 Technical Preview, remote management is enabled by default. Before you can connect to a computer that is running Windows Server 2016 Technical Preview remotely by using Server manager, Server manager remote management must be enabled on the destination computer if it has been disabled. The procedures in this section describe how to disable remote management, and how to re\-enable remote management if it has been disabled. In the Server manager console, the remote management status for the local server is displayed in the **Properties** area of the **Local Server** page.

Local administrator accounts other than the built\-in Administrator account may not have rights to manage a server remotely, even if remote management is enabled. The remote User Account Control \(UAC\) **LocalAccountTokenFilterPolicy** registry setting must be configured to allow local accounts of the Administrators group other than the built\-in administrator account to remotely manage the server.

In Windows Server 2016 Technical Preview, Server manager relies on Windows remote management \(WinRM\) and the Distributed component Object model \(DCOM\) for remote communications. The settings that are controlled by the **Configure remote management** dialog box only affect parts of Server manager and Windows powershell that use WinRM for remote communications. They do not affect parts of Server manager that use DCOM for remote communications. for example, Server manager uses WinRM to communicate with remote servers that are running Windows Server 2016 Technical Preview,  Windows Server 2012 R2 , or  Windows Server 2012 , but uses DCOM to communicate with servers that are running  Windows Server 2008  and  Windows Server 2008 R2 , but do not have the [Windows management Framework 4.0](http://go.microsoft.com/fwlink/?LinkId=293881) or [Windows management Framework 3.0](http://go.microsoft.com/fwlink/p/?LinkID=229019) updates applied. Microsoft management Console \(mmc\) and other legacy management tools use DCOM. for more information about how to change these settings, see [To configure mmc or other tool remote management over DCOM](#BKMK_dcom) in this topic.

> [!NOTE]
> Procedures in this section can be completed only on computers that are running Windows Server. You cannot enable or disable remote management on a computer that is running Windows 10 by using these procedures, because the client operating system cannot be managed by using Server manager.

-   To enable WinRM remote management, select one of the following procedures.

    -   [To enable Server manager remote management by using the Windows interface](#BKMK_windows)

    -   [To enable Server manager remote management by using Windows powershell](#BKMK_ps)

    -   [To enable Server manager remote management by using the command line](#BKMK_cmdline)

    -   [To enable Server manager and Windows powershell remote management on earlier releases of Windows Server](#BKMK_old)

-   To disable WinRM and Server manager remote management, select one of the following procedures.

    -   [To disable remote management by using Group Policy](#BKMK_disableGP)

    -   [To disable remote management by using an answer file during unattended installation](#BKMK_unattend)

-   To configure DCOM remote management, see [To configure DCOM remote management](#BKMK_dcom).

### <a name="BKMK_windows"></a>To enable Server manager remote management by using the Windows interface

1.  > [!NOTE]
    > The settings that are controlled by the **Configure remote management** dialog box do not affect parts of Server manager that use DCOM for remote communications.

    On the computer that you want to manage remotely, open Server manager, if it is not already open. On the Windows taskbar, click **Server manager**. On the **start** screen, click the **Server manager** tile.

2.  In the **Properties** area of the **Local Servers** page, click the hyperlinked value for the **remote management** property.

3.  Do one of the following, and then click **OK**.

    -   To prevent this computer from being managed remotely by using Server manager \(or Windows powershell if it is installed\), clear the **Enable remote management of this server from other computers** check box.

    -   To let this computer be managed remotely by using Server manager or Windows powershell, select **Enable remote management of this server from other computers**.

### <a name="BKMK_ps"></a>To enable Server manager remote management by using Windows powershell

1.  On the computer that you want to manage remotely, do one of the following to open a Windows powershell session with elevated user rights.

    -   On the Windows desktop, right\-click **Windows powershell** on the taskbar, and then click **Run as Administrator**.

    -   On the Windows **start** screen, right\-click **Windows powershell**, and then on the app bar, click **Run as Administrator**.

2.  type the following, and then press **Enter** to enable all required firewall rule exceptions.

    **Configure\-SMremoting.exe \-enable**

### <a name="BKMK_cmdline"></a>To enable Server manager remote management by using the command line

1.  On the computer that you want to manage remotely, open a command prompt session with elevated user rights. To do this, on the **start** screen, type **cmd**, right\-click the **Command prompt** tile when it is displayed in the **Apps** results, and then on the app bar, click **Run as Administrator**.

2.  Run the following executable file.

    **%windir%\\system32\\Configure\-SMremoting.exe**

3.  Do one of the following:

    -   To disable remote management, type **Configure\-SMremoting.exe \-disable**, and then press **Enter**.

    -   To enable remote management, type **Configure\-SMremoting.exe \-enable**, and then press **Enter**.

    -   To view the current remote management setting, type **Configure\-SMremoting.exe \-get**, and then press ENTER.

### <a name="BKMK_old"></a>To enable Server manager and Windows powershell remote management on earlier releases of Windows Server

-   Do one of the following:

    -   To enable remote management on servers that are running  Windows Server 2012 , see [To enable Server manager remote management by using the Windows interface](#BKMK_windows) in this topic.

    -   To enable remote management on servers that are running  Windows Server 2008 R2 , see [remote management with Server manager](http://go.microsoft.com/fwlink/?LinkID=137378) in the  Windows Server 2008 R2  help.

    -   To enable remote management on servers that are running  Windows Server 2008 , see [Enable and Use remote Commands in Windows powershell](http://go.microsoft.com/fwlink/p/?LinkId=242565).

### <a name="BKMK_dcom"></a>To configure mmc or other tool remote management over DCOM

1.  Do one of the following to open the Windows Firewall with Advanced Security snap\-in.

    -   In the **Properties** area of the **Local Server** page in Server manager, click the hypertext value for the **Windows Firewall** property, and then click **Advanced settings**.

    -   On the **start** screen, type **WF.msc**, and then click the snap\-in tile when it is displayed in the **Apps** results.

2.  In the tree pane, select **Inbound Rules**.

3.  verify that exceptions to the following firewall rules are enabled, and have not been disabled by Group Policy settings. if any are not enabled, go on to the next step.

    -   COM\+ Network Access \(DCOM\-In\)

    -   remote Event Log management \(NP\-In\)

    -   remote Event Log management \(RPC\)

    -   remote Event Log management \(RPC\-EPMAP\)

4.  Right\-click the rules that are not enabled, and then click **Enable Rule** on the context menu.

5.  Close the Windows Firewall with Advanced Security snap\-in.

### <a name="BKMK_disableGP"></a>To disable remote management by using Group Policy

1.  Do one of the following to open Local Group Policy editor.

    -   On a server that is running Windows Server 2016 Technical Preview,  Windows Server 2012 R2 , or  Windows Server 2012 , on the **start** screen, type **gpedit.msc**, and then click the **gpedit** tile when it is displayed.

    -   On a server that is running  Windows Server 2008 R2  or  Windows Server 2008 , in the **Run** dialog box, type **gpedit.msc**, and then press **Enter**.

2.  Open **computer Configuration\\Administrative Templates\\Windows components\\Windows remote management \(WinRM\)\\WinRM Service**.

3.  In the content pane, double\-click **Allow remote server management through WinRM**.

4.  In the dialog box for the **Allow remote server management through WinRM** policy setting, select **Disabled** to disable remote management. Click **OK** to save your changes and close the policy setting dialog box.

### <a name="BKMK_unattend"></a>To disable remote management by using an answer file during unattended installation

1.  create an unattended installation answer file for Windows Server 2016 Technical Preview installations by using Windows System Image manager \(Windows SIM\). for more information about how to create an answer file and use Windows SIM, see [What is Windows System Image manager?](http://technet.microsoft.com/library/cc766347.aspx) and [Step-by-Step: Basic Windows deployment for IT Professionals](http://technet.microsoft.com/library/dd349348.aspx).

2.  In your answer file, locate the setting **Microsoft\-Windows\-Web\-Services\-for\-management\-Core\\EnableServerremotemanagement**.

3.  To disable Server manager remote management by default on all servers to which you want to apply the answer file, set **Microsoft\-Windows\-Web\-Services\-for\-management\-Core \\EnableServerremotemanagement** to **False**.

    > [!NOTE]
    > This setting disables remote management as part of the operating system setup process. Configuring this setting does not prevent an administrator from enabling Server manager remote management on a server after operating system setup is complete. Administrators can enable Server manager remote management again by using steps in [To configure Server manager remote management by using the Windows interface](#BKMK_windows) or [To enable Server manager remote management by using Windows powershell](#BKMK_ps) in this topic.
    > 
    > if you disable remote management by default as part of an unattended installation, and do not enable remote management on the server again after installation, servers to which this answer file is applied cannot be fully managed by using Server manager. Servers that are running Windows Server 2016 Technical Preview,  Windows Server 2012 R2 , or  Windows Server 2012 —and that have remote management disabled by default—generate manageability status errors in the Server manager console after they are added to the Server manager server pool.

## Windows remote management \(WinRM\) listener settings
Server manager relies on default WinRM listener settings on the remote servers that you want to manage. if the default authentication mechanism or the WinRM listener port number on a remote server has been changed from default settings, Server manager cannot communicate with the remote server.

The following list shows default WinRM listener settings for managing by using Server manager.

-   The WinRM service is running.

-   A WinRM listener is created to accept HTTP requests through port number 5985.

-   Port number 5985 is enabled in Windows Firewall settings to allow requests through WinRM.

-   Both **Kerberos** and **Negotiate** authentication types are enabled.

The default port number is 5985 for WinRM to communicate with a remote computer.

for more information about how to configure WinRM listener settings, at a command prompt, type **winrm help config**, and then press ENTER.

## See Also
[add Servers to Server manager_1](add-servers-server-manager_1.md)
[Windows powershell: about_remote_Troubleshooting on the Windows Server TechCenter](http://technet.microsoft.com/library/dd347642.aspx)
[Description of User Account Control](http://support.microsoft.com/kb/951016)


