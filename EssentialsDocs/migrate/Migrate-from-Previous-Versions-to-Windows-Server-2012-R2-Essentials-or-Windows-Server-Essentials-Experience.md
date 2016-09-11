---
title: "Migrate from Previous Versions to Windows Server 2012 R2 Essentials or Windows Server Essentials Experience"
ms.custom: na
ms.date: 01/21/2014
ms.prod: windows-server-2012-r2-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
applies_to: 
  - Windows Server 2012 Essentials
  - Windows Server 2012 R2 Essentials
ms.assetid: 2974fb3a-5150-43fd-a73f-3e5074eb5d03
caps.latest.revision: 14
author: DonGill
manager: stevenka

---
# Migrate from Previous Versions to Windows Server 2012 R2 Essentials or Windows Server Essentials Experience
This guide describes how to migrate from previous versions of Windows Small Business Server and Windows Server Essentials (including  Windows Server 2012 Essentials, Windows Small Business Server 2011 Standard, Windows Small Business Server 2011 Essentials, Windows Small Business Server 2008, and Windows Small Business Server 2003) to  Windows Server 2012 R2 Essentials or to  Windows Server 2012 R2 with the  Windows Server Essentials Experience role installed.  
  
 **For environments with up to 25 users and 50 devices**, you can follow the steps in this guide to migrate from previous versions of Windows SBS to  Windows Server 2012 R2 Essentials.  
  
 **For environments with up to 100 users and 200 devices**, you can follow the same guidance to migrate to the Standard or Datacenter editions of  Windows Server 2012 R2 with the  Windows Server Essentials Experience role installed.  
  
> [!NOTE]
>  To avoid issues during migration, the Windows Server Essentials product development team strongly recommends that you read this document before you begin the migration.  
  
## Terms and definitions  
 **Source Server** The existing server from which you are migrating your settings and data.  
  
 **Destination Server** The new server to which you are migrating your settings and data.  
  
## Migration process summary  
 This migration guide includes the following steps:  
  
1.  [Step 1: Prepare your Source Server for Windows Server 2012 R2 Essentials migration](../Topic/Step%201:%20Prepare%20your%20Source%20Server%20for%20Windows%20Server%202012%20R2%20Essentials%20migration.md).  You must ensure that your Source Server and network are ready for migration. This section guides you through backing up the Source Server, evaluating the Source Server system health, installing the most recent service packs and fixes, and verifying the network configuration.  
  
2.  [Step 2: Install Windows Server 2012 R2 Essentials as a new replica domain controller](../Topic/Step%202:%20Install%20Windows%20Server%202012%20R2%20Essentials%20as%20a%20new%20replica%20domain%20controller.md). This section describes how to install  Windows Server 2012 R2 Essentials, or  Windows Server 2012 R2 Standard (with the Windows Server Essentials Experience role enabled) as a domain controller.  
  
3.  [Step 3: Join computers to the new Windows Server 2012 R2 Essentials server](../Topic/Step%203:%20Join%20computers%20to%20the%20new%20Windows%20Server%202012%20R2%20Essentials%20server.md).  This section explains how to join client computers to the new server running  Windows Server 2012 R2 Essentials and updating Group Policy settings.  
  
4.  [Step 4: Move settings and data to the Destination Server for Windows Server 2012 R2 Essentials migration](../Topic/Step%204:%20Move%20settings%20and%20data%20to%20the%20Destination%20Server%20for%20Windows%20Server%202012%20R2%20Essentials%20migration.md).  This section provides information about migrating data and settings from the Source Server.  
  
5.  [Step 5: Enable folder redirection on the Destination Server for Windows Server 2012 R2 Essentials migration](../Topic/Step%205:%20Enable%20folder%20redirection%20on%20the%20Destination%20Server%20for%20Windows%20Server%202012%20R2%20Essentials%20migration.md).  If folder redirection is enabled on the Source Server, you can enable folder redirection on the Destination Server, and then delete the old Folder Redirection Group Policy setting.  
  
6.  [Step 6: Demote and remove the Source Server from the new Windows Server 2012 R2 Essentials network](../Topic/Step%206:%20Demote%20and%20remove%20the%20Source%20Server%20from%20the%20new%20Windows%20Server%202012%20R2%20Essentials%20network.md).  Prior to removing the Source Server from the network, you must force a Group Policy update and demote the Source Server.  
  
7.  [Step 7: Perform post-migration tasks for the Windows Server 2012 R2 Essentials migration](../Topic/Step%207:%20Perform%20post-migration%20tasks%20for%20the%20Windows%20Server%202012%20R2%20Essentials%20migration.md).  After you finish migrating all settings and data to  Windows Server 2012 R2 Essentials, you may want to map permitted computers to user accounts.  
  
8.  [Step 8: Run the Windows Server 2012 R2 Essentials Best Practices Analyzer](../Topic/Step%208:%20Run%20the%20Windows%20Server%202012%20R2%20Essentials%20Best%20Practices%20Analyzer.md).  After you finish migrating settings and data to  Windows Server 2012 R2 Essentials, you should run the  Windows Server 2012 R2 Essentials Best Practices Analyzer (BPA).  
  
 Several of the migration procedures require that you open a Command Prompt window as an administrator. The following procedures explain how to do this.  
  
###  <a name="BKMK_OpenACommandPromptAsAdmin"></a> To open a Command Prompt window on the Source Server as an administrator  
  
1.  Click **Start**.  
  
2.  In the search box, type **cmd**.  
  
3.  In the list of results, right-click **cmd**, and then click **Run as administrator**.  
  
#### To open a Command Prompt window on the Destination Server as an administrator  
  
1.  On the **Start** screen, in the search box, type **cmd**.  
  
2.  In the list of results, right-click **cmd**, and then click **Run as administrator**.  
  
## See also  
  
<<<<<<< HEAD
-   [Migrate Server Data to Windows Server Essentials](Migrate-Server-Data-to-Windows-Server-Essentials.md)
=======
-   [Migrate Server Data to Windows Server Essentials](../migrate/Migrate-Server-Data-to-Windows-Server-Essentials.md)
>>>>>>> 4bac1739fd0378146de6c9af26f683b8076754b8
