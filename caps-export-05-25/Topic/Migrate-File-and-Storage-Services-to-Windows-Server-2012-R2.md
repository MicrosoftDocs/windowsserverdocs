---
title: Migrate File and Storage Services to Windows Server 2012 R2
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bc4dba0e-2f41-44ca-ab1a-f53228cdb975
author: JasonGerend
---
# Migrate File and Storage Services to Windows Server 2012 R2
The File and Storage Services Migration Guide provides step\-by\-step instructions for how to migrate the File and Storage Services role, including data, shared folders, and operating system settings from a source server to a destination server that is running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
|||  
|-|-|  
|![](b93f8edc-baa1-46ad-aed5-99c8690273c0)|Did you know that Microsoft Azure provides similar functionality in the cloud? Learn more about [Microsoft Azure storage solutions](http://aka.ms/y03tdi).<br /><br />Create a hybrid storage solution in Microsoft Azure:<br />\- [Learn about StorSimple Hybrid Cloud Storage](http://aka.ms/fuxxdp)|  
  
## About this guide  
  
> [!NOTE]  
> Your detailed feedback is very important and helps us to make Windows Server Migration Guides as reliable, complete, and easy to use as possible. Click **Rate this topic** at the top of the page and describe what you liked, did not like, or want to see in future versions of the topic. To submit additional suggestions about how to improve Migration guides or utilities, post on the [Windows Server 2012 forum](http://social.technet.microsoft.com/Forums/windowsserver/home?forum=winserverMigration).  
  
Migration documentation and tools ease the migration of server role settings and data from an existing server to a destination server that is running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. By using the tools that are described in this guide, you can simplify the migration process, reduce migration time, increase the accuracy of the migration process, and help to eliminate possible conflicts that might otherwise occur during the migration process. For more information about installing and using the migration tools on both source and destination servers, see [Migrating Roles and Features in Windows Server](http://technet.microsoft.com/windowsserver/jj554790.aspx).  
  
Specifically, this guide includes information about migrating the following:  
  
-   Information about the server’s identity  
  
-   Local users and groups  
  
-   Data and shared folders  
  
-   Shadow Copies of Shared Folders  
  
-   Data Deduplication  
  
-   DFS Namespaces  
  
-   DFS Replication  
  
-   File Server Resource Manager \(FSRM\)  
  
-   Group Policy settings that are specific to server message block \(SMB\)  
  
-   Group Policy settings for Offline Files \(also known as client\-side caching or CSC\)  
  
-   iSCSI Software Target  
  
    > [!NOTE]  
    > iSCSI Software Target was previously an optional Windows Server and Windows Storage Server component download. Because of the amount of content, all iSCSI\-specific migration information is located in [File and Storage Services: Migrate an iSCSI Software Target](../Topic/File-and-Storage-Services--Migrate-an-iSCSI-Software-Target.md).  
  
-   Network File System \(NFS\) file shares  
  
-   Remote Volume Shadow Copy Service \(RVSS\)  
  
### Target audience  
This document is intended for information technology \(IT\) professionals and knowledge workers who are responsible for operating and deploying file servers in a managed environment.  
  
## What this guide does not provide  
This guide does not provide information or support for the following migration scenarios:  
  
-   Migrating Roaming User Profiles  
  
-   Upgrading roles on the same computer  
  
-   Migrating more than one server role  
  
-   Migrating data across subnets  
  
-   Migrating file servers by using File Server Resource Manager  
  
-   Migrating encrypted files from Encrypting File System \(EFS\)  
  
-   Migrating file allocation tables \(FAT\) and FAT32 file systems  
  
-   Migrating hardware and software installation for storage resources  
  
In addition to these unsupported scenarios, you should understand the following migration limitations:  
  
-   If the hard disk drive that contains your data is physically moved from the source server to the destination server, file and folder permissions for local users are not preserved.  
  
-   Reparse points, hard links, and mounted volumes are not migrated when data is copied, and they need to be migrated manually.  
  
-   To facilitate migrating file and shared folder permissions, you must migrate local users and groups as part of the migration procedure. However, not all user and group attributes are migrated.  
  
    For more information about the attributes of local users and groups that can be migrated, see the [Local User and Group Migration Guide](http://technet.microsoft.com/library/dd379531.aspx).  
  
## <a name="BKMK_SupportedOperatingSystems"></a>Supported migration scenarios  
This guide provides instructions for migrating an existing server that is running [!INCLUDE[filesrv](../Token/filesrv_md.md)] to a server that is running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. This guide does not contain instructions for migration when the source server is running multiple roles. If your server is running multiple roles, it is recommended that you design a custom migration procedure for your server environment, based on the information that is provided in other server role migration guides. Migration guides for additional roles are available on the [Windows Server Migration Portal](http://go.microsoft.com/fwlink/?LinkId=247608).  
  
> [!CAUTION]  
> If your source server is running multiple roles, some migration steps in this guide, such as those for computer name and IP configuration, can cause other server roles that are running on the source server to fail.  
  
Supported migration scenarios include the following configurations or features:  
  
-   File server is joined to a domain  
  
-   File server is in a workgroup  
  
-   File server data and file shares are located in a storage area network \(SAN\) or other external storage location that preserves data and file share permissions \(except data for local users and groups\)  
  
-   File server data and file shares are located on the server disk \(direct\-attached storage\) that is preserving data and files shares permissions  
  
-   DFS Namespaces  
  
-   File Server Resource Manager  
  
-   iSCSI Software Target  
  
-   Network File System \(NFS\) file shares  
  
-   Shadow Copies of Shared Folders  
  
> [!IMPORTANT]  
> The file migration portion of the Windows Server Migration Tools is designed for smaller data sets \(less than 100 GB of data\). It copies files one at a time over HTTPS. For larger data sets, we recommend using the version of Robocopy.exe included with [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
### Supported operating systems  
  
|Source server processor|Source server operating system|Destination server operating system|Destination server processor|  
|---------------------------|----------------------------------|---------------------------------------|--------------------------------|  
|x86\-based or x64\-based|Windows Server 2003 with Service Pack 2|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], both full and Server Core installation options|x64\-based|  
|x86\-based or x64\-based|Windows Server 2003 R2|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], both full and Server Core installation options|x64\-based|  
|x86\-based or x64\-based|[!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], full installation option|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], both full and Server Core installation options|x64\-based|  
|x64\-based|[!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], both full and Server Core installation options|x64\-based|  
|x64\-based|Server Core installation option of [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], both full and Server Core installation options|x64\-based|  
|x64\-based|Server Core and full installation options of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], both full and Server Core installation options|x64\-based|  
  
The versions of operating systems shown in the preceding table are the oldest combinations of operating systems and service packs that are supported. Newer service packs, if available, are supported. Foundation, Standard, Enterprise, and Datacenter editions of Windows Server are supported as either source or destination servers.  
  
Migrations between physical operating systems and virtual operating systems are supported. Migration from a source server to a destination server that is running an operating system in a different system UI language \(that is, the installed language\) than the source server is not supported. For example, you cannot use  to migrate roles, operating system settings, data, or shares from a computer that is running  in the French system UI language to a computer that is running  in the German system UI language.[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)][!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)][!INCLUDE[wsmt](../Token/wsmt_md.md)]  
  
