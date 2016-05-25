---
title: Verifying the AD FS Migration to Windows Server 2012 R2
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e07e5978-34e1-4dbb-8d10-812d3ec229e9
author: Femila
---
# Verifying the AD FS Migration to Windows Server 2012 R2
Once you complete the same server migration of your Active Directory Federation Service \(AD FS\) farm to Windows Server 2012 R2, you can use the following procedure to verify that [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)]s in your farm are operational; that is, that any client on the same network can reach your [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)]s.  
  
Membership in **Users**, **Backup Operators**, **Power Users**, **Administrators** or equivalent, on the local computer is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To verify that a federation server is operational  
  
1.  Open a browser window and in the address bar, type the [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] name, and then append it with **federationmetadata\/2007\-06\/federationmetadata.xml** to browse to the federation service metadata endpoint. For example, **https:\/\/fs.contoso.com\/federationmetadata\/2007\-06\/federationmetadata.xml** .  
  
    If in your browser window you can see the federation server metadata without any SSL errors or warnings, your federation server is operational.  
  
2.  You can also browse to the AD FS sign\-in page \(your federation service name appended with **adfs\/ls\/idpinitiatedsignon.htm**, for example, **https:\/\/fs.contoso.com\/adfs\/ls\/idpinitiatedsignon.htm**\).  This displays the AD FS sign\-in page where you can sign in with domain administrator credentials.  
  
    > [!IMPORTANT]  
    > Make sure to configure your browser settings to trust the federation server role by adding your federation service name \(for example, **https:\/\/fs.contoso.com**\) to the browser’s local intranet zone.  
  
## See Also  
[Migrating Active Directory Federation Services Role Service to Windows Server 2012 R2](../Topic/Migrating-Active-Directory-Federation-Services-Role-Service-to-Windows-Server-2012-R2.md)  
  
