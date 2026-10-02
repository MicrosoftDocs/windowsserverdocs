---
title: Monitor AD CS Health with Enterprise PKI
titleSuffix: Windows Server
description: Use Enterprise PKI, also known as PKIView, to monitor and validate AD CS certificate and CRL publication health on Windows Server 2025.
#customer intent: As an IT administrator, I want to monitor and review PKI health on an Active Directory Certificate Services deployment.
author: orin-thomas
ms.author: orthomas
ms.topic: how-to
ms.date: 08/17/2026
ai-usage: ai-assisted
---

# Monitor AD CS publication health with Enterprise PKI

Enterprise PKI, also known as PKIView, is a Microsoft Management Console (MMC) snap-in that gathers certification authority (CA) certificate and certificate revocation list (CRL) information for the Windows CAs in an Active Directory forest and validates that information. It reports warnings or errors when certificates or CRLs fail validation or approach expiration.

When a CA certificate or CRL expires or fails to publish, clients can no longer validate certificates, which causes failed authentication and service outages that are difficult to trace. Enterprise PKI gives you an early-warning and triage view of Active Directory Certificate Services (AD CS) so that you can catch these problems before they affect users. It doesn't replace end-to-end certificate validation from a relying party, and a warning or stale state alone doesn't justify deleting an Active Directory object.

This article shows you how to use Enterprise PKI to review CA certificate and CRL health, triage publication and retrieval warnings, and establish a repeatable PKI health monitoring process.

## Prerequisites

- A Windows Server 2025 CA or administrative management host with the AD CS management tools installed.
- Forest connectivity and an account with the minimum rights required to read PKI configuration and publication data. Use a separately authorized account for remediation actions that change Active Directory Domain Services (AD DS) containers.
- A current inventory of your CA hierarchy, CA owners, publication URLs, offline-CA schedule, and expected expiration windows.
- A nonproduction certificate or controlled test certificate that you can use for URL-retrieval validation without affecting a production identity.
- A change-control and backup process for Active Directory configuration-partition changes.

## Install and start Enterprise PKI

PKIView installs with the AD CS role and appears as **Enterprise PKI** in MMC. On a Windows Server management host where the tools are absent, install the AD CS management tools, which are part of Remote Server Administration Tools (RSAT).

1. Open an elevated Windows PowerShell session.
1. Install the management tools.

    ```powershell
    Install-WindowsFeature RSAT-ADCS
    ```

1. Start the snap-in.

    ```console
    pkiview.msc
    ```

Microsoft documents both launch paths: from the command line with `pkiview.msc`, or by adding the **Enterprise PKI** snap-in to MMC. To add it manually, start `mmc.exe`, select **File** > **Add/Remove Snap-in**, select **Enterprise PKI**, select **Add**, and then select **OK**. Microsoft documents both a Windows Server CA and an administrative workstation with RSAT as management locations.

## Review CA certificate and CRL health

Enterprise PKI discovers the Windows CA hierarchy in the forest and evaluates CA certificates and CRLs. Start with the top-level hierarchy view, then investigate the individual CA that reports a warning or error.

> [!IMPORTANT]
> Microsoft describes Enterprise PKI as a tool that gathers and validates CA certificate and CRL information. It isn't documented as an end-to-end Online Certificate Status Protocol (OCSP) transaction test. When a CA publishes an OCSP URL, verify it separately with a certificate that contains the URL and `certutil -verify -urlfetch`. A healthy CA or CRL view doesn't prove that an Online Responder is reachable or returning the expected signed response.

1. Open **Enterprise PKI** and allow the snap-in to populate the hierarchy.
1. In the console tree, select a CA name.
1. In the **Status** column of the results pane, check the entries for that CA, such as **CA Certificate**, **AIA Location #1**, and **CDP Location #1**. A healthy entry shows **OK**.
1. Record whether a non-**OK** entry reflects an approaching expiration, an expired certificate or CRL, a retrieval failure, or an unexpected object.
1. Compare the finding with the approved CA inventory. Expect an offline root CA to be unavailable between scheduled publication events; don't treat that state as a defect without checking its documented operating schedule.
1. Use a certificate that the affected CA issued to test the URLs a real client receives.

    ```console
    certutil -verify -urlfetch .\issued-test-certificate.cer
    ```

