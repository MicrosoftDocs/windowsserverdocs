---
title: Remote Server Administration Tools
description: "Top level topic for Remote Server Administration Tools"
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-rsat
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: d54a1f5e-af68-497e-99be-97775769a7a7
author: coreyp-at-msft
ms.author: coreyp
manager: dansimp

---
# Remote Server Administration Tools

>Applies to: Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This topic supports Remote Server Administration Tools for Windows 10.

> [!IMPORTANT]
> Starting with Windows 10 October 2018 Update, RSAT is included as a set of **Features on Demand** in Windows 10 itself. See **When to use which RSAT version** below for installation instructions.

RSAT lets IT admins manage Windows Server roles and features from a Windows 10 PC.

Remote Server Administration Tools includes Server Manager, Microsoft Management Console (mmc) snap-ins, consoles, Windows PowerShell cmdlets and providers, and some command-line tools for managing roles and features that run on Windows Server.

Remote Server Administration Tools includes Windows PowerShell cmdlet modules that can be used to manage roles and features that are running on Remote servers. Although Windows PowerShell remote management is enabled by default on Windows Server 2016, it is not enabled by default on Windows 10. To run cmdlets that are part of Remote Server Administration Tools against a Remote server, run `Enable-PSremoting` in a Windows PowerShell session that has been opened with elevated user rights (that is, Run as Administrator) on your Windows client computer after installing Remote Server Administration Tools.

## <a name="BKMK_Thresh"></a>Remote Server Administration Tools for Windows 10
Use Remote Server Administration Tools for Windows 10 to manage specific technologies on computers that are running Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, and in limited cases,  Windows Server 2012 , or  Windows Server 2008 R2 .

Remote Server Administration Tools for Windows 10 includes support for remote management of computers that are running the Server Core installation option or the Minimal Server Interface configuration of Windows Server 2016,  Windows Server 2012 R2 , and in limited cases, the Server Core installation options of Windows Server 2012. However, Remote Server Administration Tools for Windows 10 cannot be installed on any versions of the Windows Server operating system.

