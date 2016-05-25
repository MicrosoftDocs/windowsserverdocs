---
title: Windows Server Installation Options
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - server-general
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ebbecbda-3d97-48fe-9599-4031ad285384
author: jaimeo
---
# Windows Server Installation Options
This document summarizes the differences between the installation options available for [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)], including the features that are installed with each option, the management options available after installation, and how to switch between the installation options during use. It also explains the differences between the Server Graphical Shell and the Minimal Server Interface and how to switch between them. In addition, it discusses how to use Features on Demand to further reduce the disk footprint by including the binary files for only the server roles you actually use.  
  
## <a name="BKMK_OVER"></a>Installation options description  
When you install [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], you can choose between **Server Core Installation** and **Server with a GUI**. The “Server with a GUI” option is the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] equivalent of the Full installation option available in Windows Server 2008 R2. The “Server Core Installation” option reduces the space required on disk, the potential attack surface, and especially the servicing requirements, so we recommend that you choose the Server Core installation unless you have a particular need for the additional user interface elements and graphical management tools that are included in the “Server with a GUI” option. For this reason, the Server Core installation is now the default. Because you can freely switch between these options at any time later, one approach might be to initially install the Server with a GUI option, use the graphical tools to configure the server, and then later switch to the Server Core Installation option.  
  
An intermediate state is possible where you start with a Server with a GUI installation and then remove Server Graphical Shell, resulting in a server that comprises the “Minimal Server Interface,” Microsoft Management Console \(MMC\), Server Manager, and a subset of Control Panel. See the “Minimal Server Interface” section of this document for more information.  
  
In addition, after installation of either option is complete, you can completely remove the binary files for server roles and features that you do not need, thereby conserving disk space and reducing the attack surface still further. See the “Features on Demand” section of this document for more information.  
  
A server in Minimal Server Interface mode is about 300 MB smaller than the same server in Server with a GUI mode. A server in Server Core mode is about 4 GB smaller than the same server in Server with a GUI mode. For the smallest possible installation footprint, start with a Server Core installation and then completely remove any server roles or features you do not need by using Features on Demand.  
  
### If you choose the Server Core Installation option  
With this option, the standard user interface \(the “Server Graphical Shell”\) is not installed; you manage the server using the command line, Windows PowerShell, or by remote methods.  
  
-   **User interface:** command prompt \(Server Graphical Shell is not installed\)  
  
-   **Install, configure, uninstall server roles locally:** at a command prompt with Windows PowerShell.  
  
-   **Install, configure, uninstall server roles remotely:** with Server Manager, Remote Server Administration Tools \(RSAT\), or Windows PowerShell.  
  
    > [!NOTE]  
    > For RSAT, you must use the Windows 8 version.  
  
-   **Microsoft Management Console:** not available locally.  
  
-   **Desktop Experience:** not available.  
  
-   **Server roles available:**  
  
    -   Active Directory Certificate Services  
  
    -   Active Directory Domain Services  
  
    -   DHCP Server  
  
    -   DNS Server  
  
    -   File Services \(including File Server Resource Manager\)  
  
    -   Active Directory Lightweight Directory Services \(AD LDS\)  
  
    -   Hyper\-V  
  
    -   Print and Document Services  
  
    -   Streaming Media Services  
  
    -   Web Server \(including a subset of ASP.NET\)  
  
    -   Windows Server Update Server  
  
    -   Active Directory Rights Management Server  
  
    -   Routing and Remote Access Server and the following sub\-roles:  
  
        -   Remote Desktop Services Connection Broker  
  
        -   Licensing  
  
        -   Virtualization  
  
-   **To convert to a Server with GUI installation with Windows PowerShell:** follow the steps in the procedure below.  
  
    > [!NOTE]  
    > All cmdlets must be run from an elevated Windows PowerShell prompt.  
  
##### To use Windows PowerShell to convert from a Server Core installation to a Server with a GUI installation  
  
1.  Determine the index number for a Server with a GUI image \(for example, **SERVERDATACENTER**, not **SERVERDATACENTERCORE**\) with `Get-WindowsImage -ImagePath <path to wim>\install.wim`.  
  
2.  Run `Install-WindowsFeature Server-Gui-Mgmt-Infra,Server-Gui-Shell –Restart –Source c:\mountdir\windows\winsxs`  
  
