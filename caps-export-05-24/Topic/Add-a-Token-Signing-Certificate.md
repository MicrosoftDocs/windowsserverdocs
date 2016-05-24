---
title: Add a Token-Signing Certificate
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 29b0ce70-638c-473b-ab2a-7997152df4f7
author: billmath
---
# Add a Token-Signing Certificate
Federation servers in [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)] require token\-signing certificates to prevent attackers from altering or counterfeiting security tokens in an attempt to gain unauthorized access to federated resources. Every token\-signing certificate contains cryptographic private keys and public keys that are used to digitally sign \(by means of the private key\) a security token. Later, after these keys are received by a partner [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)], they validate the authenticity \(by means of the public key\) of the encrypted security token.  
  
> [!CAUTION]  
> Certificates used for token\-signing are critical to the stability of the Federation Service. Because loss or unplanned removal of any certificates configured for this purpose can disrupt service, you should backup any certificates configured for this purpose.  
  
The token\-signing certificate should chain to a trusted root in the Federation Service. You can use the following procedure to add the token\-signing certificate to the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] Management snap\-in from a file that you have exported.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To add a token\-signing certificate  
  
1.  [!INCLUDE[clickstart](../Token/clickstart_md.md)]**AD FS Management**, and then press ENTER.  
  
2.  In the console tree, double\-click **Service**, and then click **Certificates**.  
  
3.  In the **Actions** pane, click the **Add Token\-Signing Certificate** link.  
  
4.  In the **Browse for Certificate file** dialog box, navigate to the certificate file that you want to add, select the certificate file, and then click **Open**.  
  
## Additional references  
[Checklist: Setting Up a Federation Server](../Topic/Checklist--Setting-Up-a-Federation-Server.md)  
  
[Certificate Requirements for Federation Servers](../Topic/Certificate-Requirements-for-Federation-Servers.md)  
  
