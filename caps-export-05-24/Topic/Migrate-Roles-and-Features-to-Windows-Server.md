---
title: Migrate Roles and Features to Windows Server
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - server-general
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4ced8c5d-41b6-475f-9f47-c224b93efe6c
author: jpjofre
---
# Migrate Roles and Features to Windows Server
Migration documentation and tools ease the process of migrating server roles, features, operating system settings, and data from an existing server that is running Windows Server 2003, [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] to a computer that is running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. By using migration guides linked to on this page \(and where appropriate, [!INCLUDE[wsmt](../Token/wsmt_md.md)]\) to migrate [!INCLUDE[rrsandf_plural](../Token/rrsandf_plural_md.md)], you can simplify deployment of new servers \(including those that are running the Server Core installation option of [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], and virtual servers\), reduce migration downtime, increase accuracy of the migration process, and help eliminate conflicts that could otherwise occur during the migration process.  
  
Most of the migration documentation and tools featured in this section support cross\-architecture migrations \(x86\-based to x64\-based computing platforms\), migrations between physical and virtual environments, and migrations between both the full and Server Core installation options of the Windows Server operating system, where available.  
  
In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and later releases of Windows Server, [!INCLUDE[wsmt](../Token/wsmt_md.md)] supports cross\-subnet migrations.  
  
## Migration guides  
The following are available resources for migrating roles to [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
### Windows Server roles, role services, and features  
Windows Server Migration guides provide you with instructions for migrating a single [!INCLUDE[rrsorf_sing](../Token/rrsorf_sing_md.md)] to a server that is running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. Guides do not contain instructions for migration when the source server is running multiple roles. If your server is running multiple roles, it is recommended that you design a custom migration procedure specific to your server environment, based on the information provided in other migration guides.  
  
-   [Migrate Roles and Features to Windows Server 2012 R2](../Topic/Migrate-Roles-and-Features-to-Windows-Server-2012-R2.md)  
  
-   [Migrate Roles and Features to Windows Server 2012](../Topic/Migrate-Roles-and-Features-to-Windows-Server-2012.md)  
  
## Windows Server Migration Tools  
[!INCLUDE[wsmt](../Token/wsmt_md.md)], available as a feature in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], allows an administrator to migrate some server roles, features, operating system settings, shares, and other data from computers that are running certain editions of Windows Server 2003, [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] to computers that are running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
Not all migrations require or use [!INCLUDE[wsmt](../Token/wsmt_md.md)]. Guides for migrations that require [!INCLUDE[wsmt](../Token/wsmt_md.md)] clearly state that [!INCLUDE[wsmt](../Token/wsmt_md.md)] setup is part of the migration process, and provide specific instructions for how to use [!INCLUDE[wsmt](../Token/wsmt_md.md)].  
  
To use [!INCLUDE[wsmt](../Token/wsmt_md.md)], the feature must be installed on both source and destination computers as described in the following guide.  
  
-   [Install, use, and remove Windows Server Migration Tools](http://go.microsoft.com/fwlink/?LinkID=247607)  
  
## See Also  
[Migrating Roles and Features to Windows Server](http://technet.microsoft.com/windowsserver/jj554790.aspx)  
  