1. For an OCSP endpoint, inspect the `Certificate OCSP` section of the output. For CRL endpoints, identify the attempted URL and whether the client retrieved a current CRL.

The CA's Authority Information Access (AIA) and CRL distribution point (CDP) configuration controls which URLs the CA embeds in newly issued certificates. Modifying a CRL distribution point URL affects only newly issued certificates; previously issued certificates continue to reference the original location. Keep the previously published location available until you replace all certificates that reference it, or until those certificates expire or fall under an approved exception.

## Triage a publication or retrieval warning

Use this workflow to distinguish a publication problem from a client retrieval problem. Preserve evidence before you change the CA, DNS, a publication host, or an AD DS object.

1. Identify the exact CA, certificate, CRL, or URL that Enterprise PKI reports.
1. Determine whether the item is current, expired, approaching expiration, intentionally offline, or not expected in the approved CA inventory.
1. From the CA, confirm that the CA produced and published the required CA certificate, base CRL, or delta CRL according to its configured schedule.
1. From a client network, test DNS resolution and reachability for the exact HTTP or Lightweight Directory Access Protocol (LDAP) location embedded in an issued certificate.
1. Compare the time of the published revocation data with the CRL validity interval and the time of the client test.
1. Check Active Directory replication when the issue involves data published to the forest configuration partition.
1. For an OCSP issue, validate the Online Responder independently by using the end-to-end test in [Deploy and validate an Online Responder](configure-ml-dsa-online-responder.md).
1. Record the result, affected scope, owner, and restoration evidence before closing the incident.

Use the evidence to classify the issue:

- **Publication failure:** The CA didn't place the expected current certificate or CRL at its configured publication location.
- **Retrieval failure:** The data exists at its publication source, but the affected client can't resolve, reach, authenticate to, or validate the configured URL.
- **Stale data:** The client can retrieve data, but the data is older than the CA's expected publication cycle or is no longer valid.
- **Expired CA certificate:** The CA certificate is outside its validity period or approaching an approved renewal threshold.
- **Expected offline state:** The CA or object is intentionally offline under an approved offline-CA or decommissioning plan. Confirm the plan and next publication date before remediating.

## Understand Public Key Services data

AD CS stores forest-level PKI publication and configuration data under the configuration partition. Microsoft's PKI Health Tool guidance identifies the root CA trust and NTAuth stores as important PKI containers that Enterprise PKI can manage. The NTAuth object has a distinguished name similar to the following:

```text
CN=NTAuthCertificates,CN=Public Key Services,CN=Services,CN=Configuration,DC=contoso,DC=com
```

AD CS stores certificates published to the NTAuth store in the `cACertificate` multivalued attribute. Windows enterprise domain-joined CAs publish their own CA certificates to this store automatically, so you normally need manual publication only for a third-party CA that issues smart card logon or domain controller certificates.

The **Public Key Services** branch also contains other AD CS data that you should understand before troubleshooting:

| Container or object | Operational purpose |
| --- | --- |
| **AIA** | Holds the `certificateAuthority` object for each CA and is the directory Authority Information Access publication location that clients use for chain building. |
| **CDP** | Holds a `crlDistributionPoint` object per CA server that contains the CRLs the CA publishes, and is the directory CRL distribution point location. |
| **Certification Authorities** | Holds the `certificationAuthority` object for each CA and is the forest root CA trust store. |
| **Enrollment Services** | Holds the `pKIEnrollmentService` object that an enterprise CA creates. It records which certificate types the CA can issue, and its permissions control which security principals can enroll against that CA. |
| **Certificate Templates** | Stores the templates that enterprise CAs use to issue template-based certificates. |
| **KRA** | Stores key-recovery-agent certificate information for CAs that use key archival and recovery. |
| **OID** | Stores enterprise object identifiers used for certificate template, enhanced key usage, application policy, and issuance policy display names. |
| **NTAuthCertificates** | Stores CA certificates trusted to issue certificates used for authentication, such as smart card logon and domain controller certificates. |

Use **Enterprise PKI** > **Manage AD Containers** to inspect and perform only approved, supported container tasks. For example, current Microsoft guidance documents adding a third-party CA certificate on the **NTAuthCertificates** tab of that dialog box, or with `certutil -dspublish -f <filename> NTAuthCA`.

