---
title: AD FS support for alternate hostname binding for certificate authentication
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.service: active-directory
ms.suite: na
ms.technology: 
  - active-directory-domain-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c253e60c-f335-42ad-a0cb-fc2796a3196b
---
# AD FS support for alternate hostname binding for certificate authentication
On many networks the local firewall policies might not allow traffic through non\-standard ports like 49443.   This became an issue with trying to accomplish certificate authentication with AD FS prior to AD FS in Windows Server 2016.  This is because you could not have different bindings for device authentication and user certificate authentication on the same host.  The default port 443 is bound to receive device certificates and cannot be altered to support multiple binding in the same channel.  The results were that smart card authentication would not work and users were unaware of what happened since there is no indication of what really happened.

With AD FS in Windows Server 2016 this can be accomplished

In AD FS on Windows Server 2016 this has changed. Now we support two modes, the first uses the same host \(i.e. adfs.contoso.com\) with different ports \(443, 49443\). The second used different hosts \(adfs.contoso.com and certauth.adfs.contoso.com\) with the same port \(443\). This will require an SSL certificate to support "certauth.<adfs\-service\-name>" as an alternate subject name. This can be done at the time of the farm creation of later via PowerShell.

## How to configure alternate host name binding for certificate authentication
There are two ways that you can add the alternate host name binding for certificate authentication.  The first is when setting up a new AD FS farm with AD FS for Windows Server 2016, if the certificate contains a subject alternative name \(SAN\), then it will automatically be setup to use the second method mentioned above.  That is, it will automatically setup two different hosts \(sts.contoso.com and certauth.sts.contoso.com with the same port.  If the  certificate does not contain a SAN, then you will see a warning telling you that certificate subject alternative names does not support certauth.\*.  See the screenshots below.  The first one shows an installation where the certificate had a SAN and the second one shows a certificate that did not.

![](media/ADFS_CA_1.png)

![](media/ADFS_CA_2.png)

Likewise, once AD FS in Windows Server 2016 has been depoloyed you can use the PowerShell cmdlt:  Set\-AdfsAlternateTlsClientBinding.

```
Set-AdfsAlternateTlsClientBinding -Member DC1.contoso.com -Thumbprint c67e1ffba186d70c7e00c89596e0cb5645f9874a
```

When prompted, click Yes to confirm.  And that should  be it.

![](media/ADFS_CA_3.png)