3.  Alternatively, if you want to use Windows Update as the source instead of a WIM file, use this Windows PowerShell cmdlet:  
  
    `Install-WindowsFeature Server-Gui-Mgmt-Infra,Server-Gui-Shell –Restart`  
  
### If you choose the Server with a GUI option  
With this option, the standard user interface and all tools are installed. Server roles and features are installed with Server Manager or by other methods.  
  
-   **User interface:** standard graphical user interface \(“Server Graphical Shell”\). The Server Graphical Shell includes the new Windows 8 shell, but does not include the Windows Store or support for Windows Store apps. To enable support for the Windows Store and Windows Store apps, install the Desktop Experience feature.  
  
-   **Install, configure, uninstall server roles locally:** with Server Manager or with Windows PowerShell  
  
    **Install, configure, uninstall server roles remotely:** with Server Manager, Remote Server, RSAT, or Windows PowerShell  
  
-   **Microsoft Management Console:** installed  
  
-   **Desktop Experience:** installable with Server Manager or Windows PowerShell  
  
-   **To convert to a Server Core installation with Windows PowerShell:** run the following cmdlet:  
  
    `Uninstall-WindowsFeature Server-Gui-Mgmt-Infra -Restart`  
  
If you initially install with the Server with a GUI option and then use the above command to convert to a Server Core installation, you can later revert to a Server with a GUI installation without specifying a source. This is because the necessary files remain stored on the disk, even though they are no longer installed. For more information, and for instructions to completely remove the Server with a GUI files from disk, see the “Features on Demand” section of this document.  
  
If you convert to a Server Core installation, Windows features, server roles, and GUI management tools that require a Server with a GUI installation will be uninstalled automatically. You can specify the `-WhatIf` option in Windows PowerShell to see exactly which features will be affected by the conversion.  
  
> [!NOTE]  
> If the server has been in Server Core mode and then you switch to Server with a GUI mode, clicking a tile in the Start Screen that starts Internet Explorer will result in an error reading “This app can’t open.” To fix this, go to Internet Options and select **Open Internet Explorer Tiles on the Desktop**.  
  
## Minimal Server Interface  
In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], you can remove the Server Graphical Shell, resulting in the “Minimal Server Interface.” This is similar to a Server with a GUI installation, but Internet Explorer 10, Windows Explorer, the desktop, and the Start screen are not installed. Microsoft Management Console \(MMC\), Server Manager, and a subset of Control Panel are still present.  
  
Starting with a Server with a GUI installation, you can convert to the Minimal Server Interface at any time using Server Manager.  
  
> [!NOTE]  
> When you change any of these options, you will have to restart the server for the change to take effect.  
  
See the table below for a summary of which selections to make in Server Manager \(or cmdlets to use in Windows PowerShell\) in order to get a given installation state:  
  
|To reach the installation state in each column…|Server Core installation option|Minimal Server Interface|Server with a GUI installation option|Desktop Experience feature installed|  
|---------------------------------------------------|-----------------------------------|----------------------------|-----------------------------------------|----------------------------------------|  
|Select these features in Server Manager:|none|Graphical Management Tools and Infrastructure|Graphical Management Tools and Infrastructure, Server Graphical Shell|Graphical Management Tools and Infrastructure, Server Graphical Shell, Desktop Experience|  
|Or, run the Windows PowerShell install\/uninstall commands with these values for the Name parameter:|none|`Server-Gui-Mgmt-Infra`|`Server-Gui-Mgmt-Infra, Server-Gui-Shell`|`Server-Gui-Mgmt-Infra, Server-Gui-Shell, Desktop-Experience`|  
  
## Features on Demand  
In previous versions of Windows, even if a server role or feature was disabled, the binary files for it were still present on the disk, consuming space. In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], not only can you disable a role or feature, but you can also completely remove its files, a state shown as “removed” in Server Manager or “disabled with payload removed” in Dism.exe. To reinstall a role or feature that been completely removed, you must have access to an installation source.  
  
To completely remove a role or feature, use `–Remove` with the `Uninstall-WindowsFeature` cmdlet of Windows PowerShell. For example, to completely remove Windows Explorer, Internet Explorer, and dependent components, run the following Windows PowerShell command:  
  
`Uninstall-WindowsFeature Server-Gui-Shell -Remove`  
  
