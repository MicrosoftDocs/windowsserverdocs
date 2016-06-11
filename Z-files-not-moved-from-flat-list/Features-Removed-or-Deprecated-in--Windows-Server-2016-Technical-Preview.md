---
title: Features Removed or Deprecated in  Windows Server 2016 Technical Preview
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - server-general
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5d10c5f9-ebac-49a0-b808-c0b1702e0437
author: jaimeo
---
# Features Removed or Deprecated in  Windows Server 2016 Technical Preview
The following is a list of features and functionalities in [!INCLUDE[winthreshold_server_1](includes/winthreshold_server_1_md.md)] that have either been removed from the product in the current release or are planned for potential removal in subsequent releases \(“deprecated”\). It is intended for IT professionals who are updating operating systems in a commercial environment. This list is subject to change in subsequent releases and may not include every deprecated feature or functionality. For more details about a particular feature or functionality and its replacement, see the documentation for that feature.  
  
## Features removed from Windows Server Technical Preview  
The following features and functionalities have been removed from this release of [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)]. Applications, code, or usage that depend on these features will not function in this release unless you employ an alternate method.  
  
> [!NOTE]  
> If you are moving to [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)] from a server release prior to [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], you should also review [Features Removed or Deprecated in Windows Server 2012 R2](https://technet.microsoft.com/library/dn303411.aspx)and [Features Removed or Deprecated in Windows Server 2012](https://technet.microsoft.com/library/hh831568.aspx).  
  
  
### File server  
The Share and Storage Management snap\-in for Microsoft Management Console has been removed. Instead, do any of the following:  
  
-   If the computer you want to manage is running an operating system older than Windows Server Technical Preview, connect to it with Remote Desktop and use the local version of the Share and Storage Management snap\-in.  
  
-   On a computer running Windows 8.1 or earlier, use the Share and Storage Management snap\-in from RSAT to view the computer you want to manage.  
  
-   Use Hyper\-V on a client computer to run a virtual machine running Windows 7, Windows 8, or Windows 8.1 that has the Share and Storage Management snap\-in in RSAT.  
  
### Journal.dll  
The Journal.dll is removed from Windows Server Technical Preview. There is no replacement.  
  
### Security Configuration Wizard  
The Security Configuration Wizard is removed. Instead, features are secured by default. If you need to control specific security settings, you can use either Group Policy or [Microsoft Security Compliance Manager](http://technet.microsoft.com/library/cc677002.aspx).  
  
### SQM  
The opt\-in components that manage participation in the Customer Experience Improvement Program have been removed.  
  
## Features deprecated starting with Windows Server Technical Preview  
The following features and functionalities are deprecated starting with this release. Eventually, they will be completely removed from the product, but they are still available in this release, sometimes with certain functionality removed. You should begin planning now to employ alternate methods for any applications, code, or usage that depend on these features.  
  
### Configuration tools  
  
-   Scregedit.exe is deprecated. If you have scripts that depend on Scregedit.exe, adjust them to use Reg.exe or Windows PowerShell methods.  
  
-   Sconfig.exe is deprecated. Use Windows PowerShell instead.  
  
### NetCfg custom APIs  
Installation of PrintProvider, NetClient, and ISDN using NetCfg custom APIs is deprecated.  
  
### Remote management  
WinRM.vbs is deprecated. Instead, use functionality in the WinRM provider of Windows PowerShell.  
  
### SMB  
SMB 2\+ over NetBT is deprecated. Instead, implement SMB over TCP or RDMA.  
  
1.0  
  

