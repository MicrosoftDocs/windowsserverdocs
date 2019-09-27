---
title: Migrate the AD FS 2.0 federation server
description: Provides information on migrating an AD FS server to Windows Server 2012 R2.
author: billmath
ms.author: billmath
manager: femila
ms.date: 07/10/2017
ms.topic: article
ms.prod: windows-server
ms.technology: identity-adfs
---

# Verify the AD FS 2.0 migration to Windows Server 2012 R2

Once you complete the same server migration of your Active Directory Federation Service (AD FS) farm to Windows Server 2012 R2, you can use the following procedure to verify that federation servers in your farm are operational; that is, that any client on the same network can reach your federtation servers.  
  
Membership in **Users**, **Backup Operators**, **Power Users**, **Administrators** or equivalent, on the local computer is the minimum required to complete this procedure.
  
### To verify that a federation server is operational  
  
1.  Open a browser window and in the address bar, type the federation servers name, and then append it with `federationmetadata/2007-06/federationmetadata.xml` to browse to the federation service metadata endpoint. For example, `https://fs.contoso.com/federationmetadata/2007-06/federationmetadata.xml` .  
  
If in your browser window you can see the federation server metadata without any SSL errors or warnings, your federation server is operational.  
  
2. You can also browse to the AD FS sign-in page (your federation service name appended with `adfs/ls/idpinitiatedsignon.htm`, for example, `https://fs.contoso.com/adfs/ls/idpinitiatedsignon.htm`).  This displays the AD FS sign-in page where you can sign in with domain administrator credentials.  
  
> [!IMPORTANT]
>  Make sure to configure your browser settings to trust the federation server role by adding your federation service name (for example, `https://fs.contoso.com`) to the browser's local intranet zone.  
  
## Next Steps
 [Migrate Active Directory Federation Services Role Services to Windows Server 2012 R2](migrate-ad-fs-service-role-to-windows-server-r2.md)   
 [Preparing to Migrate the AD FS Federation Server](prepare-migrate-ad-fs-server-r2.md)  
 [Migrating the AD FS Federation Server](migrate-ad-fs-fed-server-r2.md)   
 [Migrating the AD FS Federation Server Proxy](migrate-fed-server-proxy-r2.md)   
