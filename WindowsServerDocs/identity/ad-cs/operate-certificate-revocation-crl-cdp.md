---
title: Revoke Certificates and Publish CRLs in AD CS
titleSuffix: Windows Server
description: Revoke certificates, publish certificate revocation lists (CRLs), and safely change CRL distribution points (CDPs) for AD CS on Windows Server 2025.
#customer intent: As an IT administrator, I want to revoke certificates and manage CRL publication and distribution points so that relying parties receive current revocation information.
author: orin-thomas
ms.author: orthomas
ms.topic: how-to
ms.date: 08/17/2026
ai-usage: ai-assisted
---

# Operate certificate revocation, CRL publication, and CDP changes in AD CS

Certificate revocation is how a certification authority (CA) withdraws trust from a certificate before it expires, such as when a private key is compromised or you no longer need a certificate. The CA records that decision and publishes it in a certificate revocation list (CRL) that relying parties retrieve from a CRL distribution point (CDP). But revocation doesn't take effect everywhere at once: relying parties keep trusting a certificate until they retrieve an updated CRL from a location they can reach. If publication or distribution breaks, a revoked certificate can stay usable.

This article shows how to use Active Directory Certificate Services (AD CS) to revoke certificates, publish CRLs, and change CDPs safely, including CDP transitions that don't strand previously issued certificates.

## Prerequisites

Before you revoke a certificate or change a CDP, make sure that you have:

- Access as a CA administrator for CA configuration, CRL scheduling, service restarts, and CDP changes.
- Access as a certificate manager to revoke certificates and reinstate a certificate that's on hold. On the CA **Security** tab, the certificate-manager role has the **Issue and Manage Certificates** permission.
- A change record that identifies the issuing CA, affected certificate serial numbers, reason code, publication locations, rollback owner, and representative client networks.
- A nonproduction certificate from the affected CA for validation. For a CDP change, plan to issue a new test certificate after the change.
- A tested process that moves published CRL files from the CA publication path to every HTTP, Lightweight Directory Access Protocol (LDAP), or other approved retrieval endpoint.

> [!CAUTION]
> Revocation isn't instantaneous at every relying party. A newly revoked certificate can remain usable to a relying party until that party retrieves a newer revocation response or CRL according to its validation and caching behavior. Treat publication and endpoint validation as part of the revocation operation.

## Distinguish the revocation components

| Component | Purpose | Operator responsibility |
|---|---|---|
| Revocation record | Records the certificate serial number, effective time, and reason in the CA database. | Select the correct certificate and reason, retain approval evidence, and publish updated revocation data. |
| Base CRL | A signed list of revocations from the CA. | Publish it before it expires and make it available at every required retrieval endpoint. |
| Delta CRL | A smaller list of changes since a base CRL. | Use it only when your clients and operations support it. A delta CRL complements, rather than replaces, its associated base CRL. |
| Publication path | A local, file, Universal Naming Convention (UNC), or LDAP location to which the CA writes CRL data. | Grant only the required write and transfer access, and verify that the bytes arrive at the retrieval service. |
| CDP retrieval URL | A URL embedded in certificates that tells clients where to obtain a CRL. | Keep it reachable for the full period that a valid certificate or CA certificate references it. |

The CA's CDP configuration represents both publication and retrieval settings. `Get-CACrlDistributionPoint` exposes that distinction through properties such as `PublishToServer`, `PublishDeltaToServer`, `AddToCertificateCdp`, and `AddToFreshestCrl`.

> [!IMPORTANT]
> Changing a CDP URL affects only certificates issued after the change. Previously issued certificates continue to reference the earlier URL. Keep the prior endpoint and current CRL content available until no unexpired certificate or CA certificate in scope references it.

## Security considerations for revocation and CDP changes

Treat a revocation as an authorization and incident-response decision, not as routine cleanup. Separate the certificate-manager role that revokes a certificate from the CA-administrator role that changes CDPs, CRL timing, service state, and CA configuration. Require documented approval before you revoke, reinstate, or change a location that clients use to validate certificates.

