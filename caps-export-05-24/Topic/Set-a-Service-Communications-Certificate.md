---
title: Set a Service Communications Certificate
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 45c9a72a-5288-42b8-9080-4ce90c75530d
author: billmath
---
# Set a Service Communications Certificate
Federation servers in [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)] use the service communications certificate to secure Web services traffic for Secure Sockets Layer \(SSL\) communication with Web clients or with [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] proxies. This is the same certificate that a [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] uses as the SSL certificate in Internet Information Services \(IIS\).  
  
You can use the following procedure to change the service communications certificate with the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] Management snap\-in.  
  
> [!NOTE]  
> The [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] Management snap\-in refers to server authentication certificates for [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)]s as service communication certificates.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To set a service communications certificate  
  
1.  [!INCLUDE[clickstart](../Token/clickstart_md.md)]**AD FS Management**, and then press ENTER.  
  
2.  In the console tree, double\-click **Service**, and then click **Certificates**.  
  
3.  In the **Actions** pane, click the **Set Service Communications Certificate** link.  
  
4.  In the **Select a service communications certificate** dialog box, navigate to the certificate file that you want to set as the service communications certificate, select the certificate file, and then click **Open**.  
  
## Additional references  
[Checklist: Setting Up a Federation Server](../Topic/Checklist--Setting-Up-a-Federation-Server.md)  
  
[Certificate Requirements for Federation Servers](../Topic/Certificate-Requirements-for-Federation-Servers.md)  
  
