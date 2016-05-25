---
title: Windows Server Update Services 3.0 SP2 ReadMe
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0084fa5d-1a2d-444c-877f-148cf70d78a4
author: britw
---
# Windows Server Update Services 3.0 SP2 ReadMe
This ReadMe file for Windows® Server Update Services 3.0 Service Pack 2 \(WSUS 3.0 SP2\) release contains the following sections:  
  
-   What’s New in This Release  
  
-   System Requirements for the WSUS 3.0 SP2 Server Installation  
  
-   Installing WSUS 3.0 SP2  
  
## What’s New In This Release  
  
### New Windows Server and Client Version Support  
  
-   Integration with Windows Server® 2008 R2  
  
-   Support for the BranchCache feature on Windows Server 2008 R2  
  
-   Support for Windows 7 clients  
  
### WSUS Feature Improvements  
  
#### Auto\-Approval Rules  
  
-   New functionality lets you specify the approval deadline date and time for all computers or specific computer groups.  
  
#### Update Files and Languages  
  
-   This release provides improved handling of language selection on downstream servers. A new warning dialog appears when you download updates only for specified languages.  
  
#### Easy Upgrade  
  
-   WSUS 3.0 SP2 can be installed as an in\-place upgrade from earlier versions of WSUS and will preserve all of your settings and approvals. The user interface is compatible between WSUS 3.0 SP1 and SP2 on the client and the server.  
  
#### Reports  
  
-   New Update and Computer Status reports enable filtering on updates approved for installation. You can run these reports from the WSUS console or use the API to incorporate this functionality into your own reports.  
  
### Software Updates  
  
## System Requirements for the WSUS 3.0 SP2 Installation  
This section describes the software and hardware requirements for installation of WSUS 3.0 SP2.  
  
### WSUS Server Software Prerequisites  
  
-   One of the following supported operating systems:  
  
    -   Windows Server 2008 R2  
  
    -   Windows Server 2008 SP1 or later versions  
  
    -   Windows Server 2003 SP1 or later versions  
  
    -   Windows Small Business Server 2008  
  
    -   Windows Small Business Server 2003  
  
    -   In addition, the WSUS Administration console can be installed on Windows XP SP3 and later versions, including Vista and Windows 7  
  
    -   Note that additional prerequisites apply for Windows Small Business Server. See the WSUS 3.0 SP2 Release Notes at [http:\/\/go.microsoft.com\/fwlink\/?LinkId\=139840](http://go.microsoft.com/fwlink/?LinkId=139840)for details.  
  
-   IIS 6.0 or later versions  
  
-   Microsoft® .NET Framework 2.0 or later versions  
  
-   One of the following supported databases:  
  
    -   Microsoft [!INCLUDE[sql2000](../Token/sql2000_md.md)] Standard or Enterprise Edition  
  
    -   [!INCLUDE[1st_ssVersion2005](../Token/1st_ssVersion2005_md.md)] SP3 or later versions  
  
    -   Windows Internal Database  
  
    If one of the supported versions of SQL Server is not installed, the WSUS 3.0 SP2 Setup Wizard will install Windows Internal Database.  
  
-   Microsoft Management Console 3.0  
  
-   Microsoft Report Viewer Redistributable 2008  
  
> [!IMPORTANT]  
> Windows Server 2008 R2 Requires WSUS 3.0 SP2. If you install Windows Server 2008 R2 then you should install WSUS 3.0 SP2. Do not install WSUS 3.0 SP1 on Windows Server 2008 R2.  
>   
> Installation of WSUS 3.0 SP2 is not supported on servers running remote SQL Server where Terminal Services is installed on the front end server.  
  
### WSUS Server Minimum Hardware Requirements  
The following list contains the minimum hardware requirements for a basic server installation. Refer to the WSUS 3.0 SP2 Deployment Guide at [http:\/\/go.microsoft.com\/fwlink\/?LinkId\=139832](http://go.microsoft.com/fwlink/?LinkId=139832) for a comprehensive list of supported hardware configurations.  
  
-   Both the system partition and the partition on which you install WSUS 3.0 SP2 must be formatted with the NTFS file system.  
  
-   Minimum 1 GB of free space on the system partition  
  
-   Minimum 2 GB of free space on the volume on which database files will be stored  
  
-   Minimum 20 GB of free space is required on the volume on which content is stored, 30 GB is recommended  
  
> [!IMPORTANT]  
> WSUS 3.0 SP2 cannot be installed on compressed drives.  
  
## System Requirements for the WSUS Client Installation  
Automatic Updates, the WSUS client software, can be installed on any of the following operating systems:  
  
-   Windows Server 2008 R2, Windows Server 2008 SP1 or later versions, Windows Server 2003 SP2 or later versions, Windows Small Business Server 2003, 2005, or 2008, Windows Vista, Windows XP Professional RTM, SP1, SP2, SP3, or later versions, or Windows 7 client.  
  
## Installing WSUS 3.0 SP2  
The WSUS Step by Step Installation Guide at [http:\/\/go.microsoft.com\/fwlink\/?LinkId\=139836](http://go.microsoft.com/fwlink/?LinkId=139836) provides instructions for installing WSUS 3.0 SP2 by using either Windows Server Manager or the WUSSetup.exe file.  
  
For complete information about how to install and use WSUS, see:  
  
The WSUS Deployment Guide at [http:\/\/go.microsoft.com\/fwlink\/?LinkId\=139832](http://go.microsoft.com/fwlink/?LinkId=139832).  
  
The WSUS Operations Guide at [http:\/\/go.microsoft.com\/fwlink\/?LinkId\=139838](http://go.microsoft.com/fwlink/?LinkId=139838).  
  
The WSUS 3.0 SP2 Release Notes at [http:\/\/go.microsoft.com\/fwlink\/?LinkId\=139840](http://go.microsoft.com/fwlink/?LinkId=139840).  
  
## Copyright Notice  
Information in this document, including URL and other Internet Web site references, is subject to change without notice. Unless otherwise noted, the companies, organizations, products, domain names, e\-mail addresses, logos, people, places, and events depicted in examples herein are fictitious. No association with any real company, organization, product, domain name, e\-mail address, logo, person, place, or event is intended or should be inferred. Complying with all applicable copyright laws is the responsibility of the user. Without limiting the rights under copyright, no part of this document may be reproduced, stored in or introduced into a retrieval system, or transmitted in any form or by any means \(electronic, mechanical, photocopying, recording, or otherwise\), or for any purpose, without the express written permission of Microsoft Corporation.  
  
Microsoft may have patents, patent applications, trademarks, copyrights, or other intellectual property rights covering subject matter in this document. Except as expressly provided in any written license agreement from Microsoft, the furnishing of this document does not give you any license to these patents, trademarks, copyrights, or other intellectual property.  
  
© 2009 Microsoft Corporation. All rights reserved.  
  
Microsoft, Active Directory, ActiveX, Authenticode, Excel, InfoPath, Internet Explorer, MSDN, Outlook, Visual Studio, Win32, Windows, Windows Server, and Windows Vista are trademarks of the Microsoft group of companies.  
  
All other trademarks are property of their respective owners.  
  
