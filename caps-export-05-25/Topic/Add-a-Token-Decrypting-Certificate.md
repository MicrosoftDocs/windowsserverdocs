---
title: Add a Token-Decrypting Certificate
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e49f6f23-7b26-4ad6-8c58-9f4b2503661e
author: billmath
---
# Add a Token-Decrypting Certificate
Federation servers use a token\-decryption certificate when a relying party [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] must decrypt tokens that are issued with an older certificate after a new certificate is set as the primary decryption certificate. [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)] uses the Secure Sockets Layer \(SSL\) certificate for Internet Information Services \(IIS\) as the default decryption certificate.  
  
> [!CAUTION]  
> Certificates used for token\-decrypting are critical to the stability of the Federation Service. Because loss or unplanned removal of any certificates configured for this purpose can disrupt service, you should backup any certificates configured for this purpose.  
  
You can use the following procedure to add the token\-decrypting certificate to the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] Management snap\-in from a file that you have exported.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To add a token\-decrypting certificate  
  
1.  [!INCLUDE[clickstart](../Token/clickstart_md.md)]**AD FS Management**, and then press ENTER.  
  
2.  In the console tree, double\-click **Service**, and then click **Certificates**.  
  
3.  In the **Actions** pane, click the **Add Token\-Decrypting Certificate** link.  
  
4.  In the **Browse for Certificate file** dialog box, navigate to the certificate file that you want to add, select the certificate file, and then click **Open**.  
  
## Additional references  
[Checklist: Setting Up a Federation Server](../Topic/Checklist--Setting-Up-a-Federation-Server.md)  
  
[Certificate Requirements for Federation Servers](../Topic/Certificate-Requirements-for-Federation-Servers.md)  
  
