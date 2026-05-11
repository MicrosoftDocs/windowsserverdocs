---
title: Configure a certification authority to use ML-DSA (preview) in Windows Server
description: Learn how to set up ML-DSA (preview) post-quantum certification authorities with AD CS in Windows Server 2025, including Root CA and Subordinate CA configuration.
#customer intent: As a Windows Server PKI administrator, I want to configure my certification authorities to use ML-DSA algorithms so that I can prepare my PKI infrastructure for post-quantum cryptography.
author: robinharwood
ms.topic: how-to
ms.author: roharwoo
ms.date: 05/12/2026
ai-usage: ai-assisted
---

# Configure a certification authority to use ML-DSA (preview)

This article describes how to configure Active Directory Certificate Services (AD CS) certification authorities (CAs) to use Module-Lattice-Based Digital Signature Algorithm (ML-DSA) (preview) for post-quantum cryptography (PQC). ML-DSA is a digital signature algorithm standardized by the National Institute of Standards and Technology (NIST), designed to resist both classical and quantum computing attacks.

By completing the steps in this article, you set up a two-tier public key infrastructure (PKI) hierarchy with a Root CA and Subordinate CA, both using ML-DSA as the signature algorithm. You can then issue ML-DSA certificates from these CAs by [configuring certificate templates for ML-DSA](configure-ml-dsa-certificate-templates.md).

> [!IMPORTANT]
> ML-DSA support in AD CS is currently in PREVIEW. This information relates to a prerelease feature that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.
>
> ML-DSA support in AD CS requires Windows Server 2025 with the latest cumulative update and the ML-DSA feature enabled. Configure and test in a non-production environment before deploying to production.

## Prerequisites

Before you begin, make sure you meet the following requirements:

