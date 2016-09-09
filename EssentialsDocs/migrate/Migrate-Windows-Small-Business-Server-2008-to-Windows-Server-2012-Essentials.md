---
title: "Migrate Windows Small Business Server 2008 to Windows Server 2012 Essentials"
ms.custom: na
ms.date: 10/03/2012
ms.prod: windows-server-2012-r2-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
applies_to: 
  - Windows Server 2012 Essentials
  - Windows Server 2012 R2 Essentials
ms.assetid: 71e3243e-2da9-409a-ae1f-813d4c9062e1
caps.latest.revision: 13
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
# Migrate Windows Small Business Server 2008 to Windows Server 2012 Essentials
This guide describes how to migrate an existing Windows SBS 2008 domain to --- translation.priority.ht:    - cs-cz   - de-at   - de-de   - es-es   - fr-be   - fr-fr   - hu-hu   - it-ch   - it-it   - ja-jp   - ko-kr   - nl-be   - nl-nl   - pl-pl   - pt-br   - pt-pt   - ru-ru   - sv-se   - tr-tr   - zh-cn   - zh-tw --- Windows Server® 2012 Essentials on new hardware, and then to migrate the settings and data. This guide also describes how to remove your existing server from the --- translation.priority.ht:    - cs-cz   - de-at   - de-de   - es-es   - fr-be   - fr-fr   - hu-hu   - it-ch   - it-it   - ja-jp   - ko-kr   - nl-be   - nl-nl   - pl-pl   - pt-br   - pt-pt   - ru-ru   - sv-se   - tr-tr   - zh-cn   - zh-tw --- Windows Server 2012 Essentials network after you finish the migration.  
  
> [!NOTE]
>  To avoid problems during migration, the --- translation.priority.ht:    - cs-cz   - de-at   - de-de   - es-es   - fr-be   - fr-fr   - hu-hu   - it-ch   - it-it   - ja-jp   - ko-kr   - nl-be   - nl-nl   - pl-pl   - pt-br   - pt-pt   - ru-ru   - sv-se   - tr-tr   - zh-cn   - zh-tw --- Windows Server 2012 Essentials product development team strongly recommends that you read this document before you begin the migration.  
  
> [!NOTE]
<<<<<<< HEAD
>  To migrate your server data to the latest version of Windows Server Essentials, see [Migrate to Windows Server 2012 R2 Essentials](Migrate-from-Previous-Versions-to-Windows-Server-2012-R2-Essentials-or-Windows-Server-Essentials-Experience.md).  
=======
>  To migrate your server data to the latest version of Windows Server Essentials, see [Migrate to Windows Server 2012 R2 Essentials](../migrate/Migrate-from-Previous-Versions-to-Windows-Server-2012-R2-Essentials-or-Windows-Server-Essentials-Experience.md).  
>>>>>>> 4bac1739fd0378146de6c9af26f683b8076754b8
  
