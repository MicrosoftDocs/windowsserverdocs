---
title: Configure certificate templates for ML-DSA (preview) in Windows Server
description: Learn how to configure AD CS certificate templates to use ML-DSA (preview) post-quantum cryptography for code signing, TLS, and client authentication.
#customer intent: As a Windows Server PKI administrator, I want to configure certificate templates for ML-DSA so that I can issue post-quantum certificates for code signing, TLS, and client authentication.
author: robinharwood
ms.topic: how-to
ms.author: roharwoo
ms.date: 05/12/2026
ai-usage: ai-assisted
---

# Configure certificate templates for ML-DSA (preview)

This article describes how to configure Active Directory Certificate Services (AD CS) certificate templates to use Module-Lattice-Based Digital Signature Algorithm (ML-DSA) (preview) as the public key algorithm. After configuring certificate templates, users and computers with appropriate permissions can enroll for ML-DSA certificates.

> [!IMPORTANT]
> ML-DSA support in AD CS is currently in PREVIEW. This information relates to a prerelease feature that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

ML-DSA is a signature-only algorithm and doesn't support encryption operations. This limitation means you must configure the certificate template for signing, and Application Policies (EKU) and Key Usage extensions must not include encryption-related options.

Before you configure certificate templates, make sure you have a CA hierarchy that uses ML-DSA. For more information, see [Configure a certification authority to use ML-DSA](configure-ml-dsa-certification-authority.md).

## Prerequisites

Before you begin, make sure you meet the following requirements:

- A Root CA and Subordinate CA configured with ML-DSA. See [Configure a certification authority to use ML-DSA](configure-ml-dsa-certification-authority.md).
- Membership in **Domain Admins** or equivalent to manage certificate templates.
- Access to the **Certificate Templates** console on a computer with AD CS management tools installed.
- For client enrollment testing: a domain-joined client running Windows 11, version 24H2 or 25H2, with the latest cumulative update installed.

## Template requirements for ML-DSA

A certificate template must meet two requirements to support ML-DSA (preview) as the public key algorithm:

- **Cryptography Next Generation (CNG) provider**: Set the provider category to **Key Storage Provider**, not a legacy Cryptographic Service Provider (CSP). Only CNG providers support post-quantum algorithms like ML-DSA.
- **Signature purpose**: Set the **Purpose** under **Request Handling** to **Signature**. ML-DSA supports only signing operations, not encryption.

To make CNG providers available in the template, set both the **Certification Authority** and **Certificate Recipient** compatibility settings to at least **Windows Server 2008**.

### Built-in templates with signature purpose

The following built-in templates have their **Purpose** set to **Signature** by default. You can select ML-DSA algorithms after you set the **Provider Category** to **Key Storage Provider** on the **Cryptography** tab:

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

For any other template, change the **Purpose** to **Signature** on the **Request Handling** tab before configuring ML-DSA.

### Extension compatibility

When configuring templates for ML-DSA, ensure the following extensions are compatible:

- **Application Policies (EKU)**: Don't include encryption-related OIDs such as **Encrypting File System** or **Secure E-mail**.
- **Key Usage**: Don't include encryption options such as **Allow key exchange only with key encryption**.

## Configure a code signing template with ML-DSA

To create an ML-DSA (preview) code signing template, duplicate the built-in **Code Signing** template.

1. Open the **Certificate Templates** console. Right-click the **Code Signing** template, and then select **Duplicate Template**.

1. On the **Compatibility** tab:
   - Set **Certification Authority** to **Windows Server 2008** or later.
   - Set **Certificate recipient** to **Windows Vista / Server 2008** or later.

1. On the **General** tab, enter a **Template display name** (for example, *PQC Code Signing*) and configure the validity and renewal periods as needed.

1. On the **Request Handling** tab, confirm the **Purpose** is set to **Signature**.

1. On the **Cryptography** tab:
   - Set **Provider Category** to **Key Storage Provider**.
   - Set **Algorithm name** to an ML-DSA parameter set (for example, **ML-DSA-44**). The **Minimum key size** and **Request hash** fields update automatically.

   <!-- SCREENSHOT: Show the Cryptography tab with Provider Category set to Key Storage Provider, Algorithm name set to ML-DSA-44, showing the auto-populated key size and NoHash fields. The ML-DSA options in the Algorithm name dropdown are new and readers need to confirm they appear. -->

