---
title: "Migrate Windows Server Essentials to New Hardware"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f695ae90-3160-407b-bebf-9e460f22c86d
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Migrate Windows Server Essentials to New Hardware

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

This guide describes how to migrate an existing  Windows Server® 2012 Essentials domain to  Windows Server Essentials on new hardware, and then to migrate the settings and data. This guide also describes how to remove your existing server from the  Windows Server Essentials network after you finish the migration.  
  
> [!NOTE]
>  To avoid problems during migration, the  Windows Server Essentials product development team strongly recommends that you read this document before you begin the migration.  
> 
> [!NOTE]
> 
>  To migrate your server data to the latest version of Windows Server Essentials, see [Migrate to Windows Server Essentials](Migrate-from-Previous-Versions-to-Windows-Server-Essentials-or-Windows-Server-Essentials-Experience.md).  

  
## Additional resources  
 For links to additional information, tools, and community resources to help guide you through the migration process, visit the [Windows Small Business Server Migration](https://go.microsoft.com/fwlink/?LinkId=217520) website.  
  
## Terms and definitions  
 **Source Server:** The existing server from which you are migrating your settings and data.  
  
 **Destination Server:** The new server to which you are migrating your settings and data.  
  
## Migration process summary  
 This Migration Guide includes the following steps:  
  

1. [Prepare your Source Server for Windows Server Essentials migration](Prepare-your-Source-Server-for-Windows-Server-Essentials-migration.md).  You must ensure that your Source Server and network are ready for migration. This section guides you through backing up the Source Server, evaluating the Source Server system health, installing the most recent service packs and fixes, and verifying the network configuration.  
  
2. [Install Windows Server Essentials in migration mode](Install-Windows-Server-Essentials-in-migration-mode.md).  This section describes the steps you should take to install  Windows Server Essentials on the Destination Server in migration mode.  
  
3. [Join computers to the new Windows Server Essentials server](Join-computers-to-the-new-Windows-Server-Essentials-server.md).  This section covers joining client computers to the new  Windows Server Essentials server and updating Group Policy settings.  
  
4. [Move settings and data to the Destination Server for Windows Server Essentials migration](Move-settings-and-data-to-the-Destination-Server-for-Windows-Server-Essentials-migration.md).  This section provides information about migrating data and settings from the Source Server.  
  
5. [Configure folder redirection on the Windows Server Essentials Destination Server](Configure-folder-redirection-on-the-Windows-Server-Essentials-Destination-Server.md).  If folder redirection is enabled on the Source Server, you can enable folder redirection on the Destination Server, and then delete the old Folder Redirection Group Policy setting.  
  
6. [Demote and remove the Source Server from the new Windows Server Essentials network](Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-Essentials-network.md).  Prior to removing the Source Server from the network, you must force a Group Policy update and demote the Source Server.  
  
7. [Perform post-migration tasks for Windows Server Essentials migration](Perform-post-migration-tasks-for-Windows-Server-Essentials-migration.md).  After you finish migrating all settings and data to  Windows Server Essentials, you may want to map permitted computers to user accounts.  
  
8. [Run the Windows Server Essentials Best Practices Analyzer](Run-the-Windows-Server-Essentials-Best-Practices-Analyzer.md).  After you finish migrating settings and data to  Windows Server Essentials, you should download and run the  Windows Server Essentials BPA.  
  
   Several of the migration procedures require that you open a Command Prompt window as an administrator.  
  
#### To open a Command Prompt window as an administrator  
  
1.  On the **Start** screen, in the search box, type **cmd**.  
  
2.  In the list of results, right-click **cmd**, and then click **Run as administrator**.
