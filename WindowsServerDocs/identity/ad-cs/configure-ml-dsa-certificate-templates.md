---
title: Configure certificate templates for ML-DSA in Windows Server
description: Learn how to configure AD CS certificate templates to use ML-DSA post-quantum cryptography for code signing, TLS, and client authentication.
#customer intent: As a Windows Server PKI administrator, I want to configure certificate templates for ML-DSA so that I can issue post-quantum certificates for code signing, TLS, and client authentication.
author: robinharwood
ms.topic: how-to
ms.author: roharwoo
ms.reviewer: Tjha
ms.date: 05/12/2026
ai-usage: ai-generated
---

# Configure certificate templates for ML-DSA

This article describes how to configure Active Directory Certificate Services (AD CS) certificate templates to use Module-Lattice-Based Digital Signature Algorithm (ML-DSA) as the public key algorithm. After configuring certificate templates, users and computers with appropriate permissions can enroll for ML-DSA certificates.

ML-DSA is a signature-only algorithm and doesn't support encryption operations. This limitation means you must configure the certificate template for signing, and Application Policies (EKU) and Key Usage extensions must not include encryption-related options.

## Prerequisites

- A Root CA and Subordinate CA configured with ML-DSA. See [Configure a certification authority to use ML-DSA](configure-ml-dsa-certification-authority.md).
- Membership in **Domain Admins** or equivalent to manage certificate templates.
- Access to the **Certificate Templates** console on a computer with AD CS management tools installed.
- For client enrollment testing: a domain-joined client running Windows 11, version 24H2 or 25H2 with the 2025-10 non-security update ([KB5067036](https://support.microsoft.com/en-us/topic/october-28-2025-kb5067036-os-builds-26200-7019-and-26100-7019-preview-ec3da7dc-63ba-4b1d-ac41-cf2494d2123a)) or later installed.

## Review ML-DSA template requirements

A certificate template must meet two requirements to support ML-DSA as the public key algorithm:

- **Cryptography API: Next Generation (CNG) provider**: Set the provider to a non-legacy Cryptographic Service Provider (CSP), such as **Key Storage Provider**. Post-quantum cryptography (PQC) algorithms like ML-DSA are only supported by CNG providers.
- **Signature purpose**: Set the **Purpose** under **Request Handling** to **Signature**. ML-DSA supports only signing operations, not encryption.

To make CNG providers available in the template, set both the **Certification Authority** and **Certificate recipient** compatibility settings to at least **Windows Server 2008**.

### Built-in templates compatible with ML-DSA

The following built-in templates have their **Purpose** set to **Signature** by default. As a result, ML-DSA algorithms are available after setting **Key Storage Provider** on the **Cryptography** tab.

- User Signature Only
- Authenticated Session
- Code Signing
- Trust List Signing
- Enrollment Agent
- Exchange Signature Only
- Exchange Enrollment Agent (Offline request)
- Enrollment Agent (Computer)
- Root Certification Authority
- Subordinate Certification Authority
- Cross Certification Authority
- OCSP Response Signing

To use any other template, change the **Purpose** to **Signature** on the **Request Handling** tab before configuring ML-DSA.

### Extension compatibility

When configuring templates for ML-DSA, also ensure the following extensions are compatible:

- **Application Policies (EKU)**: Don't include encryption-related OIDs such as **Encrypting File System** or **Secure E-mail**.
- **Key Usage**: Don't include encryption options such as **Allow key exchange only with key encryption**.

## Configure a code signing template with ML-DSA

To create an ML-DSA code signing template, duplicate the built-in **Code Signing** template. The built-in template defaults to a compatibility setting of Windows Server 2003, which doesn't support CNG providers. The duplicated template lets you update the compatibility settings so ML-DSA algorithms become available.

1. Open the **Certificate Templates** console. Right-click the **Code Signing** template, and then select **Duplicate Template**.

1. On the **Compatibility** tab:
   - Set **Certification Authority** to **Windows Server 2008** or later.
   - Set **Certificate recipient** to **Windows Vista / Server 2008** or later.

1. On the **General** tab, enter a **Template display name** (for example, *PQC Code Signing*) and configure the validity and renewal periods as needed.

1. On the **Request Handling** tab, confirm the **Purpose** is set to **Signature**.

1. On the **Cryptography** tab:
   - Set **Provider Category** to **Key Storage Provider**.
   - Set **Algorithm name** to an ML-DSA parameter set (for example, **ML-DSA:44**). The **Minimum key size** and **Request hash** fields update automatically.

   :::image type="content" source="media/configure-ml-dsa-certificate-templates/template-cryptography-ml-dsa-options.png" alt-text="Screenshot of the certificate template Cryptography tab with Provider Category set to Key Storage Provider and the Algorithm name dropdown showing the ML-DSA:44, ML-DSA:65, and ML-DSA:87 options.":::

   The completed Cryptography tab for the code signing template shows the ML-DSA parameter set selected, with the **Minimum key size** and **Request hash** fields populated automatically.

   :::image type="content" source="media/configure-ml-dsa-certificate-templates/code-signing-cryptography-ml-dsa-44.png" alt-text="Screenshot of the PQC Code Signing template Cryptography tab with Provider Category set to Key Storage Provider, Algorithm name set to ML-DSA:44, and Request hash set to NoHash.":::

1. On the **Security** tab, grant **Enroll** and **Autoenroll** permissions to the appropriate users or groups.

1. Select **OK** to save the template.

1. In the **Certification Authority** console on the issuing CA, right-click **Certificate Templates**, select **New** > **Certificate Template to Issue**, and then select the template you created.

After you publish the template, see [Enroll for an ML-DSA certificate](#enroll-for-an-ml-dsa-certificate) to request a certificate.

## Configure a TLS certificate template with ML-DSA

Configure an ML-DSA TLS certificate template by duplicating the built-in **Web Server** template. Because the default Web Server template uses **Signature and encryption** as its **Purpose**, you must change the **Purpose** to **Signature** for ML-DSA compatibility.

1. Open the **Certificate Templates** console. Right-click the **Web Server** template, and then select **Duplicate Template**.

1. On the **Compatibility** tab:
   - Set **Certification Authority** to **Windows Server 2008** or later.
   - Set **Certificate recipient** to **Windows Vista / Server 2008** or later.

1. On the **General** tab, enter a **Template display name** (for example, *PQC Web Server*).

1. On the **Request Handling** tab, change the **Purpose** to **Signature**.

   :::image type="content" source="media/configure-ml-dsa-certificate-templates/web-server-request-handling-signature.png" alt-text="Screenshot of the Web Server template Request Handling tab with Purpose set to Signature.":::

1. On the **Cryptography** tab:
   - Set **Provider Category** to **Key Storage Provider**.
   - Set **Algorithm name** to the desired ML-DSA parameter set (for example, **ML-DSA:65**).

   :::image type="content" source="media/configure-ml-dsa-certificate-templates/web-server-cryptography-ml-dsa-65.png" alt-text="Screenshot of the PQC Web Server template Cryptography tab with Provider Category set to Key Storage Provider and Algorithm name set to ML-DSA:65.":::

1. On the **Extensions** tab, verify that **Application Policies** includes only **Server Authentication** and doesn't include encryption-related policies.

1. On the **Security** tab, grant **Enroll** permissions to the appropriate computer accounts or groups.

1. Select **OK** to save the template, and then publish it on the issuing CA.

You can configure client TLS certificate templates, such as **User** and **Computer**, the same way. Make sure the **Application Policies (EKU)** extension doesn't include **Encrypting File System** or **Secure E-mail**.

:::image type="content" source="media/configure-ml-dsa-certificate-templates/user-template-extensions-client-authentication.png" alt-text="Screenshot of the PQC User template Extensions tab with Application Policies selected and Client Authentication listed in the Description of Application Policies.":::

## Enroll for an ML-DSA certificate

After you configure and publish an ML-DSA template on the issuing CA, users with the appropriate permissions can enroll for ML-DSA certificates. The following sections describe two enrollment methods.

### Enroll by using certmgr.msc

Use the graphical certificate enrollment tool to request a certificate from the published ML-DSA template.

1. Sign in to the client machine as a user with **Enroll** permissions on the published template.

1. Open `certmgr.msc` (for user certificates) or `certlm.msc` (for computer certificates).

1. Expand **Personal**, right-click **Certificates**, and then select **All Tasks** > **Request New Certificate**.

1. In the **Certificate Enrollment** wizard, select the published ML-DSA template (for example, **PQC Code Signing** or **PQC Web Server**), and then select **Enroll**.

1. After enrollment succeeds, open the issued certificate and verify on the **Details** tab:
   - **Signature algorithm**: Shows the issuing CA's ML-DSA parameter set.
   - **Public key**: Shows the template's ML-DSA parameter set and key size.

   > [!NOTE]
   > For Web Server templates, enroll by using the **Local Computer** certificate store (`certlm.msc`) instead of the current user store (`certmgr.msc`). Grant permissions to the computer object that needs the certificate.

### Enroll by using an INF file and certreq

This method uses an INF file and the `certreq.exe` tool to request a certificate. It's useful for scripted or automated scenarios.

1. Create a text file named `request.inf` with the following content. This example requests a code signing certificate by using ML-DSA-44:

   ```inf
   [Version]
   Signature="$Windows NT$"

   [NewRequest]
   Subject = "CN=<subject-name>"
   KeyUsage = 0x80
   Keyspec = AT_SIGNATURE
   ProviderName = "Microsoft Software Key Storage Provider"
   ProviderType = 0
   HashAlgorithm = NoHash
   KeyAlgorithm = "ML-DSA:44"
   Exportable = TRUE
   RequestType = PKCS10
   SMIME = False

   [EnhancedKeyUsageExtension]
   OID=1.3.6.1.5.5.7.3.3
   Critical=FALSE

   [Extensions]
   2.5.29.19 = "{text}CA=False"

   [RequestAttributes]
   CertificateTemplate = <template-name>
   ```

   Replace `<subject-name>` with the certificate subject and `<template-name>` with the name of your published template.

   For a TLS certificate, use the following changes:
   - Set `KeyAlgorithm = "ML-DSA:65"` (or the parameter set that your template uses).
   - In `[EnhancedKeyUsageExtension]`, use `OID=1.3.6.1.5.5.7.3.1` for Server Authentication.
   - Set `CertificateTemplate` to your TLS template name.

1. Generate the certificate request:

   ```cmd
   certreq -new request.inf request.req
   ```

1. Submit the request to the CA:

   ```cmd
   certreq -submit request.req certificate.cer
   ```

1. Install the issued certificate:

   ```cmd
   certreq -accept certificate.cer
   ```

## Verify the issued ML-DSA certificate

After enrollment, verify that the CA issued the ML-DSA certificate correctly:

1. Open `certmgr.msc` or `certlm.msc` and go to **Personal** > **Certificates**.

1. Double-click the issued certificate to open it.

1. On the **Details** tab, confirm:
   - **Signature algorithm**: Shows the issuing CA's ML-DSA parameter set.
   - **Public key**: Shows the ML-DSA parameter set that the template specifies.
   - **Enhanced Key Usage**: Shows the expected purpose, such as Code Signing or Server Authentication.

1. On the **Certification Path** tab, verify the full chain from Root CA through Subordinate CA to the end-entity certificate.

## Related content

- [What is ML-DSA support in AD CS?](ml-dsa-overview.md)
- [Configure a certification authority to use ML-DSA](configure-ml-dsa-certification-authority.md)
- [Configure Online Responders (OCSP) to use ML-DSA](configure-ml-dsa-online-responder.md)
- [Manage certificate templates](manage-certificate-templates.md)
- [Certificate template concepts](certificate-template-concepts.md)
