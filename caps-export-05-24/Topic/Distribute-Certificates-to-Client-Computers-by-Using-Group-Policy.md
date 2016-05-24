---
title: Distribute Certificates to Client Computers by Using Group Policy
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9e490186-2a3f-444b-aeec-6f75d4346226
author: billmath
---
# Distribute Certificates to Client Computers by Using Group Policy
You can use the following procedure to push down the appropriate Secure Sockets Layer \(SSL\) certificates \(or equivalent certificates that chain to a trusted root\) for account [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)]s, resource [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)]s, and Web servers to each client computer in the account partner forest by using Group Policy.  
  
Membership in **Domain Admins** or **Enterprise Admins**, or equivalent, in Active Directory Domain Services \(AD DS\) is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To distribute certificates to client computers by using Group Policy  
  
1.  On a domain controller in the forest of the account partner organization, start the **Group Policy Management** snap\-in.  
  
2.  Find an existing Group Policy Object \(GPO\) or create a new GPO to contain the certificate settings. Ensure that the GPO is associated with the domain, site, or organizational unit \(OU\) where the appropriate user and computer accounts reside.  
  
3.  Right\-click the GPO, and then click **Edit**.  
  
4.  In the console tree, open **Computer Configuration\\Policies\\Windows Settings\\Security Settings\\Public Key Policies**, right\-click **Trusted Root Certification Authorities**, and then click **Import**.  
  
5.  On the **Welcome to the Certificate Import Wizard** page, click **Next**.  
  
6.  On the **File to Import** page, type the path to the appropriate certificate files \(for example, \\\\fs1\\c$\\fs1.cer\), and then click **Next**.  
  
7.  On the **Certificate Store** page, click **Place all certificates in the following store**, and then click **Next**.  
  
8.  On the **Completing the Certificate Import Wizard** page, verify that the information you provided is accurate, and then click **Finish**.  
  
9. Repeat steps 2 through 6 to add additional certificates for each of the federation servers in the farm.  
  
