---
title: Request and Renew AD CS Certificates
titleSuffix: Windows Server
description: Request and renew user and computer certificates with the Certificates snap-in on Windows Server 2025 by using Active Directory enrollment policy.
#customer intent: As an IT administrator, I want to request and renew certificates with Certificates MMC so that users and computers maintain valid certificates.
author: orin-thomas
ms.author: orthomas
ms.topic: how-to
ms.date: 08/17/2026
ai-usage: ai-assisted
---

# Request and renew certificates with Certificates MMC

Use the Certificates snap-in in Microsoft Management Console (MMC) to request or renew certificates through Active Directory Certificate Services (AD CS) enrollment policy on Windows Server 2025. Users and computers rely on certificates to authenticate and to secure communication, and every certificate expires. You request new certificates and renew existing ones to keep the applications and services that depend on them working without interruption.

This article covers the interactive user and local-computer enrollment workflows. It doesn't duplicate Certification Authority Web Enrollment procedures or Group Policy trust-distribution procedures.

## Prerequisites

Before you request a certificate, make sure that:

- The enterprise certification authority (CA) that issues the certificate publishes the template.
- The requesting security principal has **Read** and **Enroll** permissions on the template. For a computer certificate, this principal is the computer object. The issuing CA also needs **Read** on the template. If you removed **Authenticated Users** from the template access control list (ACL), add each CA's computer account explicitly. See [Certification Authority can't use a certificate template](/troubleshoot/windows-server/certificates-and-public-key-infrastructure-pki/ca-cant-use-certificate-template).
- A domain-joined client that can reach Active Directory Domain Services (AD DS) and the issuing enterprise CA. This article uses the built-in **Active Directory Enrollment Policy**. Certificate Enrollment Policy Web Service (CEP) and Certificate Enrollment Web Service (CES) can support non-domain-joined clients when you configure them for that scenario, but that scenario is outside the scope of this article.
- You know whether the application uses the current-user, local-computer, or a particular service-account certificate store.
- You can supply any policy-approved request properties that the template requires.

> [!IMPORTANT]
> Administrative elevation doesn't replace template enrollment permissions. Use the requesting identity and certificate-store scope that the certificate's application requires.

## Choose the certificate store scope

Use the scope that matches the identity that uses the private key.

| Scope | Open it with | Use it for |
|---|---|---|
| Current user | `certmgr.msc` | A certificate for use in the signed-in user's context. |
| Local computer | `certlm.msc` | A certificate for use in the local computer's context, such as a computer-template certificate. |
| Service account | `mmc.exe`, then add the **Certificates** snap-in and select **Service account** | Inspecting or managing a named Windows service's store. Plan separately for the service runtime account to use the certificate's private key. |

To add a local-computer **Certificates** snap-in manually, run `mmc.exe`, then select **File** > **Add/Remove Snap-in** > **Certificates** > **Add** > **Computer account** > **Next** > **Local computer: (the computer this console is running on)** > **Finish** > **OK**. The console tree shows **Certificates (Local Computer)**.

## Request a user certificate

Request a certificate into the signed-in user's store when an application runs in the user's context. This workflow uses the **Certificate Enrollment** wizard and the built-in Active Directory Enrollment Policy.

1. Sign in as the user who has **Read** and **Enroll** permissions on the published template.
1. Run `certmgr.msc`.
1. Expand **Personal**, select and hold (or right-click) **Certificates**, and then select **All Tasks** > **Request New Certificate**.
1. In the **Certificate Enrollment** wizard, on the **Before You Begin** page, select **Next**.
1. On the **Select Certificate Enrollment Policy** page, select the applicable policy, which is usually **Active Directory Enrollment Policy**, then select **Next**.
1. On the **Request Certificates** page, select the checkbox for the intended template, then select **Enroll**.
1. If the wizard shows **More information is required to enroll for this certificate. Click here to configure settings.**, select the message. In **Certificate Properties**, complete only the template-required and policy-approved request properties, such as subject or subject alternative name values. Select **OK**, and then select **Enroll**.