- A domain controller running Windows Server 2025 or later.
- Two domain-joined member servers for the Root CA and Subordinate CA, both running Windows Server 2025 with the latest cumulative update installed. To verify installed updates, see [Windows Server 2025 update history](https://support.microsoft.com/topic/windows-server-2025-update-history).
- An account with permissions to install and configure the Certificate Services role on each CA server.
- You must enable the ML-DSA feature on each CA server. To enable the feature, see [Enable the ML-DSA feature](#enable-the-ml-dsa-feature).

## ML-DSA parameter sets

ML-DSA (preview) provides three parameter sets, each offering a different NIST security level. Each parameter set has fixed public and private key sizes that you can't change. You can use any parameter set for Root CAs, Subordinate CAs, or end-entity certificates.

| Parameter set | Public key size | Private key size | Signature size | NIST security level |
|---|---|---|---|---|
| ML-DSA-44 | 1,312 bytes | 2,560 bytes | 2,420 bytes | Level 2 |
| ML-DSA-65 | 1,952 bytes | 4,032 bytes | 3,309 bytes | Level 3 |
| ML-DSA-87 | 2,592 bytes | 4,896 bytes | 4,627 bytes | Level 5 |

When you select an ML-DSA provider during CA configuration, the hash algorithm defaults to **NoHash**. Unlike traditional algorithms such as RSA where signing involves a pre-hash step like SHA-256, ML-DSA handles message hashing internally as part of the signature operation. ML-DSA doesn't require an external hash algorithm.

## Set up the Root CA

Sign in to the Root CA server by using an account with permissions to install and configure the Certificate Services role. Configuring ML-DSA (preview) doesn't require any extra privileges beyond the standard AD CS installation permissions.

### Install the AD CS role

1. Open **Server Manager**, select **Add Roles and Features**, and then select **Active Directory Certificate Services** on the **Server Roles** page.

1. On the **Role Services** page, select **Certification Authority**, and then complete the wizard to install the role.

Alternatively, run the following PowerShell command:

```powershell
Add-WindowsFeature Adcs-Cert-Authority -IncludeManagementTools
```

### Configure the root CA with ML-DSA

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
- You can choose a different ML-DSA (preview) parameter set from the root CA. Each CA in the hierarchy can use a distinct ML-DSA configuration.

### Install and configure the subordinate CA

1. Install the AD CS role on the subordinate CA server by following the same installation steps as for the [Root CA](#install-the-ad-cs-role).

1. Open the configuration wizard and select **Subordinate CA** as the CA type.

1. Select **Create a new private key**.

1. On the **Cryptography for CA** page, select an ML-DSA cryptographic provider. For example, **ML-DSA:65#Microsoft Software Key Storage Provider**.

1. On the **Certificate Request** page, select **Send a certificate request to a parent CA**, and then choose the previously configured Root CA. If the Root CA is offline, select **Save a certificate request to a file on the target machine**, and then submit the request manually.

1. Complete the remaining pages by using the default settings, and then select **Configure**.

### Verify the subordinate CA certificate

1. Open the **Certification Authority** console (`certsrv.msc`) on the subordinate CA.

1. Right-click the CA name, select **Properties**, and then select **View Certificate**.

1. On the **Details** tab, confirm:
   - **Signature algorithm**: Shows the Root CA's ML-DSA parameter set (for example, ML-DSA-87), because the Root CA signs the subordinate CA certificate.
   - **Public key**: Shows the subordinate CA's own ML-DSA parameter set (for example, ML-DSA-65).

   <!-- SCREENSHOT: Show the subordinate CA certificate Details tab with different ML-DSA values for Signature algorithm and Public key, demonstrating the mixed-algorithm hierarchy. -->

1. On the **Certification Path** tab, verify the chain displays both the Root CA and subordinate CA certificates.

   <!-- SCREENSHOT: Show the Certification Path tab with the two-tier chain (Root CA > subordinate CA) to confirm the hierarchy is correct. -->

## Enable the ML-DSA feature

To enable ML-DSA (preview) support in Windows Server 2025, turn on feature preview policies through Group Policy. Perform these steps on every server where you need ML-DSA support, including CA servers and Online Certificate Status Protocol (OCSP) responders.

> [!IMPORTANT]
> These feature enablement steps are for testing and evaluation. Don't apply these changes in a production environment until the feature reaches general availability.

1. Verify the server has the latest cumulative update installed. To check available updates, see [Windows Server 2025 update history](https://support.microsoft.com/topic/windows-server-2025-update-history).

1. Download and install the required feature preview MSI packages on the server:
   - [Windows Server 2025 KB5075899 Feature Preview](https://download.microsoft.com/download/d9faf8f5-a4a4-4211-9a63-59811f662151/Windows%20Server%202025%20KB5075899%20260122_030518%20Feature%20Preview.msi)
   - [Windows Server 2025 KB9999999 Feature Preview](https://download.microsoft.com/download/4672ffd5-9a07-473c-8cc2-3ffe3da4ad8d/Windows%20Server%202025%20KB9999999%20260219_03521%20Feature%20Preview.msi)

   Open each downloaded MSI file, and then approve the administrator prompt to install.

1. Open the **Local Group Policy Editor** by running `gpedit.msc`.

1. Go to **Local Computer Policy** > **Administrative Templates** > **KB5075899 260122_030518 Feature Preview** > **Windows Server 2025**.

1. Open the policy setting labeled **KB5075899_030518 Feature Preview**, change the setting to **Enabled**, and then select **OK**.

   <!-- SCREENSHOT: Show the Group Policy Editor with the KB5075899 Feature Preview policy set to Enabled. The navigation path and policy dialog aren't intuitive for this feature enablement step. -->

1. Go to **Local Computer Policy** > **Administrative Templates** > **KB9999999 260219_03521 Feature Preview** > **Windows Server 2025**.

1. Open the policy setting labeled **KB9999999_03521 Feature Preview**, change the setting to **Enabled**, and then select **OK**.

1. Restart the server to apply the changes.

## Related content

- [Configure certificate templates for ML-DSA](configure-ml-dsa-certificate-templates.md)
- [Configure OCSP responders to use ML-DSA](configure-ml-dsa-ocsp-responder.md)
- [What is Active Directory Certificate Services?](active-directory-certificate-services-overview.md)
- [PKI design considerations using AD CS](pki-design-considerations.md)
