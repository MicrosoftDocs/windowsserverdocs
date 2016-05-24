---
title: Deploy Remote Server Administration Tools
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-management-and-automation
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 43a0e015-ae11-4507-bc00-38036b330e34
author: jpjofre
---
# Deploy Remote Server Administration Tools
This topic supports both Remote Server Administration Tools for [!INCLUDE[winblue_client_1](../Token/winblue_client_1_md.md)] and Remote Server Administration Tools for [!INCLUDE[win8_client_1](../Token/win8_client_1_md.md)].  
  
-   [Remote Server Administration Tools for Windows 10 Technical Preview](#BKMK_Thresh)  
  
-   [Remote Server Administration Tools for Windows 8.1](#BKMK_8.1)  
  
-   [Remote Server Administration Tools for Windows 8](#BKMK_8)  
  
To help ease remote server management, you can download and install Remote Server Administration Tools. Remote Server Administration Tools includes [!INCLUDE[sm](../Token/sm_md.md)], Microsoft Management Console \(MMC\) snap\-ins, consoles, [!INCLUDE[wps_1](../Token/wps_1_md.md)] cmdlets and providers, and some command\-line tools for managing roles and features that run on Windows Server.  
  
Remote Server Administration Tools includes [!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlet modules that can be used to manage roles and features that are running on remote servers. Although [!INCLUDE[wps_2](../Token/wps_2_md.md)] remote management is enabled by default on [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], it is not enabled by default on [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] or [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)]. To run cmdlets that are part of Remote Server Administration Tools against a remote server, run **Enable\-PSRemoting** in a [!INCLUDE[wps_2](../Token/wps_2_md.md)] session that has been opened with elevated user rights \(that is, Run as Administrator\) on your Windows client computer after installing Remote Server Administration Tools.  
  
## <a name="BKMK_Thresh"></a>Remote Server Administration Tools for Windows 10 Technical Preview  
Use Remote Server Administration Tools for [!INCLUDE[winthreshold_client_1](../Token/winthreshold_client_1_md.md)] to manage specific technologies on computers that are running [!INCLUDE[winthreshold_server_2](../Token/winthreshold_server_2_md.md)], [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)], and in limited cases, [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
Remote Server Administration Tools for [!INCLUDE[winthreshold_client_2](../Token/winthreshold_client_2_md.md)] includes support for remote management of computers that are running the Server Core installation option or the Minimal Server Interface configuration of [!INCLUDE[winthreshold_server_2](../Token/winthreshold_server_2_md.md)], [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], and in limited cases, the Server Core installation options of [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)]. However, Remote Server Administration Tools for [!INCLUDE[winthreshold_client_2](../Token/winthreshold_client_2_md.md)] cannot be installed on any versions of the Windows Server operating system.  
  
### Tools available in this release  
For a list of the tools available in Remote Server Administration Tools for [!INCLUDE[winthreshold_client_2](../Token/winthreshold_client_2_md.md)], see the table in [Remote Server Administration Tools \(RSAT\) for Windows Vista, Windows 7, Windows 8, Windows Server 2008, Windows Server 2008 R2, Windows Server 2012, and Windows Server 2012 R2](http://go.microsoft.com/fwlink/p/?LinkID=221055).  
  
The following management tools are not available in this release of Remote Server Administration Tools.  
  
-   BitLocker Drive Encryption administration utilities  
  
-   Direct Access  
  
-   Routing and Remote Access  
  
-   Remote Desktop Services  
  
-   Windows PowerShell cmdlets for Cluster Aware Updating  
  
-   Windows PowerShell cmdlets for Best Practices Analyzer  
  
### System requirements  
Remote Server Administration Tools for [!INCLUDE[winthreshold_client_2](../Token/winthreshold_client_2_md.md)] can be installed only on computers that are running [!INCLUDE[winthreshold_client_2](../Token/winthreshold_client_2_md.md)]. Remote Server Administration Tools cannot be installed on computers that are running [!INCLUDE[winblue_winrt_2](../Token/winblue_winrt_2_md.md)], or other system\-on\-chip devices.  
  
Remote Server Administration Tools for [!INCLUDE[winthreshold_client_2](../Token/winthreshold_client_2_md.md)] runs on both x86\- and x64\-based editions of [!INCLUDE[winthreshold_client_2](../Token/winthreshold_client_2_md.md)].  
  
> [!IMPORTANT]  
> Remote Server Administration Tools for [!INCLUDE[winthreshold_client_2](../Token/winthreshold_client_2_md.md)] should not be installed on a computer that is running administration tools packs for [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], Windows Server 2003 or Windows 2000 Server®. Remove all older versions of Administration Tools Pack or Remote Server Administration Tools—including earlier prerelease versions, and releases of the tools for different languages or locales—from the computer before you install Remote Server Administration Tools for [!INCLUDE[winthreshold_client_2](../Token/winthreshold_client_2_md.md)].  
  
To use this release of [!INCLUDE[sm](../Token/sm_md.md)] to access and manage remote servers that are running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], you must install several updates to make the older Windows Server operating systems manageable by using [!INCLUDE[sm](../Token/sm_md.md)]. For detailed information about how to prepare [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] for management by using [!INCLUDE[sm](../Token/sm_md.md)] in Remote Server Administration Tools for [!INCLUDE[winthreshold_client_2](../Token/winthreshold_client_2_md.md)], see [Manage Multiple, Remote Servers with Server Manager](http://technet.microsoft.com/library/hh831456.aspx).  
  
[!INCLUDE[wps_2](../Token/wps_2_md.md)] and [!INCLUDE[sm](../Token/sm_md.md)] remote management must be enabled on remote servers to manage them by using tools that are part of Remote Server Administration Tools for [!INCLUDE[winthreshold_client_2](../Token/winthreshold_client_2_md.md)]. Remote management is enabled by default on servers that are running [!INCLUDE[winthreshold_server_2](../Token/winthreshold_server_2_md.md)], [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. For more information about how to enable remote management if it has been disabled, see [Manage multiple, remote servers with Server Manager](http://go.microsoft.com/fwlink/p/?LinkId=241358).  
  
### Install, uninstall, or disable Remote Server Administration Tools for [!INCLUDE[winthreshold_client_2](../Token/winthreshold_client_2_md.md)]  
Remote Server Administration Tools for [!INCLUDE[winthreshold_client_2](../Token/winthreshold_client_2_md.md)] has the same one\-step installation process as Remote Server Administration Tools for [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)]. Before the release of Remote Server Administration Tools for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], after running the MSU installer program, users were required to turn on specific tools that they wanted to use in the **Turn Windows features on or off** dialog box. This step has been eliminated; after you run the MSU installation program, all tools are enabled by default.  
  
#### <a name="BKMK_installthresh"></a>To install Remote Server Administration Tools for Windows 10 Technical Preview  
  
1.  Download the Remote Server Administration Tools for [!INCLUDE[winthreshold_client_2](../Token/winthreshold_client_2_md.md)] package from the [Microsoft Download Center](http://go.microsoft.com/fwlink/?LinkID=404281). You can either run the installer from the Download Center website, or save the download package to a local computer or share.  
  
    > [!IMPORTANT]  
    > You can only install Remote Server Administration Tools for [!INCLUDE[winthreshold_client_2](../Token/winthreshold_client_2_md.md)] on computers that are running [!INCLUDE[winthreshold_client_2](../Token/winthreshold_client_2_md.md)]. Remote Server Administration Tools cannot be installed on computers that are running [!INCLUDE[winblue_winrt_2](../Token/winblue_winrt_2_md.md)] or other system\-on\-chip devices.  
  
2.  If you save the download package to a local computer or share, double\-click the installer program, **WindowsTH\-KB2693643\-x64.msu** or **WindowsTH\-KB2693643\-x86.msu**, depending on the architecture of the computer on which you want to install the tools.  
  
3.  When you are prompted by the **Windows Update Standalone Installer** dialog box to install the update, click **Yes**.  
  
4.  Read and accept the license terms. Click **I accept**.  
  
5.  Installation requires a few minutes to finish.  
  
##### To uninstall Remote Server Administration Tools for [!INCLUDE[winthreshold_client_2](../Token/winthreshold_client_2_md.md)]  
  
1.  On the desktop, click **Start**, click **All Apps**, click **Windows System**, and then click **Control Panel**.  
  
2.  Under **Programs**, click **Uninstall a program**.  
  
3.  Click **View installed updates**.  
  
4.  Right\-click **Update for Microsoft Windows \(KB2693643\)**, and then click **Uninstall**.  
  
5.  When you are asked if you are sure you want to uninstall the update, click **Yes**.  
  
##### To turn off specific tools  
  
1.  On the desktop, click **Start**, click **All Apps**, click **Windows System**, and then click **Control Panel**.  
  
2.  Click **Programs**, and then in **Programs and Features** click **Turn Windows features on or off**.  
  
3.  In the **Windows Features** dialog box, expand **Remote Server Administration Tools**, and then expand either **Role Administration Tools** or **Feature Administration Tools**.  
  
4.  Clear the check boxes for any tools that you want to turn off.  
  
    > [!NOTE]  
    > If you turn off [!INCLUDE[sm](../Token/sm_md.md)], the computer must be restarted, and tools that were accessible from the **Tools** menu of [!INCLUDE[sm](../Token/sm_md.md)] must be opened from the **Administrative Tools** folder.  
  
5.  When you are finished turning off tools that you do not want to use, click **OK**.  
  
### Run Remote Server Administration Tools  
  
> [!NOTE]  
> After installing Remote Server Administration Tools for [!INCLUDE[winthreshold_client_2](../Token/winthreshold_client_2_md.md)], the **Administrative Tools** folder is displayed on the **Start** menu. You can access the tools from the following locations.  
>   
> -   The **Tools** menu in the [!INCLUDE[sm](../Token/sm_md.md)] console.  
> -   **Control Panel\\System and Security\\Administrative Tools**.  
> -   A shortcut saved to the desktop from the **Administrative Tools** folder \(to do this, right click the **Control Panel\\System and Security\\Administrative Tools** link, and then click **Create Shortcut**\).  
  
The tools installed as part of Remote Server Administration Tools for [!INCLUDE[winthreshold_client_2](../Token/winthreshold_client_2_md.md)] cannot be used to manage the local, client computer. Regardless of the tool you run, you must specify a remote server or multiple remote servers on which to run the tool. Because most tools are integrated with [!INCLUDE[sm](../Token/sm_md.md)], you add remote servers that you want to manage to the [!INCLUDE[sm](../Token/sm_md.md)] server pool before managing the server by using the tools in the **Tools** menu. For more information about how to add servers to your server pool, and create custom groups of servers, see [Add servers to Server Manager](http://go.microsoft.com/fwlink/p/?LinkId=241353) and [Create and manage server groups](http://go.microsoft.com/fwlink/?LinkId=247328).  
  
In Remote Server Administration Tools for [!INCLUDE[winthreshold_client_2](../Token/winthreshold_client_2_md.md)], all GUI\-based server management tools, such as MMC snap\-ins and dialog boxes, are accessed from the **Tools** menu of the [!INCLUDE[sm](../Token/sm_md.md)] console. Although the computer that runs Remote Server Administration Tools for [!INCLUDE[winthreshold_client_2](../Token/winthreshold_client_2_md.md)] runs a client\-based operating system, after installing the tools, [!INCLUDE[sm](../Token/sm_md.md)], included with Remote Server Administration Tools for [!INCLUDE[winthreshold_client_2](../Token/winthreshold_client_2_md.md)], opens automatically by default on the client computer. Note that there is no **Local Server** page in the [!INCLUDE[sm](../Token/sm_md.md)] console that runs on a client computer.  
  
##### To start Server Manager on a client computer  
  
1.  On the **Start** menu, click **All Apps**, and then click **Administrative Tools**.  
  
2.  In the **Administrative Tools** folder, click **Server Manager**.  
  
Although they are not listed in the [!INCLUDE[sm](../Token/sm_md.md)] console **Tools** menu, [!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlets and Command Prompt management tools are also installed for roles and features as part of Remote Server Administration Tools. For example, if you open a [!INCLUDE[wps_2](../Token/wps_2_md.md)] session with elevated user rights \(Run as Administrator\), and run the cmdlet `Get-Command -Module RDManagement`, the results include a list of Remote Desktop Services cmdlets that are now available to run on the local computer after installing Remote Server Administration Tools, as long as the cmdlets are targeted at a remote server that is running all or part of the Remote Desktop Services role.  
  
##### To start Windows PowerShell with elevated user rights \(Run as administrator\)  
  
1.  On the **Start** menu, click **All Apps**, click **Windows System**, and then click **Windows PowerShell**.  
  
2.  To run [!INCLUDE[wps_2](../Token/wps_2_md.md)] as an administrator from the desktop, right\-click the **Windows PowerShell** shortcut, and then click **Run as Administrator**.  
  
> [!NOTE]  
> You can also start a [!INCLUDE[wps_2](../Token/wps_2_md.md)] session that is targeted at a specific server by right\-clicking a managed server in a role or group page in [!INCLUDE[sm](../Token/sm_md.md)], and then clicking **Windows PowerShell**.  
  
## <a name="BKMK_8.1"></a>Remote Server Administration Tools for Windows 8.1  
Use Remote Server Administration Tools for [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] to manage specific technologies on computers that are running [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)], [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)], and in limited cases, [!INCLUDE[firstref_server_7](../Token/firstref_server_7_md.md)], or [!INCLUDE[firstref_longhorn](../Token/firstref_longhorn_md.md)]. A few of the tools might work for managing roles and features on Windows Server 2003.  
  
Remote Server Administration Tools for [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] includes support for remote management of computers that are running the Server Core installation option or the Minimal Server Interface configuration of [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], and in limited cases, the Server Core installation options of [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. However, Remote Server Administration Tools for [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] cannot be installed on any versions of the Windows Server operating system.  
  
### Tools available in this release  
For a list of the tools available in Remote Server Administration Tools for [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] and Remote Server Administration Tools for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], see the table in [Remote Server Administration Tools \(RSAT\) for Windows Vista, Windows 7, Windows 8, Windows Server 2008, Windows Server 2008 R2, Windows Server 2012, and Windows Server 2012 R2](http://go.microsoft.com/fwlink/p/?LinkID=221055).  
  
### System requirements  
Remote Server Administration Tools for [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] can be installed only on computers that are running [!INCLUDE[winblue_client_pro_2](../Token/winblue_client_pro_2_md.md)] or [!INCLUDE[winblue_client_ent_2](../Token/winblue_client_ent_2_md.md)]. Remote Server Administration Tools cannot be installed on any other editions of [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], and it cannot be installed on computers that are running [!INCLUDE[winblue_winrt_2](../Token/winblue_winrt_2_md.md)] or other system\-on\-chip devices.  
  
Remote Server Administration Tools for [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] runs on both x86\- and x64\-based editions of [!INCLUDE[winblue_client_pro_2](../Token/winblue_client_pro_2_md.md)] or [!INCLUDE[winblue_client_ent_2](../Token/winblue_client_ent_2_md.md)].  
  
> [!IMPORTANT]  
> Remote Server Administration Tools for [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] should not be installed on a computer that is running administration tools packs for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], Windows Server 2003 or Windows 2000 Server®. Remove all older versions of Administration Tools Pack or Remote Server Administration Tools—including earlier prerelease versions, and releases of the tools for different languages or locales—from the computer before you install Remote Server Administration Tools for [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)].  
  
To use this release of [!INCLUDE[sm](../Token/sm_md.md)] to access and manage remote servers that are running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], you must install several updates to make the older Windows Server operating systems manageable by using [!INCLUDE[sm](../Token/sm_md.md)]. For detailed information about how to prepare [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], and [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] for management by using [!INCLUDE[sm](../Token/sm_md.md)] in Remote Server Administration Tools for [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], see [Manage Multiple, Remote Servers with Server Manager](http://technet.microsoft.com/library/hh831456.aspx).  
  
[!INCLUDE[wps_2](../Token/wps_2_md.md)] and [!INCLUDE[sm](../Token/sm_md.md)] remote management must be enabled on remote servers to manage them by using tools that are part of Remote Server Administration Tools for [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)]. Remote management is enabled by default on servers that are running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. For more information about how to enable remote management if it has been disabled, see [Manage multiple, remote servers with Server Manager](http://go.microsoft.com/fwlink/p/?LinkId=241358).  
  
### Install, uninstall, or disable Remote Server Administration Tools for [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)]  
Remote Server Administration Tools for [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] has the same one\-step installation process as Remote Server Administration Tools for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)]. Before the release of Remote Server Administration Tools for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], after running the MSU installer program, users were required to turn on specific tools that they wanted to use in the **Turn Windows features on or off** dialog box. This step has been eliminated; after you run the MSU installation program, all tools are enabled by default.  
  
