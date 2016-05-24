---
title: Migrating Active Directory Federation Services Role Service to Windows Server 2012 R2
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 975eea98-f372-411b-aea1-1ebf266b1035
author: billmath
---
# Migrating Active Directory Federation Services Role Service to Windows Server 2012 R2
  
## About this guide  
This guide provides instructions to migrate the following role services to Active Directory Federation Services \(AD FS\) that is installed with [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)]:  
  
-   AD FS 2.0 federation server installed on Windows Server 2008 or Windows Server 2008 R2  
  
-   AD FS federation server installed on Windows Server 2012  
  
## Target audience  
  
-   IT architects who are responsible for computer management and security throughout an organization  
  
-   IT operations engineers who are responsible for the day\-to\-day management and troubleshooting of networks, servers, client computers, operating systems, or applications  
  
-   IT operations managers who are accountable for network and server management  
  
## Supported migration scenarios  
The migration instructions in this guide consist of the following tasks:  
  
-   Exporting the AD FS 2.0 configuration data from your server that is running Windows Server 2008, Windows Server 2008 R2, or Windows Server 2012  
  
-   Performing an in\-place upgrade of the operating system of this server from Windows Server 2008, Windows Server 2008 R2 or Windows Server 2012 to [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)]  
  
-   Recreating the original AD FS configuration and restoring the remaining AD FS service settings on this server, which is now running the AD FS server role that is installed with [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)].  
  
This guide does not include instructions to migrate a server that is running multiple roles. If your server is running multiple roles, we recommend that you design a custom migration process specific to your server environment, based on the information provided in other role migration guides. Migration guides for additional roles are available on the [Windows Server Migration Portal](http://go.microsoft.com/fwlink/?LinkId=247608).  
  
### Supported operating systems  
  
|Source server processor|Source server operating system|Destination server operating system|Destination server processor|  
|---------------------------|----------------------------------|---------------------------------------|--------------------------------|  
|x86\- or x64\-based|[!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], both full and Server Core installation options|[!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)] \(Server Core and full installation options\)|x64\-based|  
|x64\-based|[!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]|[!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)] \(Server Core and full installation options\)|x64\-based|  
|x64\-based|Server Core installation option of [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]|[!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)] \(Server Core and full installation options\)|x64\-based|  
|x64\-based|Server Core and full installation options of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]|[!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)] \(Server Core and full installation options\)|x64\-based|  
  
> [!NOTE]  
> -   The versions of operating systems that are listed in the preceding table are the oldest combinations of operating systems and service packs that are supported.  
> -   The Foundation, Standard, Enterprise, and Datacenter editions of the Windows Server operating system are supported as the source or the destination server.  
> -   Migrations between physical operating systems and virtual operating systems are supported.  
  
### Supported AD FS role services and features  
The following table describes the migration scenarios of the AD FS role services and their respective settings that are described in this guide.  
  
|From|To AD FS installed with [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)]|  
|--------|-----------------------------------------------------------------------------------------|  
|AD FS 2.0 federation server installed on Windows Server 2008 or Windows Server 2008 R2|Migration on the same server is supported. For more information, see:<br /><br />-   [Preparing to Migrate the AD FS Federation Server](../Topic/Preparing-to-Migrate-the-AD-FS-Federation-Server.md)<br />-   [Migrating the AD FS Federation Server](../Topic/Migrating-the-AD-FS-Federation-Server.md)|  
|AD FS federation server installed on Windows Server 2012|Migration on the same server is supported.  For more information see:<br /><br />-   [Preparing to Migrate the AD FS Federation Server](../Topic/Preparing-to-Migrate-the-AD-FS-Federation-Server.md)<br />-   [Migrating the AD FS Federation Server](../Topic/Migrating-the-AD-FS-Federation-Server.md)|  
  
## See Also  
[Preparing to Migrate the AD FS Federation Server](../Topic/Preparing-to-Migrate-the-AD-FS-Federation-Server.md)  
[Migrating the AD FS Federation Server](../Topic/Migrating-the-AD-FS-Federation-Server.md)  
[Migrating the AD FS Federation Server Proxy](../Topic/Migrating-the-AD-FS-Federation-Server-Proxy.md)  
[Verifying the AD FS Migration to Windows Server 2012 R2](../Topic/Verifying-the-AD-FS-Migration-to-Windows-Server-2012-R2.md)  
  
