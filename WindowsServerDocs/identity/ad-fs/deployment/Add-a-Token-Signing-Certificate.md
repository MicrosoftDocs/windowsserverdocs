---
ms.assetid: bbb84ea6-7e31-4442-85ab-a9447e7c19e8
title: Add a Token-Signing Certificate
description:
author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adfs
ms.author: billmath
---

# Add a Token-Signing Certificate


Federation servers in Active Directory Federation Services \(AD FS\) require token\-signing certificates to prevent attackers from altering or counterfeiting security tokens in an attempt to gain unauthorized access to federated resources. Every token\-signing certificate contains cryptographic private keys and public keys that are used to digitally sign \(by means of the private key\) a security token. Later, after these keys are received by a partner federation server, they validate the authenticity \(by means of the public key\) of the encrypted security token.  
  
> [!CAUTION]  
> Certificates used for token\-signing are critical to the stability of the Federation Service. Because loss or unplanned removal of any certificates configured for this purpose can disrupt service, you should backup any certificates configured for this purpose.  
  
The token\-signing certificate should chain to a trusted root in the Federation Service. You can use the following procedure to add the token\-signing certificate to the AD FS Management snap\-in from a file that you have exported.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure.  Review details about using the appropriate accounts and group memberships at [Local and Domain Default Groups](https://go.microsoft.com/fwlink/?LinkId=83477) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=83477\).   
  
### To add a token\-signing certificate  
  
1.  On the **Start** screen, type**AD FS Management**, and then press ENTER.  
  
2.  In the console tree, double\-click **Service**, and then click **Certificates**.  
  
3.  In the **Actions** pane, click the **Add Token\-Signing Certificate** link.  
  
4.  In the **Browse for Certificate file** dialog box, navigate to the certificate file that you want to add, select the certificate file, and then click **Open**.  
  
## Additional references  
[Checklist: Setting Up a Federation Server](Checklist--Setting-Up-a-Federation-Server.md)  
  
[Certificate Requirements for Federation Servers](https://technet.microsoft.com/library/dd807040.aspx)  
  

