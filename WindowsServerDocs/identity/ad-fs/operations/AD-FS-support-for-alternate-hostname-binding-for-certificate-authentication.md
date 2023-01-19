---
title: AD FS support for alternate hostname binding for certificate authentication
description: Learn more about: AD FS support for alternate hostname binding for certificate authentication.
ms.topic: article
author: billmath
ms.author: billmath
ms.date: 01/03/2023

---
# AD FS support for alternate hostname binding for certificate authentication

Applies to: Windows Server 2016 and later

On many networks the local firewall policies may not allow traffic through non-standard ports like 49443. This was an issue when trying to accomplish certificate authentication with AD FS prior to Windows Server 2016 because different bindings for device authentication and user certificate authentication on the same host is not possible in earlier versions. Prior to Windows Server 2016, default port 443 is bound to receive device certificates and cannot be altered to support multiple binding in the same channel. Smart card authentication does not work and there is no notification to users explaining the cause.

## AD FS in Windows Server 2016 supports alternate host name binding.

AD FS in Windows Server 2016 provides support for alternate host name binding. Two modes are supported. The first mode uses the same host (that is, adfs.contoso.com) with different ports (443, 49443). The second mode uses different hosts (adfs.contoso.com and certauth.adfs.contoso.com) with the same port (443). This will require an SSL certificate to support "certauth.\<adfs-service-name>" as an alternate subject name. This can be done at the time of the farm creation or later via PowerShell.

## How to configure alternate host name binding for certificate authentication

There are two ways you can add the alternate host name binding for certificate authentication. 

- When setting up a new AD FS farm with AD FS for Windows Server 2016, if the certificate contains a subject alternative name (SAN), it will automatically be setup to use the second mode mentioned in the preceding section. That is, it will automatically setup two different hosts (sts.contoso.com and certauth.sts.contoso.com) with the same port. 

If the certificate does not contain a SAN, then you will see a warning telling you that certificate subject alternative names does not support certauth.*. See the following screenshots. The first screenshot shows an installation where the certificate contains a SAN. The second screenshot shows a certificate that didn't contain a SAN.

![Screenshot that shows an installation where the certificate contains a SAN.](media/AD-FS-support-for-alternate-hostname-binding-for-certificate-authentication/ADFS_CA_1.png)

![Screenshot that shows a certificate that doesn't contain a SAN.](media/AD-FS-support-for-alternate-hostname-binding-for-certificate-authentication/ADFS_CA_2.png)

- After AD FS in Windows Server 2016 has been deployed you can use the PowerShell cmdlet: Set-AdfsAlternateTlsClientBinding to add the alternate host name binding for certificate authentication.

```powershell
Set-AdfsAlternateTlsClientBinding -Member ADFS1.contoso.com -Thumbprint '<thumbprint of cert>'
```

When prompted, select Yes to confirm.

![alternate hostname binding](media/AD-FS-support-for-alternate-hostname-binding-for-certificate-authentication/ADFS_CA_3.png)

## Related links

* [Managing SSL Certificates in AD FS and WAP in Windows Server 2016](./manage-ssl-certificates-ad-fs-wap.md)