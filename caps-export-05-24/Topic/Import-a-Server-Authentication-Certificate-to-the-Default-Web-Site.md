---
title: Import a Server Authentication Certificate to the Default Web Site
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 60db14a3-a3eb-451a-9e95-2fe6066defc2
author: billmath
---
# Import a Server Authentication Certificate to the Default Web Site
After you obtain a server authentication certificate from a certification authority \(CA\), you must manually install that certificate on the Default Web Site for each [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] or [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)] in a server farm.  
  
For Web servers, you must manually install the server authentication certificate on the appropriate Web site or virtual directory where your federated application resides.  
  
If you are setting up a farm, be sure to perform this procedure identically—using the exact same settings—on each of the servers in your farm.  
  
> [!NOTE]  
> The [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] Management snap\-in refers to server authentication certificates for federation servers as service communication certificates.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To import a server authentication certificate to the Default Web Site  
  
1.  [!INCLUDE[clickstart](../Token/clickstart_md.md)]**Internet Information Services \(IIS\) Manager**, and then press ENTER.  
  
2.  In the console tree, click **ComputerName**.  
  
3.  In the center pane, double\-click **Server Certificates**.  
  
4.  In the **Actions** pane, click **Import**.  
  
5.  In the **Import Certificate** dialog box, click the **…** button.  
  
6.  Browse to the location of the pfx certificate file, highlight it, and then click **Open**.  
  
7.  Type a password for the certificate, and then click **OK**.  
  
## Additional references  
[Checklist: Setting Up a Federation Server](../Topic/Checklist--Setting-Up-a-Federation-Server.md)  
  
[Checklist: Setting Up a Federation Server Proxy](../Topic/Checklist--Setting-Up-a-Federation-Server-Proxy.md)  
  
[Certificate Requirements for Federation Servers](../Topic/Certificate-Requirements-for-Federation-Servers.md)  
  
[Certificate Requirements for Federation Server Proxies](../Topic/Certificate-Requirements-for-Federation-Server-Proxies.md)  
  
