---
title: Configure a certification authority to use ML-DSA in Windows Server
description: Learn how to set up ML-DSA post-quantum certification authorities with AD CS in Windows Server 2025, including Root CA and Subordinate CA configuration.
#customer intent: As a Windows Server PKI administrator, I want to configure my certification authorities to use ML-DSA algorithms so that I can prepare my PKI infrastructure for post-quantum cryptography.
author: robinharwood
ms.topic: how-to
ms.author: roharwoo
ms.reviewer: Tjha
ms.date: 05/12/2026
ai-usage: ai-generated
---

# Configure a certification authority to use ML-DSA

This article describes how to configure Active Directory Certificate Services (AD CS) certification authorities (CAs) to use Module-Lattice-Based Digital Signature Algorithm (ML-DSA) for post-quantum cryptography (PQC). ML-DSA is a digital signature algorithm standardized by the National Institute of Standards and Technology (NIST), designed to resist both classical and quantum computing attacks.

By completing the steps in this article, you set up a two-tier public key infrastructure (PKI) hierarchy with a Root CA and Subordinate CA, both using ML-DSA as the signature algorithm.

## Prerequisites

Before you begin, make sure you meet the following requirements:

- A domain controller running Windows Server 2025 or later.
- Two domain-joined member servers for the Root CA and Subordinate CA, both running Windows Server 2025 with the latest cumulative update installed. To verify installed updates, see [Windows Server 2025 update history](https://support.microsoft.com/topic/windows-server-2025-update-history).
- An account with permissions to install and configure the Certificate Services role on each CA server.

## Choose an ML-DSA parameter set

Before you configure your CAs, choose an ML-DSA parameter set. ML-DSA provides three parameter sets, each offering a different NIST security level. Each parameter set has fixed public and private key sizes that you can't change. You can use any parameter set for Root CAs, Subordinate CAs, or end-entity certificates.

| Parameter set | Public key size | Private key size | Signature size | NIST security level |
|---|---|---|---|---|
| ML-DSA-44 | 1,312 bytes | 2,560 bytes | 2,420 bytes | Level 2 |
| ML-DSA-65 | 1,952 bytes | 4,032 bytes | 3,309 bytes | Level 3 |
| ML-DSA-87 | 2,592 bytes | 4,896 bytes | 4,627 bytes | Level 5 |

When you select an ML-DSA provider during CA configuration, the hash algorithm defaults to **NoHash**. Unlike traditional algorithms such as RSA where signing involves a pre-hash step like SHA-256, ML-DSA handles message hashing internally as part of the signature operation. ML-DSA doesn't require an external hash algorithm.

## Set up the Root CA

To set up the Root CA, install the AD CS role and then configure it with an ML-DSA cryptographic provider. Sign in to the Root CA server by using an account with permissions to install and configure the Certificate Services role. ML-DSA doesn't require any extra privileges beyond the standard AD CS installation permissions.

### Install the AD CS role

Install the AD CS role and the Certification Authority role service on the Root CA server.

1. Open **Server Manager**, select **Add Roles and Features**, and then select **Active Directory Certificate Services** on the **Server Roles** page.

1. On the **Role Services** page, select **Certification Authority**, and then complete the wizard to install the role.

Alternatively, run the following PowerShell command:

```powershell
Add-WindowsFeature Adcs-Cert-Authority -IncludeManagementTools
```

### Configure the root CA with ML-DSA

After the role installs, configure the CA as an enterprise root CA with an ML-DSA cryptographic provider.

1. After installation, select the **Configure Active Directory Certificate Services** link in Server Manager.

1. On the **CA Type** page, select **Root CA**.

1. On the **Private Key** page, select **Create a new private key**.

1. On the **Cryptography for CA** page, select one of the following ML-DSA cryptographic providers:
   - **ML-DSA:44#Microsoft Software Key Storage Provider**
   - **ML-DSA:65#Microsoft Software Key Storage Provider**
   - **ML-DSA:87#Microsoft Software Key Storage Provider**

   The **Key Length** field displays the public key size in bits for the selected parameter set. The **Hash algorithm** defaults to **NoHash**.

   <!-- SCREENSHOT: Show the Cryptography for CA page with an ML-DSA provider selected, showing the Key Length and NoHash fields. This is the key decision point where the reader selects the PQC algorithm. -->

1. Complete the remaining pages by using the default settings, and then select **Configure** to finish setup.

   <!-- SCREENSHOT: Show the Results page with "Configuration succeeded" for the Certification Authority role service. Shows what success looks like. -->

Alternatively, configure the root CA by using PowerShell. The following example uses ML-DSA-87:

```powershell
# KeyLength is specified in bits. For ML-DSA-87: 2592 bytes x 8 = 20736 bits
Install-AdcsCertificationAuthority `
    -CAType EnterpriseRootCA `
    -CACommonName "<your-root-ca-name>" `
    -KeyLength 20736 `
    -HashAlgorithm NoHash `
    -CryptoProviderName "ML-DSA:87#Microsoft Software Key Storage Provider"
```

Replace `<your-root-ca-name>` with the common name for your root CA.

### Verify the root CA certificate

Confirm the root CA certificate uses the ML-DSA algorithm you selected.

1. Open the **Certification Authority** console (`certsrv.msc`).

1. Right-click the CA name, select **Properties**, and then select **View Certificate** on the **General** tab.

1. On the **Details** tab, confirm the following fields:
   - **Signature algorithm**: Shows the ML-DSA parameter set, such as ML-DSA-87.
   - **Public key**: Shows the ML-DSA parameter set and key size in bits.

   Because the root CA certificate is self-signed, both the signature algorithm and public key algorithm use the same ML-DSA parameter set.

   <!-- SCREENSHOT: Show the certificate Details tab with Signature algorithm and Public key fields highlighted showing ML-DSA values. Confirms the reader's CA is correctly configured. -->

The CA service automatically publishes certificate revocation lists (CRLs) when it starts and signs them by using the configured ML-DSA algorithm.

## Set up the subordinate CA

The setup steps for a subordinate CA are similar to the root CA, with two key differences:

- Select **Subordinate CA** as the CA type.
- You can choose a different ML-DSA parameter set from the root CA. Each CA in the hierarchy can use a distinct ML-DSA configuration.

### Install and configure the subordinate CA

Install AD CS on the subordinate CA server and configure it to use an ML-DSA provider and obtain its certificate from the root CA.

1. Install the AD CS role on the Subordinate CA server by following the same installation steps as for the [Root CA](#install-the-ad-cs-role).

1. Open the configuration wizard and select **Subordinate CA** as the CA type.

1. Select **Create a new private key**.

1. On the **Cryptography for CA** page, select an ML-DSA cryptographic provider. For example, **ML-DSA:65#Microsoft Software Key Storage Provider**.

1. On the **Certificate Request** page, select **Send a certificate request to a parent CA**, and then choose the previously configured Root CA. If the Root CA is offline, select **Save a certificate request to a file on the target machine**, and then submit the request manually.

1. Complete the remaining pages by using the default settings, and then select **Configure**.

### Verify the subordinate CA certificate

Confirm the subordinate CA certificate shows the expected ML-DSA algorithms for both the signature and public key.

1. Open the **Certification Authority** console (`certsrv.msc`) on the subordinate CA.

1. Right-click the CA name, select **Properties**, and then select **View Certificate**.

1. On the **Details** tab, confirm:
   - **Signature algorithm**: Shows the Root CA's ML-DSA parameter set (for example, ML-DSA-87), because the Root CA signs the subordinate CA certificate.
   - **Public key**: Shows the subordinate CA's own ML-DSA parameter set (for example, ML-DSA-65).

   <!-- SCREENSHOT: Show the subordinate CA certificate Details tab with different ML-DSA values for Signature algorithm and Public key, demonstrating the mixed-algorithm hierarchy. -->

1. On the **Certification Path** tab, verify the chain displays both the Root CA and subordinate CA certificates.

   <!-- SCREENSHOT: Show the Certification Path tab with the two-tier chain (Root CA > subordinate CA) to confirm the hierarchy is correct. -->

## Related content

- [What is ML-DSA support in AD CS?](ml-dsa-overview.md)
- [Configure certificate templates for ML-DSA](configure-ml-dsa-certificate-templates.md)
- [Configure OCSP responders to use ML-DSA](configure-ml-dsa-ocsp-responder.md)
- [Post-quantum cryptography in AD CS overview](post-quantum-cryptography-overview.md)
- [PKI design considerations using AD CS](pki-design-considerations.md)
