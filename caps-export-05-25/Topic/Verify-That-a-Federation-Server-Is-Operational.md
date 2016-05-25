---
title: Verify That a Federation Server Is Operational
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: baa1cdc7-6e26-4c37-b82f-6a0189a13aec
author: billmath
---
# Verify That a Federation Server Is Operational
You can use the following procedure to verify that a [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] is operational; that is, that any client on the same network can reach your [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)].  
  
Membership in **Users**, **Backup Operators**, **Power Users**, **Administrators**, or equivalent on the local computer is the minimum requirement to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To verify that a federation server is operational  
  
1.  Open a browser window and in the address bar, type the [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] name, and then append it with **federationmetadata\/2007\-06\/federationmetadata.xml** to browse to the federation service metadata endpoint. For example, **https:\/\/fs.contoso.com\/federationmetadata\/2007\-06\/federationmetadata.xml**.  
  
    In your browser window, if you can see the federation server metadata without any Secure Socket Layer \(SSL\) errors or warnings, your federation server is operational.  
  
2.  You can also browse to the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] sign\-in page where your federation service name is appended with **adfs\/ls\/idpinitiatedsignon.htm**, for example, **https:\/\/fs.contoso.com\/adfs\/ls\/idpinitiatedsignon.htm**. This entry displays the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] sign\-in page where you can sign in by using domain administrator credentials.  
  
    > [!IMPORTANT]  
    > Ensure to configure your browser settings to trust the federation server role by adding your federation service name, for example, **https:\/\/fs.contoso.com**, to the browser’s local intranet zone.  
  
## See Also  
[Deploying a Federation Server Farm](../Topic/Deploying-a-Federation-Server-Farm.md)  
  
