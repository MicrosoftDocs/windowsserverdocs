---
title: Enroll an SSL Certificate for AD FS
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: 359b6b3e-29ef-4c65-a9dd-3733ef974387
author: billmath
---
# Enroll an SSL Certificate for AD FS
[!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)] requires a certificate for Secure Socket Layer \(SSL\) server authentication on each federation server in your federation server farm. The same certificate can be used on each federation server in a farm. You must have both the certificate and its private key available. For example, if you have the certificate and its private key in a .pfx file, you can import the file directly into the Active Directory Federation Services Configuration Wizard. This SSL certificate must contain the following:  
  
1.  The subject name and subject alternative name must contain your federation service name, such as fs.contoso.com.  
  
2.  The subject alternative name must contain the value **enterpriseregistration** that is followed by the User Principal Name \(UPN\) suffix of your organization, for example, **enterpriseregistration.corp.contoso.com**.  
  
    > [!WARNING]  
    > Specify the subject alternative name if you plan to enable the Device Registration Service \(DRS\) for Workplace Join.  
  
> [!IMPORTANT]  
> If your organization uses multiple UPN suffixes, and you plan to enable the DRS, the SSL certificate must contain a subject alternative name entry for each suffix.  
  
## See Also  
[Deploying a Federation Server Farm](../Topic/Deploying-a-Federation-Server-Farm.md)  
  
