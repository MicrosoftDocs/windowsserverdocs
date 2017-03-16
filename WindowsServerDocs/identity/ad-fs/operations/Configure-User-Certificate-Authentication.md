---
ms.assetid: 1ea2e1be-874f-4df3-bc9a-eb215002da91
title: Configure AD FS support for user certificate authentication
description:
author: jenfieldmsft
ms.author: jfield
manager: samueld
ms.date: 12/5/2016
ms.topic: article
ms.prod: windows-server-threshold
ms.service: active-directory
ms.technology: identity-adfs
---
# Configuring AD FS for user certificate authentication

>Applies To: Windows Server 2016

AD FS can be configured for x509 user certificate authentication using one of the modes described in [this article](AD-FS-support-for-alternate-hostname-binding-for-certificate-authentication.md). This capability can be used [with Azure Active Directory](https://blogs.msdn.microsoft.com/samueld/2016/07/19/adfs-certauth-aad-o365/) or on its own, to enable clients and devices provisioned with user certificates to access AD FS resources from the intranet or the extranet.

## Prerequisites
- Ensure that your user certificates are trusted by all AD FS and WAP servers
- Ensure that the root certificate of the chain of trust for your user certificates is in the NTAuth store in Active Directory

## Configure AD FS for user certificate authentication  
- Enable Certificate Authentication in AD FS
- Ensure that the entire chain of trust, including any intermediate certificates, is installed on every AD FS and WAP server
To accomplish this, ensure the intermediate certs of the AD FS SSL cert are in the local computer intermediate certification authorities store on all AD FS and WAP servers.
- [Optional] Configure the Active Directory claims provider trust to pass certificate extension claims
- [Optional] Configure client certificate authentication issuer certificates on the AD FS and WAP servers

## Configure the web application proxy
- Configure pass through rules for access to certificate revocation information
-

## Troubleshooting

## Reference: Complete list of user certificate claim types

There are two ways that you can add the alternate host name binding for certificate authentication.  The first is when setting up a new AD FS farm with AD FS for Windows Server 2016, if the certificate contains a subject alternative name (SAN), then it will automatically be setup to use the second method mentioned above.  That is, it will automatically setup two different hosts (sts.contoso.com and certauth.sts.contoso.com with the same port.  If the  certificate does not contain a SAN, then you will see a warning telling you that certificate subject alternative names does not support certauth.*.  See the screenshots below.  The first one shows an installation where the certificate had a SAN and the second one shows a certificate that did not.  

![alternate hostname binding](media/AD-FS-support-for-alternate-hostname-binding-for-certificate-authentication/ADFS_CA_1.png)  

![alternate hostname binding](media/AD-FS-support-for-alternate-hostname-binding-for-certificate-authentication/ADFS_CA_2.png)  

Likewise, once AD FS in Windows Server 2016 has been depoloyed you can use the PowerShell cmdlt:  Set-AdfsAlternateTlsClientBinding.  

```  
Set-AdfsAlternateTlsClientBinding -Member DC1.contoso.com -Thumbprint c67e1ffba186d70c7e00c89596e0cb5645f9874a  
```  

When prompted, click Yes to confirm.  And that should  be it.  

![alternate hostname binding](media/AD-FS-support-for-alternate-hostname-binding-for-certificate-authentication/ADFS_CA_3.png)  
