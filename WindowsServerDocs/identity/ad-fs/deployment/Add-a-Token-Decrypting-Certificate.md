---
ms.assetid: 27e1e299-0beb-4e86-8143-1ba031dc3502
title: Add a Token-Decrypting Certificate
description:
author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adfs
ms.author: billmath
---

# Add a Token-Decrypting Certificate

Federation servers use a token\-decryption certificate when a relying party federation server must decrypt tokens that are issued with an older certificate after a new certificate is set as the primary decryption certificate. Active Directory Federation Services \(AD FS\) uses the Secure Sockets Layer \(SSL\) certificate for Internet Information Services \(IIS\) as the default decryption certificate.  
  
> [!CAUTION]  
> Certificates used for token\-decrypting are critical to the stability of the Federation Service. Because loss or unplanned removal of any certificates configured for this purpose can disrupt service, you should backup any certificates configured for this purpose.  
  
You can use the following procedure to add the token\-decrypting certificate to the AD FS Management snap\-in from a file that you have exported.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure.  Review details about using the appropriate accounts and group memberships at [Local and Domain Default Groups](https://go.microsoft.com/fwlink/?LinkId=83477) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=83477\).   
  
### To add a token\-decrypting certificate  
  
1.  On the **Start** screen, type**AD FS Management**, and then press ENTER.  
  
2.  In the console tree, double\-click **Service**, and then click **Certificates**.  
  
3.  In the **Actions** pane, click the **Add Token\-Decrypting Certificate** link.  
  
4.  In the **Browse for Certificate file** dialog box, navigate to the certificate file that you want to add, select the certificate file, and then click **Open**.  
  
## Additional references  
[Checklist: Setting Up a Federation Server](Checklist--Setting-Up-a-Federation-Server.md)  
  
[Certificate Requirements for Federation Servers](https://technet.microsoft.com/library/dd807040.aspx)  
  