##### To install supported language packs when the system UI language is not supported by the download package  
  
1.  > [!NOTE]  
    > This procedure applies only if your system UI language does not match one of the available Remote Server Administration Tools languages. If your computer’s system UI language matches an available Remote Server Administration Tools language, go on to the next procedure, [To install Remote Server Administration Tools for Windows 8.1](#BKMK_installrsat).  
  
    Follow instructions in [KB 2839636](http://support.microsoft.com/kb/2839636) to install supported [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] language packs from Windows Update. Be sure to install one of the language packs that is supported by Remote Server Administration Tools.  
  
    Remote Server Administration Tools for [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] is available in cs\-CZ, de\-DE, en\-US, es\-ES, fr\-FR, hu\-HU, it\-IT, ja\-JP, ko\-KR, nl\-NL, pl\-PL, pt\-BR, pt\-PT, ru\-RU, sv\-SE, tr\-TR, zh\-CN, and zh\-TW.  
  
    1.  On the **Start** screen, type **language** to search for language settings.  
  
    2.  In the search results, click or tap **Add a language to this device**.  
  
    3.  On the **Time and Language** page, under **Languages**, click or tap **Add a language**.  
  
    4.  Select and install a language that is supported by RSAT.  
  
2.  When the language pack installation is complete, verify that the language pack is installed by running `get-windowspackage -online` in a [!INCLUDE[wps_2](../Token/wps_2_md.md)] session that has been started with elevated user rights \(Run as Administrator\).  
  
    The language pack entry starts with the following:  
  
    Microsoft\-Windows\-Client\-LanguagePack\-Package~\(GUID\)~\(architecture\)~\(supported language\)~6.3.9600.XXXXX  
  
3.  After you have installed a supported language pack, go on to the next procedure, [To install Remote Server Administration Tools for Windows 8.1](#BKMK_installrsat).  
  
#### <a name="BKMK_installrsat"></a>To install Remote Server Administration Tools for Windows 8.1  
  
1.  Download the Remote Server Administration Tools for [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] package from the [Microsoft Download Center](http://go.microsoft.com/fwlink/?LinkID=304145). You can either run the installer from the Download Center website, or save the download package to a local computer or share.  
  
    > [!IMPORTANT]  
    > You can only install Remote Server Administration Tools for [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] on computers that are running [!INCLUDE[winblue_client_pro_2](../Token/winblue_client_pro_2_md.md)] or [!INCLUDE[winblue_client_ent_2](../Token/winblue_client_ent_2_md.md)]. Remote Server Administration Tools cannot be installed on any other editions of [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], it cannot be installed on prerelease or evaluation copies of Windows 8.1, and it cannot be installed on computers that are running [!INCLUDE[winblue_winrt_2](../Token/winblue_winrt_2_md.md)] or other system\-on\-chip devices.  
  
2.  If you save the download package to a local computer or share, double\-click the installer program, **Windows8.1\-KB2693643\-x64.msu** or **Windows8.1\-KB2693643\-x86.msu**, depending on the architecture of the computer on which you want to install the tools.  
  
3.  When you are prompted by the **Windows Update Standalone Installer** dialog box to install the update, click **Yes**.  
  
4.  Read and accept the license terms. Click **I accept**.  
  
5.  Installation requires a few minutes to finish.  
  
##### To uninstall Remote Server Administration Tools for [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)]  
  
1.  On the desktop, hover in the upper right corner of the screen, and then click **Settings**.  
  
2.  On the **Desktop** menu, click **Control Panel**.  
  
3.  Under **Programs**, click **Uninstall a program**.  
  
4.  Click **View installed updates**.  
  
5.  Right\-click **Update for Microsoft Windows \(KB2693643\)**, and then click **Uninstall**.  
  
6.  When you are asked if you are sure you want to uninstall the update, click **Yes**.  
  
##### To turn off specific tools  
  
1.  On the desktop, hover in the upper right corner of the screen, and then click **Settings**.  
  
2.  On the **Desktop** menu, click **Control Panel**.  
  
3.  Click **Programs**, and then in **Programs and Features** click **Turn Windows features on or off**.  
  
4.  In the **Windows Features** dialog box, expand **Remote Server Administration Tools**, and then expand either **Role Administration Tools** or **Feature Administration Tools**.  
  
5.  Clear the check boxes for any tools that you want to turn off.  
  
    > [!NOTE]  
    > If you turn off [!INCLUDE[sm](../Token/sm_md.md)], the computer must be restarted, and tools that were accessible from the **Tools** menu of [!INCLUDE[sm](../Token/sm_md.md)] must be opened from the **Administrative Tools** folder.  
  
6.  When you are finished turning off tools that you do not want to use, click **OK**.  
  
### Run Remote Server Administration Tools  
  
> [!NOTE]  
> After installing Remote Server Administration Tools for [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], the **Administrative Tools** folder is not displayed on the **Start** screen. This is a known issue in this release of Remote Server Administration Tools for [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)]. You can access the tools from the following locations.  
>   
> -   The **Tools** menu in the [!INCLUDE[sm](../Token/sm_md.md)] console.  
> -   **Control Panel\\System and Security\\Administrative Tools**.  
> -   A shortcut saved to the desktop from the **Administrative Tools** folder \(to do this, right click the **Control Panel\\System and Security\\Administrative Tools** link, and then click **Create Shortcut**\).  
  
The tools installed as part of Remote Server Administration Tools for [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] cannot be used to manage the local computer. Regardless of the tool you run, you must specify a remote server or multiple remote servers on which to run the tool. Because most tools are integrated with [!INCLUDE[sm](../Token/sm_md.md)], you add remote servers that you want to manage to the [!INCLUDE[sm](../Token/sm_md.md)] server pool before managing the server by using the tools in the **Tools** menu. For more information about how to add servers to your server pool, and create custom groups of servers, see [Add servers to Server Manager](http://go.microsoft.com/fwlink/p/?LinkId=241353) and [Create and manage server groups](http://go.microsoft.com/fwlink/?LinkId=247328).  
  
In Remote Server Administration Tools for [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], all GUI\-based server management tools, such as MMC snap\-ins and dialog boxes, are accessed from the **Tools** menu of the [!INCLUDE[sm](../Token/sm_md.md)] console. Although the computer that runs Remote Server Administration Tools for [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] runs a client\-based operating system, after installing the tools, [!INCLUDE[sm](../Token/sm_md.md)], included with Remote Server Administration Tools for [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], opens automatically by default on the client computer. Note that there is no **Local Server** page in the [!INCLUDE[sm](../Token/sm_md.md)] console that runs on a client computer.  
  
##### To start Server Manager on a client computer  
  
1.  On the **Start** screen, click **Administrative Tools**.  
  
2.  In the **Administrative Tools** folder, double\-click **Server Manager**.  
  
3.  If neither the **Administrative Tools** nor the **Server Manager** tiles are displayed on the **Start** screen after installing Remote Server Administration Tools, and searching for [!INCLUDE[sm](../Token/sm_md.md)] on the **Start** screen does not display results, verify that the **Show administrative tools** setting is turned on. To view this setting, hover the mouse cursor over the upper right corner of the **Start** screen, and then click **Settings**. If **Show administrative tools** is turned off, turn the setting on to display tools that you have installed as part of Remote Server Administration Tools for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)].  
  
Although they are not listed in the [!INCLUDE[sm](../Token/sm_md.md)] console **Tools** menu, [!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlets and Command Prompt management tools are also installed for roles and features as part of Remote Server Administration Tools. For example, if you open a [!INCLUDE[wps_2](../Token/wps_2_md.md)] session with elevated user rights \(Run as Administrator\), and run the cmdlet `Get-Command -Module RDManagement`, the results include a list of Remote Desktop Services cmdlets that are now available to run on the local computer after installing Remote Server Administration Tools, as long as the cmdlets are targeted at a remote server that is running all or part of the Remote Desktop Services role.  
  
##### To start Windows PowerShell with elevated user rights \(Run as administrator\)  
  
1.  On the **Start** screen, right\-click the **Windows PowerShell** tile, and then click **Run as administrator**.  
  
2.  To run [!INCLUDE[wps_2](../Token/wps_2_md.md)] as an administrator from the desktop, right\-click the **Windows PowerShell** shortcut in the taskbar, and then click **Run as Administrator**.  
  
> [!NOTE]  
> You can also start a [!INCLUDE[wps_2](../Token/wps_2_md.md)] session that is targeted at a specific server by right\-clicking a managed server in a role or group page in [!INCLUDE[sm](../Token/sm_md.md)], and then clicking **Windows PowerShell**.  
  
## <a name="BKMK_8"></a>Remote Server Administration Tools for Windows 8  
Use Remote Server Administration Tools for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] to manage specific technologies on computers that are running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], and in limited cases, [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. Some of the tools work for managing roles and features on Windows Server 2003.  
  
Remote Server Administration Tools for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] includes support for remote management of computers that are running the Server Core installation option or the Minimal Server Interface configuration of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], and in limited cases, the Server Core installation options of [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. However, Remote Server Administration Tools for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] cannot be installed on any versions of the Windows Server operating system.  
  
