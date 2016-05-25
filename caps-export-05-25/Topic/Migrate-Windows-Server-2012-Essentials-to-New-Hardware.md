---
title: Migrate Windows Server 2012 Essentials to New Hardware
ms.custom: na
ms.prod: windows-server-2012-r2-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f695ae90-3160-407b-bebf-9e460f22c86d
author: cfreemanwa
---
# Migrate Windows Server 2012 Essentials to New Hardware
This guide describes how to migrate an existing [!INCLUDE[sbs_sbs8web_1](../Token/sbs_sbs8web_1_md.md)] domain to [!INCLUDE[sbs_sbs8web_2](../Token/sbs_sbs8web_2_md.md)] on new hardware, and then to migrate the settings and data. This guide also describes how to remove your existing server from the [!INCLUDE[sbs_sbs8web_2](../Token/sbs_sbs8web_2_md.md)] network after you finish the migration.  
  
> [!NOTE]  
> To avoid problems during migration, the [!INCLUDE[sbs_sbs8web_2](../Token/sbs_sbs8web_2_md.md)] product development team strongly recommends that you read this document before you begin the migration.  
  
> [!NOTE]  
> To migrate your server data to the latest version of Windows Server Essentials, see [Migrate from Previous Versions to Windows Server 2012 R2 Essentials or Windows Server Essentials Experience](../Topic/Migrate-from-Previous-Versions-to-Windows-Server-2012-R2-Essentials-or-Windows-Server-Essentials-Experience.md).  
  
## Additional resources  
For links to additional information, tools, and community resources to help guide you through the migration process, visit the [Windows Small Business Server Migration](http://go.microsoft.com/fwlink/?LinkId=217520) website.  
  
## Terms and definitions  
**Source Server:** The existing server from which you are migrating your settings and data.  
  
**Destination Server:** The new server to which you are migrating your settings and data.  
  
## Migration process summary  
This Migration Guide includes the following steps:  
  
1.  [Prepare your Source Server for Windows Server 2012 Essentials migration_4](../Topic/Prepare-your-Source-Server-for-Windows-Server-2012-Essentials-migration_4.md).  You must ensure that your Source Server and network are ready for migration. This section guides you through backing up the Source Server, evaluating the Source Server system health, installing the most recent service packs and fixes, and verifying the network configuration.  
  
2.  [Install Windows Server 2012 Essentials in migration mode_4](../Topic/Install-Windows-Server-2012-Essentials-in-migration-mode_4.md).  This section describes the steps you should take to install [!INCLUDE[sbs_sbs8web_2](../Token/sbs_sbs8web_2_md.md)] on the Destination Server in migration mode.  
  
3.  [Join computers to the new Windows Server 2012 Essentials server_2](../Topic/Join-computers-to-the-new-Windows-Server-2012-Essentials-server_2.md).  This section covers joining client computers to the new [!INCLUDE[sbs_sbs8web_2](../Token/sbs_sbs8web_2_md.md)] server and updating Group Policy settings.  
  
4.  [Move settings and data to the Destination Server for Windows Server 2012 Essentials migration](../Topic/Move-settings-and-data-to-the-Destination-Server-for-Windows-Server-2012-Essentials-migration.md).  This section provides information about migrating data and settings from the Source Server.  
  
5.  [Configure folder redirection on the Windows Server 2012 Essentials Destination Server](../Topic/Configure-folder-redirection-on-the-Windows-Server-2012-Essentials-Destination-Server.md).  If folder redirection is enabled on the Source Server, you can enable folder redirection on the Destination Server, and then delete the old Folder Redirection Group Policy setting.  
  
6.  [Demote and remove the Source Server from the new Windows Server 2012 Essentials network_2](../Topic/Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-2012-Essentials-network_2.md).  Prior to removing the Source Server from the network, you must force a Group Policy update and demote the Source Server.  
  
7.  [Perform post-migration tasks for Windows Server 2012 Essentials migration_2](../Topic/Perform-post-migration-tasks-for-Windows-Server-2012-Essentials-migration_2.md).  After you finish migrating all settings and data to [!INCLUDE[sbs_sbs8web_2](../Token/sbs_sbs8web_2_md.md)], you may want to map permitted computers to user accounts.  
  
8.  [Run the Windows Server 2012 Essentials Best Practices Analyzer_5](../Topic/Run-the-Windows-Server-2012-Essentials-Best-Practices-Analyzer_5.md).  After you finish migrating settings and data to [!INCLUDE[sbs_sbs8web_2](../Token/sbs_sbs8web_2_md.md)], you should download and run the [!INCLUDE[sbs_sbs8web_2](../Token/sbs_sbs8web_2_md.md)] BPA.  
  
Several of the migration procedures require that you open a Command Prompt window as an administrator.  
  
#### To open a Command Prompt window as an administrator  
  
1.  On the **Start** screen, in the search box, type **cmd**.  
  
2.  In the list of results, right\-click **cmd**, and then click **Run as administrator**.  
  
