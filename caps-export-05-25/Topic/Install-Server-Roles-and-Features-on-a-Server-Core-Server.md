---
title: Install Server Roles and Features on a Server Core Server
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - server-general
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8e8615c1-d652-4433-9d4c-3245906270a9
author: jaimeo
---
# Install Server Roles and Features on a Server Core Server
When [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] is in Server Core mode, the following server roles are supported:  
  
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
  
-   Routing and Remote Access Server, including the following sub\-roles:  
  
    -   Remote Desktop Services Connection Broker  
  
    -   Licensing  
  
    -   Virtualization  
  
When [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] is in Server Core mode, the following server features are supported:  
  
-   Microsoft .NET Framework 3.5  
  
-   Microsoft .NET Framework 4.5  
  
-   Windows PowerShell  
  
-   Background Intelligent Transfer Service \(BITS\)  
  
-   BitLocker Drive Encryption  
  
-   BitLocker Network Unlock  
  
-   BranchCache  
  
-   Data Center Bridging  
  
-   Enhanced Storage  
  
-   Failover Clustering  
  
-   Multipath I\/O  
  
-   Network Load Balancing  
  
-   Peer Name Resolution Protocol  
  
-   Quality Windows Audio Video Experience  
  
-   Remote Differential Compression  
  
-   Simple TCP\/IP Services  
  
-   RPC over HTTP Proxy  
  
-   SMTP Server  
  
-   SNMP Service  
  
-   Telnet client  
  
-   Telnet server  
  
-   TFTP client  
  
-   Windows Internal Database  
  
-   Windows PowerShell Web Access  
  
-   Windows Process Activation Service  
  
-   Windows Standards\-based Storage Management  
  
-   WinRM IIS extension  
  
-   WINS server  
  
-   WoW64 support  
  
> [!NOTE]  
> [!INCLUDE[wps_howtorun](../Token/wps_howtorun_md.md)]  
  
## <a name="BKMK_1.1"></a>Installing and uninstalling server roles and features  
To discover the server roles and features on your computer, run the Windows PowerShell cmdlet `Get-WindowsFeature`.  
  
To install a server role or feature, make a note of the role or feature name in the output from `Get-WindowsFeature` and then run `Install-WindowsFeature <featurename>`.  
  
You can install \(or uninstall\) more than one feature at a time by separating feature names with commas. For example, to install both Server Graphical Shell and Windows PowerShell ISE \(and its dependencies\), if you run `Install-WindowsFeature Server-Gui-Shell,PowerShell-ISE`, the server is converted to Server with a GUI mode.  
  
Appending the `–WhatIf` parameter to either `Install-WindowsFeature <featurename>` or `Uninstall-WindowsFeature <featurename>` displays any dependent features that will be installed or uninstalled along with the feature you have specified.  
  
To uninstall a server role or feature, run the Windows PowerShell cmdlet `Uninstall-WindowsFeature <featurename>`  
  
> [!NOTE]  
> When you uninstall a role or feature with this command, the binary files for it remain on the disk. This allows you to add the role or feature later without having to access an installation source \(such as an installation DVD or WIM image\). To completely remove the files for the role or feature from the disk or to reinstall a role or feature that has been completely removed, see “Working with Features on Demand” in this topic.  
  
### Working with Features on Demand  
In previous versions of Windows, even if a server role or feature was disabled, the binary files for it were still present on the disk, consuming space. In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], not only can you disable a role or feature, but you can also completely remove its files, a state shown as “removed” in Server Manager or “disabled with payload removed” in Dism.exe. To reinstall a role or feature that has been completely removed, you must have access to an installation source.  
  
To completely remove a role or feature, use `–Remove` with the `Uninstall-WindowsFeature` cmdlet of Windows PowerShell. For example, to completely remove Windows Explorer, Internet Explorer, and dependent components, run the following Windows PowerShell command:  
  
`Uninstall-WindowsFeature Server-Gui-Shell -remove`  
  
To install a role or feature that has been completely removed, use the Windows PowerShell `–Source` option of the `Install-WindowsFeature` Server Manager cmdlet. The `–Source` option specifies a path to a WIM image and the index number of the image. If you do not specify a `–Source` option, Windows will use Windows Update by default.  
  
To install a removed role or feature using a WIM image, use these steps and Windows PowerShell cmdlets:  
  
1.  Run `Get-windowsimage –imagepath <path to wim>\install.wim`, and make note of the index of the image for the Server with a GUI version of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
2.  `Install-WindowsFeature <featurename> -Source wim:<path>:<index>`, where:  
  
    *Featurename* is the name of the role or feature from Get\-WindowsFeature  
  
    *Path* is the path to the WIM mount point  
  
    *Index* is the index of the server image from Step 1.  
  
For example, if the Server with a GUI image is in D:\\sources: `Install-WindowsFeature <featurename> -Source wim:d:\sources\install.wim:4`  
  
You can also specify a source for servers that are domain members using Group Policy. Navigate to **Computer Configuration > Administrative Templates > System > “Specify settings for optional component installation and component repair”**  
  
> [!NOTE]  
> Permissions might affect the system’s ability to access Windows features for installation over a network. The Trusted Installer process runs within the machine account. If you encounter network access issues, try issuing a net use command \(for example, **net use \* \\\\path\\to\\network**\) to connect to the network source and then copy the source locally. Then use the local copy as the installation source.  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Manage a Server Core Server](../Topic/Manage-a-Server-Core-Server.md)  
  
-   [Configure a Server Core Server](../Topic/Configure-a-Server-Core-Server.md)  
  
-   [Configure and Manage Server Core Installations](../Topic/Configure-and-Manage-Server-Core-Installations.md)  
  
-   [Windows Server Installation Options](../Topic/Windows-Server-Installation-Options.md)  
  
-   [Evaluation Versions and Upgrade Options for Windows Server 2012](http://go.microsoft.com/fwlink/?LinkId=260917)  
  