After successful enrollment, the certificate appears in **Personal** > **Certificates** for the current user.

## Create a custom or offline request with certreq

Use `certreq` when the certificate owner approves a request configuration file and the interactive template workflow can't express the required request. This path doesn't cover Certification Authority Web Enrollment or uploading a preexisting Public Key Cryptography Standards (PKCS) request to a web page.

1. Obtain an approved `requestconfig.inf` from the template or application owner. Don't copy cryptographic, identity, or exportability settings from an unrelated template.
1. Generate the request in the intended context:

    ```cmd
    certreq -new requestconfig.inf certrequest.req
    ```

    For a local-computer certificate, the approved INF must specify `MachineKeySet = TRUE`. The `-machine` option sets the machine context for the request and must be consistent with that INF key and the template context:

    ```cmd
    certreq -new -machine requestconfig.inf certrequest.req
    ```

1. Submit the request to the approved CA:

    ```cmd
    certreq -submit certrequest.req certnew.cer
    ```

1. If the CA returns a pending disposition, record the request ID. After issuance, retrieve the certificate from the issuing CA:

    ```cmd
    certreq -retrieve <RequestID> certnew.cer
    ```

1. Accept and install the issued certificate in the same user or machine context as the original request:

    ```cmd
    certreq -accept certnew.cer
    ```

    If no matching pending request exists in that context, add `-user` or `-machine` to `certreq -accept` to select the destination context.

Validate the installed certificate in the intended store and with the relying application. For command syntax and request-file guidance, see [certreq](../../administration/windows-commands/certreq_1.md).

## Request a computer certificate

Request a certificate into the local-computer store for a computer-template certificate, such as one that a service uses in the computer context. You must grant template permissions to the computer object that needs the certificate.

1. On the target computer, run `certlm.msc`.
1. Expand **Personal**, select and hold (or right-click) **Certificates**, and then select **All Tasks** > **Request New Certificate**.
1. In the **Certificate Enrollment** wizard, on the **Before You Begin** page, select **Next**.
1. On the **Select Certificate Enrollment Policy** page, select the applicable policy, which is usually **Active Directory Enrollment Policy**, then select **Next**.
1. On the **Request Certificates** page, select the intended computer template and select **Enroll**.
1. Select **Finish**, then verify that the issued certificate appears in **Personal** > **Certificates** under **Certificates (Local Computer)**.

For example, Microsoft documents local-computer enrollment for web-server templates and notes that you must grant template permissions to the computer object that needs the certificate. See [Configure certificate templates for ML-DSA](configure-ml-dsa-certificate-templates.md).

> [!NOTE]
> Use an elevated session or an account authorized to manage the Local Computer certificate store. Elevation doesn't grant the computer account template permissions.

## Renew a certificate with a new key

Use a new-key renewal when the template and application support it and you want the replacement certificate to use a newly generated key.

1. Open the store that contains the certificate: `certmgr.msc` for a user certificate or `certlm.msc` for a local-computer certificate.
1. Go to **Personal** > **Certificates** and select the existing certificate.
1. Select and hold (or right-click) the certificate, then select **All Tasks** > **Renew Certificate with New Key**.
1. In the **Certificate Enrollment** wizard, select **Next**.
1. On the **Request Certificates** page, confirm that the template is available, then select **Enroll**.
1. Select **Finish** when the renewal completes.

> [!NOTE]
> **All Tasks** also lists **Request Certificate with New Key** and **Renew Certificate with Same Key**. Same-key renewal reuses the existing key pair, so choose it only when an approved application or enrollment design requires key reuse. Verify the template and application requirements before you renew a production certificate.

## Decide whether same-key renewal is required

