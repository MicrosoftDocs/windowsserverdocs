---
title: remote Server Administration Tools
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-management-and-automation
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: d54a1f5e-af68-497e-99be-97775769a7a7
---
# remote Server Administration Tools
This topic supports remote Server Administration Tools for Windows 10®.

To help ease remote server management, you can [download and install remote Server Administration Tools](http://go.microsoft.com/fwlink/?LinkID=404281). remote Server Administration Tools includes Server manager, Microsoft management Console \(mmc\) snap\-ins, consoles, Windows powershell® cmdlets and providers, and some command\-line tools for managing roles and features that run on Windows Server.

remote Server Administration Tools includes Windows powershell cmdlet modules that can be used to manage roles and features that are running on remote servers. Although Windows powershell remote management is enabled by default on Windows Server 2016 Technical Preview, it is not enabled by default on Windows 10. To run cmdlets that are part of remote Server Administration Tools against a remote server, run **Enable\-PSremoting** in a Windows powershell session that has been opened with elevated user rights \(that is, Run as Administrator\) on your Windows client computer after installing remote Server Administration Tools.

## <a name="BKMK_Thresh"></a>remote Server Administration Tools for Windows 10
Use remote Server Administration Tools for Windows 10 to manage specific technologies on computers that are running Windows Server 2016 Technical Preview, Windows Server® 2012 R2, and in limited cases,  Windows Server 2012 , or  Windows Server 2008 R2 .

remote Server Administration Tools for Windows 10 includes support for remote management of computers that are running the Server Core installation option or the Minimal Server Interface configuration of Windows Server 2016 Technical Preview,  Windows Server 2012 R2 , and in limited cases, the Server Core installation options of Windows Server® 2012. However, remote Server Administration Tools for Windows 10 cannot be installed on any versions of the Windows Server operating system.

### Tools available in this release
for a list of the tools available in remote Server Administration Tools for Windows 10, see the table in [remote Server Administration Tools (RSat) for Windows Vista, Windows 7, Windows 8, Windows Server 2008, Windows Server 2008 R2, Windows Server 2012, and Windows Server 2012 R2](http://go.microsoft.com/fwlink/p/?LinkID=221055).

The following management tools are not available in this release of remote Server Administration Tools.

-   BitLocker Drive Encryption administration utilities

-   direct Access

-   Routing and remote Access

-   remote Desktop Services

-   Windows powershell cmdlets for Cluster Aware Updating

-   Windows powershell cmdlets for Best Practices Analyzer

### System requirements
remote Server Administration Tools for Windows 10 can be installed only on computers that are running Windows 10. remote Server Administration Tools cannot be installed on computers that are running Windows RT 8.1, or other system\-on\-chip devices.

remote Server Administration Tools for Windows 10 runs on both x86\- and x64\-based editions of Windows 10.

> [!importANT]
> remote Server Administration Tools for Windows 10 should not be installed on a computer that is running administration tools packs for Windows 8.1, Windows 8,  Windows Server 2008 R2 ,  Windows Server 2008 , Windows Server 2003 or Windows 2000 Server®. remove all older versions of Administration Tools Pack or remote Server Administration Tools—including earlier prerelease versions, and releases of the tools for different languages or locales—from the computer before you install remote Server Administration Tools for Windows 10.

To use this release of Server manager to access and manage remote servers that are running  Windows Server 2012 R2 ,  Windows Server 2012 , or  Windows Server 2008 R2 , you must install several updates to make the older Windows Server operating systems manageable by using Server manager. for detailed information about how to prepare  Windows Server 2012 R2 ,  Windows Server 2012 , and  Windows Server 2008 R2  for management by using Server manager in remote Server Administration Tools for Windows 10, see [manage Multiple, remote Servers with Server manager](http://technet.microsoft.com/library/hh831456.aspx).

Windows powershell and Server manager remote management must be enabled on remote servers to manage them by using tools that are part of remote Server Administration Tools for Windows 10. remote management is enabled by default on servers that are running Windows Server 2016 Technical Preview,  Windows Server 2012 R2 , and  Windows Server 2012 . for more information about how to enable remote management if it has been disabled, see [manage multiple, remote servers with Server manager](http://go.microsoft.com/fwlink/p/?LinkId=241358).

### Install, uninstall, or disable remote Server Administration Tools for Windows 10
remote Server Administration Tools for Windows 10 has the same one\-step installation process as remote Server Administration Tools for Windows 8.1. Before the release of remote Server Administration Tools for Windows 8, after running the MSU installer program, users were required to turn on specific tools that they wanted to use in the **Turn Windows features on or off** dialog box. This step has been eliminated; after you run the MSU installation program, all tools are enabled by default.

#### <a name="BKMK_installthresh"></a>To install remote Server Administration Tools for Windows 10

1.  Download the remote Server Administration Tools for Windows 10 package from the [Microsoft Download Center](http://go.microsoft.com/fwlink/?LinkID=404281). You can either run the installer from the Download Center website, or save the download package to a local computer or share.

    > [!importANT]
    > You can only install remote Server Administration Tools for Windows 10 on computers that are running Windows 10. remote Server Administration Tools cannot be installed on computers that are running Windows RT 8.1 or other system\-on\-chip devices.

2.  if you save the download package to a local computer or share, double\-click the installer program, **WindowsTH\-KB2693643\-x64.msu** or **WindowsTH\-KB2693643\-x86.msu**, depending on the architecture of the computer on which you want to install the tools.

3.  When you are prompted by the **Windows Update Standalone Installer** dialog box to install the update, click **Yes**.

4.  Read and accept the license terms. Click **I accept**.

5.  Installation requires a few minutes to finish.

##### To uninstall remote Server Administration Tools for Windows 10

1.  On the desktop, click **start**, click **All Apps**, click **Windows System**, and then click **Control Panel**.

2.  Under **Programs**, click **Uninstall a program**.

3.  Click **View installed updates**.

4.  Right\-click **Update for Microsoft Windows \(KB2693643\)**, and then click **Uninstall**.

5.  When you are asked if you are sure you want to uninstall the update, click **Yes**.

##### To turn off specific tools

1.  On the desktop, click **start**, click **All Apps**, click **Windows System**, and then click **Control Panel**.

2.  Click **Programs**, and then in **Programs and Features** click **Turn Windows features on or off**.

3.  In the **Windows Features** dialog box, expand **remote Server Administration Tools**, and then expand either **Role Administration Tools** or **Feature Administration Tools**.

4.  Clear the check boxes for any tools that you want to turn off.

    > [!NOTE]
    > if you turn off Server manager, the computer must be restarted, and tools that were accessible from the **Tools** menu of Server manager must be opened from the **Administrative Tools** folder.

5.  When you are finished turning off tools that you do not want to use, click **OK**.

### Run remote Server Administration Tools

> [!NOTE]
> After installing remote Server Administration Tools for Windows 10, the **Administrative Tools** folder is displayed on the **start** menu. You can access the tools from the following locations.
> 
> -   The **Tools** menu in the Server manager console.
> -   **Control Panel\\System and Security\\Administrative Tools**.
> -   A shortcut saved to the desktop from the **Administrative Tools** folder \(to do this, right click the **Control Panel\\System and Security\\Administrative Tools** link, and then click **create Shortcut**\).

The tools installed as part of remote Server Administration Tools for Windows 10 cannot be used to manage the local, client computer. regardless of the tool you run, you must specify a remote server or multiple remote servers on which to run the tool. Because most tools are integrated with Server manager, you add remote servers that you want to manage to the Server manager server pool before managing the server by using the tools in the **Tools** menu. for more information about how to add servers to your server pool, and create custom groups of servers, see [add servers to Server manager](http://go.microsoft.com/fwlink/p/?LinkId=241353) and [create and manage server groups](http://go.microsoft.com/fwlink/?LinkId=247328).

In remote Server Administration Tools for Windows 10, all GUI\-based server management tools, such as mmc snap\-ins and dialog boxes, are accessed from the **Tools** menu of the Server manager console. Although the computer that runs remote Server Administration Tools for Windows 10 runs a client\-based operating system, after installing the tools, Server manager, included with remote Server Administration Tools for Windows 10, opens automatically by default on the client computer. Note that there is no **Local Server** page in the Server manager console that runs on a client computer.

##### To start Server manager on a client computer

1.  On the **start** menu, click **All Apps**, and then click **Administrative Tools**.

2.  In the **Administrative Tools** folder, click **Server manager**.

Although they are not listed in the Server manager console **Tools** menu, Windows powershell cmdlets and Command prompt management tools are also installed for roles and features as part of remote Server Administration Tools. for example, if you open a Windows powershell session with elevated user rights \(Run as Administrator\), and run the cmdlet `Get-Command -Module rdmanagement`, the results include a list of remote Desktop Services cmdlets that are now available to run on the local computer after installing remote Server Administration Tools, as long as the cmdlets are targeted at a remote server that is running all or part of the remote Desktop Services role.

##### To start Windows powershell with elevated user rights \(Run as administrator\)

1.  On the **start** menu, click **All Apps**, click **Windows System**, and then click **Windows powershell**.

2.  To run Windows powershell as an administrator from the desktop, right\-click the **Windows powershell** shortcut, and then click **Run as Administrator**.

> [!NOTE]
> You can also start a Windows powershell session that is targeted at a specific server by right\-clicking a managed server in a role or group page in Server manager, and then clicking **Windows powershell**.

## See Also
[remote Server Administration Tools for Windows 10](http://go.microsoft.com/fwlink/?LinkID=404281)
[remote Server Administration Tools (RSat) for Windows Vista, Windows 7, Windows 8, Windows Server 2008, Windows Server 2008 R2, Windows Server 2012, and Windows Server 2012 R2](http://go.microsoft.com/fwlink/p/?LinkID=221055)


