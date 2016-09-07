---
title: "Migrate Windows Server 2008 Foundation to Windows Server 2012 Essentials"
ms.custom: na
ms.date: 11/20/2012
ms.prod: windows-server-2012-r2-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
applies_to: 
  - Windows Server 2012 Essentials
  - Windows Server 2012 R2 Essentials
ms.assetid: f22fc0a4-cb82-4e60-afe6-2d03145745e7
caps.latest.revision: 6
author: DonGill
manager: stevenka
translation.priority.ht: 
  - de-at
  - de-de
  - es-es
  - fr-be
  - fr-fr
  - it-ch
  - it-it
  - ja-jp
  - ko-kr
  - pt-br
  - ru-ru
  - zh-cn
  - zh-tw
---
# Migrate Windows Server 2008 Foundation to Windows Server 2012 Essentials
This guide describes how to migrate an existing Windows Server 2008 Foundation domain to [!INCLUDE[sbs_sbs8web_1](../install/includes/sbs_sbs8web_1_md.md)] on new hardware, and then to migrate the settings and data. This guide also describes how to remove your existing server from the [!INCLUDE[sbs_sbs8web_2](../install/includes/sbs_sbs8web_2_md.md)] network after you finish the migration.  
  
> [!NOTE]
>  To avoid problems during migration, the [!INCLUDE[sbs_sbs8web_2](../install/includes/sbs_sbs8web_2_md.md)] product development team strongly recommends that you read this document before you begin the migration.  
  
## Additional resources  
 For links to additional information, tools, and community resources to help guide you through the migration process, see [Windows Small Business Server Migration](http://go.microsoft.com/fwlink/?LinkId=217520).  
  
## Terms and definitions  
 **Source Server:** The existing server from which you are migrating your settings and data.  
  
 **Destination Server:** The new server to which you are migrating your settings and data.  
  
## Migration process summary  
 This Migration Guide includes the following steps:  
  
1.  [Prepare your Source Server for Windows Server 2012 Essentials migration](../migrate/Prepare-your-Source-Server-for-Windows-Server-2012-Essentials-migration2.md).  You must ensure that your Source Server and network are ready for migration. This section guides you through backing up the Source Server, evaluating the Source Server system health, installing the most recent service packs and fixes, and verifying the network configuration.  
  
2.  [Install Windows Server 2012 Essentials in migration mode](../migrate/Install-Windows-Server-2012-Essentials-in-migration-mode5.md).  This section describes the steps you should take to install [!INCLUDE[sbs_sbs8web_2](../install/includes/sbs_sbs8web_2_md.md)] on the Destination Server in migration mode.  
  
3.  [Join computers to the new Windows Server 2012 Essentials network](../migrate/Join-computers-to-the-new-Windows-Server-2012-Essentials-network3.md).  This section covers joining client computers to the new [!INCLUDE[sbs_sbs8web_2](../install/includes/sbs_sbs8web_2_md.md)] network and updating Group Policy settings.  
  
4.  [Move Windows Server 2008 Foundation settings and data to the Destination Server](../migrate/Move-Windows-Server-2008-Foundation-settings-and-data-to-the-Destination-Server-for-Windows-Server-2012-Essentials-migration.md).  This section provides information about migrating data and settings from the Source Server.  
  
5.  [Demote and remove the Source Server from the new Windows Server 2012 Essentials network](../migrate/Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-2012-Essentials-network6.md).  Prior to removing the Source Server from the network, you must force a Group Policy update and demote the Source Server.  
  
6.  [Perform post-migration tasks for Windows Server 2012 Essentials migration](../migrate/Perform-post-migration-tasks-for-Windows-Server-2012-Essentials-migration2.md).  After you finish migrating all settings and data to [!INCLUDE[sbs_sbs8web_2](../install/includes/sbs_sbs8web_2_md.md)], you may want to map permitted computers to user accounts.  
  
7.  [Run the Windows Server 2012 Essentials Best Practices Analyzer](../migrate/Run-the-Windows-Server-2012-Essentials-Best-Practices-Analyzer5.md).  After you finish migrating settings and data to [!INCLUDE[sbs_sbs8web_2](../install/includes/sbs_sbs8web_2_md.md)], you should run the [!INCLUDE[sbs_sbs8web_2](../install/includes/sbs_sbs8web_2_md.md)] BPA.  
  
 Several of the migration procedures require that you open a command prompt window as an administrator.  
  
###  <a name="BKMK_OpenACommandPromptAsAdmin"></a> To open a command prompt window on the Source Server as an administrator  
  
1.  Click **Start**.  
  
2.  In the search box, type **cmd**.  
  
3.  In the list of results, right-click **cmd**, and then click **Run as administrator**.  
  
#### To open a command prompt window on the Destination Server as an administrator  
  
1.  On the **Start** screen, in the search box, type **cmd**.  
  
2.  In the list of results, right-click **cmd**, and then click **Run as administrator**.