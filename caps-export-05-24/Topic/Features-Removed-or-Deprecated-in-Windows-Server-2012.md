---
title: Features Removed or Deprecated in Windows Server 2012
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - server-general
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 69cf141e-765f-4b56-b74f-56dd0458d6ca
author: jaimeo
---
# Features Removed or Deprecated in Windows Server 2012
The following is a list of features and functionalities in [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] that have either been removed from the product in the current release or are planned for potential removal in subsequent releases. It is intended for IT professionals who are updating operating systems in a commercial environment. This list is subject to change in subsequent releases and may not include every deprecated feature or functionality.  
  
## Features removed from Windows Server 2012  
The following features and functionalities have been removed from this release of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. Applications, code, or usage that depend on these features will not function in this release unless you employ an alternate method.  
  
### Active Directory Federation Services  
  
-   Support for applications that use the “NT Token mode” configuration of the web agent is removed. Applications are expected to move to Windows Identity Foundation and use the “Claims to Windows Token Service” to convert a UPN from a SAML token to a Windows token for consumption in the application.  
  
-   Support for “Resource Group” is removed. \(Resource groups are explained at [http:\/\/technet.microsoft.com\/library\/cc753670\(WS.10\).aspx](http://technet.microsoft.com/library/cc753670(WS.10).aspx)\)  
  
-   Support for using Active Directory Lightweight Directory Services \(AD LDS\) as an authentication store is removed  
  
-   You are required to migrate to the AD FS version in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. In\-place upgrade from AD FS 1.0 or “out of box” AD FS 2.0 is not supported.  
  
### Server Core components  
Oclist.exe has been removed. Instead, use Dism.exe. For documentation on using Dism.exe, see [http:\/\/technet.microsoft.com\/library\/dd772580\(WS.10\).aspx](http://technet.microsoft.com/library/dd772580(WS.10).aspx).  
  
### Clustering  
  
-   The Cluster Automation Server \(MSClus\) COM application programming interface \(API\) has been made an optional component called FailoverCluster\-AutomationServer which is not installed by default. Cluster programmatic functionality is now provided by the Failover Cluster API and the Failover Cluster WMI provider.  
  
-   The Cluster.exe command\-line interface has been made an optional component called FailoverCluster\-CmdInterface which is not installed by default. Cluster command\-line functionality is provided by the Failover Cluster PowerShell cmdlets.  
  
-   Support for 32\-bit cluster resource DLLs has been deprecated. Use 64\-bit versions instead.  
  
### Graphics  
  
-   Support for hardwire drivers for XDDM has been removed. As a result, XDDM graphics drivers will not load in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. Instead, you can do any of the following:  
  
    -   Use the WDDM “basic display\-only driver” included in the operating system.  
  
    -   Use a WDDM “display\-only driver” provided by a hardware vendor.  
  
    -   Use a full WDDM driver provided by a hardware vendor.  
  
-   Support for native VGA via the PC\/AT BIOS is removed. The WDDM “basic display\-only driver” included in the operating system will replace this functionality. In UEFI systems, you may see fewer high\-resolution \(VESA\) modes, but there is no other impact.  
  
### Hyper\-V  
  
-   VM Chimney \(also called TCP Offload\) has been removed. The TCP chimney will not be available to guest operating systems.  
  
-   Support for Static VMQ has been removed. Drivers using NDIS 6.3 will automatically access Dynamic VMQ capabilities that are new in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
### Networking  
  
-   NetDMA has been removed.  
  
-   Support for Token Rings has been removed.  
  
### Server roles  
The Role Collector \(Ceiprole.exe\) and the associated API \(Ceiprole.dll\) have been removed. To collect telemetry data on server roles, use Server Manager.  
  
### Server Message Block  
SMB.sys has been removed. The operating system now uses the Winsock Kernel \(WSK\) to provide the same functionality.  
  
### SQL Server  
Versions of Microsoft SQL Server prior to 7.0 are no longer supported. Computers running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] that connect to computers running SQL Server 6.5 \(or earlier\) will receive an error message.  
  
### Storage  
  
-   The Storage Manager for SANs snap\-in for MMC has been removed. Instead, manage storage with PowerShell cmdlets and Server Manager.  
  
-   The Storage Explorer snap\-in for MMC has been removed.  
  
-   The SCSIport host\-bus adapter driver has been removed. Instead, either use a Storport driver or a different host\-bus adapter.  
  
### Visual Studio  
Support for Visual Studio Analyzer 2003 over ODBC, OLEDB, and ADO has been removed.  
  
### Windows Help  
The Windows Help program \(specifically, WinHlp32.exe, the executable file that opens \*.hlp help files\) has been removed from Windows since Windows Server 2008. Previously, downloadable packages that provide this functionality were made available \(see [http:\/\/support.microsoft.com\/kb\/917607](http://support.microsoft.com/kb/917607)\). Starting with this release, no download will be provided to enable you to view \*.hlp files on [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. For this milestone release, Windows Help is also currently unsupported in [!INCLUDE[win8_client_1](../Token/win8_client_1_md.md)].  
  
## Features deprecated starting with Windows Server 2012  
The following features and functionalities are deprecated starting with this release. Eventually, they will be completely removed from the product, but they are still available in this release, sometimes with certain functionality removed. You should begin planning now to employ alternate methods for any applications, code, or usage that depend on these features.  
  
### Active Directory  
Dcpromo.exe has been deprecated. In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], if you run dcpromo.exe \(without any parameters\) from a command prompt, you receive a message directing you to Server Manager, where you can install Active Directory Domain Services using the Add Roles wizard. If you run **dcpromo \/unattend** from a command prompt, you can still perform unattended installations that use Dcpromo.exe. This allows organizations to continue to use automated Active Directory Domain Services \(AD DS\) installation routines based on dcpromo.exe until they can rewrite those routines using Windows PowerShell. For more information, see [http:\/\/technet.microsoft.com\/library\/hh472160.aspx](http://technet.microsoft.com/library/hh472160.aspx).  
  
### Database management systems  
  
-   ODBC support for 16\- and 32\-bit applications and drivers is deprecated. Use 64\-bit versions instead.  
  
-   ODBC\/OLEDB support for Microsoft Oracle is deprecated. Migrate to drivers and providers supplied by Oracle.  
  
-   Jet Red RDBMS and ODBC drivers are deprecated.  
  
### Networking  
The Network Driver Interface Specification \(NDIS\) version 5.0, 5.1, and 5.2 APIs are deprecated. New drivers for NDIS 6.0 must be written.  
  
### Hyper\-V  
  
-   The WMI root\\virtualization namespace is deprecated. The new namespace is root\\virtualization\\v2.  
  
-   Windows Authorization Manager \(AzMan\) is deprecated. You may need to use new management tools for virtual machines or redesign the authorization model.  
  
### Printing  
The line printer daemon protocol \(LPR\/LPD\) is deprecated. When this feature is eventually removed, clients that print to a server using this protocol, such as UNIX clients, will not be able to connect or print. Instead, UNIX clients should use IPP. Windows clients can connect to UNIX shared printers using the Windows Standard Port Monitor \(see [http:\/\/support.microsoft.com\/kb\/246868](http://support.microsoft.com/kb/246868)for more information\).  
  
### Remote Data Service  
The Remote Data service is deprecated. Migrate to the Windows Web Services API.  
  
### SMTP  
SMTP and the associated management tools are deprecated. Though the functionality is still available in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], you should begin using System.Net.Smtp. With this API, you will not be able to insert a message into a file for pickup; instead configure Web applications to connect on port 25 to another server using SMTP.  
  
### Subsystem for UNIX\-based Applications  
The Subsystem for UNIX\-based Applications \(SUA\) is deprecated. If you use the SUA POSIX subsystem with this release, use Hyper\-V to virtualize the server. If you use the tools provided by SUA, switch to Cygwin's POSIX emulation, or use either mingw\-w64 \(available from Sourceforge.net\) or MinGW \(available from MinGW.org\) for doing a native port.  
  
### Transport protocols  
  
-   The Transport Driver Interface \(TDI\) is deprecated. Use Windows Filtering Platform instead.  
  
-   Layered Service Providers \(LSP\) are deprecated. Use Windows Filtering Platform instead.  
  
-   Winsock Direct is deprecated. Use Network Direct instead.  
  
### SNMP  
SNMP is deprecated. Instead, use the Common Information Model \(CIM\), which is supported by the WS\-Management web services protocol and implemented as Windows Remote Management.  
  
### SQL Server  
  
-   ODBC\/OLEDB support for SQL is deprecated for versions beyond SQL Server 7 and SQL 2000. Migrate to SQL Native Client \(SNAC\) to use features provided by SQL Server 2005, SQL Server 2008, and later versions.  
  
-   SQLXMLX is deprecated. Migrate code to use SQLXML.  
  
### Windows System Resource Manager  
Windows System Resource Manager \(WSRM\) is deprecated. Similar functionality is provided by Hyper\-V.  
  
### WMI providers  
  
-   The WMI provider for Simple Network Management Protocol \(SNMP\) is deprecated because the SNMP service is being deprecated.  
  
-   The WMI provider for the Win32\_ServerFeature API is deprecated.  
  
-   The WMI provider for Active Directory is deprecated. Manage Active Directory with PowerShell cmdlets.  
  
-   The WMI command\-line tool \(Wmic\) is deprecated. Use PowerShell cmdlets instead.  
  
-   The namespace for version 1.0 of WMI is deprecated. Prepare to adapt scripts for a revised namespace.  
  
### XML  
  
-   XML\-Data Reduced \(XDR\) schema elements are deprecated. Migrate Web applications that use this schema to the W3C Standards\-compliant XML schema.  
  
-   The XSL pattern feature of MSXML3 is deprecated. Migrate Web applications that use this feature to the W3C Standards\-compliant XML Path Language \(XPath\) feature set.  
  
## Copyright  
This document is provided “as\-is”. Information and views expressed in this document, including URL and other Internet Web site references, may change without notice.  
  
This document does not provide you with any legal rights to any intellectual property in any Microsoft product. You may copy and use this document for your internal, reference purposes.  
  
©2012 Microsoft Corporation. All rights reserved.  
  
Microsoft, Active Directory, Hyper\-V, MS\-DOS, Windows, Windows NT, Windows Server, and Windows Vista are either registered trademarks or trademarks of Microsoft Corporation in the United States and\/or other countries.  
  
This product contains graphics filter software; this software is based in part on the work of the Independent JPEG Group.  
  
All other trademarks are property of their respective owners.  
  
4.1  
  
