---
title: Migrate Print and Document Services to Windows Server 2012
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 05813af4-f354-47d6-963d-73edb3204ad8
author: vhorne
---
# Migrate Print and Document Services to Windows Server 2012
  
## <a name="BKMK_Overview"></a>Overview  
This article provides guidance to migrate a print server running Windows Server® 2003, Windows Server 2003 R2, [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], or  [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] operating systems to a server running the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] operating system with the [!INCLUDE[printdocsrv](../Token/printdocsrv_md.md)] role installed. This includes cross\-architecture and stand\-alone migrations, as well as configurations for a server in a cluster. This document provides step\-by\-step instructions for migrating from old hardware to new hardware and consolidating print servers.  
  
[!INCLUDE[printdocsrv](../Token/printdocsrv_md.md)] enables print server tools and configures the server to act as a print server. [!INCLUDE[printdocsrv](../Token/printdocsrv_md.md)] is not dependent on any other features or roles. However, some specific network configurations, clients, and hardware may require you to install additional features or enable certain services.  
  
This guide provides you with instructions for migrating an existing print server to a server that is running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. This guide does not contain instructions for migration when the source server is running multiple roles. If your server is running multiple roles, we recommend that you design a custom migration procedure specific to your server environment, based on the information provided in other role migration guides. Migration guides for additional roles are available in the [Windows Server TechCenter](http://technet.microsoft.com/library/hh831620.aspx).  
  
> [!CAUTION]  
> If your source server is running multiple roles, some migration steps in this guide, such as those for computer name and IP configuration, can cause other roles that are running on the source server to fail.  
  
To manage the migration process, use one of the following:  
  
-   The Printer Migration Wizard, which you access through Print Management, a snap\-in in Microsoft Management Console \(MMC\).  
  
-   The Printbrm.exe command\-line tool.  
  
You can perform the migration locally or remotely, and from either a client computer or server.  
  
> [!IMPORTANT]  
> As a best practice, run the Printer Migration Wizard or Printbrm.exe from a computer running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] to ensure that you are using the newest version of the migration tools that have the latest updates and features. You can run these tools either locally on the server or remotely from any other computer running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)].  
>   
> Remember that if you are running printbrm over the network to remote servers, the **Print$** share must exist on both the source and target servers and the Remote Registry Service must be running.  
  
