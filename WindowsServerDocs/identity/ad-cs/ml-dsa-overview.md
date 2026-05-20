---
title: What is ML-DSA support in AD CS
description: Learn about ML-DSA support in Active Directory Certificate Services (AD CS), including supported parameter sets, scenarios, and configuration guidance.
#customer intent: As an AD CS administrator, I want to understand ML-DSA support in AD CS so that I can configure post-quantum certification authorities and issue ML-DSA certificates.
author: robinharwood
ms.author: roharwoo
ms.reviewer: Tjha
ms.topic: overview
ms.date: 05/12/2026
ai-usage: ai-generated
---

# What is ML-DSA support in AD CS?

Active Directory Certificate Services (AD CS) supports Module-Lattice-Based Digital Signature Algorithm (ML-DSA), a National Institute of Standards and Technology (NIST)-standardized post-quantum digital signature algorithm designed to resist quantum computing attacks. ML-DSA is a signature-only algorithm and doesn't support encryption or key exchange. You can configure certification authorities (CAs), certificate templates, and Online Responders (OCSP) to use ML-DSA for signing operations.

## Supported ML-DSA parameter sets

AD CS supports all three ML-DSA parameter sets, all in pure mode.

| Parameter set | Public key | Private key | Signature | NIST security level |
|---|---|---|---|---|
| ML-DSA-44 | 1,312 bytes | 2,560 bytes | 2,420 bytes | Level 2 |
| ML-DSA-65 | 1,952 bytes | 4,032 bytes | 3,309 bytes | Level 3 |
| ML-DSA-87 | 2,592 bytes | 4,896 bytes | 4,627 bytes | Level 5 |

Higher parameter sets provide larger security margins but produce larger keys and signatures. Choose the parameter set that matches your security requirements and bandwidth constraints.

## Supported ML-DSA scenarios

AD CS supports ML-DSA across the certificate lifecycle—CA hierarchy setup, leaf certificate issuance, and OCSP response signing. Each scenario links to the corresponding configuration guide.

### CA hierarchy

AD CS supports ML-DSA as the signature algorithm for Root, Subordinate, Enterprise, and Standalone CAs. Full post-quantum protection requires ML-DSA signatures across the entire certificate chain. For more information, see [Configure a certification authority to use ML-DSA](configure-ml-dsa-certification-authority.md).

### Code signing

Configure certificate templates on CAs to issue ML-DSA code signing certificates. For more information, see [Configure certificate templates for ML-DSA](configure-ml-dsa-certificate-templates.md).

### TLS and authentication

Configure Web Server, User, and Computer templates to issue ML-DSA certificates that authenticate servers and clients by using post-quantum signatures. For more information, see [Configure certificate templates for ML-DSA](configure-ml-dsa-certificate-templates.md).

### OCSP response signing

Configure Online Responders with ML-DSA OCSP response signing certificates. For more information, see [Configure Online Responders (OCSP) to use ML-DSA](configure-ml-dsa-online-responder.md).

> [!NOTE]
> You can enroll ML-DSA certificates through the Certificates Microsoft Management Console (MMC) snap-in and `certreq.exe`. Enrollment through the Network Device Enrollment Service (NDES) isn't currently available.

## Platform requirements

ML-DSA support requires minimum OS versions for both CA servers and clients.

| Component | Minimum version |
|---|---|
| AD CS servers | Windows Server 2025 with the 2026-05 Security update ([KB5087539](https://support.microsoft.com/help/5087539)) or later installed. |
| Client | Windows 11, version 24H2 and version 25H2 with the 2025-10 non-security update ([KB5067036](https://support.microsoft.com/help/5067036)) or later installed. |

> [!IMPORTANT]
> You must **newly install** ML-DSA CAs. ML-DSA doesn't support in-place migration of existing CAs. Build a new CA hierarchy in parallel with your existing hierarchy to evaluate and test post-quantum certificate issuance, without disrupting current operations.

## Certificate template requirements

All ML-DSA leaf certificate templates - code signing, TLS, user/computer, and OCSP response signing - must meet the following requirements. For configuration steps, see [Configure certificate templates for ML-DSA](configure-ml-dsa-certificate-templates.md).

| Setting | Requirement |
|---|---|
| **Cryptographic provider** | Cryptography Next Generation (CNG) Key Storage Provider. Legacy Cryptographic Service Providers (CSPs) aren't supported. |
| **Compatibility settings** | Set both **Certification Authority** and **Certificate Recipient** to **Windows Server 2008** or later so that CNG providers appear in the provider list. |
| **Request handling - Purpose** | Set to **Signature**. ML-DSA doesn't support encryption. |
| **Application Policies (EKU)** | Must **not** include **Encrypting File System** or **Secure E-mail**. |
| **Key Usage** | Must **not** include **Key Encipherment** or **Key Agreement**. |

> [!NOTE]
> Not all third-party applications, devices, or services recognize ML-DSA certificates. Validate compatibility in a test environment before deploying to production.

## Related content

- [Post-quantum cryptography in AD CS overview](post-quantum-cryptography-overview.md)
- [Configure a certification authority to use ML-DSA](configure-ml-dsa-certification-authority.md)
- [Configure certificate templates for ML-DSA](configure-ml-dsa-certificate-templates.md)
- [Configure Online Responders (OCSP) to use ML-DSA](configure-ml-dsa-online-responder.md)
