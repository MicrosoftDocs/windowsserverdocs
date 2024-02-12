---
title: AD FS troubleshooting - certificates
description: This article describes typical certificate problems.
ms.topic: article
author: billmath
ms.author: billmath
ms.date: 08/15/2023
---

# AD FS troubleshooting - certificates

Active Directory Federation Services (AD FS) requires specific certificates in order to work correctly. Problems can occur if any of these certificates aren't set up or configured properly.

## Required certificates

Each of the required AD FS certificates has its own requirements:

- **Federation trust**: Federation trust requires one of the following:
  - A certificate that's chained to a mutually trusted internet root certificate authority (CA) is present in the trusted root store of both the claims provider (CP) and relying party (RP) federation servers.
  - A cross-certification design was implemented, and each side exchanged its root CA with its partner.
  - Self-signed certificates were imported on each side where appropriate.
- **Token signing**: Each federation service computer requires a token-signing certificate. The CP token-signing certificate must be trusted by the RP federation server. The RP token-signing certificate must be trusted by all applications that receive tokens from the RP federation server.
- **Secure Sockets Layer (SSL)**: The SSL certificate for the federation service must be present in a trusted store on the federation server proxy computer and have a valid chain to a trusted CA store.
- **Certificate revocation list (CRL)**: For any certificate that has a CRL published, the CRL must be accessible to all clients and servers that need to access the certificate.

If any of the preceding requirements aren't configured correctly, AD FS won't work.

## Common things to check with certificates

The following checklist can help you resolve a certificate problem:

- Make sure that the certificate is trusted.
- Make sure that SSL certificates are trusted by the clients.
  - Token-signing certificates need to be trusted by the relying parties.
- Check the trust chain. Every certificate in the chain needs to be valid.
- Verify the certificate's expiration date.
- Check CRL accessibility.
  - Make sure the field for CRL distribution point (CDP) is populated.
  - Manually browse to the CDP.
- Make sure the certificate wasn't revoked.

## Common certificate errors

The following table lists common certificate errors and possible causes.

|Event|Cause|Resolution
|-----|-----|-----|
|Event 249: A certificate couldn't be found in the certificate store. In certificate rollover scenarios, this can potentially cause a failure when the Federation Service is signing or decrypting using this certificate.|The certificate in question isn't present in the local certificate store, or the service account doesn't have permission to the certificate's private key.|Ensure that the certificate is installed in *LocalMachine\My store* on the AD FS server. Ensure that the AD FS service account has read access to the private key of the certificate.|
|Event 315: An error occurred during an attempt to build the certificate chain for the claims provider trust signing certificate.|The certificate was revoked. </br></br>The certificate chain can't be verified. </br></br>The certificate is expired or isn't yet valid.|Ensure that the certificate is valid and wasn't revoked. </br></br>Ensure that the CRL is accessible.|
|Event 316: An error occurred during an attempt to build the certificate chain for the relying party trust signing certificate.|The certificate was revoked. </br></br>The certificate chain can't be verified. </br></br>The certificate is expired or isn't yet valid.|Ensure that the certificate is valid and wasn't revoked. </br></br>Ensure that the CRL is accessible.|
|Event 317: An error occurred during an attempt to build the certificate chain for the relying party trust encryption certificate.|The certificate was revoked. </br></br>The certificate chain can't be verified. </br></br>The certificate is expired or isn't yet valid.|Ensure that the certificate is valid and wasn't revoked. </br></br>Ensure that the CRL is accessible.|
|Event 319: An error occurred while the certificate chain for the client certificate was being built.|The certificate was revoked. </br></br>The certificate chain can't be verified. </br></br>The certificate is expired or isn't yet valid.|Ensure that the certificate is valid and wasn't revoked. </br></br>Ensure that the CRL is accessible.|
|Event 360: A request was made to a certificate transport endpoint, but the request didn't include a client certificate.|The root CA that issued the client certificate isn't trusted. </br></br>The client certificate is expired. </br></br>The client certificate is self-signed and isn't trusted.|Ensure that the root CA that issued the client certificate is present in the trusted root store. </br></br>Ensure that the client certificate isn't expired. </br></br>If the client certificate is self-signed, ensure that it was added to the list of trusted certificates, or replace the self-signed certificate with a trusted certificate.|
|Event 374: An error occurred while building the certificate chain for the claims provider trust encryption certificate.|The certificate was revoked. </br></br>The certificate chain can't be verified. </br></br>The certificate is expired or isn't yet valid.|Ensure that the certificate is valid and wasn't revoked. </br></br>Ensure that the CRL is accessible.|
|Event 381: An error occurred during an attempt to build the certificate chain for configuration certificate.|One of the certificates configured for use on the AD FS server is expired or was revoked.|Ensure that all configured certificates weren't revoked and aren't expired.|
|Event 385: AD FS detected that one or more certificates in the AD FS configuration database needs to be updated manually.|One of the certificates configured for use on the AD FS server is expired or is nearing its expiration date.|Update the expired or soon-to-expire certificate with a replacement. (If you're using self-signed certificates and automatic certificate rollover is enabled, you can ignore this error because it'll self-resolve.)|
|Event 387: AD FS detected that one or more of the certificates that are specified in the Federation Service weren't accessible to the service account that's used by the AD FS Windows Service.|The AD FS service account doesn't have read permissions to the private key of one or more configured certificates.|Ensure that the AD FS service account has read permission to the private key of all configured certificates.|
|Event 389: AD FS detected that one or more of your trusts require their certificates to be updated manually because they're expired, or will expire soon.|One of your configured partner's certificates is expired or is about to expire. The event can apply to either a claims provider trust or a relying party trust.|If you manually created this trust, update the certificate configuration manually. If you used federation metadata to create the trust, the certificate will be updated automatically as soon as the partner updates the certificate.|

## Related links

- [AD FS troubleshooting](ad-fs-tshoot-overview.md)