For more information about installing and using these tools, see [Access the migration tools](../Topic/Preparing-to-Migrate.md#BKMK_Step1AccessingMigrationTools).  
  
> [!NOTE]  
> The Print Management snap\-in is not available in Windows Server 2003. However, it is available in [!INCLUDE[nextref_vistae](../Token/nextref_vistae_md.md)] and [!INCLUDE[nextref_vistau](../Token/nextref_vistau_md.md)], which enables you to migrate from Windows Server 2003. It is also available in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. For more information about migrating from Windows Server 2003, see [Preparing to Migrate](../Topic/Preparing-to-Migrate.md).  
>   
> The Print Management snap\-in and the Printbrm.exe command\-line tool are not available for the Server Core installation option. To migrate from a print server running on a Server Core installation, use a server running the Printer Migration Wizard, Windows Vista Enterprise, or Windows Vista Ultimate. For more information about migrating from a server running a Server Core installation, see [Preparing to Migrate](../Topic/Preparing-to-Migrate.md).  
>   
> There is no equivalent to [!INCLUDE[printdocsrv](../Token/printdocsrv_md.md)] for Windows® client operating systems.  
  
You can migrate [!INCLUDE[printdocsrv](../Token/printdocsrv_md.md)] from the destination server or from any client with the following:  
  
-   The Printer Migration Wizard \(provided that the client is running one of the supported operating systems listed in the [Supported operating systems](#BKMK_MigrationMatrix) matrix\).  
  
-   Remote access to the destination server.  
  
-   Access to the printer settings file created when you back up the source server.  
  
> [!NOTE]  
> All commands in this guide are case\-insensitive unless specifically noted.  
  
## <a name="BKMK_AboutThisGuide"></a>About this guide  
This guide is designed as a step\-by\-step tutorial for migrating print servers.  
  
### Target audience  
This document is intended for IT administrators and other knowledge workers who are responsible for the operation and deployment of print servers in a managed environment.  
  
## <a name="BKMK_WhatThisGuideDoesNotProvide"></a>What this guide does not provide  
This document does not provide guidance for the following:  
  
-   Upgrading roles on the same computer  
  
-   Migrating printer configurations during client installations of Windows  
  
-   Migrating settings for a server that is not being used as a print server  
  
-   Recovering server information that was not properly saved prior to migration for in\-place upgrades  
  
-   Instructions for migrating more than [!INCLUDE[printdocsrv](../Token/printdocsrv_md.md)]  
  
## Supported migration scenarios  
You must have access to the Printer Migration Wizard to migrate print servers. For more information about supported scenarios and limitations, see [Preparing to Migrate](../Topic/Preparing-to-Migrate.md).  
  
### <a name="BKMK_MigrationMatrix"></a>Supported operating systems  
The following table outlines the supported operating systems for migration covered in this guide.  
  
|Source server processor|Source server operating system|Destination server operating system|Destination server processor|  
|---------------------------|----------------------------------|---------------------------------------|--------------------------------|  
|x86\- or x64\-based|Windows Server 2003 with Service Pack 2|[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], including full, MinShell, and Server Core installation options|x64\-based|  
|x86\- or x64\-based|Windows Server 2003 R2|[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], including full, MinShell, and Server Core installation options|x64\-based|  
|x86\- or x64\-based|[!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], both full and Server Core installation options|[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], including full, MinShell, and Server Core installation options|x64\-based|  
|x64\-based|[!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]|[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], including full, MinShell, and Server Core installation options|x64\-based|  
|x64\-based|Server Core installation option of [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]|[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], including full, MinShell, and Server Core installation options|x64\-based|  
|X64\-based|[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]|[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], including full, MinShell, and Server Core installation options|x64\-based|  
|X64\-based|Server Core and MinShell installation options of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]|[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], including full, MinShell, and Server Core installation options|x64\-based|  
  
The versions of operating systems shown in the preceding table are the oldest combinations of operating systems and service packs that are supported. Newer service packs, if available, are supported.  
  
The Foundation, Standard, Enterprise, and Datacenter editions of Windows Server are supported on full, Server Core, and MinShell installation options, as either source or destination servers.  
  
All versions of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] are x64\-based. Migrating to an x86\-based server is not supported.  
  
Migrations between physical operating systems and virtual operating systems are supported.  
  
> [!NOTE]  
> Both x86\-based and x64\-based migrations are supported for Windows Server 2003 and [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. All editions of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] are x64\-based.  
  
You might prefer the migration process, rather than an upgrade, even when the hardware is native x64\-based. An example would be a case where there is increased use of the server and there is a server role split \(in which the source server has more than one server role\)—and you decide to separate the roles onto several additional x64\-based servers. In this case, migration of individual server roles to other servers might be the best solution.  
  
The server administrator can choose which parts of an existing installation to migrate, but along with the server role, this usually includes configuration, data, system identity, and operating system settings.  
  
Migration from a source server to a destination server that is running an operating system in a different system UI language \(that is, the installed language\) than the source server is not supported. For example, you cannot use Windows Server Migration Tools to migrate roles, operating system settings, data, or shares from a computer that is running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] in the French language to a computer that is running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] in the German language.  
  
> [!NOTE]  
> The system UI language is the language of the localized installation package that was used to set up the Windows operating system.  
  
Cross\-architecture migration \(such as migrating from an x86\-based server to an x64\-based server\) is supported. The source server must have print queue drivers installed for both the source and destination server architectures. If a print queue does not have a driver for the destination server architecture, then it will not be migrated. Similarly, verify that the destination server contains drivers for each supported architecture.  
  
