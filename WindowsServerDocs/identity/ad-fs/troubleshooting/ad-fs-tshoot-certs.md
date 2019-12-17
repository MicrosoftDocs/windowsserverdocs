---
title: AD FS Troubleshooting - Certificates
description:  This document describes typical certificate issues.
author: billmath
ms.author: billmath
manager: mtillman
ms.date: 02/21/2017
ms.topic: article
ms.prod: windows-server
ms.technology: identity-adfs
---

# AD FS Troubleshooting - Certificates
AD FS requires the following certificates in order to work correctly.  If any of these have not been setup or configured properly then issues can arise.  

## Required certificates
AD FS requires the following certificates:



- **Federation trust** – This requires that either a certificate chained to a mutually trusted Internet root Certificate Authority (CA) is present in the trusted root store of both the claims provider and relying party Federation Servers, a cross-certification design has been implemented in which each side has exchanged its root CA with its partner, or self-signed certificates that have been imported on each side where appropriate.
- **Token-signing** – Each Federation Service computer requires a token-signing certificate.  The claims provider token-signing certificate must be trusted by the relying party Federation Server. The relying party token-signing certificate must be trusted by all applications that receive tokens from the RP Federation Server.
- **Secure Sockets Layer (SSL)** – The SSL certificate for the Federation Service must be present in a trusted store on the Federation Server proxy computer and has a valid chain to a trusted Certificate Authority (CA) store.
- **Certificate Revocation List (CRL)** – For any certificate that has a CRL published, the CRL must be accessible to all clients and servers who need to access the certificate.

If any of the above are not configured correctly, AD FS will not work.

## Common things to check with certificates
The following is a list of things that can arise and should be verified when trying to resolve a certificate issue.

- Make sure that the certificate is trusted
	- SSL certs need to be trusted by the clients
	- Token signing certificates need to be trusted by the relying parties
- Check the trust chain - every cert in the chain needs to be valid.
- Verify the certificate expiration date
- Check Certificate Revocation List (CRL) accessibility
	- Make sure the CDP field is populated
	- Manually browse to the CDP
- Make sure the certificate has not been revoked

## Common certificate errors
The following table is a list of common errors and possible causes.

|Event|Cause|Resolution
|-----|-----|-----|
|Event 249 - A certificate could not be found in the certificate store. In certificate rollover scenarios, this can potentially cause a failure when the Federation Service is signing or decrypting using this certificate.|The certificate in question is not present in the local certificate store, or the service account does not have permission to the certificate's private key.|Ensure that the certificate is installed in the LocalMAchine\My store on the AD FS server. Ensure that the AD FS service account has read access to the private key of the certificate.|
|Event 315 - An error occurred during an attempt to build the certificate chain for the claims provider trust signing certificate.|The certificate has been revoked.</br></br>The certificate chain cannot be verified.</br></br>The certificate is expired or is not yet valid.|Ensure that the certificate is valid and has not been revoked.</br></br>Ensure that the CRL is accessible.|
|Event 316 - An error occurred during an attempt to build the certificate chain for the relying party trust signing certificate.|The certificate has been revoked.</br></br>The certificate chain cannot be verified.</br></br>The certificate is expired or is not yet valid.|Ensure that the certificate is valid and has not been revoked.</br></br>Ensure that the CRL is accessible.|
|Event 317 - An error occurred during an attempt to build the certificate chain for the relying party trust encryption certificate.|The certificate has been revoked.</br></br>The certificate chain cannot be verified.</br></br>The certificate is expired or is not yet valid.|Ensure that the certificate is valid and has not been revoked.</br></br>Ensure that the CRL is accessible.|
|Event 319 -An error occurred while the certificate chain for the client certificate was being built.|The certificate has been revoked.</br></br>The certificate chain cannot be verified.</br></br>The certificate is expired or is not yet valid.|Ensure that the certificate is valid and has not been revoked.</br></br>Ensure that the CRL is accessible.|
|Event 360 - A request was made to a certificate transport endpoint, but the request did not include a client certificate.|The root CA that issued the client certificate is not trusted.</br></br>The client certificate is expired.</br></br>The client certificate is self-signed and is not trusted.|Ensure that the root CA that issued the client certificate is present in the trusted root store.</br></br>Ensure that the client certificate is not expired.</br></br>If the client certificate is self-signed, ensure that it has been added to the list of trusted certificates, or replace the self-signed certificate with a trusted certificate.|
|Event 374 - An error occurred while building the certificate chain for the claims provider trust encryption certificate.|The certificate has been revoked.</br></br>The certificate chain cannot be verified.</br></br>The certificate is expired or is not yet valid.|Ensure that the certificate is valid and has not been revoked.</br></br>Ensure that the CRL is accessible.|
|Event 381 - An error occurred during an attempt to build the certificate chain for configuration certificate.|One of the certificates configured for use on the AD FS server is expired or has been revoked.|Ensure that all configured certificates have not been revoked and have not expired.|
|Event 385 - AD FS detected that one or more certificates in the AD FS configuration database needs to be updated manually.|One of the certificates configured for use on the AD FS server has expired or is nearing its expiration date.|Update the expired or soon-to-expire certificate with a replacement. (If you are using self-signed certificates and automatic certificate rollover is enabled, this error may be ignored as it will self-resolve.)|
|Event 387 - AD FS detected that one or more of the certificates that are specified in the Federation Service were not accessible to the service account that is used by the AD FS Windows Service.|The AD FS service account does not have read permissions to the private key of one or more configured certificates.|Ensure that the AD FS service account has read permission to the private key of all configured certificates.|
|Event 389 - AD FS detected that one or more of your trusts require their certificates to be updated manually because they are expired, or will expire soon.|One of your configured partner's certificates has expired, or is about to expire. This can apply to either a claims provider trust or to a relying party trust.|If you have manually created this trust, update the certificate configuration manually. If you used federation metadata to create the trust, the certificate will update automatically as soon as the partner updates the certificate.|




## Next Steps

- [AD FS Troubleshooting](ad-fs-tshoot-overview.md)
 