> [!NOTE]  
> The system UI language is the language of the localized installation package that was used to set up the Windows operating system.  
  
Both x86\-based and x64\-based migrations are supported for [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and Windows Server 2003. All editions of [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] are x64\-based.  
  
## File services migration overview  
The following topics contain step\-by\-step information about how to migrate [!INCLUDE[filesrv](../Token/filesrv_md.md)] from a computer that is running Windows Server 2003 or later to a computer that is running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]:  
  
-   [File and Storage Services: Prepare to Migrate](../Topic/File-and-Storage-Services--Prepare-to-Migrate.md)  
  
-   [File and Storage Services: Migrate the File and Storage Services Role](../Topic/File-and-Storage-Services--Migrate-the-File-and-Storage-Services-Role.md)  
  
-   [File and Storage Services: Verify the Migration](../Topic/File-and-Storage-Services--Verify-the-Migration.md)  
  
-   [File and Storage Services: Post-Migration Tasks](../Topic/File-and-Storage-Services--Post-Migration-Tasks.md)  
  
## <a name="BKMK_datamigration"></a>Impact of migration on other computers in the enterprise  
The content in this section describes the impact to the other computers in your enterprise during migration.  
  
### <a name="BKMK_datashare"></a>Impact of data migration by copying data and shared folders  
  
-   The performance of your source server can be affected during the data migration. This can result in slower access to files that are stored on the server.  
  
-   At the beginning of the second phase of the data migration, all open files are closed, which can lead to data loss.  
  
-   During the second phase of data migration, clients are unable to access the file server.  
  
### Impact of data migration by physically moving data drives  
Clients cannot access the file server from the moment the storage device is disconnected from the source server until it is attached to the destination server.  
  