### Tools available in this release
For a list of the tools available in Remote Server Administration Tools for Windows 10, see the table in [Remote Server Administration Tools (RSAT) for Windows operating systems](https://support.microsoft.com/help/2693643/remote-server-administration-tools-rsat-for-windows-operating-systems).

### System requirements
Remote Server Administration Tools for Windows 10 can be installed only on computers that are running Windows 10. Remote Server Administration Tools cannot be installed on computers that are running Windows RT 8.1, or other system-on-chip devices.

Remote Server Administration Tools for Windows 10 runs on both x86-based and x64-based editions of Windows 10.

> [!IMPORTANT]
> Remote Server Administration Tools for Windows 10 should not be installed on a computer that is running administration tools packs for Windows 8.1, Windows 8,  Windows Server 2008 R2,  Windows Server 2008, Windows Server 2003 or Windows 2000 Server. Remove all older versions of Administration Tools Pack or Remote Server Administration Tools, including earlier prerelease versions, and releases of the tools for different languages or locales from the computer before you install Remote Server Administration Tools for Windows 10.

To use this release of Server Manager to access and manage Remote servers that are running  Windows Server 2012 R2 ,  Windows Server 2012 , or  Windows Server 2008 R2 , you must install several updates to make the older Windows Server operating systems manageable by using Server Manager. For detailed information about how to prepare  Windows Server 2012 R2,  Windows Server 2012, and  Windows Server 2008 R2 for management by using Server Manager in Remote Server Administration Tools for Windows 10, see [Manage Multiple, Remote Servers with Server Manager](https://technet.microsoft.com/library/hh831456.aspx).

Windows PowerShell and Server Manager remote management must be enabled on remote servers to manage them by using tools that are part of Remote Server Administration Tools for Windows 10. Remote management is enabled by default on servers that are running Windows Server 2016,  Windows Server 2012 R2, and  Windows Server 2012. For more information about how to enable remote management if it has been disabled, see [Manage multiple, remote servers with Server Manager](https://go.microsoft.com/fwlink/p/?LinkId=241358).

## Install, uninstall and turn off/on RSAT tools

### Use Features on Demand (FoD) to install specific RSAT tools on Windows 10 October 2018 Update, or later

Starting with Windows 10 October 2018 Update, RSAT is included as a set of **Features on Demand** right from Windows 10. Now, instead of downloading an RSAT package you can just go to **Manage optional features** in **Settings** and click **Add a feature** to see the list of available RSAT tools. Select and install the specific RSAT tools you need. To see installation progress, click the **Back** button to view status on the **Manage optional features** page.

See the [list of RSAT tools available via **Features on Demand**](https://docs.microsoft.com/windows-hardware/manufacture/desktop/features-on-demand-non-language-fod#remote-server-administration-tools-rsat). In addition to installing via the graphical **Settings** app, you can also install specific RSAT tools via command line or automation using [**DISM /Add-Capability**](https://docs.microsoft.com/windows-hardware/manufacture/desktop/features-on-demand-v2--capabilities#using-dism-add-capability-to-add-or-remove-fods).

One benefit of Features on Demand is that installed features persist across Windows 10 version upgrades.

#### To uninstall specific RSAT tools on Windows 10 October 2018 Update or later (after installing with FoD)

On Windows 10, open the **Settings** app, go to **Manage optional features**, select and uninstall the specific RSAT tools you wish to remove. Note that in some cases, you will need to manually uninstall dependencies. Specifically, if RSAT tool A is needed by RSAT tool B, then choosing to uninstall RSAT tool A will fail if RSAT tool B is still installed. In this case, uninstall RSAT tool B first, and then uninstall RSAT tool A. Also note that in some cases, uninstalling an RSAT tool may appear to succeed even though the tool is still installed. In this case, restarting the PC will complete the removal of the tool.

See the [list of RSAT tools including dependencies](https://docs.microsoft.com/windows-hardware/manufacture/desktop/features-on-demand-non-language-fod#remote-server-administration-tools-rsat). In addition to uninstalling via the graphical Settings app, you can also uninstall specific RSAT tools via command line or automation using [**DISM /Remove-Capability**](https://docs.microsoft.com/windows-hardware/manufacture/desktop/features-on-demand-v2--capabilities#using-dism-add-capability-to-add-or-remove-fods).

### When to use which RSAT version

If you have a version of Windows 10 prior to the October 2018 Update (1809), you will not be able to use **Features on Demand**. You will need to download and install the RSAT package.

- **Install RSAT FODs directly from Windows 10, as outlined above**:
When installing on Windows 10 October 2018 Update (1809) or later, for managing Windows Server 2019 or previous versions.

- **Download and install WS_1803 RSAT package, as outlined below**:
When installing on Windows 10 April 2018 Update (1803) or earlier, for managing Windows Server, version 1803 or Windows Server, version 1709.

- **Download and install WS2016 RSAT package, as outlined below**:
When installing on Windows 10 April 2018 Update (1803) or earlier, for managing Windows Server 2016 or previous versions.

#### <a name="BKMK_installthresh"></a>Download the RSAT package to install Remote Server Administration Tools for Windows 10

1.  Download the Remote Server Administration Tools for Windows 10 package from the [Microsoft Download Center](https://go.microsoft.com/fwlink/?LinkID=404281). You can either run the installer from the Download Center website, or save the download package to a local computer or share.

    > [!IMPORTANT]
    > You can only install Remote Server Administration Tools for Windows 10 on computers that are running Windows 10. Remote Server Administration Tools cannot be installed on computers that are running Windows RT 8.1 or other system-on-chip devices.

2.  If you save the download package to a local computer or share, double-click the installer program, **WindowsTH-KB2693643-x64.msu** or **WindowsTH-KB2693643-x86.msu**, depending on the architecture of the computer on which you want to install the tools.

3.  When you are prompted by the **Windows Update Standalone Installer** dialog box to install the update, click **Yes**.

4.  Read and accept the license terms. Click **I accept**.

5.  Installation requires a few minutes to finish.

##### To uninstall Remote Server Administration Tools for Windows 10 (after RSAT package install)

1. On the desktop, click **Start**, click **All Apps**, click **Windows System**, and then click **Control Panel**.

2. Under **Programs**, click **Uninstall a program**.

3. Click **View installed updates**.

4. Right-click **Update for Microsoft Windows (KB2693643)**, and then click **Uninstall**.

5. When you are asked if you are sure you want to uninstall the update, click **Yes**.
   S
   ##### To turn off specific tools (after RSAT package install)

6. On the desktop, click **Start**, click **All Apps**, click **Windows System**, and then click **Control Panel**.

7. Click **Programs**, and then in **Programs and Features** click **Turn Windows features on or off**.

8. In the **Windows Features** dialog box, expand **Remote Server Administration Tools**, and then expand either **Role Administration Tools** or **Feature Administration Tools**.

9. Clear the check boxes for any tools that you want to turn off.

   > [!NOTE]
   > If you turn off Server Manager, the computer must be restarted, and tools that were accessible from the **Tools** menu of Server Manager must be opened from the **Administrative Tools** folder.

10. When you are finished turning off tools that you do not want to use, click **OK**.

### Run Remote Server Administration Tools

> [!NOTE]
> After installing Remote Server Administration Tools for Windows 10, the **Administrative Tools** folder is displayed on the **Start** menu. You can access the tools from the following locations.
>
> -   The **Tools** menu in the Server Manager console.
> -   **Control Panel\System and Security\Administrative Tools**.
> -   A shortcut saved to the desktop from the **Administrative Tools** folder (to do this, right click the **Control Panel\System and Security\Administrative Tools** link, and then click **Create Shortcut**).

The tools installed as part of Remote Server Administration Tools for Windows 10 cannot be used to manage the local client computer. Regardless of the tool you run, you must specify a remote server, or multiple remote servers, on which to run the tool. Because most tools are integrated with Server Manager, you add remote servers that you want to manage to the Server Manager server pool before managing the server by using the tools in the **Tools** menu. For more information about how to add servers to your server pool, and create custom groups of servers, see [Add servers to Server Manager](https://go.microsoft.com/fwlink/p/?LinkId=241353) and [Create and manage server groups](https://go.microsoft.com/fwlink/?LinkId=247328).

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


## Known issues

### **Issue**: RSAT FOD installation fails with error code 0x800f0954

> **Impact**: RSAT FODs on Windows 10 1809 (October 2018 Update) in WSUS/Configuration Manager environments
> 
> **Resolution**: To install FODs on a domain-joined PC which receives updates through WSUS or Configuration Manager, you will need to change a Group Policy setting to enable downloading FODs directly from Windows Update or a local share. For more details and instructions on how to change that setting, see [How to make Features on Demand and language packs available when you're using WSUS/SCCM](https://docs.microsoft.com/windows/deployment/update/fod-and-lang-packs).

---

### **Issue**: RSAT FOD installation via Settings app does not show status/progress

> **Impact**: RSAT FODs on Windows 10 1809 (October 2018 Update)
> 
> **Resolution**: To see installation progress, click the **Back** button to view status on the **Manage optional features** page.

---

### **Issue**: RSAT FOD uninstallation via Settings app may fail

> **Impact**: RSAT FODs on Windows 10 1809 (October 2018 Update)
> 
> **Resolution**: In some cases, uninstallation failures are due to the need to manually uninstall dependencies. Specifically, if RSAT tool A is needed by RSAT tool B, then choosing to uninstall RSAT tool A will fail if RSAT tool B is still installed. In this case, uninstall RSAT tool B first, and then uninstall RSAT tool A. See the list of RSAT FODs including dependencies.

---

### **Issue**: RSAT FOD uninstallation appears to succeed, but the tool is still installed

> **Impact**: RSAT FODs on Windows 10 1809 (October 2018 Update)
> 
> **Resolution**: Restarting the PC will complete the removal of the tool.

---

### **Issue**: RSAT missing after Windows 10 upgrade

> **Impact**: Any RSAT .MSU package installation (prior to RSAT FODs) not automatically reinstalled
> 
> **Resolution**: An RSAT installation cannot be persisted across OS upgrades due to the RSAT .MSU being delivered as a Windows Update package. Please install RSAT again after upgrading Windows 10. Note that this limitation is one of the reasons why we've moved to FODs starting with Windows 10 1809. RSAT FODs which are installed will persist across future Windows 10 version upgrades.

## See Also
>- [Remote Server Administration Tools for Windows 10](https://go.microsoft.com/fwlink/?LinkID=404281)
>- [Remote Server Administration Tools (RSAT) for Windows Vista, Windows 7, Windows 8, Windows Server 2008, Windows Server 2008 R2, Windows Server 2012, and Windows Server 2012 R2](https://go.microsoft.com/fwlink/p/?LinkID=221055)