Protect the CRL publication path against unauthorized writes, and restrict the copy or replication identity to the permissions it needs. At the same time, make the client-facing retrieval endpoint available to every relying party that must validate the affected certificates. A protected publication path doesn't replace a reachable retrieval URL.

## Choose the correct revocation reason

Use the reason that most accurately describes why you can no longer trust the certificate. The reason is part of the signed revocation data and helps incident responders understand the decision.

| Reason | Use it when |
|---|---|
| Key compromise | The subject private key is known or suspected to be compromised. |
| CA compromise | The issuing CA key or its security is compromised. Start the CA incident process in addition to revoking the affected certificate. |
| Affiliation changed | The subject is no longer associated with the organization, role, or service that the certificate represents. |
| Superseded | A replacement certificate is the authorized successor. |
| Cessation of operation | The certificate, service, or issuer has permanently stopped operating. |
| Certificate hold | You might reinstate the certificate after an investigation. Use it only for a deliberate temporary hold. It's the only reason you can reverse. |
| Unspecified | Use it only when your documented revocation policy specifically calls for that reason. It gives incident responders no context for the decision. |

Those reasons are the codes documented for the CA administration interface that the **Certification Authority** console uses. The `certutil -revoke` command also accepts privilege withdrawn and AA compromise. Use one of those extra codes only when your revocation policy requires it and you confirm how your relying parties interpret it.

The reason doesn't create an exception at the relying party. After a relying party consumes valid revocation data that contains the serial number, it treats the certificate as revoked according to its validation policy.

## Revoke a certificate

Record the revocation decision in the issuing CA database, then publish updated revocation data so that relying parties can act on it.

