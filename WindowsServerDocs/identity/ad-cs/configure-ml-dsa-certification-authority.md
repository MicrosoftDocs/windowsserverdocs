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

This article describes how to configure Active Directory Certificate Services (AD CS) certification authorities (CAs) to use Module-Lattice-Based Digital Signature Algorithm (ML-DSA) for Post-Quantum Cryptography (PQC). ML-DSA is a digital signature algorithm standardized by the National Institute of Standards and Technology (NIST), designed to resist quantum computing attacks.

By completing the steps in this article, you set up a two-tier public key infrastructure (PKI) hierarchy with a Root CA and Subordinate CA, both using ML-DSA as the signature algorithm.

## Prerequisites

Before you begin, make sure you meet the following requirements:

- A domain controller running the latest Windows Server release. Windows Server 2025 or later is recommended.

- Two servers running Windows Server 2025 with the 2026-05 Security update ([KB5087539](https://support.microsoft.com/help/5087539)) or later installed for the Root CA and Subordinate CA. 

  - The **Subordinate CA** server must be domain-joined.

  - The **Root CA** server can be either domain-joined (Enterprise Root CA) or non-domain joined (Standalone Root CA). See the following note.

  > [!NOTE]
  > This article shows both Enterprise and Standalone Root CA configurations. For production environments, a Standalone Root CA that is taken offline after issuing the Subordinate CA certificate is the recommended best practice. For general two-tier PKI architecture guidance, see [AD CS Two Tier PKI Hierarchy Deployment](https://techcommunity.microsoft.com/blog/microsoft-security-blog/step-by-step-2-tier-pki-lab/4413982) and [AD CS design guide](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831348(v=ws.11)).

- An account with permissions to install and configure the Certificate Services role on each CA server.

- AD CS role and Certification Authority role service installed on the Root CA server. For detailed steps, see [Install Active Directory Certificate Services using Server Manager](/windows-server/networking/core-network-guide/cncg/server-certs/install-the-certification-authority#install-active-directory-certificate-services-using-server-manager).

## Choose an ML-DSA parameter set

Before you configure your CAs, choose an ML-DSA parameter set. ML-DSA provides three parameter sets, each offering a different NIST security level. Each parameter set has fixed public and private key sizes that you can't change. You can use any parameter set for Root CAs, Subordinate CAs, or end-entity certificates.

| Parameter set | Public key size | Private key size | Signature size | NIST security level |
|---|---|---|---|---|
| ML-DSA-44 | 1,312 bytes | 2,560 bytes | 2,420 bytes | Level 2 |
| ML-DSA-65 | 1,952 bytes | 4,032 bytes | 3,309 bytes | Level 3 |
| ML-DSA-87 | 2,592 bytes | 4,896 bytes | 4,627 bytes | Level 5 |

When you select an ML-DSA provider during CA configuration, the hash algorithm defaults to **NoHash**. Unlike traditional algorithms such as RSA where signing involves a pre-hash step like SHA-256, ML-DSA handles message hashing internally as part of the signature operation. ML-DSA doesn't require an external hash algorithm.

## Set up the Root CA

After you install the AD CS role and Certification Authority role service, the next step is to configure the CA with an ML-DSA cryptographic provider. The configuration process involves selecting the CA type (Root CA), choosing to create a new private key, and then selecting the desired ML-DSA provider that corresponds to the parameter set you chose.

### Configure the root CA with ML-DSA

After the role installs, configure the root CA with an ML-DSA cryptographic provider. 

1. After installation, select the **Configure Active Directory Certificate Services** link in Server Manager.

1. On the Setup Type page, select one of the following:  

   - **Enterprise:** if the server is domain-joined. Suitable for lab and test environments.  

   - **Standalone:** if the server isn't domain-joined. Recommended for production.  
  
1. On the **CA Type** page, select **Root CA**.

1. On the **Private Key** page, select **Create a new private key**.

1. On the **Cryptography for CA** page, select one of the following ML-DSA cryptographic providers:

   - `ML-DSA:44#Microsoft Software Key Storage Provider`

   - `ML-DSA:65#Microsoft Software Key Storage Provider`

   - `ML-DSA:87#Microsoft Software Key Storage Provider`

   The **Key Length** field displays the public key size in bits for the selected parameter set. The **Hash algorithm** defaults to **NoHash**.

   :::image type="content" source="media/configure-ml-dsa-certification-authority/cryptography-for-ca.png" alt-text="Screenshot of the AD CS Cryptography for CA page with the ML-DSA-87 provider selected, showing a key length of 20736 and NoHash as the hash algorithm.":::

1. Complete the remaining pages by using the default settings, and then select **Configure** to finish setup.

Alternatively, configure the root CA by using PowerShell. The following example uses ML-DSA-87:

```powershell
# KeyLength is specified in bits. For ML-DSA-87: 2592 bytes x 8 = 20736 bits  

# For Standalone Root CA (recommended for production)  
Install-AdcsCertificationAuthority `  
    -CAType StandaloneRootCA `  
    -CACommonName "<your-root-ca-name>" `  
    -KeyLength 20736 `  
    -HashAlgorithm NoHash `  
    -CryptoProviderName "ML-DSA:87#Microsoft Software Key Storage Provider"  
    
# For Enterprise Root CA (lab and test environments)  
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

   :::image type="content" source="media/configure-ml-dsa-certification-authority/root-ca-certificate-details.png" alt-text="Screenshot of the root CA certificate Details tab showing ML-DSA-87 as both the signature algorithm and the public key algorithm.":::

The CA service automatically publishes certificate revocation lists (CRLs) when it starts and signs them by using the configured ML-DSA algorithm.

## Set up the subordinate CA

Configure the subordinate CA as an Enterprise CA (domain-joined) so it can use Active Directory for certificate enrollment and template management. The setup steps for a subordinate CA are similar to the root CA, with two key differences:

- Select **Subordinate CA** as the CA type.
- You can choose a different ML-DSA parameter set from the root CA. Each CA in the hierarchy can use a distinct ML-DSA configuration.

### Configure the subordinate CA

After installing the AD CS role and Certification Authority role service on the subordinate CA server, configure it with an ML-DSA provider and submit a certificate request to the root CA.

1. After installation, select the **Configure Active Directory Certificate Services** link in Server Manager.

1. On the **Setup Type** page, select **Enterprise**.

1. On the **CA Type** page, select **Subordinate CA**.  

1. Select **Create a new private key**.

1. On the **Cryptography for CA** page, select an ML-DSA cryptographic provider. For example, **ML-DSA:65#Microsoft Software Key Storage Provider**.

   :::image type="content" source="media/configure-ml-dsa-certification-authority/cryptography-for-subordinate-ca.png" alt-text="Screenshot of the AD CS Cryptography for CA page for the subordinate CA with the ML-DSA-65 provider selected, showing a key length of 15616 and NoHash as the hash algorithm.":::

1. On the **Certificate Request** page, select one of the following options:  

   - **Send a certificate request to a parent CA**, and then choose the previously configured Root CA - if the Root CA is online and reachable.  

   - **Save a certificate request to a file on the target machine** - if the Root CA is offline (standalone). Submit the request manually to the Root CA, retrieve the issued certificate, and install it.

1. Complete the remaining pages by using the default settings, and then select **Configure**.

### Verify the subordinate CA certificate

Confirm the subordinate CA certificate shows the expected ML-DSA algorithms for both the signature and public key.

1. Open the **Certification Authority** console (`certsrv.msc`) on the subordinate CA.

1. Right-click the CA name, select **Properties**, and then select **View Certificate**.

1. On the **Details** tab, confirm:
   - **Signature algorithm**: Shows the Root CA's ML-DSA parameter set (for example, ML-DSA-87), because the Root CA signs the subordinate CA certificate.
   - **Public key**: Shows the subordinate CA's own ML-DSA parameter set (for example, ML-DSA-65).

   :::image type="content" source="media/configure-ml-dsa-certification-authority/subordinate-ca-certificate-details.png" alt-text="Screenshot of the subordinate CA certificate Details tab showing ML-DSA-87 as the signature algorithm and ML-DSA-65 as the public key algorithm.":::

1. On the **Certification Path** tab, verify the chain displays both the Root CA and subordinate CA certificates.

   :::image type="content" source="media/configure-ml-dsa-certification-authority/subordinate-ca-certification-path.png" alt-text="Screenshot of the Certification Path tab showing a two-tier certificate chain with the root CA and subordinate CA.":::

## Related content

- [What is ML-DSA support in AD CS?](ml-dsa-overview.md)
- [Configure certificate templates for ML-DSA](configure-ml-dsa-certificate-templates.md)
- [Configure OCSP responders to use ML-DSA](configure-ml-dsa-ocsp-responder.md)
- [Post-quantum cryptography in AD CS overview](post-quantum-cryptography-overview.md)
- [PKI design considerations using AD CS](pki-design-considerations.md)