> [!CAUTION]
> Never delete an object because Enterprise PKI appears to mark it stale. An unexpired certificate, an offline CA, a cross-certificate path, or a delayed replication topology can still require a stale object. Remove Public Key Services objects only as part of an approved decommissioning plan, and follow the documented procedure in [How to decommission a Windows enterprise certification authority and remove all related objects](/troubleshoot/windows-server/certificates-and-public-key-infrastructure-pki/decommission-enterprise-certification-authority-and-remove-objects). Before you remove or replace any object, identify all dependent certificates and CAs, back up the object and its attributes, obtain the data owner's approval, plan forest replication, define a rollback path, and validate restoration in a nonproduction environment.

## Build a recurring PKI health monitoring process

Schedule a review at an interval that's shorter than your shortest certificate, CRL, and signing-certificate renewal window. The review should produce evidence that you can compare over time rather than a one-time green or red status.

1. Capture the Enterprise PKI view for each forest and record the date, management host, CA hierarchy, warnings, errors, and expiration dates.
1. Select representative certificates from each issuing CA and run `certutil -verify -urlfetch` from representative client networks.
1. Record CA certificate validity, CRL publication and next-update times, AIA/CDP retrieval results, OCSP response results, and the owner for each exception.
1. Forward approved host, service, and publication telemetry to your monitoring or security information and event management (SIEM) platform with enough context to link an error to a CA and endpoint.
1. Test controlled failure and recovery in a nonproduction environment: an unreachable HTTP location, an expired CRL, a missing published object, an expired CA certificate, and restored publication.
1. Review open exceptions before their expiration or review date. Don't normalize a persistent warning without an owner and a documented rationale.

## Security considerations for forest-wide PKI changes

The configuration partition is forest-wide. A change to a trust, enrollment, template, or publication object can affect clients beyond the CA that appears in the current view.

- Use read-only monitoring access whenever possible, and separate container-management rights from CA-operation rights.
- Protect exported CA certificates, CRLs, and configuration evidence according to their sensitivity and change-control requirements.
- Validate changes from a client network after AD DS replication completes; a successful change on one domain controller doesn't prove that all clients see it.
- Keep offline-root and decommissioned-CA records with the PKI monitoring evidence so that you don't accidentally remediate expected states.
- Treat certificate publication URLs as long-lived dependencies. Don't remove a DNS name, virtual directory, or directory publication point while unexpired certificates can still reference it.

## Troubleshoot Enterprise PKI monitoring

| Symptom | Check |
| --- | --- |
| `pkiview.msc` doesn't start. | Confirm that the AD CS role or `RSAT-ADCS` management tools are installed, then add **Enterprise PKI** manually through MMC. |
| A CA or CRL shows a warning. | Determine whether the issue is expiration, publication, retrieval, replication, or an approved offline state. Test the exact URL from a client network before modifying the CA. |
| HTTP works on the CA but fails for clients. | Compare DNS, firewall, proxy, and authentication behavior from the affected client network. Test the URL embedded in the actual certificate, not an assumed publication path. |
| Enterprise PKI looks healthy but application validation fails. | Use `certutil -verify -urlfetch` on the application certificate and inspect OCSP separately. Enterprise PKI doesn't replace a relying-party validation test. |
| An object appears obsolete. | Treat it as a controlled change. Identify dependencies, back up the object, obtain approval, plan replication and rollback, and validate in nonproduction. Remove objects only through the documented CA decommissioning procedure. |

## Related content

- [How to import third-party certification authority certificates into the Enterprise NTAuth store](/troubleshoot/windows-server/certificates-and-public-key-infrastructure-pki/import-third-party-ca-to-enterprise-ntauth-store)
- [How to decommission a Windows enterprise certification authority and remove all related objects](/troubleshoot/windows-server/certificates-and-public-key-infrastructure-pki/decommission-enterprise-certification-authority-and-remove-objects)
- [PKI design considerations using Active Directory Certificate Services](pki-design-considerations.md)
- [Manage certificate templates](manage-certificate-templates.md)
- [Deploy and validate an Online Responder](configure-ml-dsa-online-responder.md)
- [certutil](../../administration/windows-commands/certutil.md)