### Tools available in this release  
For a list of the tools available in Remote Server Administration Tools for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] and Remote Server Administration Tools for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], see the table in [Remote Server Administration Tools \(RSAT\) for Windows Vista, Windows 7, Windows 8, Windows Server 2008, Windows Server 2008 R2, Windows Server 2012, and Windows Server 2012 R2](http://go.microsoft.com/fwlink/p/?LinkID=221055).  
  
### System requirements  
Remote Server Administration Tools for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] can be installed only on computers that are running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)]. Remote Server Administration Tools cannot be installed on computers that are running [!INCLUDE[winrt_2](../Token/winrt_2_md.md)] or other system\-on\-chip devices.  
  
Remote Server Administration Tools for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] runs on both x86\- and x64\-based editions of [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)].  
  
> [!IMPORTANT]  
> Remote Server Administration Tools for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] should not be installed on a computer that is running administration tools packs for [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], Windows Server 2003 or Windows 2000 Server®. Remove all older versions of Administration Tools Pack or Remote Server Administration Tools—including earlier prerelease versions, and releases of the tools for different languages or locales—from the computer before you install Remote Server Administration Tools for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)].  
  
To use this release of [!INCLUDE[sm](../Token/sm_md.md)] to access and manage remote servers that are running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], you must install several updates to make the older Windows Server operating systems manageable by using [!INCLUDE[sm](../Token/sm_md.md)]. For detailed information about how to prepare [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] for management by using [!INCLUDE[sm](../Token/sm_md.md)] in Remote Server Administration Tools for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], see [Manage Multiple, Remote Servers with Server Manager](http://technet.microsoft.com/library/hh831456.aspx).  
  
[!INCLUDE[wps_2](../Token/wps_2_md.md)] and [!INCLUDE[sm](../Token/sm_md.md)] remote management must be enabled on remote servers to manage them by using tools that are part of Remote Server Administration Tools for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)]. Remote management is enabled by default on servers that are running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. For more information about how to enable remote management, see [Manage multiple, remote servers with Server Manager](http://go.microsoft.com/fwlink/p/?LinkId=241358).  
  
### Install, uninstall, or disable Remote Server Administration Tools for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)]  
Remote Server Administration Tools for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] has a faster, one\-step installation process. In earlier releases of Remote Server Administration Tools, after running the MSU installer program, users were required to turn on specific tools that they wanted to use in the **Turn Windows features on or off** dialog box. This step has been eliminated; after you run the MSU installation program, all tools are enabled by default.  
  