#### Impact on DFS Namespaces  
The DFS Namespaces are unavailable at several times during the migration process. You should plan your migration when you can take the namespace offline that is hosted on the source server.  
  
#### Impact on DFS Replication  
The impact of migration activity on other servers in the enterprise depends largely on the configuration of the replication topology. Typically, DFS Replication is configured in a hub and spoke replication topology with multiple branch office servers \(spokes\) replicating with a single hub server. Depending on which server in the replication topology is migrated and how the data is migrated, the remaining servers in the enterprise can be affected. Client workstations that are accessing data that is contained in the replicated folder on the server can be affected during the migration process.  
  
Client computers may be accessing data in the folder that is being replicated by using DFS Replication. The replicated folder is often exposed to client computers as an SMB shared folder.  
  
For more information about the impact of the migration process on client computers, see [Impact of data migration by copying data and shared folders](#BKMK_datashare) earlier in this document.  
  
## Permissions required to complete migration  
This section describes permissions that are required to complete the migration.  
  
### Permissions required for data and shared folder migration  
For data and shared folder migration, local Administrator permissions are required on the source server and destination server.  
  
### Permissions required to complete migration on the destination server  
This section describes permissions that are required to perform the migration on the destination server.  
  
#### Permissions required to migrate DFS Namespaces  
For a stand\-alone namespace, the user must be a member of the local Administrators group on the destination server.  
  
There are three permissions options for a domain\-based namespace:  
  
-   Option 1: Membership in the Domain Admins group  
  
-   Option 2 \(if there are more than one namespace servers\):  
  
    -   Permission to administer all namespaces that are hosted on the source server  
  
    -   Member of the local Administrators group on the destination server  
  
-   Option 3 \(if there is a single namespace server\):  
  
    -   Permission to delete and create domain\-based namespaces in the domain  
  
    -   Member of the local Administrators group on the destination server  
  
### Permissions required to perform migration on the source server  
This section describes permissions that are required to perform the migration on the source server.  
  
#### Permissions required to migrate DFS Namespaces  
For a stand\-alone namespace, the user must have membership in the local Administrators group on the source server.  
  
There are three permissions options for a domain\-based namespace:  
  
-   Option 1: Membership in the Domain Admins group  
  
-   Option 2 \(if there are more than one namespace servers\):  
  
    -   Permission to administer the all namespaces that are hosted on the source server  
  
    -   Member of the local Administrators group on the source server  
  
-   Option 3 \(if there is a single namespace server\):  
  
    -   Permission to delete and create domain\-based namespaces in the domain  
  
    -   Member of the local Administrators group on the destination server  
  
#### Permissions required for DFS Replication  
For DFS Replication, the user who starts the migration must be a member of the Domain Admins group or have delegated permissions to the replication groups and replication members. This permission is required to remove the source server from replication groups to which it belongs. If the permissions to administer a replication group have been delegated to a particular user through the DFS Management snap\-in, that user can use the DFS Management snap\-in to perform tasks such as removing the source server from a replication group. The user must also be a member of the local Administrators group on the source server and the destination server.  
  
## See also  
  
-   [Migrate File and Storage Services to Windows Server 2012 R2](../Topic/Migrate-File-and-Storage-Services-to-Windows-Server-2012-R2.md)  
  
-   [File and Storage Services: Prepare to Migrate](../Topic/File-and-Storage-Services--Prepare-to-Migrate.md)  
  
-   [File and Storage Services: Migrate the File and Storage Services Role](../Topic/File-and-Storage-Services--Migrate-the-File-and-Storage-Services-Role.md)  
  
-   [File and Storage Services: Verify the Migration](../Topic/File-and-Storage-Services--Verify-the-Migration.md)  
  
-   [File and Storage Services: Migrate an iSCSI Software Target](../Topic/File-and-Storage-Services--Migrate-an-iSCSI-Software-Target.md)  
  
-   [File and Storage Services: Migrate Network File System](../Topic/File-and-Storage-Services--Migrate-Network-File-System.md)  
  
-   [File and Storage Services: Post-Migration Tasks](../Topic/File-and-Storage-Services--Post-Migration-Tasks.md)  
  
-   [File and Storage Services: Appendix A: Optional Procedures](../Topic/File-and-Storage-Services--Appendix-A--Optional-Procedures.md)  
  
-   [File and Storage Services: Appendix B: Migration Data Collection Worksheets](../Topic/File-and-Storage-Services--Appendix-B--Migration-Data-Collection-Worksheets.md)  
  
-   [Migrating Roles and Features in Windows Server](http://technet.microsoft.com/windowsserver/jj554790.aspx)  
  
