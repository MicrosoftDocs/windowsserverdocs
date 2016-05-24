---
title: Join a Computer to a Domain
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c7593b62-e8f3-46a6-8560-d305cac134e5
author: billmath
---
# Join a Computer to a Domain
For [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)] to function, each computer that functions as a [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] must be joined to a domain. [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] proxies may be joined to a domain, but this is not a requirement.  
  
You do not have to join a Web server to a domain if the Web server is hosting claims\-aware applications only.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To join a computer to a domain  
  
1.  [!INCLUDE[clickstart](../Token/clickstart_md.md)]**Control Panel**, and then press ENTER.  
  
2.  Navigate to **System and Security**, and then click **System**.  
  
3.  Under **Computer name, domain, and workgroup settings**, click **Change settings**.  
  
4.  On the **Computer Name** tab, click **Change**.  
  
5.  Under **Member of**, click **Domain**, type the name of the domain that this computer will join, and then click **OK**.  
  
6.  Click **OK**, and then restart the computer.  
  
## Additional references  
[Checklist: Setting Up a Federation Server](../Topic/Checklist--Setting-Up-a-Federation-Server.md)  
  
[Checklist: Setting Up a Federation Server Proxy](../Topic/Checklist--Setting-Up-a-Federation-Server-Proxy.md)  
  
