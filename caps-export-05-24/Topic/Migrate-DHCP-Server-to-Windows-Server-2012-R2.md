---
title: Migrate DHCP Server to Windows Server 2012 R2
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1df3e163-e9e5-4aca-9dae-ca49c84e68d0
---
# Migrate DHCP Server to Windows Server 2012 R2
DHCP server role migration involves moving the settings for your existing DHCP server to a new DHCP server on the network. The goal of this server migration is to install the DHCP server role on the [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)] operating system so that it provides DHCP leases on a network without any perceptible change to DHCP client computers.  
  
## About this guide  
This guide describes the steps for migrating existing DHCP server settings to a server that is running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. Migration documentation and tools ease the migration of server role settings and data from an existing server to a destination server that is running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. By using the tools that are described in this guide to migrate a DHCP server, you can simplify migration, reduce migration time, increase the accuracy of the migration process, and help eliminate possible conflicts that might otherwise occur during DHCP migration. For more information about the migration tools, see [DHCP Server Migration: Appendix A](../Topic/DHCP-Server-Migration--Appendix-A.md).  
  
### Target audience  
This guide is intended for information technology \(IT\) administrators, IT professionals, and other knowledge workers who are responsible for the operation and deployment of DHCP servers in a managed environment.  
  
### What this guide does not provide  
The following scenarios are not supported or are beyond the scope of this guide.  
  
-   Clustering scenarios are not supported by this migration process. For more information about migrating DHCP Server in a cluster environment, see [Migrating DHCP to a Cluster Running Windows Server 2008 R2 Step\-by\-Step Guide](http://go.microsoft.com/fwlink/?LinkId=140512) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=140512\) on the Windows Server TechCenter.  
  
    Also see [Migrate to DHCP Failover](../Topic/Migrate-to-DHCP-Failover.md). DHCP failover is a new option for DHCP high availability, introduced in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
-   Upgrading roles on the same computer is out of scope for this guide.  
  
-   Scenarios in which the new operating system is installed on existing server hardware by using the **Upgrade** option during setup \(in\-place upgrades\) are not covered in this guide.  
  
-   Migrating more than one server role is not covered in this guide.  
  
### <a name="BKMK_Supportedmigrationscenarios"></a>Supported migration scenarios  
This guide gives you the instructions to migrate an existing DHCP server to a server that is running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. This guide does not contain instructions for migration when the source server is running multiple roles. If your server is running multiple roles, we recommend that you design a custom migration procedure specific to your server environment based on the information provided in other role migration guides. Migration guides for additional roles are available on the [Windows Server 2012 TechCenter](http://technet.microsoft.com/library/jj134039.aspx) \(http:\/\/technet.microsoft.com\/library\/jj134039.aspx\).  
  
> [!CAUTION]  
> If the source server is running multiple roles, some migration steps in this guide, such as those for computer name and IP configuration, can cause other roles that are running on the source server to fail.  
  
This guide provides instructions only for migrating DHCP data and settings from a server that is being replaced by an x64\-based server running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
#### Supported operating systems  
This guide provides instructions for migration of a DHCP server from a server that is running Windows Server 2003 or a later operating system to a server running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. Supported operating systems are listed in the following table.  
  
### Supported operating systems for migration  
  
|Source server processor|Source server operating system|Destination server operating system|Destination server processor|  
|---------------------------|----------------------------------|---------------------------------------|--------------------------------|  
|x86\- or x64\-based|Windows Server 2003 with Service Pack 2|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], both full and Server Core installation options|x64\-based|  
|x86\- or x64\-based|Windows Server 2003 R2|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], both full and Server Core installation options|x64\-based|  
|x86\- or x64\-based|Windows Server 2008|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], both full and Server Core installation options|x64\-based|  
|x64\-based|[!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], both full and Server Core installation options|x64\-based|  
|x64\-based|Server Core installation option of [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], both full and Server Core installation options|x64\-based|  
|x64\-based|[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], both full and Server Core installation options|x64\-based|  
|x64\-based|Server Core installation option of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], both full and Server Core installation options|x64\-based|  
|x64\-based|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], both full and Server Core installation options|x64\-based|  
|x64\-based|Server Core installation option of [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], both full and Server Core installation options|x64\-based|  
  
The versions of operating systems shown in the previous table are the oldest combinations of operating systems and service packs that are supported. Newer service packs, if available, are supported for the migration of DHCP server settings.  
  
Foundation, Standard, Enterprise, and Datacenter editions of Windows Server are supported as either source or destination servers.  
  
Migrations between physical operating systems and virtual operating systems are supported.  
  
