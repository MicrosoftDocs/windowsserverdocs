---
title: Configure AIA and Path Validation in AD CS
titleSuffix: Windows Server
description: Configure AIA issuer-certificate retrieval and validate certificate-path and revocation endpoints on Windows Server 2025.
#customer intent: As an IT administrator, I want to configure issuer-certificate retrieval and validate certificate endpoints so that clients can build and verify certificate chains.
author: orin-thomas
ms.author: orthomas
ms.topic: how-to
ms.date: 08/17/2026
ai-usage: ai-assisted
---

# Configure AIA issuer retrieval and validate certificate endpoints

Certificate path validation is the process a Windows client uses to build and verify a certificate's chain of trust. This process includes locating the issuing certification authority (CA) certificate and checking whether the certificate is revoked. When a client can't reach the endpoints that supply this information, certificate-dependent connections can fail, or a client might accept a certificate that it should reject.

This article shows you how to configure Authority Information Access (AIA) issuer-certificate retrieval and validate the certificate-path and revocation endpoints on managed Windows Server 2025 computers, so that clients can reliably build and verify certificate chains. The Certificate Path Validation Settings control that this procedure uses is computer scoped.

This article doesn't distribute trusted roots, intermediate certificates, or disallowed certificates. Separate articles cover those tasks; the Related content section at the end of this article lists them.

## Prerequisites

- A Windows Server 2025 test computer in the organizational unit that receives the policy.
- An account with permission to create or edit the Group Policy Object (GPO) and link it to the target scope, or, for local or nondelegated administration, an account that has the required administrative rights.
- A certification authority (CA) administrator to review the AIA, certificate revocation list (CRL) distribution point (CDP), and Online Certificate Status Protocol (OCSP) endpoints that the CA puts in new certificates.
- A test certificate chain that includes an end-entity certificate, its issuing CA certificate, and a revocation endpoint that you can control.
- A controlled test for each of these conditions: normal endpoint access, cleared user URL cache, blocked AIA or revocation access, and a revoked certificate.

## Understand AIA, CDP, OCSP, and caching

Certificate path validation uses certificate extensions and local state. Keep the following distinctions clear when you design the policy:

| Component | Purpose | Operational decision |
|---|---|---|
| Authority Information Access (AIA) | Identifies a location for the issuing CA certificate. When Windows can't build a complete chain from local stores, it might retrieve a missing intermediate certificate from AIA. | Keep issuer retrieval enabled unless you deliberately pre-stage every required issuer certificate and test the offline dependency. |
| CRL Distribution Point (CDP) | Identifies locations from which a client can retrieve certificate revocation information. | Publish reachable, monitored CRLs before issuing certificates that reference the CDP. |
| Online Certificate Status Protocol (OCSP) | Provides a signed status response for an individual certificate when the issuer includes an OCSP location. | Deploy and monitor an Online Responder only when the deployment has a tested signing-certificate and revocation-data design. |
| Cryptnet URL cache | Stores retrieved URL data, including time-valid OCSP responses and CRLs, in the cache of the identity that retrieved it. | Use a fresh test computer or a controlled test-cache baseline when you validate an outage. Don't assume every application uses the cache in the same way. |

When a Crypt32 caller builds a chain with online revocation checking enabled, Windows looks for a time-valid OCSP response or CRL in the following order: a stapled OCSP response included in the handshake, an OCSP response or CRL in the user's Cryptnet URL cache, a CRL in a system store, the OCSP URL in the certificate's AIA extension, and then the CRL distribution point in the certificate. Windows adds a successful download to the user's Cryptnet URL cache. This sequence describes the Windows chain engine. It isn't a guarantee for a browser, TLS client, or third-party cryptographic library that applies its own validation logic.

> [!NOTE]
> A cache-only chain or revocation check is an application API choice. It avoids the corresponding network retrieval and relies on previously available data. It isn't a general-purpose server policy that makes offline validation safe.

## Limit the certificate path validation scope

Open the GPO at **Computer Configuration** > **Policies** > **Windows Settings** > **Security Settings** > **Public Key Policies** > **Certificate Path Validation Settings**.