## Additional resources  
 For links to additional information, tools, and community resources to help guide you through the migration process, visit the [Windows Small Business Server Migration](http://go.microsoft.com/fwlink/?LinkId=217520) website.  
  
## Terms and definitions  
 **Source Server:** The existing server from which you are migrating your settings and data.  
  
 **Destination Server:** The new server to which you are migrating your settings and data.  
  
## Migration process summary  
 This Migration Guide includes the following steps:  
  
<<<<<<< HEAD
1.  [Prepare your Source Server for Windows Server 2012 Essentials migration](Prepare-your-Source-Server-for-Windows-Server-2012-Essentials-migration3.md).  You must ensure that your Source Server and network are ready for migration. This section guides you through backing up the Source Server, evaluating the Source Server system health, installing the most recent service packs and fixes, and verifying the network configuration.  
  
2.  [Install Windows Server 2012 Essentials in migration mode](Install-Windows-Server-2012-Essentials-in-migration-mode1.md).  This section describes the steps you should take to install --- translation.priority.ht:    - cs-cz   - de-at   - de-de   - es-es   - fr-be   - fr-fr   - hu-hu   - it-ch   - it-it   - ja-jp   - ko-kr   - nl-be   - nl-nl   - pl-pl   - pt-br   - pt-pt   - ru-ru   - sv-se   - tr-tr   - zh-cn   - zh-tw --- Windows Server 2012 Essentials on the Destination Server in migration mode.  
  
3.  [Join computers to the new Windows Server 2012 Essentials network](Join-computers-to-the-new-Windows-Server-2012-Essentials-network1.md).  This section covers joining client computers to the new --- translation.priority.ht:    - cs-cz   - de-at   - de-de   - es-es   - fr-be   - fr-fr   - hu-hu   - it-ch   - it-it   - ja-jp   - ko-kr   - nl-be   - nl-nl   - pl-pl   - pt-br   - pt-pt   - ru-ru   - sv-se   - tr-tr   - zh-cn   - zh-tw --- Windows Server 2012 Essentials network and updating Group Policy settings.  
  
4.  [Move SBS 2008 settings and data to the Destination Server](Move-Windows-SBS-2008-settings-and-data-to-the-Destination-Server-for-Windows-Server-2012-Essentials-migration.md).  This section provides information about migrating data and settings from the Source Server.  
  
5.  [Enable folder redirection on the Windows Server 2012 Essentials Destination Server](Enable-folder-redirection-on-the-Windows-Server-2012-Essentials-Destination-Server2.md).  If folder redirection is enabled on the Source Server, you can enable folder redirection on the Destination Server, and then delete the old Folder Redirection Group Policy setting.  
  
6.  [Demote and remove the Source Server from the new Windows Server 2012 Essentials network](Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-2012-Essentials-network5.md).  Prior to removing the Source Server from the network, you must force a Group Policy update and demote the Source Server.  
  
7.  [Perform post-migration tasks for Windows Server 2012 Essentials migration](Perform-post-migration-tasks-for-Windows-Server-2012-Essentials-migration5.md).  After you finish migrating all settings and data to --- translation.priority.ht:    - cs-cz   - de-at   - de-de   - es-es   - fr-be   - fr-fr   - hu-hu   - it-ch   - it-it   - ja-jp   - ko-kr   - nl-be   - nl-nl   - pl-pl   - pt-br   - pt-pt   - ru-ru   - sv-se   - tr-tr   - zh-cn   - zh-tw --- Windows Server 2012 Essentials, you may want to map permitted computers to user accounts.  
  
8.  [Run the Windows Server 2012 Essentials Best Practices Analyzer](Run-the-Windows-Server-2012-Essentials-Best-Practices-Analyzer3.md).  After you finish migrating settings and data to --- translation.priority.ht:    - cs-cz   - de-at   - de-de   - es-es   - fr-be   - fr-fr   - hu-hu   - it-ch   - it-it   - ja-jp   - ko-kr   - nl-be   - nl-nl   - pl-pl   - pt-br   - pt-pt   - ru-ru   - sv-se   - tr-tr   - zh-cn   - zh-tw --- Windows Server 2012 Essentials, you should run the --- translation.priority.ht:    - cs-cz   - de-at   - de-de   - es-es   - fr-be   - fr-fr   - hu-hu   - it-ch   - it-it   - ja-jp   - ko-kr   - nl-be   - nl-nl   - pl-pl   - pt-br   - pt-pt   - ru-ru   - sv-se   - tr-tr   - zh-cn   - zh-tw --- Windows Server 2012 Essentials BPA.  
=======
1.  [Prepare your Source Server for Windows Server 2012 Essentials migration](../migrate/Prepare-your-Source-Server-for-Windows-Server-2012-Essentials-migration3.md).  You must ensure that your Source Server and network are ready for migration. This section guides you through backing up the Source Server, evaluating the Source Server system health, installing the most recent service packs and fixes, and verifying the network configuration.  
  
2.  [Install Windows Server 2012 Essentials in migration mode](../migrate/Install-Windows-Server-2012-Essentials-in-migration-mode1.md).  This section describes the steps you should take to install --- translation.priority.ht:    - cs-cz   - de-at   - de-de   - es-es   - fr-be   - fr-fr   - hu-hu   - it-ch   - it-it   - ja-jp   - ko-kr   - nl-be   - nl-nl   - pl-pl   - pt-br   - pt-pt   - ru-ru   - sv-se   - tr-tr   - zh-cn   - zh-tw --- Windows Server 2012 Essentials on the Destination Server in migration mode.  
  
3.  [Join computers to the new Windows Server 2012 Essentials network](../migrate/Join-computers-to-the-new-Windows-Server-2012-Essentials-network1.md).  This section covers joining client computers to the new --- translation.priority.ht:    - cs-cz   - de-at   - de-de   - es-es   - fr-be   - fr-fr   - hu-hu   - it-ch   - it-it   - ja-jp   - ko-kr   - nl-be   - nl-nl   - pl-pl   - pt-br   - pt-pt   - ru-ru   - sv-se   - tr-tr   - zh-cn   - zh-tw --- Windows Server 2012 Essentials network and updating Group Policy settings.  
  
4.  [Move SBS 2008 settings and data to the Destination Server](../migrate/Move-Windows-SBS-2008-settings-and-data-to-the-Destination-Server-for-Windows-Server-2012-Essentials-migration.md).  This section provides information about migrating data and settings from the Source Server.  
  
5.  [Enable folder redirection on the Windows Server 2012 Essentials Destination Server](../migrate/Enable-folder-redirection-on-the-Windows-Server-2012-Essentials-Destination-Server2.md).  If folder redirection is enabled on the Source Server, you can enable folder redirection on the Destination Server, and then delete the old Folder Redirection Group Policy setting.  
  
6.  [Demote and remove the Source Server from the new Windows Server 2012 Essentials network](../migrate/Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-2012-Essentials-network5.md).  Prior to removing the Source Server from the network, you must force a Group Policy update and demote the Source Server.  
  
7.  [Perform post-migration tasks for Windows Server 2012 Essentials migration](../migrate/Perform-post-migration-tasks-for-Windows-Server-2012-Essentials-migration5.md).  After you finish migrating all settings and data to --- translation.priority.ht:    - cs-cz   - de-at   - de-de   - es-es   - fr-be   - fr-fr   - hu-hu   - it-ch   - it-it   - ja-jp   - ko-kr   - nl-be   - nl-nl   - pl-pl   - pt-br   - pt-pt   - ru-ru   - sv-se   - tr-tr   - zh-cn   - zh-tw --- Windows Server 2012 Essentials, you may want to map permitted computers to user accounts.  
  
8.  [Run the Windows Server 2012 Essentials Best Practices Analyzer](../migrate/Run-the-Windows-Server-2012-Essentials-Best-Practices-Analyzer3.md).  After you finish migrating settings and data to --- translation.priority.ht:    - cs-cz   - de-at   - de-de   - es-es   - fr-be   - fr-fr   - hu-hu   - it-ch   - it-it   - ja-jp   - ko-kr   - nl-be   - nl-nl   - pl-pl   - pt-br   - pt-pt   - ru-ru   - sv-se   - tr-tr   - zh-cn   - zh-tw --- Windows Server 2012 Essentials, you should run the --- translation.priority.ht:    - cs-cz   - de-at   - de-de   - es-es   - fr-be   - fr-fr   - hu-hu   - it-ch   - it-it   - ja-jp   - ko-kr   - nl-be   - nl-nl   - pl-pl   - pt-br   - pt-pt   - ru-ru   - sv-se   - tr-tr   - zh-cn   - zh-tw --- Windows Server 2012 Essentials BPA.  
>>>>>>> 4bac1739fd0378146de6c9af26f683b8076754b8
  
 Several of the migration procedures require that you open a Command Prompt window as an administrator.  
  
###  <a name="BKMK_OpenACommandPromptAsAdmin"></a> To open a Command Prompt window on the Source Server as an administrator  
  
1.  Click Start.  
  
2.  In the search box, type cmd.  
  
3.  In the list of results, right-click cmd, and then click Run as administrator.  
  
#### To open a Command Prompt window on the Destination Server as an administrator  
  
1.  On the **Start** screen, in the search box, type **cmd**.  
  
2.  In the list of results, right-click **cmd**, and then click **Run as administrator**.