Use the new-key workflow in this article unless an approved application or enrollment design requires reuse of the existing key. In the documented Certificate Enrollment Policy Web Service and Certificate Enrollment Web Service scenario, a client renews a certificate through key-based renewal by using the key of its existing certificate for authentication, and the scenario's validation step renews the certificate with the same key from an MMC snap-in. Treat that as a scenario-specific workflow, not as a generic alternative for every template. For the required service and policy configuration, see [Configure Certificate Enrollment Web Service for certificate key-based renewal](certificate-enrollment-certificate-key-based-renewal.md).

## Validate the issued or renewed certificate

After enrollment or renewal, validate both the certificate contents and its store location.

1. In **Personal** > **Certificates**, open the new certificate.
1. On the **Details** tab, verify the expected public key, signature algorithm, and **Enhanced Key Usage** (EKU).
1. On the **Certification Path** tab, verify the full expected path: the root and its trust status, any subordinate or issuing CAs, and the end-entity certificate.
1. Confirm that the certificate is in the store the application uses.
1. For a certificate that needs a private key, use PowerShell to confirm `HasPrivateKey`:

    ```powershell
    Get-ChildItem -Path Cert:\CurrentUser\My |
        Select-Object Subject, Thumbprint, NotAfter, HasPrivateKey
    ```

    Replace `Cert:\CurrentUser\My` with `Cert:\LocalMachine\My` when you validate a local-computer certificate. `HasPrivateKey` confirms a private-key association only; it doesn't prove that the application's runtime identity can use the key.
1. Test private-key use and chain-policy and revocation behavior as the relying application's runtime identity. An enrollment success message or certificate-store entry doesn't validate application configuration.

## Security considerations

- Use the narrowest template enrollment group that meets the business requirement.
- Treat caller-supplied subject and subject alternative name values as sensitive. For templates that permit requester-supplied values, restrict eligible enrollees and require appropriate approval or authorized signatures.
- Verify the expected EKU and certificate chain before you bind a certificate to an application.
- Don't export a private key as part of routine enrollment validation. If a backup or migration requires a Personal Information Exchange (PFX) file, follow [Export a certificate with its private key](export-certificate-private-key.md).

## Troubleshoot Certificates MMC enrollment

| Symptom | Check |
|---|---|
| The expected template isn't listed. | Confirm that an enterprise CA publishes the template and ask the template administrator to verify the requester's applicable **Read** and **Enroll** permissions. |
| The wizard asks for more information. | The template requires request properties. Provide only policy-approved values, or cancel the request and ask the template owner to confirm the required identity data. |
| The request stays pending, or the CA denies it. | Contact the CA administrator for the request disposition. This article doesn't use Certification Authority Web Enrollment status pages. |
| The certificate is in the wrong store. | Verify whether the application uses the current-user, local-computer, or service-account store. For a service store, use the **Certificates** snap-in's **Service account** option, follow the service's installation requirements, and verify that the service runtime account can use the private key. |
| The new certificate has no private key. | Confirm that you enrolled in the intended scope and that the selected template and application require a private key. |

## Related content

- [What is Active Directory Certificate Services in Windows Server?](active-directory-certificate-services-overview.md)
- [Certificate template concepts](certificate-template-concepts.md)
- [Manage certificate templates](manage-certificate-templates.md)
- [Configure certificate templates for ML-DSA](configure-ml-dsa-certificate-templates.md)
- [Configure certificates for LDAP over SSL in Active Directory Domain Services](../ad-ds/configure-ldap-signing-certificates.md)
- [Export a certificate with its private key](export-certificate-private-key.md)
- [Certification Authority can't use a certificate template](/troubleshoot/windows-server/certificates-and-public-key-infrastructure-pki/ca-cant-use-certificate-template)
- [Certificates security posture assessment in Microsoft Defender for Identity](/defender-for-identity/security-posture-assessments/certificates)
- [certreq](../../administration/windows-commands/certreq_1.md)
