---
description: Learn more about service communications certificates in AD FS
title: Service Communications Certificates
author: billmath
ms.author: billmath
ms.date: 08/15/2023
ms.topic: article
---

# Service communications certificates

A federation server requires the use of service communication certificates for scenarios in which WCF message security is used.

## Service communication certificate requirements

Service communication certificates must meet the following requirements to work with AD FS:

- The service communication certificate must include the server authentication enhanced key usage (EKU) extension.

- The certificate revocation lists (CRLs) must be accessible for all the certificates in the chain from the service communication certificate to the root CA certificate. Any federation server proxies and Web servers that trust this federation server must also trust the root CA.

- The subject name that's used in the service communication certificate must match the Federation Service name in the properties of the Federation Service.

## Deployment considerations for service communication certificates

Configure service communication certificates so that all federation servers use the same certificate. If you're deploying the Federated Web Single-Sign-On (SSO) design, we recommend that a public CA issue your service communication certificate. You can request and install these certificates through the IIS Manager snap-in.

You can use self-signed, service communication certificates successfully on federation servers in a test lab environment. However, for a production environment, we recommend that you obtain service communication certificates from a public CA.

Reasons why you shouldn't use self-signed, service communication certificates for a live deployment include:

- A self-signed, SSL certificate must be added to the trusted root store on each of the federation servers in the resource partner organization. While a self-signed certificate alone doesn't enable an attacker to compromise a resource federation server, trusting self-signed certificates does increase the attack surface of a computer. If the certificate signer isn't trustworthy, it can lead to security vulnerabilities.

- A self-signed, service communication certificate creates a bad user experience. Clients receive Security Alert prompts when they try to access federated resources that display the following message: "The security certificate was issued by a company you have not chosen to trust." This message is expected, because the self-signed certificate isn't trusted.

    > [!NOTE]
    > If necessary, you can work around this condition by using Group Policy to manually push down the self-signed certificate to the trusted root store on each client computer that attempts to access an AD FS site.

- CAs provide more certificate-based features, such as private key archive, renewal, and revocation that aren't provided by self-signed certificates.
