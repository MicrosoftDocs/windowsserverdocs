---
title: Migrate Active Directory Federation Services Role Services to Windows Server 2012
description: Provides instructions for migrating the AD FS service to Windows Server 2012.
author: billmath
ms.author: billmath
manager: femila
ms.date: 06/28/2017
ms.topic: article
ms.prod: windows-server
ms.technology: identity-adfs
---

# Migrate Active Directory Federation Services Role Services to Windows Server 2012

The following provides instructions on migrating the following role services to Active Directory Federation Services (AD FS) on Windows Server 2012:  
  
-   AD FS 1.1 Windows token-based agent and AD FS 1.1 claims-aware agent installed with Windows Server 2008 or Windows Server 2008 R2  
  
-   AD FS 2.0 federation server and AD FS 2.0 federation server proxy installed on Windows Server 2008 or Windows Server 2008 R2    
  
## Supported migration scenarios  
 The migration instructions contains the following tasks:  
  
- Exporting the AD FS 2.0 configuration data from your server that is running Windows Server 2008 or Windows Server 2008 R2  
  
- Performing an in-place upgrade of the operating system of this server from Windows Server 2008 or Windows Server 2008 R2 to Windows Server 2012.
  
- Recreating the original AD FS configuration and restoring the remaining AD FS service settings on this server, which is now running the AD FS server role that is installed with Windows Server 2012.  
  
  This guide does not include instructions to migrate a server that is running multiple roles. If your server is running multiple roles, we recommend that you design a custom migration process specific to your server environment, based on the information provided in other role migration guides. Migration guides for additional roles are available on the [Windows Server Migration Portal](https://go.microsoft.com/fwlink/?LinkId=247608).  
  
## Supported operating systems  
 **Destination server operating system:**  
  

- Windows Server 2012 or Windows Server 2008 R2 (Server Core and full installation options)  
  
  **Destination server processor:**  
  

- x64-based  
  
|Source server processor|Source server operating system|  
|-----|-----|  
|x86- or x64-based|Windows Server 2003 with Service Pack 2|  
|x86- or x64-based|Windows Server 2003 R2|  
|x86- or x64-based|Windows Server 2008, both full and Server Core installation options|  
|x64-based|Windows Server 2008 R2|  
|x64-based|Server Core installation option of Windows Server 2008 R2|  
|x64-based|Server Core and full installation options of Windows Server 2012|  
  
> [!NOTE]
> - The versions of operating systems that are listed in the preceding table are the oldest combinations of operating systems and service packs that are supported.  
>   -   The Foundation, Standard, Enterprise, and Datacenter editions of the Windows Server operating system are supported as the source or the destination server.  
>   -   Migrations between physical operating systems and virtual operating systems are supported.  
  
### Supported AD FS role services and features  
 The following table describes the migration scenarios of the AD FS role services and their respective settings that are described in this guide.  
  
|From|To AD FS installed with Windows Server 2012|  
|----------|-----|  
|AD FS 1.0 federation server installed with Windows Server 2003 R2|Migration is not supported|  
|AD FS 1.0 federation server proxy installed with Windows Server 2003 R2|Migration is not supported|  
|AD FS 1.0 Windows token-based agent installed with Windows Server 2003 R2|Migration is not supported|  
|AD FS 1.0 claims-aware agent installed with Windows Server 2003 R2)|Migration is not supported|  
|AD FS 1.1 federation server installed with Windows Server 2008 or Windows Server 2008 R2|Migration is not supported|  
|AD FS 1.1 federation server proxy installed with Windows Server 2008 or Windows Server 2008 R2|Migration is not supported|  
|AD FS 1.1 Windows token-based agent installed with Windows Server 2008 or Windows Server 2008 R2|Migration on the same server is supported, but the migrated AD FS Windows token-based agent will function only with an AD FS 1.1 federation service installed with Windows Server 2008 or Windows Server 2008 R2. For more information, see:<br /><br /> [Migrate the AD FS 1.1 Web Agents](migrate-the-ad-fs-web-agent.md)<br /><br /> [Interoperating with AD FS 1.x](Interoperating-with-AD-FS-1.x.md)|  
|AD FS 1.1 claims-aware agent installed with Windows Server 2008 or Windows Server 2008 R2)|Migration on the same server is supported. The migrated AD FS 1.1 claims-aware web agent will function with the following:<br /><br /> AD FS 1.1 federation service installed with Windows Server 2008 or Windows Server 2008 R2<br /><br /> AD FS 2.0 federation service installed on Windows Server 2008 or Windows Server 2008 R2<br /><br /> AD FS federation service installed with Windows Server 2012<br /><br /> For more information, see:<br /><br /> [Migrate the AD FS 1.1 Web Agents](migrate-the-ad-fs-web-agent.md)<br /><br /> [Interoperating with AD FS 1.x](Interoperating-with-AD-FS-1.x.md)|  
|AD FS 2.0 federation server installed on Windows Server 2008 or Windows Server 2008 R2|Migration on the same server is supported. For more information, see:<br /><br /> [Prepare to Migrate the AD FS 2.0 Federation Server](prepare-to-migrate-ad-fs-fed-server.md)<br /><br /> [Migrate the AD FS 2.0 Federation Server](migrate-the-ad-fs-fed-server.md)|  
|AD FS 2.0 federation server proxy installed on Windows Server 2008 or Windows Server 2008 R2|Migration on the same server is supported.  For more information see:<br /><br /> [Prepare to Migrate the AD FS 2.0 Federation Server Proxy](prepare-to-migrate-ad-fs-fed-proxy.md)<br /><br /> [Migrate the AD FS 2.0 Federation Server Proxy](migrate-the-ad-fs-2-fed-server-proxy.md)|  
  
## See Also  
 [Prepare to Migrate the AD FS 2.0 Federation Server](prepare-to-migrate-ad-fs-fed-server.md)   
 [Prepare to Migrate the AD FS 2.0 Federation Server Proxy](prepare-to-migrate-ad-fs-fed-proxy.md)   
 [Migrate the AD FS 2.0 Federation Server](migrate-the-ad-fs-fed-server.md)   
 [Migrate the AD FS 2.0 Federation Server Proxy](migrate-the-ad-fs-2-fed-server-proxy.md)   
 [Migrate the AD FS 1.1 Web Agents](migrate-the-ad-fs-web-agent.md)