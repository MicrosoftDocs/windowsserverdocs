---
title: Remote Server Administration Tools
description: "Top level topic for Remote Server Administration Tools"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-rsat
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: d54a1f5e-af68-497e-99be-97775769a7a7
author: coreyp-at-msft
ms.author: coreyp
manager: lizapo
ms.date: 03/17/2017
---
# Remote Server Administration Tools

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This topic supports Remote Server Administration Tools for Windows 10.

To help ease Remote server management, you can [download and install Remote Server Administration Tools](http://go.microsoft.com/fwlink/?LinkID=404281). Remote Server Administration Tools includes Server Manager, Microsoft Management Console (mmc) snap-ins, consoles, Windows PowerShell cmdlets and providers, and some command-line tools for managing roles and features that run on Windows Server.

Remote Server Administration Tools includes Windows PowerShell cmdlet modules that can be used to manage roles and features that are running on Remote servers. Although Windows PowerShell remote management is enabled by default on Windows Server 2016, it is not enabled by default on Windows 10. To run cmdlets that are part of Remote Server Administration Tools against a Remote server, run `Enable-PSremoting` in a Windows PowerShell session that has been opened with elevated user rights (that is, Run as Administrator) on your Windows client computer after installing Remote Server Administration Tools.

## <a name="BKMK_Thresh"></a>Remote Server Administration Tools for Windows 10
Use Remote Server Administration Tools for Windows 10 to manage specific technologies on computers that are running Windows Server 2016, Windows Server 2012 R2, and in limited cases,  Windows Server 2012 , or  Windows Server 2008 R2 .

Remote Server Administration Tools for Windows 10 includes support for remote management of computers that are running the Server Core installation option or the Minimal Server Interface configuration of Windows Server 2016,  Windows Server 2012 R2 , and in limited cases, the Server Core installation options of Windows Server 2012. However, Remote Server Administration Tools for Windows 10 cannot be installed on any versions of the Windows Server operating system.

### Tools available in this release
for a list of the tools available in Remote Server Administration Tools for Windows 10, see the table in [Remote Server Administration Tools (RSAT) for Windows Vista, Windows 7, Windows 8, Windows Server 2008, Windows Server 2008 R2, Windows Server 2012, and Windows Server 2012 R2](http://go.microsoft.com/fwlink/p/?LinkID=221055).

### System requirements
Remote Server Administration Tools for Windows 10 can be installed only on computers that are running Windows 10. Remote Server Administration Tools cannot be installed on computers that are running Windows RT 8.1, or other system-on-chip devices.

Remote Server Administration Tools for Windows 10 runs on both x86-based and x64-based editions of Windows 10.

> [!IMPORTANT]
> Remote Server Administration Tools for Windows 10 should not be installed on a computer that is running administration tools packs for Windows 8.1, Windows 8,  Windows Server 2008 R2,  Windows Server 2008, Windows Server 2003 or Windows 2000 Server. Remove all older versions of Administration Tools Pack or Remote Server Administration Tools, including earlier prerelease versions, and releases of the tools for different languages or locales from the computer before you install Remote Server Administration Tools for Windows 10.

To use this release of Server Manager to access and manage Remote servers that are running  Windows Server 2012 R2 ,  Windows Server 2012 , or  Windows Server 2008 R2 , you must install several updates to make the older Windows Server operating systems manageable by using Server Manager. For detailed information about how to prepare  Windows Server 2012 R2,  Windows Server 2012, and  Windows Server 2008 R2 for management by using Server Manager in Remote Server Administration Tools for Windows 10, see [Manage Multiple, Remote Servers with Server Manager](http://technet.microsoft.com/library/hh831456.aspx).

Windows PowerShell and Server Manager remote management must be enabled on remote servers to manage them by using tools that are part of Remote Server Administration Tools for Windows 10. Remote management is enabled by default on servers that are running Windows Server 2016,  Windows Server 2012 R2, and  Windows Server 2012. For more information about how to enable remote management if it has been disabled, see [Manage multiple, remote servers with Server Manager](http://go.microsoft.com/fwlink/p/?LinkId=241358).

### Install, uninstall, or disable Remote Server Administration Tools for Windows 10
Remote Server Administration Tools for Windows 10 has the same one-step installation process as Remote Server Administration Tools for Windows 8.1. Before the release of Remote Server Administration Tools for Windows 8, after running the MSU installer program, users were required to turn on specific tools that they wanted to use in the **Turn Windows features on or off** dialog box. This step has been eliminated; after you run the MSU installation program, all tools are enabled by default.

#### <a name="BKMK_installthresh"></a>To install Remote Server Administration Tools for Windows 10

1.  Download the Remote Server Administration Tools for Windows 10 package from the [Microsoft Download Center](http://go.microsoft.com/fwlink/?LinkID=404281). You can either run the installer from the Download Center website, or save the download package to a local computer or share.
I
    > [!IMPORTANT]
    > You can only install Remote Server Administration Tools for Windows 10 on computers that are running Windows 10. Remote Server Administration Tools cannot be installed on computers that are running Windows RT 8.1 or other system-on-chip devices.

2.  If you save the download package to a local computer or share, double-click the installer program, **WindowsTH-KB2693643-x64.msu** or **WindowsTH-KB2693643-x86.msu**, depending on the architecture of the computer on which you want to install the tools.

3.  When you are prompted by the **Windows Update Standalone Installer** dialog box to install the update, click **Yes**.

4.  Read and accept the license terms. Click **I accept**.

5.  Installation requires a few minutes to finish.

##### To uninstall Remote Server Administration Tools for Windows 10

1.  On the desktop, click **Start**, click **All Apps**, click **Windows System**, and then click **Control Panel**.

2.  Under **Programs**, click **Uninstall a program**.

3.  Click **View installed updates**.

4.  Right-click **Update for Microsoft Windows (KB2693643)**, and then click **Uninstall**.

5.  When you are asked if you are sure you want to uninstall the update, click **Yes**.
S
##### To turn off specific tools

1.  On the desktop, click **Start**, click **All Apps**, click **Windows System**, and then click **Control Panel**.

2.  Click **Programs**, and then in **Programs and Features** click **Turn Windows features on or off**.

3.  In the **Windows Features** dialog box, expand **Remote Server Administration Tools**, and then expand either **Role Administration Tools** or **Feature Administration Tools**.

4.  Clear the check boxes for any tools that you want to turn off.

    > [!NOTE]
    > If you turn off Server Manager, the computer must be restarted, and tools that were accessible from the **Tools** menu of Server Manager must be opened from the **Administrative Tools** folder.

5.  When you are finished turning off tools that you do not want to use, click **OK**.

### Run Remote Server Administration Tools

> [!NOTE]
> After installing Remote Server Administration Tools for Windows 10, the **Administrative Tools** folder is displayed on the **Start** menu. You can access the tools from the following locations.
>
> -   The **Tools** menu in the Server Manager console.
> -   **Control Panel\System and Security\Administrative Tools**.
> -   A shortcut saved to the desktop from the **Administrative Tools** folder (to do this, right click the **Control Panel\System and Security\Administrative Tools** link, and then click **Create Shortcut**).

The tools installed as part of Remote Server Administration Tools for Windows 10 cannot be used to manage the local client computer. Regardless of the tool you run, you must specify a remote server, or multiple remote servers, on which to run the tool. Because most tools are integrated with Server Manager, you add remote servers that you want to manage to the Server Manager server pool before managing the server by using the tools in the **Tools** menu. For more information about how to add servers to your server pool, and create custom groups of servers, see [Add servers to Server Manager](http://go.microsoft.com/fwlink/p/?LinkId=241353) and [Create and manage server groups](http://go.microsoft.com/fwlink/?LinkId=247328).

In Remote Server Administration Tools for Windows 10, all GUI-based server management tools, such as mmc snap-ins and dialog boxes, are accessed from the **Tools** menu of the Server Manager console. Although the computer that runs Remote Server Administration Tools for Windows 10 runs a client-based operating system, after installing the tools, Server Manager, included with Remote Server Administration Tools for Windows 10, opens automatically by default on the client computer. Note that there is no **Local Server** page in the Server Manager console that runs on a client computer.

##### To start Server Manager on a client computer

1.  On the **Start** menu, click **All Apps**, and then click **Administrative Tools**.

2.  In the **Administrative Tools** folder, click **Server Manager**.

Although they are not listed in the Server Manager console **Tools** menu, Windows PowerShell cmdlets and Command prompt management tools are also installed for roles and features as part of Remote Server Administration Tools. For example, if you open a Windows PowerShell session with elevated user rights (Run as Administrator), and run the cmdlet `Get-Command -Module RDManagement`, the results include a list of remote Desktop Services cmdlets that are now available to run on the local computer after installing Remote Server Administration Tools, as long as the cmdlets are targeted at a remote server that is running all or part of the remote Desktop Services role.

##### To start Windows PowerShell with elevated user rights (Run as administrator)

1.  On the **Start** menu, click **All Apps**, click **Windows System**, and then click **Windows PowerShell**.

2.  To run Windows PowerShell as an administrator from the desktop, right-click the **Windows PowerShell** shortcut, and then click **Run as Administrator**.

> [!NOTE]
> You can also start a Windows PowerShell session that is targeted at a specific server by right-clicking a managed server in a role or group page in Server Manager, and then clicking **Windows PowerShell**.

## See Also
>- [Remote Server Administration Tools for Windows 10](http://go.microsoft.com/fwlink/?LinkID=404281)
>- [Remote Server Administration Tools (RSAT) for Windows Vista, Windows 7, Windows 8, Windows Server 2008, Windows Server 2008 R2, Windows Server 2012, and Windows Server 2012 R2](http://go.microsoft.com/fwlink/p/?LinkID=221055)