### Supported role configurations  
The [supported operating systems](#BKMK_MigrationMatrix) matrix provides a complete listing of the supported migration scenarios.  
  
Some migration scenarios require additional preparation. For more information about these scenarios, see [Appendix B - Additional Destination Server Scenarios](../Topic/Appendix-B---Additional-Destination-Server-Scenarios.md).  
  
### Supported role services and features  
The Printer Migration Wizard migrates:  
  
-   Print queues.  
  
-   Shared printer settings.  
  
-   Printer drivers in use by the print spooler.  
  
-   Any security settings specific to the installed printer.  
  
### Migrating from x86\-based to x64\-based v3 printer drivers  
There are several things you must consider when managing migrations using v3 print drivers. The first is that a print queue cannot function without the native printer driver for the server architecture \(x86 or x64\) on which it exists. Since [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] is a 64\-bit only operating system, it is important that you have 64\-bit drivers installed for all of your printers if you are migrating from a 32\-bit system. The most difficult transition is from 32\-bit to 64\-bit servers in an organization with 32\-bit clients since it is common to have third\-party 32\-bit printer drivers that do not have 64\-bit equivalents. During the print configuration restoration for cross\-platform scenarios, if the backup file does not contain driver binaries for the platform of the target server, the drivers will be installed from the target server’s driver store, if available.  
  
As a best practice, when migrating from x86\-based to x64\-based v3 drivers:  
  
1.  Verify that x64\-based versions of the drivers are available.  
  
2.  If you are unable to verify their availability, back up the source server before the migration.  
  
3.  Install the x64\-based drivers on the source server so that you can determine if there any problems or conflicts before the migration process.  
  
4.  If there are conflicts or problems on the destination server after the migration, roll back the migration. For more information, see “Roll back migration on the source server” in [Post-Migration Tasks_1](../Topic/Post-Migration-Tasks_1.md).  
  
### Unsupported scenarios  
The Printer Migration Wizard does not migrate the following:  
  
-   Other services or settings that specific printers may rely on, such as Line Printer Remote \(LPR\), Internet Printer Protocol \(IPP\), or Web Services on Devices \(WSD\). You must enable or install these features before restoring the source print server configuration. For additional information, see “Roll back migration on the source server” in [Post-Migration Tasks_1](../Topic/Post-Migration-Tasks_1.md).  
  
-   Local bus printers \(LPT and USB\), although they are shown during backup. For additional information, see [Appendix B - Additional Destination Server Scenarios](../Topic/Appendix-B---Additional-Destination-Server-Scenarios.md).  
  
-   Plug and play printers. However, plug and play printer drivers will be migrated. For additional information, see [Appendix B - Additional Destination Server Scenarios](../Topic/Appendix-B---Additional-Destination-Server-Scenarios.md).  
  
-   Any print jobs currently in the printer queue.  
  
-   Any system or print administrators, or permissions. If you want to retain the same system or print administrators on the destination server as on the source server, you will need to manually add these administrators to the destination server.  
  
## <a name="BKMK_OverviewOfMigration"></a>Print and Document Services migration overview  
While the original server is still running, use the Printer Migration Wizard or the Printbrm.exe command\-line tool to export or back up the print information \(such as settings, queues, and drivers\) in a printer settings file. Then, import or restore this backup image to a destination server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] that has been configured to run as a print server.  
  
Some migration scenarios require additional preparation. For more information about these scenarios, see [Appendix B - Additional Destination Server Scenarios](../Topic/Appendix-B---Additional-Destination-Server-Scenarios.md).  
  