This procedure changes only the AIA issuer-retrieval control on the **Network Retrieval** tab. It doesn't prescribe trust-store, trusted-publisher, retrieval-timeout, or revocation-tab settings. Keep those decisions in their dedicated policy and application-owner processes.

| Area | What this procedure does |
|---|---|
| Network Retrieval | Configures AIA issuer retrieval and validates the endpoint path. |
| Trust stores and publisher trust | Links to dedicated content rather than changing trust or publisher policy. |
| Revocation endpoint behavior | Tests the AIA, CDP, and OCSP data that certificates and applications use. It doesn't change a Certificate Path Validation revocation setting. |

## Configure issuer-certificate retrieval

The Windows Server policy that controls AIA retrieval is on the **Network Retrieval** tab.

1. In Group Policy Management, create or select the dedicated computer-scoped GPO.
1. Open **Certificate Path Validation Settings**.
1. On the **Network Retrieval** tab, select **Define these policy settings**.
1. Keep **Allow issuer certificate (AIA) retrieval during path validation** selected for a normal connected policy, and then select **OK**.
1. To create a deliberately disconnected policy, clear **Allow issuer certificate (AIA) retrieval during path validation** only after you pre-stage the required issuer certificates and complete the validation steps in this article.
1. To return the targeted computers to the default retrieval behavior, clear **Define these policy settings**, and then select **OK**.
1. Link the GPO only to the pilot computers, update policy, and validate the result before wider deployment.

On a pilot computer, refresh computer policy and inspect the applied GPO:

```cmd
gpupdate /target:computer /force
gpresult /scope computer /r
```

The documented setting is a computer configuration policy, so it applies to the computers that receive the GPO rather than to signed-in users. Application behavior can still differ when an application doesn't use the Windows chain engine.

## Review CA endpoint publication

Path policy can't repair certificates that contain unavailable endpoints. Before you deploy the GPO, review the CA configuration and the certificates that the CA issues.

1. On the CA, identify the AIA and CDP locations that the CA includes in new certificates.
1. Confirm that every required client network, including remote or segmented client networks, can reach each endpoint.
1. Confirm that the CDP publishes current CRLs at the interval the CA design requires.
1. If you deploy OCSP, configure the OCSP location on the CA:

   1. Open the CA's **Properties**, and on the **Extensions** tab select **Authority Information Access (AIA)**.
   1. Select **Add**, and then enter the responder URL.
   1. Select **Include in the online certificate status protocol (OCSP) extension**, and clear **Include in the AIA extension of issued certificates** for that entry.
   1. Restart the CA service when prompted.
   1. Validate the responder before you issue relying-party certificates.
1. Reissue a nonproduction test certificate after an endpoint change. Inspect that new certificate instead of assuming an earlier certificate acquired the new location.

Use the Active Directory Certificate Services (AD CS) cmdlets to review the CA configuration, rather than overwrite it without checking:

```powershell
Get-CAAuthorityInformationAccess
Get-CACrlDistributionPoint
```

If you add an endpoint, use [Add-CAAuthorityInformationAccess](/powershell/module/adcsadministration/add-caauthorityinformationaccess) with `-AddToCertificateAia` for an issuer-certificate location or `-AddToCertificateOcsp` for an OCSP location, or use the **Extensions** tab in the Certification Authority console. An AIA URI should specify either an AIA extension or an OCSP extension, but not both.

For an OCSP endpoint, see [Configure Online Responders (OCSP) to use ML-DSA in Windows Server](configure-ml-dsa-online-responder.md). The AIA extension procedure in that article applies to any OCSP responder URL; its ML-DSA prerequisites apply only to the ML-DSA scenario.

## Validate path and revocation retrieval

> [!IMPORTANT]
> Don't use an unreachable revocation endpoint, a cached result, or an offline result as evidence that a certificate is revoked. A revoked certificate and a certificate whose status can't be determined are different outcomes. Test both outcomes with a known certificate and record the application-specific result.

Run these tests from a client in scope for the GPO, not only from the CA.

Use `certutil` as an administrator diagnostic. Microsoft doesn't recommend `certutil` as a production-code dependency, and available parameters can vary by version. Use `certutil -?` or `certutil <parameter> -?` to check the local version.