To install a role or feature that has been completely removed, use the Windows PowerShell `–Source` option of the `Install-WindowsFeature` Server Manager cmdlet. The `–Source` option specifies a path to a WIM image and the index number of the image. If you do not specify a `–Source` option, Windows will use Windows Update by default. Offline VHDs cannot be used as a source for installing roles or features which have been completely removed.  
  
Only component sources from the exact same version of Windows are supported. For example, a component source derived from the Windows Server Developer Preview is not a valid installation source for a server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
To install a removed role or feature using a WIM image, use the steps and Windows PowerShell cmdlets:  
  
1.  Run `Get-windowsimage –imagepath <path to wim>\install.wim`, and make note of the index of the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] image.  
  
2.  `Install-WindowsFeature <featurename> -Source wim:<path>:<index>`, where:  
  
    *Featurename* is the name of the role or feature from Get\-WindowsFeature  
  
    *Path* is the path to the WIM mount point  
  
    *Index* is the index of the server image from Step 1.  
  
For example: `Install-WindowsFeature <featurename> -Source wim:d:\sources\install.wim:4`  
  
You can also specify a source for servers that are domain members using Group Policy. Navigate to **Computer Configuration > Administrative Templates > System > “Specify settings for optional component installation and component repair”**  
  
> [!NOTE]  
> Permissions might affect the system’s ability to access Windows features for installation over a network. The Trusted Installer process runs within the machine account. If you encounter network access issues, try issuing a net use command \(for example, **net use \* \\\\path\\to\\network** or the cmdlet `New-PSDrive -Name Z -PSProvider Filesystem -Root "\\path\to\network`\) to mount the network source and then copy the source locally. Then use the local copy as the installation source.  
  
## <a name="BKMK_APP"></a>Practical applications  
These examples give you an idea of how you can choose the installation option that might be most appropriate for your deployment needs:  
  
-   Server Core installations require approximately 4 GB less space than a Server with a GUI installation. By using Server Core installations on virtual machines, you can achieve a significant space savings by not having to store the GUI files on the virtual machine’s disk.  
  
-   Servers often have comparatively large amounts of memory and complex disk arrays, both of which can take a significant amount of time to initialize at startup. Because Server Core installations minimize the number of restarts required for updates, the frequency at which disk arrays and memory must be re\-initialized is reduced.  
  
-   Certain server applications have dependencies on certain Windows services, libraries, applications, and files that are not available in Server Core installations, but the administrator wants to take advantage of the reduced need for updating typical of Server Core installations. The Minimal Server Interface offers additional compatibility while still maintaining a reduced system footprint \(though to a lesser extent than a Server Core installation\).  
  
-   Features on Demand can be used to reduce the footprint for your virtual machine deployments by removing roles and features that will never be deployed in your virtual machines. Depending on the roles and features used in your virtual machines, it is possible to reduce the size by over 1 GB.  
  
## <a name="BKMK_NEW"></a>Reference table  
This table summarizes which features are available locally depending on which installation option you choose.  
  
||Server Core installation option|Minimal Server Interface|Server with a GUI installation option|Desktop Experience feature installed|  
|-|-----------------------------------|----------------------------|-----------------------------------------|----------------------------------------|  
|Command prompt|available|available|available|available|  
|Windows PowerShell\/Microsoft .NET|available|available|available|available|  
|Server Manager|not available|available|available|available|  
|Microsoft Management Console|not available|available|available|available|  
|Control Panel|not available|not available|available|available|  
|Control Panel applets|not available|some available|available|available|  
|Windows Explorer|not available|not available|available|available|  
|Taskbar|not available|not available|available|available|  
|Notification area|not available|not available|available|available|  
|Internet Explorer|not available|not available|available|available|  
|Built\-in help system|not available|not available|available|available|  
|Themes|not available|not available|not available|available|  
|Windows 8 Shell|not available|not available|not available|available|  
|Windows Store and support for Windows Store apps|not available|not available|not available|available|  
|Windows Media Player|not available|not available|not available|available|  
  
## <a name="BKMK_LINKS"></a>See also  
For detailed information about working with a server in Server Core mode, see [Configure and Manage Server Core Installations](../Topic/Configure-and-Manage-Server-Core-Installations.md).  
  
1.5  
  