1. On the **Security** tab, grant **Enroll** and **Autoenroll** permissions to the appropriate users or groups.

1. Select **OK** to save the template.

1. In the **Certification Authority** console on the issuing CA, right-click **Certificate Templates**, select **New** > **Certificate Template to Issue**, and then select the template you created.

## Configure a TLS certificate template with ML-DSA

Configure an ML-DSA (preview) TLS certificate template by duplicating the built-in **Web Server** template. Because the default Web Server template uses **Signature and encryption** as its purpose, you must change the purpose to **Signature** for ML-DSA compatibility.

1. Open the **Certificate Templates** console. Right-click the **Web Server** template, and then select **Duplicate Template**.

1. On the **Compatibility** tab:
   - Set **Certification Authority** to **Windows Server 2008** or later.
   - Set **Certificate recipient** to **Windows Vista / Server 2008** or later.

1. On the **General** tab, enter a **Template display name** (for example, *PQC Web Server*).

1. On the **Request Handling** tab, change the **Purpose** to **Signature**.

   <!-- SCREENSHOT: Show the Request Handling tab with Purpose set to Signature. This is a critical change for Web Server templates since the default is Signature and encryption, and ML-DSA won't work without this change. -->

1. On the **Cryptography** tab:
   - Set **Provider Category** to **Key Storage Provider**.
   - Set **Algorithm name** to the desired ML-DSA parameter set (for example, **ML-DSA-65**).

1. On the **Extensions** tab, verify that **Application Policies** includes only **Server Authentication** and doesn't include encryption-related policies.

1. On the **Security** tab, grant **Enroll** permissions to the appropriate computer accounts or groups.

1. Select **OK** to save the template, and then publish it on the issuing CA.

> [!NOTE]
> For Web Server templates, enroll by using the **Local Computer** certificate store (`certlm.msc`) instead of the current user store. Grant permissions to the computer object that needs the certificate.

You can configure client TLS certificate templates, such as **User** and **Computer**, the same way. Make sure the **Application Policies (EKU)** extension doesn't include **Encrypting File System** or **Secure E-mail**.

## Enroll for an ML-DSA certificate

After you configure and publish an ML-DSA (preview) template on the issuing CA, users with the appropriate permissions can enroll for ML-DSA certificates. The following sections describe two enrollment methods.

### Enroll by using certmgr.msc

1. Sign in to the client machine as a user with **Enroll** permissions on the published template.

1. Open `certmgr.msc` (for user certificates) or `certlm.msc` (for computer certificates).

1. Expand **Personal**, right-click **Certificates**, and then select **All Tasks** > **Request New Certificate**.

1. In the **Certificate Enrollment** wizard, select the published ML-DSA template (for example, **PQC Code Signing**), and then select **Enroll**.

1. After enrollment succeeds, open the issued certificate and verify on the **Details** tab:
   - **Signature algorithm**: Shows the issuing CA's ML-DSA parameter set.
   - **Public key**: Shows the template's ML-DSA parameter set and key size.

   <!-- SCREENSHOT: Show the issued certificate Details tab with ML-DSA Signature algorithm and Public key values. Confirms successful enrollment with PQC. -->

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

After enrollment, verify that the CA issued the ML-DSA (preview) certificate correctly:

1. Open `certmgr.msc` or `certlm.msc` and go to **Personal** > **Certificates**.

1. Double-click the issued certificate to open it.

1. On the **Details** tab, confirm:
   - **Signature algorithm**: Shows the issuing CA's ML-DSA parameter set.
   - **Public key**: Shows the ML-DSA parameter set that the template specifies.
   - **Enhanced Key Usage**: Shows the expected purpose, such as Code Signing or Server Authentication.

1. On the **Certification Path** tab, verify the full chain from Root CA through Subordinate CA to the end-entity certificate.

   <!-- SCREENSHOT: Show the Certification Path tab displaying the full three-level chain (Root CA > Subordinate CA > end-entity certificate). Confirms the PQC chain validates correctly. -->

## Related content

- [Configure a certification authority to use ML-DSA](configure-ml-dsa-certification-authority.md)
- [Configure OCSP responders to use ML-DSA](configure-ml-dsa-ocsp-responder.md)
- [Manage certificate templates](manage-certificate-templates.md)
- [Certificate template concepts](certificate-template-concepts.md)
