---
title: Windows Server 2012 R2 Update
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - server-general
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 002201f4-a6db-49da-95b0-6f868e1a559f
author: jaimeo
---
# Windows Server 2012 R2 Update
This topic summarizes the features included in the Windows Server 2012 R2 Update. Related updates have also been released for Windows 8.1 and Windows 8.1 RT. For more details about the updates for Windows 8.1 and Windows 8.1 RT, see [What's new in Windows 8.1 Update and Windows RT 8.1 Update](http://go.microsoft.com/fwlink/p/?LinkId=395010).  
  
## Obtaining the update  
If you are running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], this update will appear as a required update in Windows Update as KB2919355. You can also obtain a version of [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] that has the update already included from the [Microsoft Download Center](http://download.microsoft.com) \(search that location for KB2919355\).  
  
Release notes, system requirements, deprecated features, and related release documentation for Windows Server 2012 R2 also apply to Windows Server 2012 R2 Update. See [Install and Deploy Windows Server 2012 R2 and Windows Server 2012](http://technet.microsoft.com/library/hh831620.aspx) for those topics.  
  
> [!NOTE]  
> To confirm the exact version of [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] that is installed on a computer, run Msinfo32.exe. If Windows Server 2012 R2 Update is installed, the value reported for **Hardware Abstraction Layer** will be **6.3.9600.17031**.  
  
## Changes included in the update  
After the update is installed, the following features are present:  
  
-   Internet Explorer 11 now includes an “Enterprise Mode.” This mode is available if you disable Enhanced Security Configuration and provides better compatibility for sites designed for Internet Explorer 8, along with tools to manage which web apps use it. You can specify a list of web apps to render dynamically in Enterprise Mode, avoiding compatibility problems with web apps written for older versions of Internet Explorer. For more information, see the [Internet Explorer 11 FAQ for IT Pros](http://technet.microsoft.com/library/dn268945.aspx) or [TechNet documentation](http://technet.microsoft.com/library/dn640687.aspx).  
  
-   The user interface includes buttons for **Search** and **Power** on the Start page. If you install the Desktop Experience feature, other changes introduced with Windows 8.1 Update will also be visible. For details, see [What's new in Windows 8.1 Update and Windows RT 8.1 Update](http://go.microsoft.com/fwlink/p/?LinkId=395010). The specific Windows 8.1 features installed when you install Desktop Experience have not changed from those in Windows Server 2012 R2 \(see [Desktop Experience Overview](http://technet.microsoft.com/library/dn609826.aspx)\).  
  
-   Active Directory Federation Services \(AD FS\) has added the capability for an administrator to enable signing in with an alternate login ID that is an attribute of the user object in Active Directory Domain Services \(AD DS\). This enables customers to adopt Azure Active Directory without modifying on\-premises User Principal Names \(UPNs\). It also allows users to log in to Office 365 services by using an email address instead of a UPN. This change does not affect the Active Directory schema. For more information, see [Configuring Alternate Login ID](http://go.microsoft.com/fwlink/?LinkID=394192).  
  
-   The update includes all other updates released since Windows Server 2012 R2 was released.  
  
## See also  
[What's new in Windows 8.1 Update and Windows RT 8.1 Update](http://go.microsoft.com/fwlink/p/?LinkId=395010)  
  
[Install and Deploy Windows Server 2012 R2 and Windows Server 2012](http://technet.microsoft.com/library/hh831620.aspx)  
  
[Desktop Experience Overview](http://technet.microsoft.com/library/dn609826.aspx)  
  
