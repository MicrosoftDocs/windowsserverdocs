---
title: Manage Pending Certificate Requests in AD CS
titleSuffix: Windows Server
description: Review, issue, deny, and govern pending certificate requests on an AD CS certification authority in Windows Server 2025.
#customer intent: As an IT administrator, I want to review and dispose of pending certificate requests so that issuance decisions are controlled and auditable.
author: orin-thomas
ms.author: orthomas
ms.topic: how-to
ms.date: 08/17/2026
ai-usage: ai-assisted
---

# Review and dispose of pending certificate requests

A pending request is a certificate request that the certification authority (CA) policy holds for a certificate manager to decide, rather than issuing automatically. It isn't the same as a requester viewing the status of their own request in Certification Authority Web Enrollment.

Reviewing a request before you approve it is how you keep certificate issuance controlled and accountable. You confirm that the requester and the requested certificate are authorized, avoid issuing a credential that bypasses your policy, and keep the evidence you need to explain the decision later.

This article describes how to review pending requests, make a controlled disposition, and retain the evidence you need to account for the decision.

## Prerequisites

Before you dispose of a request, ensure that you have:

- An approved certificate issuance policy and a defined owner for each certificate template or standalone request policy.
- An account assigned the **Certificate manager** CA role. On the CA **Security** tab, this role corresponds to the **Issue and Manage Certificates** permission. It can issue, deny, revoke, and reinstate certificates without granting the broader **Manage CA** permission.
- Access to the authoritative source that validates the requester, subject name, and intended certificate use. A pending request alone isn't proof of authorization.
- A documented approval path for sensitive uses, such as code signing, enrollment agent, OCSP response signing, or certificates that include requester-supplied names.
- Auditing and retention procedures that preserve the request ID, approver, decision, and supporting evidence.

> [!IMPORTANT]
> Don't change the CA **Policy Module** settings while handling an individual request. Changing policy is a CA-administrator action that affects later requests; issuing or denying a request is a certificate-manager action.

## Understand pending certificate request behavior on a CA

The active CA policy controls whether to issue, deny, or hold a request pending. The policy-module model is common to both CA types, but the normal workflow differs.

| CA type | Normal request behavior | What a pending request means |
|---|---|---|
| Enterprise CA | The Microsoft enterprise policy module uses certificate templates and their access control lists to authorize requests. A valid request on a template that doesn't select **CA certificate manager approval** on the template's **Issuance Requirements** tab normally issues without entering **Pending Requests**. | A template that selects **CA certificate manager approval**, another CA policy setting, or a local configuration can hold the request for review. Verify why the CA held it before you approve it. |
| Standalone CA | The default standalone policy holds requests in a pending queue until a certificate manager manually issues them. | Manual identity and purpose verification is part of the normal issuance workflow. |

Don't infer the CA type or the cause of a pending request from the requester-facing web page. A requester can select **View the status of a pending certificate request** in Certification Authority Web Enrollment and can remove their own still-pending request. That page doesn't grant any ability to issue or deny a request. For requester guidance, see [Request certificates using Web Enrollment in Active Directory Certificate Services](request-certificate-windows-server.md).

## Review a pending certificate request

### Verify access to the CA administrative interface

Run the following command from an administrative command prompt to confirm that you can reach the target CA administrative interface. Replace the configuration string with the CA's actual `computer\CA name` value.

```cmd
certutil -config "CAHOST\Contoso Issuing CA" -pingadmin
```

> [!NOTE]
> Use `certutil` as an administrative inspection tool, not in production application code. Microsoft doesn't provide live-site support or application-compatibility guarantees for that use.

The command checks connectivity; it doesn't grant permission to dispose of requests. If it succeeds, open **Certification Authority**, expand the target CA, and select **Pending Requests**.

### Build a decision record before issuing

Select one request at a time and record its request ID. Review the request against the authoritative information for the requested certificate profile, not only against the values that the requester supplies.

| Review area | Verify before you issue |
|---|---|
| Requester and authorization | You know the requester identity, and the requester is authorized to request this certificate use. For an enterprise CA, confirm the applicable template and enrollment authorization. |
| Subject and subject alternative names | Each identity value matches an approved source of truth. Treat requester-supplied names as high risk unless your policy explicitly permits and verifies them. |
| Certificate purpose | The requested enhanced key usages, issuance policies, and intended relying-party use match the approved profile. |
| Key and validity controls | The requested key provider, algorithm, key size, exportability, and validity are acceptable for the profile and its consumers. |
| Approval evidence | Required second approval, ticket, asset record, or service-owner approval exists and identifies the same request ID. |