1. Open **Certification Authority** and expand the issuing CA.
1. Select **Issued Certificates** and identify the certificate by serial number, requester, template or policy, and intended service.
1. Select **Action** > **All Tasks** > **Revoke Certificate**.
1. Select the approved reason code (and, if you select **Key Compromise**, the optional date and time the private key compromise occurred), then select **OK**.
1. Record the serial number, request ID if available, reason, effective time, approver, and incident or change record.
1. Publish an updated CRL as described in the [Publish and verify CRLs](#publish-and-verify-crls) section.

## Reinstate a certificate placed on hold

You can reinstate only a certificate that you revoked with the **Certificate Hold** reason. You can't reinstate a certificate that you revoked for any other reason. Don't use a hold as a routine retry mechanism or to reverse a key-compromise decision.

1. In **Certification Authority**, select **Revoked Certificates**.
1. Select the certificate that's on hold.
1. Select **Action** > **All Tasks** > **Unrevoke Certificate**.
1. Confirm the decision to reinstate the certificate.
1. Record the authorization for the reinstatement.
1. Immediately publish updated revocation data as described in the [Publish and verify CRLs](#publish-and-verify-crls) section.

A reinstated certificate no longer appears in CRLs that the CA publishes after the reinstatement. Until relying parties retrieve that newer revocation data, they can continue to treat the certificate as revoked.

## Publish and verify CRLs

To publish a CRL manually from **Revoked Certificates**, select **Action** > **All Tasks** > **Publish**, and then select the appropriate CRL type. Use the console when your operational process requires an interactive confirmation.

For a scripted or documented CA operation, run the following command from an elevated command prompt. It publishes the base and delta CRLs when you configure delta CRLs for the CA.

```cmd
certutil -config "CAHOST\Contoso Issuing CA" -CRL
```

> [!NOTE]
> Use `certutil` as an administrative inspection and management tool, not in production application code. Microsoft doesn't provide live-site support or application-compatibility guarantees for that use.

`certutil -CRL` writes new CRL data according to the CA configuration; it doesn't prove that a web server, replication process, or external transfer makes the new files available. After publishing, verify the publication path, the transfer or replication job, and the retrieval endpoint separately.

### Plan base and delta CRLs without a universal schedule

Set the base CRL interval, delta CRL interval, validity interval, and overlap based on your certificate population, expected revocation urgency, endpoint capacity, replication or transfer delay, client connectivity, and monitoring response time. Don't adopt another organization's schedule without measuring those constraints.

- A base CRL provides the complete revocation state for the applicable CA.
- A delta CRL contains changes since the associated base CRL. Clients need the base CRL for the delta CRL to be useful.
- Overlap provides time for clients to obtain new revocation data before the previous CRL becomes unusable. It should cover the actual end-to-end delay, including CA publication, replication, file transfer, and client reachability.
- A publishing interval and a CRL validity period are different settings. Make sure your process publishes and distributes a successor before clients need it.

For an offline root CA, avoid delta CRLs unless a documented requirement justifies them. Use a scheduled, witnessed process to publish a new base CRL, transfer it to every retrieval endpoint, and verify it from the networks that depend on the root.

### Monitor the delivery chain

Monitor more than the CA publication result. At each HTTP endpoint, verify that the expected CRL file is current, complete, and readable by the intended clients. Configure the web server with the `.crl` MIME mapping required by your web-server policy, and verify the actual HTTP response after deployment. At LDAP or file-based publication locations, verify the directory replication or file-transfer result and the permissions used by the publishing process.

Alert before a CRL reaches its next-update boundary. Your response procedure should identify whether the failure is in CA generation, the publication path, the copy or replication process, DNS or network reachability, or the retrieval service.

## Change a CDP safely

Use a staged transition. Add and validate the new endpoint before you remove an old one.

### Record the existing state

Run the following command on the target CA and save the result with the change record.

```powershell
Get-CACrlDistributionPoint
```

For each entry, identify whether it's:

- A location where the CA publishes a base CRL (`PublishToServer`) or a delta CRL (`PublishDeltaToServer`).
- A URL that appears in the CDP extension of newly issued certificates (`AddToCertificateCdp`).
- A location advertised in published CRLs so clients can find the associated delta CRL (`AddToFreshestCrl`).
- An LDAP location included in the CRL (`AddToCrlCdp`), or a URL added to the issuing distribution point extension of the CRL (`AddToCrlIdp`).

Don't assume that a local folder or a UNC path is suitable as a client-facing CDP. Publish an HTTP CRL location so that clients outside the organization and clients that don't run Windows can validate certificates, and use LDAP where your domain design requires it.

Windows clients try the URLs in a certificate's CDP extension in order until they retrieve a valid CRL. Account for that order when you add a URL that clients in some networks can't reach.

### Add the new publication and retrieval locations

The following example separates the local publication path from the HTTP URL embedded in newly issued certificates. It also advertises the HTTP location for delta CRLs. Use the existing CA naming convention and omit delta-related switches when the CA doesn't publish delta CRLs.

Compare the planned entries against the `Get-CACrlDistributionPoint` output first. A newly installed CA already has default publication and retrieval entries, and adding a URI that's already configured with the same flags creates a duplicate.

```powershell
# Run on the target CA. The bracketed values are AD CS substitution tokens.
Add-CACrlDistributionPoint `
  -Uri "$env:SystemRoot\System32\CertSrv\CertEnroll\<CAName><CRLNameSuffix><DeltaCRLAllowed>.crl" `
  -PublishToServer `
  -PublishDeltaToServer

Add-CACrlDistributionPoint `
  -Uri "http://pki.contoso.com/pki/<CAName><CRLNameSuffix><DeltaCRLAllowed>.crl" `
  -AddToCertificateCdp `
  -AddToFreshestCrl
```

`Add-CACrlDistributionPoint` prompts for confirmation. Add `-Force` only when your change process authorizes an unattended run.

The cmdlets update CA configuration; they don't create a web publication service or copy files to an HTTP server. Make the required web-server and transfer changes, then check the command result. If it reports that the CA requires a restart, restart the CA service during the approved change window before you issue certificates that should carry the new CDP.

Publish new CRLs after the restart, then verify that the new files are present at the publication and retrieval locations.

## Validate the revocation workflow

1. Issue a nonproduction certificate after the CDP change.
1. Inspect the certificate's **CRL Distribution Points** extension and confirm that it contains the new retrieval URL.
1. From each representative network zone, validate the test certificate and retrieve its revocation data:

   ```cmd
   certutil -verify -urlfetch "test-certificate.cer"
   ```

1. Confirm that the output shows a successful retrieval of the base CRL and, when you use delta CRLs, of the associated delta CRL.
1. Repeat the retrieval test against a certificate issued before the change. Verify that it still retrieves revocation data from the previous CDP.
1. Revoke a nonproduction certificate, then publish a new CRL.
1. Confirm that a representative relying party detects the revocation after it obtains the updated data.

### Retire an old CDP only after its references expire

Leave the old endpoint in service until you show that no unexpired end-entity or CA certificate in scope refers to it. This scope includes long-lived CA certificates and certificates outside the network where you made the change.

After the retention decision, use `-WhatIf` before removing the old URI. Include only the flags that match the CDP entry you intend to remove. If you omit the flags, the cmdlet removes every distribution point that matches the URI.

```powershell
Remove-CACrlDistributionPoint `
  -Uri "http://pki.contoso.com/pki/old-issuing-ca.crl" `
  -AddToCertificateCdp `
  -AddToFreshestCrl `
  -WhatIf
```

Review the result, remove `-WhatIf` only when the change record authorizes the action, restart the CA service if the operation requires it, publish fresh CRLs, and repeat the validation matrix. Removing an endpoint from the CA configuration doesn't remove it from certificates that already contain it.

## Roll back a failed CDP change

If the new endpoint doesn't pass validation:

1. Stop issuing certificates that carry the new CDP, if your change process permits.
1. Restore the previously recorded CDP configuration and its matching publication settings.
1. Restart the CA service if the configuration operation requires it.
1. Publish new CRLs and confirm that the previous retrieval URLs serve current, valid data.
1. Keep both endpoint sets available until the restored path passes tests from every required network zone.
1. Record the affected certificate issuance window and decide whether you must replace certificates issued with an unusable new URL.

## Troubleshoot revocation operations

| Symptom | Scope the investigation |
|---|---|
| A certificate remains accepted after revocation | Verify the serial number and CA, then check whether the CA published a new CRL, the transfer moved it, and clients retrieved it. Account for the relying party's revocation cache. |
| A client can't retrieve a CRL | Test the exact CDP URL from that client network. Check DNS, HTTP or LDAP reachability, authentication requirements, web-server MIME mapping, file freshness, and CA-to-endpoint transfer. |
| A client can retrieve the base CRL but not a delta CRL | Verify that the client has the required base CRL and that the CDP configuration advertises the delta location only when the CA actually publishes delta CRLs. |
| A new certificate contains the new URL but an older certificate fails validation | Keep the old CDP online and restore current CRL content there. A CDP configuration change doesn't repair old certificates. |
| The CA generated a CRL but the web endpoint is stale | Investigate the publication path and the copy or replication process. The CA's local generation result doesn't validate the delivery chain. |

## Related content

- [PKI design considerations using Active Directory Certificate Services](pki-design-considerations.md)
- [Get-CACrlDistributionPoint](/powershell/module/adcsadministration/get-cacrldistributionpoint)
- [Add-CACrlDistributionPoint](/powershell/module/adcsadministration/add-cacrldistributionpoint)
- [Remove-CACrlDistributionPoint](/powershell/module/adcsadministration/remove-cacrldistributionpoint)
- [Retrieve base & delta CRLs using Web Enrollment in AD CS](retrieve-base-and-delta-crl.md)
- [certutil](../../administration/windows-commands/certutil.md)