Migration from a source server to a destination server that is running an operating system in a different system user interface \(UI\) language than the source server is not supported. The system UI language is the language of the localized installation package that was used to set up the Windows operating system. For example, you cannot use Windows Server migration tools to migrate roles, operating system settings, data, or shares from a computer that is running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] in the French system UI language to a computer that is running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] in the German system UI language.  
  
Both x86\-based and x64\-based migrations are supported for Windows Server 2003 and [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. All editions of [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] are x64\-based.  
  
Roles that are running on Server Core installations of [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] cannot be migrated, because there is no .NET Framework available on Server Core installations of [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)].  
  
We recommend migration rather than an upgrade even when the hardware is native x64\-based. For example, with a server role split, a scenario in which the source server has more than one server role, because of increased use of this server you might decide to separate the roles onto several additional x64\-based servers. In this case, migrating \(not upgrading\) individual server roles to other servers may be the best solution.  
  
The server administrator can choose which components of an existing installation to migrate; together with the server role, these components usually include configuration, data, system identity, and operating system settings.  
  
#### Supported role configurations  
You can migrate all DHCP Server settings by using this guide, including registry and database settings.  
  
> [!NOTE]  
> If you are migrating a DHCP server in a cluster configuration, see [Migrating DHCP to a Cluster Running Windows Server 2008 R2 Step\-by\-Step Guide](http://go.microsoft.com/fwlink/?LinkId=140512) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=140512\) on the Windows Server TechCenter.  
>   
> Also see [Migrate to DHCP Failover](../Topic/Migrate-to-DHCP-Failover.md). DHCP failover is a new option for DHCP high availability, introduced in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
#### <a name="BKMK_Migrationoverview"></a>DHCP Server migration overview  
DHCP Server migration is divided into the following major sections:  
  
-   [DHCP Server Migration: Preparing to Migrate](../Topic/DHCP-Server-Migration--Preparing-to-Migrate.md)  
  
-   [DHCP Server Migration: Migrating the DHCP Server Role](../Topic/DHCP-Server-Migration--Migrating-the-DHCP-Server-Role.md)  
  
-   [DHCP Server Migration: Verifying the Migration](../Topic/DHCP-Server-Migration--Verifying-the-Migration.md)  
  
-   [DHCP Server Migration: Post-Migration Tasks](../Topic/DHCP-Server-Migration--Post-Migration-Tasks.md)  
  
##### <a name="BKMK_DHCPserverrolemigrationprocessdiagram"></a>DHCP Server migration process  
As shown in the following illustration, the pre\-migration process involves the manual collection of data, followed by procedures on the destination and source servers. The migration process includes source and destination server procedures that use the **Export** and **Import** cmdlets to automatically collect, store, and then migrate server role settings. Post\-migration procedures include verifying that the destination server successfully replaced the source server and then retiring or repurposing the source server. If the verification procedure indicates that the migration failed, troubleshooting begins. If troubleshooting fails, rollback instructions are provided to return to the use of the original source server.  
  
![](../Image/RoleFeatureMigrationProcess.gif)  
  
## Impact of migration on other computers in the enterprise  
During migration, the source DHCP server might not be available. Therefore, client computers will not be able to obtain IP addresses from this DHCP server. We recommend that you maintain or create an auxiliary DHCP server so that client computers can obtain IP addresses while you migrate the primary DHCP server.  
  
Be aware that if you choose to perform the migration without any auxiliary DHCP servers, all clients with valid leases must keep using those leases. If a lease for an existing client expires, that client will not be able to obtain an IP address. In addition, any new client that connects to the network will not be able to obtain an IP address when the single\-source DHCP server is not available.  
  
## Permissions required to complete migration  
The following permissions are required on the source server and the destination server:  
  
-   Domain administrative rights that are required to authorize DHCP Server.  
  
-   Local administrative rights are required to install or manage DHCP Server.  
  
-   Write permissions are required to the migration store location. For more information, see [DHCP Server Migration: Preparing to Migrate](../Topic/DHCP-Server-Migration--Preparing-to-Migrate.md).  
  
## Estimated duration  
The migration can take two to three hours, including testing.  
  
## See also  
[DHCP Server Migration: Preparing to Migrate](../Topic/DHCP-Server-Migration--Preparing-to-Migrate.md)  
  
[DHCP Server Migration: Migrating the DHCP Server Role](../Topic/DHCP-Server-Migration--Migrating-the-DHCP-Server-Role.md)  
  
[DHCP Server Migration: Verifying the Migration](../Topic/DHCP-Server-Migration--Verifying-the-Migration.md)  
  
[DHCP Server Migration: Post-Migration Tasks](../Topic/DHCP-Server-Migration--Post-Migration-Tasks.md)  
  
[DHCP Server Migration: Appendix A](../Topic/DHCP-Server-Migration--Appendix-A.md)  
  