To migrate printers from a server running Windows Server 2003 or a Server Core installation to a server running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], you must use a computer running the Printer Migration Wizard to remotely manage the server running Windows Server 2003 or a Server Core installation. Using this computer, you can store the printer settings file \(containing information about the printers you want to migrate, such as settings, queues, and drivers\) from the server running Windows Server 2003 or a Server Core installation to a file share. You can then use the Printer Migration Wizard to migrate the printers from the file share to the server running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
For more information about accessing the Printer Migration Wizard, see [Preparing to Migrate](../Topic/Preparing-to-Migrate.md).  
  
> [!NOTE]  
> The **Printing\-Server Core** role must be installed on a server running a Server Core installation from which you want to migrate.  
  
## <a name="BKMK_Checklist"></a>Migrate print servers \(overview\)  
The following list provides an overview of the steps to migrating the print servers.  
  
-   [Access the migration tools](../Topic/Preparing-to-Migrate.md#BKMK_Step1AccessingMigrationTools)  
  
-   [Prepare the destination server](../Topic/Preparing-to-Migrate.md#BKMK_Step2PrepareDestinationServer)  
  
-   [Prepare the source server](../Topic/Preparing-to-Migrate.md#BKMK_Step3PrepareSourceServer)  
  
-   [Back up the source server](../Topic/Migrating-the-Print-and-Document-Services-Role.md#BKMK_Step4BackUpSourceServer)  
  
-   [Restoration](../Topic/Migrating-the-Print-and-Document-Services-Role.md#BKMK_Step5Restoration)  
  
-   [Verify the migration](../Topic/Verifying-the-Migration.md#BKMK_Step6VerifyTheMigration)  
  
-   [Post-migration](../Topic/Post-Migration-Tasks_1.md#BKMK_Step7PostMigration)  
  
## Impact of migration  
The objective of the migration process is that the destination server is able to perform the same functions as the source server did, without client computers on the network being aware that the migration has taken place. The following sections describe the impact of migration.  
  
### Impact of migration on the source server  
The source server is not impacted by print server migration until the destination server takes over as the active server \(typically when the name or IP address of the source server is assigned to the destination server\).  At that point, the source server no longer services print requests that target the print server.  
  
### Impact of migration on other computers in the enterprise  
If the destination server replaces the source server in the network \(same name or IP address\), then there should be no impact to other computers in the enterprise.  
  
If the destination server has a different name or IP address than the source server, then all clients with existing print connections must delete and recreate those print connections so that they target the destination server.  
  
## Permissions required to complete migration  
Administrative permissions are required on both the source print server and the destination print server.  
  
### Permissions required to complete migration on other computers in the enterprise  
If the destination server replaces the source server in the network, then no permissions are required on other computers in the enterprise. If the destination server has a different name or IP address, then the permissions required on other computers may vary depending on Group Policy settings, Windows Update access, and driver availability.  
  
## Estimated duration  
The time required to migrate a print server will vary from server to server, depending on the following:  
  
-   The number of queues being migrated.  
  
-   The number of individual drivers needed for the queue.  
  
-   The size of a given driver, in terms of its file size and the number of files.  
  
-   The configuration of the server.  
  
Migrating a single printer queue with a typical x86\-based and x64\-based driver can range from five seconds to several minutes, depending on the factors listed above. Because of this range, a typical migration can take anywhere from less than an hour to several hours.  
  
## See Also  
[Preparing to Migrate](../Topic/Preparing-to-Migrate.md)  
[Migrating the Print and Document Services Role](../Topic/Migrating-the-Print-and-Document-Services-Role.md)  
[Verifying the Migration](../Topic/Verifying-the-Migration.md)  
[Post-Migration Tasks_1](../Topic/Post-Migration-Tasks_1.md)  
[Appendix A - Printbrm.exe Command-Line Tool Details](../Topic/Appendix-A---Printbrm.exe-Command-Line-Tool-Details.md)  
[Appendix B - Additional Destination Server Scenarios](../Topic/Appendix-B---Additional-Destination-Server-Scenarios.md)  
[Appendix C - Printbrm Event IDs](../Topic/Appendix-C---Printbrm-Event-IDs.md)  
  
