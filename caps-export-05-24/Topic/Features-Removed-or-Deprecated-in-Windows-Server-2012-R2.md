---
title: Features Removed or Deprecated in Windows Server 2012 R2
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - server-general
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 16f7f50d-5c08-40c8-a258-01339351a52c
author: jaimeo
---
# Features Removed or Deprecated in Windows Server 2012 R2
The following is a list of features and functionalities in [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)] that have either been removed from the product in the current release or are planned for potential removal in subsequent releases \(“deprecated”\). It is intended for IT professionals who are updating operating systems in a commercial environment. This list is subject to change in subsequent releases and may not include every deprecated feature or functionality. For more details about a particular feature or functionality and its replacement, see the documentation for that feature.  
  
For your quick reference, following table briefly summarizes the status of features that have been removed or deprecated in either [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
> [!NOTE]  
> This table is necessarily abbreviated; if you see a feature marked for deprecation or removal, please consult the detailed information in this topic or in [Features Removed or Deprecated in Windows Server 2012](../Topic/Features-Removed-or-Deprecated-in-Windows-Server-2012.md).  
  
## Quick reference table  
  
||[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|  
|-|-----------------------------------------------------------|-----------------------------------------------------------------|  
|Feature|Removed|Deprecated|Removed|Deprecated|  
|AD FS v1 Web Agent|||x||  
|AD FS in\-place upgrade from AD FS 1.0 or “out of box” AD FS 2.0|x||||  
|AD FS support for “Resource Group”|x||||  
|AD FS support for NT Token mode|x||||  
|AD FS support for using AD LDS as an authentication store|x||||  
|AD RMS license revocation||||x|  
|AD RMS SDK||||x|  
|Application Server role||||x|  
|Built\-in drivers for tape drives||||x|  
|Cluster Automation Server COM API|x \(made optional\)||x \(optional\)||  
|Cluster.exe command\-line interface|x \(made optional\)||x \(optional\)||  
|CertObj COM and InetInfo interfaces of the Web Server role||||x|  
|Dcpromo.exe||x|||  
|Dfscmd.exe||||x|  
|Drivers for Jet Red RDBMS and ODBC||x||x|  
|File Replication Service||||x|  
|GAA\_FLAG\_INCLUDE\_TUNNEL\_BINDINGORDER flat in GetAdaptersAddresses||||x|  
|Internet Information Service \(IIS\) 6.0 Manager||||x|  
|Layered Service Providers||x||x|  
|IscsiVirtualDiskSnapshot and associated WMI methods||||x|  
|LPR\/LPD protocol||x||x|  
|Namespace for version 1.0 of WMI; WMIC \(in WMI\)||x|x||  
|NDIS version 5.0, 5.1, and 5.2 APIs||x|x||  
|Net DMA|x||||  
|Network Access Protection \(NAP\)||||x|  
|Network Information Service \(NIS\) and Tools \(in RSAT\)||||x|  
|Nfsshare.exe||||x|  
|NFSv2 support||||x|  
|Oclist.exe|x||||  
|ODBC support for 16\- and 32\-bit applications and drivers||x||x|  
|ODBC\/OLEDB support for Microsoft Oracle||x|||  
|ODBC\/OLEDB support for SQL beyond SQL Server 7 and SQL 2000||x||x|  
|Providers for SNMP, Win32\_ServerFeature API, Active Directory, MSClus WMI1.0 \(in WMI\)||x||x|  
|Recovery disk creation|||x||  
|Remote Data Service||x|||  
|Role Collector \(Ceiprole.exe\) and associated API|x||||  
|SCSIport host\-bus adapter|x||||  
|Servermanagercmd.exe||x|x||  
|Security Configuration Wizard||||x|  
|SIS Limited API||||x|  
|Slmgr.vbs options|||x||  
|SMB 1.0||||x|  
|SMB.sys|x||||  
|SMTP and associated management tools||x||x|  
|SQLXMLX||x||x|  
|Storage Explorer snap\-in for MMC|x||||  
|Storage Manager for SANs snap\-in for MMC|x||||  
|Subsystem for UNIX\-based Applications||x|x||  
|Support for 32\-bit cluster resource DLLs|x||||  
|Support for hardware drivers for XDDM|x||||  
|Support for Microsoft SQL Server prior to 7.0|x||||  
|Support for native VGA via the PC\/AT BIOS or UEFI CSM|x||||  
|Support for Static VMQ|x||||  
|Support for Token Rings|x||||  
|Support for Visual Studio Analyzer 2003 over ODBC, OLEDB, and ADO|x||||  
|System Image Backup \(“Windows 7 File Recovery”\)|||x||  
|Telnet server||||x|  
|VM Chimney \(also called TCP Offload\) \(in Hyper\-V\)|x||||  
|Windows Server 2003 domain and functional levels of Active Directory||||x|  
|Windows Authorization Manager \(AzMan\)||x||x|  
|Windows Help executable \(WinHlp32.exe\)|x||||  
|Windows Identity Foundation 3.5||||x|  
|Windows Server Resource Manager||x|x||  
|Winsock Direct||x|x||  
|WMI root\\virtualization namespace v1 \(in Hyper\-V\)||x|x||  
|XDR schema elements, XSl pattern feature of MSXML3 \(in XML\)||x||x|  
  
## Features removed from Windows Server 2012 R2  
The following features and functionalities have been removed from this release of [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. Applications, code, or usage that depend on these features will not function in this release unless you employ an alternate method.  
  
> [!NOTE]  
> If you are moving to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] from a server release prior to [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], you should also review [Features Removed or Deprecated in Windows Server 2012](../Topic/Features-Removed-or-Deprecated-in-Windows-Server-2012.md).  
  
### Backup and file recovery  
  
-   The File Backup and Restore feature has been removed. Use the File History feature instead.  
  
-   System Image Backup \(the “Windows 7 File Recovery” feature\) has been removed. Instead, use “Reset your PC.”  
  
### Drivers  
Drivers for tape drives have been removed from the operating system. Instead, use the drivers provided by the manufacturer of your tape drive.  
  
### Recovery disk creation  
The ability to create a recovery disk on CD or DVD has been removed. Use the Recovery Disk to USB feature.  
  
### Slmgr.vbs options  
The **\/stao** \(sets token activation only\) and **\/ctao** \(clears activation tokens only\) options of Slmgr.vbs have been removed. These options have been replaced by more flexible activation command options.  
  
### Subsystem for UNIX\-based Applications  
The Subsystem for UNIX\-based Applications \(SUA\) has been removed. If you use the SUA POSIX subsystem with this release, use Hyper\-V to virtualize the server. If you use the tools provided by SUA, switch to Cygwin's POSIX emulation, or use either mingw\-w64 \(available from Sourceforge.net\) or MinGW \(available from MinGW.org\) for doing a native port.  
  
### WMI root\\virtualization namespace v1 \(used in Hyper\-V\)  
The WMI root\\virtualization\\v1 namespace has been removed. Instead use the root\\virtualization\\v2 namespace.  
  
## Features deprecated starting with Windows Server 2012 R2  
The following features and functionalities are deprecated starting with this release. Eventually, they will be completely removed from the product, but they are still available in this release, sometimes with certain functionality removed. You should begin planning now to employ alternate methods for any applications, code, or usage that depend on these features.  
  
### Active Directory  
  
-   The Active Directory Rights Management Services \(AD RMS\) SDK has been deprecated. To build applications for AD RMS, migrate to AD RMS SDK 2.0, which leverages functionality exposed by the client in Msipc.dll.  
  
-   The license revocation functionality in AD RMS is deprecated. Use the protection policy to control the document lifecycle. To remove access to a particular document, set the validity time to “0” in the template, or select **Require a connection to verify a user’s permission** in Microsoft Office. Be aware that both of these options require a connection to a Rights Management Server in order to open the files.  
  
-   The File Replication Service \(FRS; part of the Active Directory Domain Services role\) is deprecated. You should migrate any FRS\-based SYSVOLs to use Distributed File System Replication.  
  
-   The Windows Server 2003 domain functional level is deprecated. When you create a new domain on a server that runs Windows Server 2012 R2, the domain functional level must be Windows Server 2008 or newer. For more details about supported domain functional levels in Windows Server 2012 R2, see [Understanding Active Directory Domain Services \(AD DS\) Functional Levels](http://technet.microsoft.com/library/understanding-active-directory-functional-levels(v=ws.10).aspx)and [Upgrade Domain Controllers to Windows Server 2012 R2 and Windows Server 2012](http://technet.microsoft.com/library/hh994618.aspx).  
  
### Application Server  
The Application Server role is deprecated and will eventually no longer be available as an installable server role. Instead, install individual features and roles separately.  
  
### COM and Inetinfo interfaces of the Web Server role  
  
-   The IIS CertObj COM interface is deprecated. Use alternate methods for managing certificates.  
  
-   The Inetinfo interface is deprecated.  
  
### DNS  
The GAA\_FLAG\_INCLUDE\_TUNNEL\_BINDINGORDER flag in GetAdaptersAddresses is deprecated. There is no specific replacement.  
  
### File and storage services  
  
-   The SIS Limited API set is deprecated. Once it is removed, backups of SIS\-enabled volumes on servers running Windows Server 2008 R2 or earlier operating systems will not be able to be restored to newer servers. If you use this API, you should limit the target operating system to older versions that still support the API.  
  
-   Dfscmd.exe is deprecated. Instead, use Windows PowerShell cmdlets for Distributed File System Namespaces or the Dfsutil.exe command set.  
  
-   Support for the Network File System version 2 protocol is deprecated. This means that UNMP protocol support, version 2 of the MOUNT protocol, and versions 1, 2, and 3 of the NLM protocol are also deprecated. Migrate to using NFS version 3 or 4.1.  
  
-   Nfsshare.exe is deprecated. Instead, use Windows PowerShell cmdlets in scripts for share provisioning.  
  
-   The Local Mount driver, related cmdlets \(Mount\-IscsiVirtualDiskSnapshot, Dismount\-IscsiVirtualDiskSnapshot\) and WMI methods \(see “WMI” section of this document\), as well as conversion of VHD files from prior to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] using Convert\-IscsiVirtualDisk are deprecated. Change any scripts that use these cmdlets or WMI methods to use the Export\-IscsiVirtualDiskSnapshot cmdlet. Then assign it to an iSCSI target and use it like any other iSCSI virtual disk. Alternately, you can access virtual disks using a local loopback iSCSI initiator.  
  
### IIS Manager 6.0  
Internet Information Services \(IIS\) Manager 6.0 is deprecated. It has been replaced by a newer management console.  
  
### Networking  
Network Access Protection \(NAP\) is deprecated. Other options for keeping client computers up to date and secure for remote access include DirectAccess, Windows Web Application Proxy, and various non\-Microsoft solutions.  
  
### Network Information Service \(NIS\) and Tools \(in RSAT\)  
The Server for Network Information Service \(NIS\) is deprecated. This includes the associated administration tools in Remote Server Administration Tools \(RSAT\). Use native LDAP, Samba Client, Kerberos, or non\-Microsoft options.  
  
### RSAT: Identity management for Unix\/NIS  
The Server for Network Information Service \(NIS\) Tools option of Remote Server Administration Tools \(RSAT\) is deprecated. Use native LDAP, Samba Client, Kerberos, or non\-Microsoft options.  
  
### Security Configuration Wizard  
The Security Configuration Wizard is deprecated. Instead, features are secured by default. If you need to control specific security settings, you can use either Group Policy or [Microsoft Security Compliance Manager](http://technet.microsoft.com/library/cc677002.aspx).  
  
### SMB  
SMB 1.0 is deprecated. Once this is removed, systems running Windows XP or Windows Server 2003 \(or older\) operating systems will not be able to access file shares. SMB 1.0 has been replaced by SMB 2.0 and newer versions.  
  
### Telnet server  
Telnet server is deprecated. Instead, use Remote Desktop.  
  
### Windows Identity Foundation  
Windows Identity Foundation \(WIF\) 3.5 is deprecated and has been replaced by WIF 4.5. You should start migrating applications that use WIF to WIF 4.5 or Windows .NET Framework 4.5.  
  
### SQL Lite  
SQL Lite is deprecated. Migrate to alternatives such as SQL LocalDb.  
  
### WMI providers and methods  
  
-   The WMI version 1 provider for MSCluster is deprecated; it is being replaced by a WMI version 2 provider.  
  
-   The WMI methods related to the file server Local Mount driver and related cmdlets \(WT\_Snapshot.DVMount, WT\_SnapShot.DVDismount, WT\_Disk.GetDVMountPoints, and the WT\_DVMountedPath class\) are deprecated. See the “File and storage services” section of this document for more information.  
  
## Copyright  
This document is provided “as\-is”. Information and views expressed in this document, including URL and other Internet Web site references, may change without notice.  
  
This document does not provide you with any legal rights to any intellectual property in any Microsoft product. You may copy and use this document for your internal, reference purposes.  
  
©2013 Microsoft Corporation. All rights reserved.  
  
Microsoft, Active Directory, Hyper\-V, MS\-DOS, Windows, Windows NT, Windows Server, and Windows Vista are either registered trademarks or trademarks of Microsoft Corporation in the United States and\/or other countries.  
  
This product contains graphics filter software; this software is based in part on the work of the Independent JPEG Group.  
  
All other trademarks are property of their respective owners.  
  
5.0  
  
