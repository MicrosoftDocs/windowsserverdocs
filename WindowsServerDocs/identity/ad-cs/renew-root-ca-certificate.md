---
title: Renew root CA certificate
description: This article describes how to renew a CA certificate with existing key pair, and a renew CA certificate with new key pair.
author: meaghanlewis
ms.author: mosagie
ms.topic: overview
ms.date: 02/26/2025
#customer intent: As an IT administrator, I want to renew the Root CA certificate so that the PKI remains secure and trusted.
---

# Renew root CA certificate

In this article, you'll learn about how-to renew a Root Certification Authority (CA) certificate with a new and existing key pair. Renewing the Root CA certificate is a critical task to ensure the continued trust and security of your Public Key Infrastructure (PKI).

## Prerequisites

Before you begin, ensure you have the following:

- Administrative access to the Root CA server.
- Backup of the CA database and private key.
- Understanding of your organization's PKI hierarchy and certificate policies.

## Renew the root CA certificate with existing key pair

When you renew CA certificates with an existing key pair, nothing important in the certificate changes. The certificate contains the same public and private key. As a result, all previously issued certificates chain up to the new CA certificate without any changes. You just replace the old CRT file in AIA download locations. In addition, new CA certificate ValidFrom (NotBefore) field contains the value when the existing CA key pair was generated.

For example, the old CA certificate is Valid From 08/10/2000 to 08/10/2010. When you renew a CA cert with the existing key pair, the new certificate has the following values: Valid From 08/10/2000 to 08/10/2020. This renewal increases the current CA certificate validity period. Also, the new CA certificate's hash now contains the previous certificate's Thumbprint extension value. And the new CA certificate changes the CA Version.

CA version extension allows to build correct chains in the case a particular CA has more than one certificate. This extension consists of two values: the CA Certificate Index, and the CA Key Index. These values are separated by dot, for example: 0.0, 2.1, and 3.3. Each time you renew a CA certificate, the CA Certificate Index is increased by 1: 0.0, 1.0, 2.0, etc. Since the key pair remains the same, the CA Key Index value doesn't change. The CA maintains the same CRL's, and clients are able to chain previously and newly issued certificates up to new CA certificate. This is because all these client certificates are signed by the same CA signing key, and both CA certs produce the same signature for the identical data.

>[!NOTE]
>After CA certificate renewal, a new CA certificate doesn't replace a previous CA certificate. Instead, it's another file and adds a certificate index in parentheses to the file name. For example, the old certificate has a name: **TestCA.crt**, and the new certifcate has the following name: TestCA(1).crt. The number and parentheses are maintained by the <CertificateName> variable in AIA location settings.

The renewal is quite simple and is recommended for most scenarios unless of the following statements are valid for you:

- CA signing (existing CA key pair) is compromised;
- You have a program that requires a new signing key to be used with a new CA certificate;
- The current CRL file is too large and you want to move some revocation information to a new CRL file.

## Renew the root CA certificate with new key pair

There might be a requirement to renew a CA certificate with a new key pair. This renewal type is more complex. Since a new key pair is generated, many things in the CA certificate change. For example, a new public key produces a different Subject Key Identifier (the hash of public key). When CA issues a new certificate, it gives a certificate Subject Key Identifier value to an issued certificate Authority Key Identifier extension. The extension comparison is used by certificate chaining engine (CCE). As a result, the previously issued certificates chain up to the previous CA certificate, and newly issued certs chain up to the new CA certificate respectively. And, the new CRL is generated. The new CRL contains only those revoked certificates that were signed using the renewed CA certificate (or signing key), and the new CRL file contains the CRL suffix. For example, the old CRL has the name **TestCA.crl**, and the new CRL has the name: **TestCA(1).crl**. This CRL suffix is maintained by the <CRLNameSuffix> variable in the CDP location setting, and the number always equals to certificate CA Version extension CA Key Index value.

>[!NOTE]
>Unlike CA Certificate Index value, the CA Key Index doesn't always increase by 1, but is set to the CA Certificate Index value. For example, the previous CA certificate has CA Version extension as 2.0, and the new CA certificate CA Version extension has the value: 3.3.

## Steps to renew the root CA certificate

This section describes the steps to renew a root CA certificate.

### Step 1: Backup the CA

1. Open the Certification Authority console.
2. Right-click the CA name, select **All Tasks**, and then **Back up CA**.
3. Follow the wizard to back up the CA database and private key.

### Step 2: Renew the Root CA Certificate

1. Open the Certification Authority console.
2. Right-click the CA name, select **All Tasks**, and then **Renew CA Certificate**.
3. Choose whether to generate a new key pair or use the existing key pair.
4. Complete the wizard to renew the certificate.

### Step 3: Publish the New Root CA Certificate

1. Distribute the new Root CA certificate to all domain-joined computers.
2. Update any applications or services that rely on the Root CA certificate.

### Post-renewal tasks

- Verify that the new Root CA certificate is trusted by all clients.
- Monitor the CA for any issues related to the renewal process.

## Related content

- [Microsoft Learn: Active Directory Certificate Services](/windows-server/identity/ad-cs/)
