---
title: NPS CRL Check overview
description: This topic provides information about Certificate Revocation handling by NPS (Network Policy Server).
ms.topic: article
ms.assetid: 
ms.author: wscontent
author: marcussa
ms.date: 10/12/2023
ms.contributor: marcussa
---

# NPS CRL check overview  

> Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2

If a certificate based authentication method, like EAP-TLS or PEAP-TLS, is used the client sends certificates to the NPS (Network Policy Server). By default, the Network Policy Server (NPS) checks the revocation status for all certificates in the certificate chain. If the certificate revocation check fails for **any** of the certificates in the chain, the connection attempt is denied. A CA (Certificate Authority) publishes the information about revoked certificates in a CRL (Certificate Revocation List).  

The behaviour of the certificate revocation check on NPS can be modified with registry settings. For more information, see [NPS CRL Check Registry Settings](nps-crl-check-registry-settings.md).

Certificate revocation checking can prevent client access if the CRL for any certificate in the certificate chain has expired or is unavailable. Avoid that by designing your public key infrastructure (PKI) for high availability of CRLs. For example, configure multiple CRL distribution points for each CA in the certificate hierarchy and configure publication schedules that ensure that the most current CRL is always available.

Certificate revocation checking is only as accurate as the CRL on the NPS. CRLs are
- published by the CA based on a schedule that can be configured and
- cached on a NPS server for the time they are valid.

If a certificate gets revoked, the new CRL, containing the newly revoked certificate, is not automatically published. Also, the CRL on the NPS server is not updated as long as the cached CRL is valid.  
The revoked certificate can still be used to authenticate until the new CRL is published by the CA and updated on the NPS.

To prevent this from occurring, the network administrator must manually publish the updated CRL and manually update the CRL on the NPS Server.  
Ask your PKI administrator for how to publish the new CRL.  
Run these commands in an elevated command prompt (CMD) to manually update the CRL on your NPS server:  

```
certutil -urlcache * delete
certutil -setreg chain\ChainCacheResyncFiletime @now
```

> [!Important]
> When using certificates for computer or user authentication, ensure that the CRLs are published in a primary and at least one secondary location that are accessible by all computers, especially all NPS and other RADIUS servers. If the NPS servers attempts to perform CRL validation of user or computer certificates, but cannot locate the CRLs, the NPS server rejects all certificate-based connection attempts and authentication fails.

The certificate revocation check for a certificate can fail for the following reasons:

- The certificate has been revoked.  
  
- The CRL for the certificate cannot be reached or is not available.
  CAs maintain CRLs and publish them to CRL distribution points (CDP). The CDPs are included in the 'CRL Distribution Points' property of the certificate.
  If the CDPs cannot be contacted the certificate revocation check fails, the access request is denied.
  If there are no CDPs in the certificate the certificate revocation check fails, the access request is denied.

- The publisher of the CRL did not issue the certificate.
  Included in the CRL is the publishing CA. If the publishing CA of the CRL does not match the issuing CA for the certificate being checked, the certificate revocation check fails, the access request is denied.

- The CRL is not current.
  A CRL is only valid for a limited time. If the CRL is expired, the CRL is considered invalid and the certificate revocation check fails, the access request is denied.
  New CRLs must be published before the expiration date of the last published CRL.