##### To install supported language packs when the system UI language is not supported by the download package  
  
1.  > [!NOTE]  
    > This procedure applies only if your system UI language does not match one of the available Remote Server Administration Tools languages. If your computer’s system UI language matches an available Remote Server Administration Tools language, go on to the next procedure, [To install Remote Server Administration Tools for Windows 8](#BKMK_installwin8).  
  
    Follow instructions in [KB 2607607](http://support.microsoft.com/kb/2607607) to install supported [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] language packs from Windows Update. Be sure to install one of the language packs that is supported by Remote Server Administration Tools for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)].  
  
    Remote Server Administration Tools for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] is available in the following languages:  cs\-CZ, de\-DE, en\-US, es\-ES, fr\-FR, hu\-HU, it\-IT, ja\-JP, ko\-KR, nl\-NL, pl\-PL, pt\-BR, pt\-PT, ru\-RU, sv\-SE, tr\-TR, zh\-CN, zh\-HK, and zh\-TW.  
  
2.  When the language pack installation is complete, verify that the language pack is installed by running `get-windowspackage -online` in a [!INCLUDE[wps_2](../Token/wps_2_md.md)] session that has been started with elevated user rights \(Run as Administrator\).  
  
    The language pack entry starts with the following:  
  
    Microsoft\-Windows\-Client\-LanguagePack\-Package~\(GUID\)~\(architecture\)~\(supported language\)~6.2.9200.16384  
  
3.  After you have installed a supported language pack, go on to the next procedure, [To install Remote Server Administration Tools for Windows 8](#BKMK_installwin8).  
  
#### <a name="BKMK_installwin8"></a>To install Remote Server Administration Tools for Windows 8  
  
1.  Download the Remote Server Administration Tools for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] package from the [Microsoft Download Center](http://go.microsoft.com/fwlink/p/?LinkID=238560). You can either run the installer from the Download Center website, or save the download package to a local computer or share.  
  
2.  If you save the download package to a local computer or share, double\-click the installer program, **Windows6.2\-KB2693643\-x64.msu** or **Windows6.2\-KB2693643\-x86.msu**, depending on the architecture of the computer on which you want to install the tools.  
  
3.  When you are prompted by the **Windows Update Standalone Installer** dialog box to install the update, click **Yes**.  
  
4.  Read and accept the license terms. Click **I accept**.  
  
5.  Installation requires a few minutes to finish.  
  
##### To uninstall Remote Server Administration Tools for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)]  
  
1.  On the desktop, hover in the upper right corner of the screen, and then click **Settings**.  
  
2.  On the **Desktop** menu, click **Control Panel**.  
  
3.  Under **Programs**, click **Uninstall a program**.  
  
4.  Click **View installed updates**.  
  
5.  Right\-click **Update for Microsoft Windows \(KB2693643\)**, and then click **Uninstall**.  
  
6.  When you are asked if you are sure you want to uninstall the update, click **Yes**.  
  
##### To turn off specific tools  
  
1.  On the desktop, hover in the upper right corner of the screen, and then click **Settings**.  
  
2.  On the **Desktop** menu, click **Control Panel**.  
  
3.  Click **Programs**, and then in **Programs and Features** click **Turn Windows features on or off**.  
  
4.  In the **Windows Features** dialog box, expand **Remote Server Administration Tools**, and then expand either **Role Administration Tools** or **Feature Administration Tools**.  
  
5.  Clear the check boxes for any tools that you want to turn off.  
  
    > [!NOTE]  
    > If you turn off [!INCLUDE[sm](../Token/sm_md.md)], the computer must be restarted, and tools that were accessible from the **Tools** menu of [!INCLUDE[sm](../Token/sm_md.md)] must be opened from the **Administrative Tools** folder.  
  
6.  When you are finished turning off tools that you do not want to use, click **OK**.  
  
### Run Remote Server Administration Tools  
The tools installed as part of Remote Server Administration Tools for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] cannot be used to manage the local computer. Regardless of the tool you run, you must specify a remote server or multiple remote servers on which to run the tool. Because most tools are integrated with [!INCLUDE[sm](../Token/sm_md.md)], you add remote servers that you want to manage to the [!INCLUDE[sm](../Token/sm_md.md)] server pool before managing the server by using the tools in the **Tools** menu. For more information about how to add servers to your server pool, and create custom groups of servers, see [Add servers to Server Manager](http://go.microsoft.com/fwlink/p/?LinkId=241353) and [Create and manage server groups](http://go.microsoft.com/fwlink/?LinkId=247328).  
  
In Remote Server Administration Tools for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], all GUI\-based server management tools, such as MMC snap\-ins and dialog boxes, are accessed from the **Tools** menu of the [!INCLUDE[sm](../Token/sm_md.md)] console. Although the computer that runs Remote Server Administration Tools for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] runs a client\-based operating system, after installing the tools, [!INCLUDE[sm](../Token/sm_md.md)], included with Remote Server Administration Tools for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], opens automatically by default on the client computer. Note that there is no **Local Server** page in the [!INCLUDE[sm](../Token/sm_md.md)] console that runs on a client computer.  
  
