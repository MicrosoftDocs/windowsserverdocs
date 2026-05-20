---
title: Configure OCSP responders to use ML-DSA in Windows Server
description: Learn how to configure ML-DSA post-quantum OCSP response signing in Active Directory Certificate Services (AD CS) for certificate revocation checking.
#customer intent: As a Windows Server PKI administrator, I want to configure my OCSP responder to use ML-DSA so that certificate revocation checking supports post-quantum cryptography.
author: robinharwood
ms.topic: how-to
ms.author: roharwoo
ms.reviewer: Tjha
ms.date: 05/12/2026
ai-usage: ai-generated
---

# Configure Online Responders (OCSP) to use ML-DSA

This article describes how to configure an Online Responder (OCSP) to sign responses by using Module-Lattice-Based Digital Signature Algorithm (ML-DSA) in Active Directory Certificate Services (AD CS). When you configure OCSP with ML-DSA, you enable revocation checking for certificates by using post-quantum signed responses.

## Prerequisites

- A Subordinate CA configured with ML-DSA and issuing certificates. See [Configure a certification authority to use ML-DSA](configure-ml-dsa-certification-authority.md).

- A domain-joined member server for the Online Responder, running Windows Server 2025 with the 2026-05 Security update ([KB5087539](https://support.microsoft.com/help/5087539)) or later installed. Ensure that the Online Responder role service is installed on this server. The installation steps are the same as for any Online Responder deployment. For detailed guidance, see [Implementing an OCSP Responder: Configuring OCSP for use with Enterprise CAs](https://techcommunity.microsoft.com/blog/askds/implementing-an-ocsp-responder-part-iii---configuring-ocsp-for-use-with-enterpri/396584).


- An account with permissions to install and configure AD CS role services.

- Membership in **Domain Admins** or equivalent to manage certificate templates.

## Create an OCSP Response Signing template with ML-DSA

Before configuring the OCSP responder, create an OCSP Response Signing certificate template that uses ML-DSA.

1. Open the **Certificate Templates** console on a machine with AD CS management tools installed.

1. Right-click the **OCSP Response Signing** template, and then select **Duplicate Template**.

1. On the **General** tab, enter a **Template display name** (for example, *PQC OCSP Response Signing*).

1. On the **Cryptography** tab:
   - Set **Provider Category** to **Key Storage Provider**.
   - Set **Algorithm name** to the desired ML-DSA parameter set (for example, **ML-DSA:65**).
   - The **Minimum key size** and **Request hash** fields update automatically.

   :::image type="content" source="media/configure-ml-dsa-ocsp-responder/ocsp-template-cryptography-ml-dsa-65.png" alt-text="Screenshot of the OCSP Response Signing template Cryptography tab with Provider Category set to Key Storage Provider and Algorithm name set to ML-DSA:65.":::

1. On the **Security** tab, grant **Enroll** and **Autoenroll** permissions to the computer account of the OCSP responder.

1. Select **OK** to save the template.

1. In the **Certification Authority** console on the Subordinate CA configured with ML-DSA, right-click **Certificate Templates**, select **New** > **Certificate Template to Issue**, and then select the template you created.

## Configure the OCSP revocation provider

The revocation provider configuration is where ML-DSA-specific settings apply. You associate the Online Responder with your ML-DSA Subordinate CA and specify the ML-DSA signing certificate template.

1. Open the **Online Responder Management** console (`ocsp.msc`).

1. Right-click **Revocation Configuration** and select **Add Revocation Configuration**.

1. On the **Name the Revocation Configuration** page, enter a name (for example, *PQC SubCA OCSP*).

1. On the **Select CA Certificate Location** page, select **Select a certificate for an Existing enterprise CA**.

1. On the **Choose CA Certificate** page, select **Browse CA certificates published in Active Directory**, and then select the Subordinate CA configured with ML-DSA.

1. On the **Select Signing Certificate** page:
   - Select **Automatically select a signing certificate**.
   - Select **Auto-Enroll for an OCSP signing certificate**.
   - Set the **Certification authority** to the Subordinate CA configured with ML-DSA.
   - Set the **Certificate Template** to the ML-DSA OCSP Response Signing template you created (for example, *PQCOCSPResponseSigning*).

   :::image type="content" source="media/configure-ml-dsa-ocsp-responder/select-signing-certificate.png" alt-text="Screenshot of the Select Signing Certificate page with auto-enroll selected and the PQCOCSPResponseSigning template chosen.":::

1. Select **Finish** to complete the configuration.

1. In the **Online Responder Management** console, under **Array Configuration**, verify that the **Revocation Configuration Status** shows:
   - **Signing Certificate**: OK
   - **Revocation Provider Status**: The ML-DSA revocation provider is successfully configured.

   :::image type="content" source="media/configure-ml-dsa-ocsp-responder/revocation-configuration-status.png" alt-text="Screenshot of the Online Responder Management console showing Signing Certificate OK and successful revocation provider status.":::

## Update the AIA extension on the subordinate CA

To direct clients to use the OCSP responder for ML-DSA certificate revocation checking, add the OCSP URL to the Authority Information Access (AIA) extension on the subordinate CA.

1. On the subordinate CA, open the **Certification Authority** console (`certsrv.msc`).

1. Right-click the CA name and select **Properties**.

1. On the **Extensions** tab, select **Authority Information Access (AIA)** from the dropdown.

1. Select **Add** and enter the OCSP responder URL (for example, `http://<ocsp-server-fqdn>/ocsp`).

1. Check **Include in the online certificate status protocol (OCSP) extension**.

1. Clear **Include in the AIA extension of issued certificates** for the OCSP URL entry.

   :::image type="content" source="media/configure-ml-dsa-ocsp-responder/aia-extension-properties.png" alt-text="Screenshot of the CA Properties Extensions tab showing the Authority Information Access extension with the OCSP responder URL added.":::

1. Select **OK** and restart the CA service when prompted.

> [!IMPORTANT]
> The AIA extension change applies only to certificates issued after the change. Previously issued certificates continue to reference the original AIA locations.

## Validate ML-DSA OCSP responses

After configuration, verify that the OCSP responder correctly returns ML-DSA signed responses.

### Verify by using `certutil`

1. Enroll for a test certificate from the Subordinate CA by using an ML-DSA template. Export the certificate to a `.cer` file.

1. Run the following command to check the revocation status:

   ```cmd
   certutil -verify -urlfetch <certificate-file>.cer
   ```

1. In the output, look for the **Certificate OCSP** section. A valid certificate shows:

   ```output
   Verified "OCSP" Time: 0
   ```

1. To verify the responder correctly identifies revoked certificates, revoke the certificate on the issuing CA, publish a new certificate revocation list (CRL), and then run the same command. A revoked certificate shows:

   ```output
   Revoked "OCSP" Time: 0
   ```

### Verify the ML-DSA signature

To confirm the OCSP response uses an ML-DSA signature, inspect the signing certificate in the **Online Responder Management** console:

1. Open `ocsp.msc` on the OCSP responder server.

1. Select the revocation configuration, and then select **View Signing Certificate**.

1. On the **Details** tab, confirm the **Public key** field shows the ML-DSA parameter set and key size.

1. The **Signature algorithm** shows the issuing CA's ML-DSA parameter set, confirming the ML-DSA CA issued the signing certificate.

## Related content

- [What is ML-DSA support in AD CS?](ml-dsa-overview.md)
- [Configure a certification authority to use ML-DSA](configure-ml-dsa-certification-authority.md)
- [Configure certificate templates for ML-DSA](configure-ml-dsa-certificate-templates.md)
- [Post-quantum cryptography in AD CS overview](post-quantum-cryptography-overview.md)
