---
ms.assetid: 3095e6a7-b562-4c6a-bf29-13b32c133cac
title: Enroll an SSL Certificate for AD FS
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---

# Enroll an SSL Certificate for AD FS

Active Directory Federation Services \(AD FS\) requires a certificate for Secure Socket Layer \(SSL\) server authentication on each federation server in your federation server farm. The same certificate can be used on each federation server in a farm. You must have both the certificate and its private key available. For example, if you have the certificate and its private key in a .pfx file, you can import the file directly into the Active Directory Federation Services Configuration Wizard. This SSL certificate must contain the following:  
  
1.  The subject name and subject alternative name must contain your federation service name, such as fs.contoso.com.  
  
2.  The subject alternative name must contain the value **enterpriseregistration** that is followed by the User Principal Name \(UPN\) suffix of your organization, for example, **enterpriseregistration.corp.contoso.com**.  
  
    > [!WARNING]  
    > Specify the subject alternative name if you plan to enable the Device Registration Service \(DRS\) for Workplace Join.  
  
> [!IMPORTANT]  
> If your organization uses multiple UPN suffixes, and you plan to enable the DRS, the SSL certificate must contain a subject alternative name entry for each suffix.  
  
## See Also
[AD FS Deployment](../../ad-fs/AD-FS-Deployment.md)  

[Windows Server 2012 R2 AD FS Deployment Guide](../../ad-fs/deployment/Windows-Server-2012-R2-AD-FS-Deployment-Guide.md)  
 
[Deploying a Federation Server Farm](../../ad-fs/deployment/Deploying-a-Federation-Server-Farm.md)  
  
  