##### To start Server Manager on a client computer  
  
1.  On the **Start** screen, click **Administrative Tools**.  
  
2.  In the **Administrative Tools** folder, double\-click **Server Manager**.  
  
3.  If neither the **Administrative Tools** nor the **Server Manager** tiles are displayed on the **Start** screen after installing Remote Server Administration Tools, and searching for [!INCLUDE[sm](../Token/sm_md.md)] on the **Start** screen does not display results, verify that the **Show administrative tools** setting is turned on. To view this setting, hover the mouse cursor over the upper right corner of the **Start** screen, and then click **Settings**. If **Show administrative tools** is turned off, turn the setting on to display tools that you have installed as part of Remote Server Administration Tools for [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)].  
  
Although they are not listed in the [!INCLUDE[sm](../Token/sm_md.md)] console **Tools** menu, [!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlets and Command Prompt management tools are also installed for roles and features as part of Remote Server Administration Tools. For example, if you open a [!INCLUDE[wps_2](../Token/wps_2_md.md)] session with elevated user rights \(Run as Administrator\), and run the cmdlet `Get-Command -Module RDManagement`, the results include a list of Remote Desktop Services cmdlets that are now available to run on the local computer after installing Remote Server Administration Tools, as long as the cmdlets are targeted at a remote server that is running all or part of the Remote Desktop Services role.  
  
##### To start Windows PowerShell with elevated user rights \(Run as administrator\)  
  
1.  On the **Start** screen, right\-click the **Windows PowerShell** tile, and then click **Run as administrator**.  
  
2.  To run [!INCLUDE[wps_2](../Token/wps_2_md.md)] as an administrator from the desktop, right\-click the **Windows PowerShell** shortcut in the taskbar, and then click **Run as Administrator**.  
  
> [!NOTE]  
> You can also start a [!INCLUDE[wps_2](../Token/wps_2_md.md)] session that is targeted at a specific server by right\-clicking a managed server in a role or group page in [!INCLUDE[sm](../Token/sm_md.md)], and then clicking **Windows PowerShell**.  
  
## See Also  
[Remote Server Administration Tools for Windows 8.1](http://go.microsoft.com/fwlink/?LinkID=304145)  
[Remote Server Administration Tools for Windows 8](http://go.microsoft.com/fwlink/p/?LinkID=238560)  
[Remote Server Administration Tools \(RSAT\) for Windows Vista, Windows 7, Windows 8, Windows Server 2008, Windows Server 2008 R2, Windows Server 2012, and Windows Server 2012 R2](http://go.microsoft.com/fwlink/p/?LinkID=221055)  
[Manage multiple, remote servers with Server Manager](http://go.microsoft.com/fwlink/p/?LinkId=241358)  
[Windows PowerShell Support for Windows Server 2012 R2 and Windows Server 2012](http://technet.microsoft.com/library/hh801904.aspx)  
  