> [!CAUTION]
> Don't use a certificate-manager action to correct a request. If the requested subject, SAN, key properties, template, or purpose is wrong, require a new request that contains the approved values. Approving a changed or failed request can bypass the safeguards that evaluated the original submission.

## Issue an approved request

After the review is complete:

1. In **Pending Requests**, select the request.
1. Select **Action** > **All Tasks** > **Issue**.
1. Record the request ID, CA name, approver, approval evidence, and time of the decision in your issuance record.
1. Confirm that the request moves from the pending view to the issued-certificate view.
1. Notify the requester through your approved process.

An issued certificate is a security credential. Don't treat the successful move of a request to **Issued Certificates** as proof that the requester installed it or that a relying party accepts it.

## Deny an unacceptable request

Deny a request when the requester isn't authorized, the request doesn't meet the certificate profile, the approval evidence is missing or rejected, or you no longer need the request.

1. In **Pending Requests**, select the request.
1. Select **Action** > **All Tasks** > **Deny Request**.
1. Record the request ID, decision authority, decision reason, and the information that led to the denial.
1. Tell the requester how to obtain a corrected request, if appropriate. Don't include secrets or sensitive identity evidence in a broad notification.

Use a new request when the request contents must change. A denied request and a failed request are distinct dispositions even though the CA console can group them in **Failed Requests**. Don't issue or resubmit a request merely to bypass a policy or template failure; re-evaluate it only when its contents and approval evidence remain valid.

## Retain a request only while a decision is active

Keep a request pending only when a named owner is completing a defined review. Associate the request ID with the outstanding evidence and a review deadline. If the evidence expires or the requester no longer needs the certificate, deny the request according to your retention policy rather than leaving an unmanaged authorization path on the CA.

## Security considerations

Separate the CA administrator from the certificate manager whenever your operating model allows it. A CA administrator configures policy, extensions, service settings, and role assignments. A certificate manager disposes of requests. Keeping those roles separate reduces the chance that one compromised account can both weaken policy and issue a certificate.

Require an independent approval for high-impact certificate profiles. This requirement is especially important when a profile can authorize code, delegate enrollment, authenticate a privileged account, or carry a name that the requester supplies. Review the name and certificate purpose together; a correct requester identity doesn't automatically authorize every requested name or usage.

Treat request records and approval evidence as sensitive operational data. Restrict access to CA database views, export only the information required for the review, and keep retention periods aligned with your audit and incident-response requirements. If an existing exit-module integration publishes certificates to a file system, govern that integration separately: document its consumer, restrict the destination, monitor its integrity, and ensure it never publishes private key material.

## Validate the request-disposition workflow

Validate the request-disposition workflow with nonproduction requests before you rely on it for a sensitive certificate profile:

1. Submit an authorized test request that your policy holds pending. Verify that it appears in **Pending Requests** and that the request ID matches your test record.
1. Use an account assigned only the certificate-manager role to issue the request. Verify that the certificate appears in **Issued Certificates** and that the intended test requester can retrieve it.
1. Submit a second test request that intentionally fails an approval requirement. Deny it and verify that the requester sees the denied status rather than an issued certificate.
1. Test with an account that lacks **Issue and Manage Certificates**. Verify that it can't issue or deny the request.
1. Review your CA and operating audit records to confirm that the request ID, disposition, and approving identity are available for investigation.

## Troubleshoot request disposition

| Symptom | Scope the investigation |
|---|---|
| **Pending Requests** is empty on an enterprise CA | This condition can be normal. Verify the requester's status and the active CA policy before changing the CA to hold requests. |
| A request appears in **Failed Requests** | Determine whether its disposition is failed or denied. Resolve the template, policy, signature, or enrollment error before a new request; re-evaluate a denied request only when the original request and approval evidence remain valid. |
| The issue or deny action is unavailable | Check the CA **Security** tab and confirm that the account has **Issue and Manage Certificates**. A CA administrator must change role assignments. |
| The requester receives a template-not-supported denial | Verify that the CA can read and issue the intended template. For a common enterprise-CA cause and corrective action, see [CA can't use a certificate template](/troubleshoot/windows-server/certificates-and-public-key-infrastructure-pki/ca-cant-use-certificate-template). |
| The requester still sees **Pending** after you issue or deny | Confirm the request ID and target CA. Requester status pages are separate from the CA console, and the requester must retrieve the result through the enrollment method they used. |

## Related content

- [Request certificates using Web Enrollment in Active Directory Certificate Services](request-certificate-windows-server.md)
- [Submit certificate requests to AD CS using a PKCS #10 or PKCS #7 file](submit-pkcs-certificate-request.md)
- [Manage certificate templates](manage-certificate-templates.md)
- [Policy modules](/windows/win32/seccrypto/policy-modules)