1. Validate the normal path and online retrieval for a test certificate:

   ```cmd
   certutil -verify -urlfetch .\Leaf.cer
   ```

1. Verify the AIA, CDP, and OCSP URLs in a certificate. The command opens the URL Retrieval Tool, where you select **Retrieve** to test the URLs:

   ```cmd
   certutil -URL .\Leaf.cer
   ```

1. Show the current user's Cryptnet URL-cache entries:

   ```cmd
   certutil -URLCache *
   ```

1. On the nonproduction test client, run under the identity the application uses and clear the relevant current-user URL cache before the blocked-endpoint test:

   ```cmd
   certutil -URLCache * delete
   ```

   The deletion affects relevant URLs only in the cache of the identity that runs it. It doesn't clear URL caches for other identities, and it doesn't remove system-store CRLs or stapled OCSP data. Test a service workload under its actual identity and record the cache state. Don't clear a production user's cache merely to run a test.

1. Inventory certificates in the local computer's Personal store:

   ```powershell
   Get-ChildItem -Path Cert:\LocalMachine\My |
       Select-Object Subject, Thumbprint, NotAfter, HasPrivateKey
   ```

1. Run the following controlled cases and record the certificate, endpoint state, cache state, application, and result:

   | Case | Expected evidence |
   |---|---|
   | Normal client | The chain builds and, when needed, required endpoint retrieval succeeds. |
   | Disconnected client with the user URL cache cleared | Record whether the Windows chain engine or the tested application can complete validation without new endpoint retrieval. Don't assume a universal failure mode. |
   | Blocked AIA, CDP, or OCSP access | The diagnostic identifies the unreachable URL. Confirm that the application follows the organization's intended failure behavior. |
   | Revoked certificate | The tested relying party rejects the certificate as revoked when it enforces revocation checking. |

## Security considerations for certificate path validation

- Treat AIA, CDP, and OCSP availability as a security and availability dependency. Monitor the endpoints and test them from the client networks that rely on the certificates.
- If a workload has a separate revocation-policy requirement, test that workload under the policy its owner defines. This procedure doesn't configure broader revocation settings.
- Keep the policy limited to the intended computer population. A policy that's appropriate for an isolated segment might be unsafe for general-purpose servers.
- Don't use cache behavior as an availability design. A cache can make an endpoint outage appear healthy until the cached data is no longer usable.
- Review endpoint changes before a CA issues certificates. Old certificates keep their old endpoint references.

## Troubleshoot path validation

| Symptom | Action |
|---|---|
| The chain is incomplete. | Use `certutil -verify -urlfetch` to identify issuer retrieval. Check the AIA URI, DNS, proxy, firewall, and the availability of the issuing CA certificate. |
| The revocation check is inconclusive. | Inspect CDP and OCSP URLs by using `certutil -URL`. Test from the affected client network and distinguish an unreachable source from a revoked certificate. |
| A disconnected test gives inconsistent results. | Repeat the test on a fresh client, or on a test profile whose user URL cache you cleared. Record whether the application uses Crypt32 and whether it applies its own validation policy. |
| The GPO appears ineffective. | Confirm that the computer receives the intended GPO by using `gpresult /scope computer /r`, then check that **Define these policy settings** is selected on the **Network Retrieval** tab. |
| A new endpoint isn't visible in the certificate. | Issue a new test certificate after the CA change. Existing certificates don't acquire changed AIA or CDP values. |

## Related content

- [Authority Information Access in Windows](../../security/authority-information-access-retrieval.md)
- [Configure trusted roots and disallowed certificates in Windows](configure-trusted-roots-disallowed-certificates.md)
- [Distribute certificates to Windows devices by using Group Policy](distribute-certificates-group-policy.md)
- [PKI design considerations using Active Directory Certificate Services](pki-design-considerations.md)
- [Configure Online Responders (OCSP) to use ML-DSA in Windows Server](configure-ml-dsa-online-responder.md)
- [Crypt32 certificate revocation list (CRL) semantics](/windows/win32/seccrypto/certificate-revocation-list-semantics)
- [CertGetCertificateChain function](/windows/win32/api/wincrypt/nf-wincrypt-certgetcertificatechain)
