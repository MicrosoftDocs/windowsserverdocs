---
title: Migrate the AD FS 2.0 federation proxy server
description: Provides information on migrating an AD FS proxy server to Windows Server 2012 R2.
author: billmath
ms.author: billmath
manager: femila
ms.date: 07/10/2017
ms.topic: article
ms.prod: windows-server
ms.technology: identity-adfs
---

# Migrate the Active Directory Federation Services Proxy Server to Windows Server 2012 R2

In Active Directory Federation Services (AD FS) in Windows Server 2012 R2, the role of a federation server proxy is handled by a new Remote Access role service called Web Application Proxy. In Windows Server 2012 R2, to enable your AD FS for accessibility from outside of the corporate network, you can deploy one or more Web Application Proxies. However, you cannot migrate a federation server proxy running on Windows Server 2008 R2 or Windows Server 2012 to a Web Application Proxy running on Windows Server 2012 R2.  
  
> [!IMPORTANT]
>  The migration of a federation server proxy running on Windows Server 2008, Windows Server 2008 R2, or Windows Server 2012 to a Web Application Proxy running on Windows Server 2012 R2 is NOT supported.  
  
If you want to configure AD FS in a Windows Server 2012 R2 migrated farm for extranet access, you must perform a fresh deployment of one or more Web Application Proxy computers as part of your AD FS infrastructure.  
  
To plan Web Application Proxy deployment, you can review the information in the following topics:  
  
- [Plan the Web Application Proxy Infrastructure](https://technet.microsoft.com/library/dn383648.aspx)  
  
- [Plan the Web Application Proxy Server](https://technet.microsoft.com/library/dn383647.aspx)  
  
  To deploy Web Application proxy, you can follow the procedures in the following topics:  
  
- [Configure the Web Application Proxy Infrastructure](https://technet.microsoft.com/library/dn383644.aspx)  
  
- [Install and Configure the Web Application Proxy Server](https://technet.microsoft.com/library/dn383662.aspx)  
  
## Next Steps
 [Migrate Active Directory Federation Services Role Services to Windows Server 2012 R2](migrate-ad-fs-service-role-to-windows-server-r2.md)   
 [Preparing to Migrate the AD FS Federation Server](prepare-migrate-ad-fs-server-r2.md)   
 [Migrating the AD FS Federation Server](migrate-ad-fs-fed-server-r2.md)    
 [Verifying the AD FS Migration to Windows Server 2012 R2](verify-ad-fs-migration.md)

