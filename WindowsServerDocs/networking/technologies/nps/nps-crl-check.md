---
title: NPS CRL Check Registry Settings
description: This topic provides information about configuring Certificate Revocation List settings for EAP-TLS authentication on a Network Policy Server.
ms.topic: article
ms.assetid: 
ms.author: wscontent
author: marcussa
ms.date: 10/12/2023
ms.contributor: marcussa
---

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2

# NPS CRL checks  

By default, the server running Network Policy Server (NPS) checks for certificate revocation for all of the certificates in the certificate chain sent by the client computer during the EAP-TLS and PEAP-TLS authentication process. If certificate revocation fails for any of the certificates in the chain, the connection attempt is not authenticated and is denied.

Certificate revocation checking behavior for NPS can be modified with registry settings. For more information, see [NPS CRL Check Registry Settings](nps-crl-check-registry-settings.md).

Because certificate revocation checking can prevent client access due to the unavailability or expiration of certificate revocation lists (CRLs) for each certificate in the certificate chain, design your public key infrastructure (PKI) for high availability of CRLs. For example, configure multiple CRL distribution points for each certification authority (CA) in the certificate hierarchy and configure publication schedules that ensure that the most current CRL is always available.

Certificate revocation checking is only as accurate as the last published CRL. For example, if a certificate is revoked, by default the new CRL containing the newly revoked certificate is not automatically published. CRLs are typically published based on a schedule that can be configured. This means that the revoked certificate can still be used to authenticate because the published CRL is not current; it does not contain the revoked certificate and can therefore still be used to create wireless connections. To prevent this from occurring, the network administrator must manually publish the new CRL with the newly revoked certificate.

By default, the NPS server uses the CRL distribution points in the certificates. However, it is also possible to store a local copy of the CRL on the NPS server. In this case, the local CRL is used during certificate revocation checking. If a new CRL is manually published to Active Directory® Domain Services (AD DS), the local CRL on the NPS server is not updated. The local CRL is updated when it expires. This can create a situation wherein a certificate is revoked, the CRL is manually published, but the NPS server still allows the connection because the local CRL has not yet been updated.

> [!Important]
> When using certificates for computer-level or user-level network access authentication, ensure that the CRLs are published in a primary and at least one secondary location that are accessible by all computers, especially all NPS and other RADIUS servers. If the NPS-RADIUS servers attempt to perform CRL validation of the user or computer certificate, but cannot locate the CRLs, the NPS RADIUS servers reject all certificate-based connection attempts and authentication fails.

The certificate revocation check for a certificate can fail for the following reasons.

- The certificate has been revoked.  
  
- The CRL for the certificate cannot be reached or is not available.
  CAs maintain CRLs and publish them to CRL distribution points. The CRL distribution points are included in the CRL Distribution Points property of the certificate. If the CRL distribution points cannot be contacted to check for certificate revocation, then the certificate revocation check fails.
  Additionally, if there are no CRL distribution points in the certificate, the NPS server cannot verify that the certificate has not been revoked and the certificate revocation check fails.

- The publisher of the CRL did not issue the certificate.
  Included in the CRL is the publishing CA. If the publishing CA of the CRL does not match the issuing CA for the certificate for which certificate revocation is being checked, then the certificate revocation check fails.

- The CRL is not current.
  Each published CRL has a range of valid dates. If the CRL Next update date has passed, the CRL is considered invalid and the certificate revocation check fails. New CRLs should be published before the expiration date of the last published CRL.
