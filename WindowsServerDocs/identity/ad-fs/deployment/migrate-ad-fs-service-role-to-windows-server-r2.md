---
title: Migrate Active Directory Federation Services Role Services to Windows Server 2012 R2
description: Provides instructions for migrating the AD FS service to Windows Server 2012 R2.
author: billmath
ms.author: billmath
manager: femila
ms.date: 07/10/2017
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: identity-adfs
---



# Migrate Active Directory Federation Services Role Services to Windows Server 2012 R2
 This document provides instructions to migrate the following role services to Active Directory Federation Services (AD FS) that is installed with Windows Server 2012 R2:  
  
-   AD FS 2.0 federation server installed on Windows Server 2008 or Windows Server 2008 R2  
  
-   AD FS federation server installed on Windows Server 2012  
  
## Supported migration scenarios  
 The migration instructions in this guide consist of the following tasks:  
  
- Exporting the AD FS 2.0 configuration data from your server that is running Windows Server 2008, Windows Server 2008 R2, or Windows Server 2012  
  
- Performing an in-place upgrade of the operating system of this server from Windows Server 2008, Windows Server 2008 R2 or Windows Server 2012 to Windows Server 2012 R2. 
  
- Recreating the original AD FS configuration and restoring the remaining AD FS service settings on this server, which is now running the AD FS server role that is installed with Windows Server 2012 R2.  
  
  This guide does not include instructions to migrate a server that is running multiple roles. If your server is running multiple roles, we recommend that you design a custom migration process specific to your server environment, based on the information provided in other role migration guides. Migration guides for additional roles are available on the [Windows Server Migration Portal](https://go.microsoft.com/fwlink/?LinkId=247608).  
  
### Supported operating systems  
 Destination server operating system:  
  
 Windows Server 2012 R2 (Server Core and full installation options)  
  
 Destination server processor:  
  
 x64-based  
  
|Source server processor|Source server operating system|  
|-----------------------------|------------------------------------|  
|x86- or x64-based| Windows Server 2008, both full and Server Core installation options|  
|x64-based|Windows Server 2008 R2|  
|x64-based|Server Core installation option of Windows Server 2008 R2|  
|x64-based|Server Core and full installation options of Windows Server 2012|  
  
> [!NOTE]
> - The versions of operating systems that are listed in the preceding table are the oldest combinations of operating systems and service packs that are supported.  
>   -   The Foundation, Standard, Enterprise, and Datacenter editions of the Windows Server operating system are supported as the source or the destination server.  
>   -   Migrations between physical operating systems and virtual operating systems are supported.  
  
### Supported AD FS role services and features  
 The following table describes the migration scenarios of the AD FS role services and their respective settings that are described in this guide.  
  
|From|To AD FS installed with Windows Server 2012 R2|  
|----------|----------------------------------------------------------------------------------------------|  
|AD FS 2.0 federation server installed on Windows Server 2008 or Windows Server 2008 R2|Migration on the same server is supported. For more information, see:<br /><br /> [Preparing to Migrate the AD FS Federation Server](prepare-migrate-ad-fs-server-r2.md)<br /><br /> [Migrating the AD FS Federation Server](migrate-ad-fs-fed-server-r2.md)|  
|AD FS federation server installed on Windows Server 2012|Migration on the same server is supported.  For more information see:<br /><br /> [Preparing to Migrate the AD FS Federation Server](prepare-migrate-ad-fs-server-r2.md)<br /><br /> [Migrating the AD FS Federation Server](migrate-ad-fs-fed-server-r2.md)|  
  
## Next Steps
 [Preparing to Migrate the AD FS Federation Server](prepare-migrate-ad-fs-server-r2.md)   
 [Migrating the AD FS Federation Server](migrate-ad-fs-fed-server-r2.md)   
 [Migrating the AD FS Federation Server Proxy](migrate-fed-server-proxy-r2.md)   
 [Verifying the AD FS Migration to Windows Server 2012 R2](verify-ad-fs-migration.md)